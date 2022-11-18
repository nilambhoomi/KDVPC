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




public partial class OPReport : System.Web.UI.Page
{
    DBHelperClass db = new DBHelperClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uname"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        //if (!IsPostBack)
        //{ bindLocation(); }
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
        string condition = string.Empty;
        string query = @"SELECT 
                         op.PatientIE_ID,op.PatientFU_ID,op.SurgeryCenter 'Clinics',ie.Compensation 'CaseType',pm.LastName+ ','+pm.FirstName 'Patient Name',op.SurgeryCenter 'Sx center', 
                         CONVERT(VARCHAR,op.DOS,101) 'DOS', op.PreOp_ReportCode 'Procedure type',CONVERT(VARCHAR,op.DOS,101) 'Date of Followup',op.Anesthesiologist 'Surgeon',
                         op.PreOp_ReportCode,op.Op_ReportCode,op.PostOp_ReportCode
                         FROM
                         tblPatientIE ie 
                         inner join tblPatientMaster pm on ie.Patient_ID = pm.Patient_ID
                         inner join tblOpReportsDetail op on op.PatientIE_ID = ie.PatientIE_ID";

        condition = " (op.DOS BETWEEN CONVERT(VARCHAR(10),'" + txtSearchFromdate.Text + "',101) and CONVERT(VARCHAR(10),'" + txtSearchTodate.Text + "',101))";


        if (!string.IsNullOrEmpty(condition))
        {
            condition = condition.Insert(0, " where ");
            query += condition;
        }

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
            wb.Worksheets.Add(dt, "OPReport");
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=OPReport.xlsx");
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


    //private void bindLocation()
    //{
    //    DataSet ds = new DataSet();
    //    ds = db.selectData("select Location,Location_ID from tblLocations Order By Location");
    //    if (ds.Tables[0].Rows.Count > 0)
    //    {
    //        ddlLocation.ClearSelection();
    //        ddlLocation.DataValueField = "Location_ID";
    //        ddlLocation.DataTextField = "Location";

    //        ddlLocation.DataSource = ds;
    //        ddlLocation.DataBind();

    //        ddlLocation.Items.Insert(0, new ListItem("-- Location --", "0"));
    //    }
    //}
}