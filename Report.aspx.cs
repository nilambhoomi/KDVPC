using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.IO;
using ClosedXML.Excel;
using System.Globalization;




public partial class Report : System.Web.UI.Page
{
    DBHelperClass db = new DBHelperClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uname"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

    }
    protected void CustomValidator1_ServerValidate(object sender, ServerValidateEventArgs e)
    {
        DateTime d;
        e.IsValid = DateTime.TryParseExact(e.Value, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out d);
        txtSearchFromdate.Text = d.ToShortDateString();
        //e.IsValid = false; 
    }
    protected void CustomValidator2_ServerValidate(object sender, ServerValidateEventArgs e)
    {
        DateTime d;
        e.IsValid = DateTime.TryParseExact(e.Value, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out d);
        txtSearchTodate.Text = d.ToShortDateString();
        //e.IsValid = false; 
    }
    protected void BindProcudureList()
    {
        string query = "select pm.LastName +', '+ pm.FirstName 'Name',ie.compensation 'CaseType',convert(varchar,ie.DOE,101) 'primary visit', lastvisit =(select top 1 convert(varchar,DOE,101) from tblFUPatient where PatientIE_ID = ie.PatientIE_ID)";
        query += " ,(select Location from tblLocations where Location_ID = ie.Location_ID) 'location',(select insco from tblInsCos where InsCo_ID = ie.InsCo_ID)'Ins'";
        query += " ,pm.policy_no 'Policy No',pm.SSN,ie.ClaimNumber,att.Attorney,ie.WCBGroup,ie.EmpName,ie.EmpAddress,ie.EmpPhone,ie.EmpFax,ie.InsMailingAddress,ie.InsNote,";
        query += "tp.MCODE,convert(varchar,tp.Executed,101) 'Executed Date'";
        query += " from dbo.tblPatientIE ie inner join dbo.tblPatientMaster pm On pm.Patient_ID = ie.Patient_ID inner join dbo.tblAttorneys att on ie.Attorney_ID=att.Attorney_ID INNER join dbo.tblProceduresDetail tp  on tp.PatientIE_ID = ie.PatientIE_ID ";
        string condition = "where ie.Compensation='WC'and ie.DOE BETWEEN CONVERT(VARCHAR(10),'" + txtSearchFromdate.Text + "',101) and CONVERT(VARCHAR(10),'" + txtSearchTodate.Text + "',101) order by pm.LastName";
        string condition1 = null;
        string condition2 = null;




        if (!string.IsNullOrEmpty(ddldb.SelectedValue))
        {
            condition.Replace("dbo.", ddldb.SelectedValue);
        }

        query += condition;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connString_Test_Live"].ConnectionString))
        {

            SqlCommand cm = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cm);
            con.Open();
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];

                gvProcedureTbl.DataSource = dt;
                Session["Datatableprocedure"] = dt;
                gvProcedureTbl.DataBind();
            }
        }
    }

    protected void lkExportToexcel_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)Session["Datatableprocedure"];

        using (XLWorkbook wb = new XLWorkbook())
        {
            wb.Worksheets.Add(dt, "WCReport");
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=WCReport.xlsx");
            using (MemoryStream MyMemoryStream = new MemoryStream())
            {
                wb.SaveAs(MyMemoryStream);
                MyMemoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }

        }

    }
    protected void gridView_Sorting(object sender, GridViewSortEventArgs e)
    {
        string sortExpression = e.SortExpression;
        ViewState["z_sortexpresion"] = e.SortExpression;
        if (GridViewSortDirection == SortDirection.Ascending)
        {
            GridViewSortDirection = SortDirection.Descending;
            SortGridView(sortExpression, "DESC");
        }
        else
        {
            GridViewSortDirection = SortDirection.Ascending;
            SortGridView(sortExpression, "ASC");
        }

    }

    public string SortExpression
    {
        get
        {
            if (ViewState["z_sortexpresion"] == null)
                ViewState["z_sortexpresion"] = this.gvProcedureTbl.DataKeyNames[0].ToString();
            return ViewState["z_sortexpresion"].ToString();
        }
        set
        {
            ViewState["z_sortexpresion"] = value;
        }
    }

    public SortDirection GridViewSortDirection
    {
        get
        {
            if (ViewState["sortDirection"] == null)
                ViewState["sortDirection"] = SortDirection.Ascending;
            return (SortDirection)ViewState["sortDirection"];
        }
        set
        {
            ViewState["sortDirection"] = value;
        }
    }
    private void SortGridView(string sortExpression, string direction)
    {
        DataTable dt = ((DataTable)Session["Datatableprocedure"]);
        DataView dv = new DataView(dt);
        dv.Sort = sortExpression + " " + direction;
        this.gvProcedureTbl.DataSource = dv;
        gvProcedureTbl.DataBind();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtSearchFromdate.Text = string.Empty;
        txtSearchTodate.Text = string.Empty;

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindProcudureList();
    }

}