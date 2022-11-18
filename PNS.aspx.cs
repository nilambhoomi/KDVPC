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

public partial class PNS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uname"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["o_column"] = "FirstName";
            ViewState["c_order"] = "asc";

            txtSearchTodate.Text = System.DateTime.Now.ToString("MM/dd/yyyy");
            //lnkTransfer.Attributes.Add("onclick", "javascript:return ExecuteConfirm()");
            bindLocation();
        }
    }
    protected void CustomValidator3_ServerValidate(object sender, ServerValidateEventArgs e)
    {
        DateTime d;
        e.IsValid = DateTime.TryParseExact(e.Value, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out d);
        txtMaxDate.Text = d.ToShortDateString();
        //e.IsValid = false; 
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
        string query = "select  max(ie.patientie_id) IE,max(pm.FirstName) +' '+ max(pm.Lastname) as 'Patient',max(pm.Phone) as 'Mobile Number',max(lc.Location) as 'Location',ISNULL(CONVERT(VARCHAR(10),max(fu.DOE),101),'') as 'LastDOV'";
        string condition = " from tblPatientMaster pm inner join tblPatientIE ie on pm.Patient_ID=ie.Patient_ID inner join tblFUPatient fu on ie.PatientIE_ID=fu.PatientIE_ID inner join tblLocations lc on ie.Location_ID=lc.Location_ID";
        string condition1 = null;


        condition1 = "(fu.DOE NOT BETWEEN '" + txtSearchFromdate.Text + "' and '" + txtSearchTodate.Text + "') and (fu.DOE  BETWEEN '" + txtMaxDate.Text + "' and '" + txtSearchTodate.Text + "')";

        
        if (ddl_location.SelectedIndex > 0)
        {

            if (!string.IsNullOrEmpty(condition1))
                condition1 += condition1 = " and ie.Location_ID=" + ddl_location.SelectedValue;
            else
                condition1 = " ie.Location_ID=" + ddl_location.SelectedValue;
        }


        query += condition;
        if (!string.IsNullOrEmpty(condition1))
        {
            condition1 = condition1.Insert(0, " where ");
            query += condition1;
        }
        query = query + " group by ie.patientie_id order by LastDOV desc";
        //query = query + "group by pm.Patient_ID,pm.FirstName order by max(" + ViewState["o_column"] +")"+ " " + ViewState["c_order"];

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
            else
            {
                gvProcedureTbl.DataSource = null;
                Session["Datatableprocedure"] = null;
                gvProcedureTbl.DataBind();
            }
        }
    }

    private void bindLocation()
    {
        DataSet ds = new DataSet();
        DBHelperClass db = new DBHelperClass();

        string query = "select Location,Location_ID from tblLocations ";
        if (!string.IsNullOrEmpty(Session["Locations"].ToString()))
        {
            query = query + " where Location_ID in (" + Session["Locations"] + ")";
        }
        query = query + " Order By Location";

        ds = db.selectData(query);
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddl_location.DataValueField = "Location_ID";
            ddl_location.DataTextField = "Location";

            ddl_location.DataSource = ds;
            ddl_location.DataBind();

            ddl_location.Items.Insert(0, new ListItem("-- All --", "0"));


        }

    }


    protected void lkExportToexcel_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)Session["Datatableprocedure"];

        dt.Columns.Remove("IE");
        //dt.Columns.Remove("ProcedureDetail_ID1");
        using (XLWorkbook wb = new XLWorkbook())
        {
            wb.Worksheets.Add(dt, "PtNotSeen");
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=PtsNotseenReport.xlsx");
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
    protected void gvProcedureTbl_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    }
    protected void lnk_sorting_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        sortorder(lnk.CommandArgument);
    }

    private void sortorder(string colname)
    {
        try
        {

            if (ViewState["c_order"].ToString().ToUpper() == "ASC")
                ViewState["c_order"] = "DESC";
            else if (ViewState["c_order"].ToString().ToUpper() == "DESC")
                ViewState["c_order"] = "ASC";

            ViewState["o_column"] = colname;

            BindProcudureList();
        }
        catch (Exception ex)
        {

        }
    }
}