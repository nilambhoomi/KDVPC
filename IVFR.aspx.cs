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

public partial class IVFR : System.Web.UI.Page
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

            //lnkTransfer.Attributes.Add("onclick", "javascript:return ExecuteConfirm()");
            bindLocation();
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
        string query = "select  pm.LastName+', '+pm.FirstName 'Name',CASE WHEN pm.sex ='Ms.' THEN 'F'WHEN pm.sex ='Mr.' THEN 'M'ELSE '' END AS Sex,tp.MCODE,ie.Compensation as 'Case' ,ISNULL(CONVERT(VARCHAR(10),pm.DOB,101),'') as DOB ,ISNULL(CONVERT(VARCHAR(10),ie.DOA,101),'') as DOA ,pm.SSN ,pm.phone+','+pm.Phone2 as Phone,lc.location,pm.Address1+','+pm.City+','+pm.State+','+pm.Zip as Address,(select ic.InsCo from tblInsCos ic where ic.InsCo_ID=ie.InsCo_ID) 'Ins Co',ie.claimnumber 'Claim Number',pm.policy_no 'Policy No'";
        //string query = "select  max(pm.LastName)+', '+max(pm.FirstName) 'Name',CASE WHEN max(pm.sex) ='Ms.' THEN 'F'WHEN max(pm.sex) ='Mr.' THEN 'M'ELSE '' END AS Sex,max(ie.Compensation) as 'Case' ,ISNULL(CONVERT(VARCHAR(10),max(pm.DOB),101),'') as DOB ,ISNULL(CONVERT(VARCHAR(10),max(ie.DOA),101),'') as DOA ,max(pm.SSN) As 'SSN' ,max(pm.phone)+','+max(pm.Phone2) as Phone,max(lc.location) as 'location',max(pm.Address1)+','+max(pm.City)+','+max(pm.State)+','+max(pm.Zip) as Address,(select ic.InsCo from tblInsCos ic where ic.InsCo_ID=max(ie.InsCo_ID)) 'Ins Co',max(ie.claimnumber) 'Claim Number',max(pm.policy_no) 'Policy No'";
        string condition = " from  tblProceduresDetail tp  inner join tblPatientIE ie on tp.PatientIE_ID = ie.PatientIE_ID inner join tblPatientMaster pm on pm.Patient_ID=ie.Patient_ID left join dbo.tblLocations lc ON ie.Location_ID = lc.Location_ID";
        string condition1 = null;


        //query += ", ISNULL(CONVERT(VARCHAR(10),tp.Requested,101),'') as Requested ";

        //if (chkRequested.Checked)
        //condition1 = " (tp.Requested>='" + txtSearchFromdate.Text + "' and tp.Requested<='" + txtSearchTodate.Text + "')";


                query += ", ISNULL(CONVERT(VARCHAR(10),tp.Scheduled,101),'') as Scheduled ";

        if (chkScheduled.Checked)
        {
            if (!string.IsNullOrEmpty(condition1))
                condition1 += condition1 = " or (tp.Scheduled>='" + txtSearchFromdate.Text + "' and tp.Scheduled<='" + txtSearchTodate.Text + "')";
            else
                condition1 = " (tp.Scheduled>='" + txtSearchFromdate.Text + "' and tp.Scheduled<='" + txtSearchTodate.Text + "')";
        }

        //query += ", ISNULL(CONVERT(VARCHAR(10),tp.Executed,101),'') as Executed ";
        //if (chkExecuted.Checked)
        //{

        // if (!string.IsNullOrEmpty(condition1))
        // condition1 += condition1 = " or (tp.Executed>='" + txtSearchFromdate.Text + "' and tp.Executed<='" + txtSearchTodate.Text + "')";
        //else
        // condition1 = " (tp.Executed>='" + txtSearchFromdate.Text + "' and tp.Executed<='" + txtSearchTodate.Text + "')";
        //}

        //query += " ,tp.ProcedureDetail_ID ,ISnull(pm.Note,'') AS Note ";


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
          query = query + " order by " + ViewState["o_column"] + " " + ViewState["c_order"];
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

        //dt.Columns.Remove("ProcedureDetail_ID");
        //dt.Columns.Remove("ProcedureDetail_ID1");
        using (XLWorkbook wb = new XLWorkbook())
        {
            wb.Worksheets.Add(dt, "IVFReport");
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=IVFReport.xlsx");
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