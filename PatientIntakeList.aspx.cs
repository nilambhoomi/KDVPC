using IntakeSheet.BLL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PatientIntakeList : System.Web.UI.Page
{
    DBHelperClass db = new DBHelperClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uname"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            Session["patientFUId"] = "";
            BindPatientIEDetails();
            bindLocation();
            txtSearch.Attributes.Add("onkeydown", "funfordefautenterkey1(" + btnSearch.ClientID + ",event)");
            txtFromDate.Attributes.Add("onkeydown", "funfordefautenterkey1(" + btnSearch.ClientID + ",event)");
            txtEndDate.Attributes.Add("onkeydown", "funfordefautenterkey1(" + btnSearch.ClientID + ",event)");
        }
    }

    protected void BindPatientIEDetails(string patientId = null, string searchText = null)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connString_Test_Live"].ConnectionString))
        {
            SqlCommand cmd = new SqlCommand("nusp_GetPatientIEDetails_new", con);

            if (!string.IsNullOrEmpty(patientId))
            {
                 cmd.Parameters.AddWithValue("@Patient_Id", hfPatientId.Value);
                 // cmd.Parameters.AddWithValue("@Patient_Id", patientId);
            }
            else if (!string.IsNullOrEmpty(searchText) && string.IsNullOrEmpty(patientId))
            {
                string keyword = searchText.TrimStart(("Mrs. ").ToCharArray());
                cmd.Parameters.AddWithValue("@SearchText", keyword);
            }
            else
            {
                if (Session["Location"] != null)
                {
                    cmd.Parameters.AddWithValue("@LocationId", Convert.ToString(Session["Location"]));
                }
            }
            if (!string.IsNullOrEmpty(txtFromDate.Text) && !string.IsNullOrEmpty(txtEndDate.Text))
            {
                cmd.Parameters.AddWithValue("@SDate", txtFromDate.Text);
                cmd.Parameters.AddWithValue("@EDate", txtEndDate.Text);

            }
            else if (!string.IsNullOrEmpty(txtFromDate.Text) && string.IsNullOrEmpty(txtEndDate.Text))
            {
                cmd.Parameters.AddWithValue("@SDate", txtFromDate.Text);
            }


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 120;
            con.Open();
            DataTable dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();

            string _query = "";
            DataRow row;
           
                if (ddl_location.SelectedIndex > 0)
            {
                if (string.IsNullOrEmpty(_query))
                {
                    _query = " Location_ID=" + ddl_location.SelectedItem.Value;
                }
                else
                    _query = _query + " and Location_ID=" + ddl_location.SelectedItem.Value;
            }
            else
            {
                if (string.IsNullOrEmpty(_query))
                    _query = " Location_ID in (" + Session["Locations"].ToString() + ")";
                else
                    _query = _query + " and Location_ID in (" + Session["Locations"].ToString() + ")";
            }



            try
            {
                dt = dt.Select(_query).CopyToDataTable();
                DataView dv = dt.DefaultView;
                dv.Sort = "LastTestDate desc";
                dt = dv.ToTable();
            }
            catch (Exception ex)
            {
                dt = null;
            }


            con.Close();
            Session["iedata"] = dt;


            gvPatientDetails.DataSource = dt;
            gvPatientDetails.DataBind();
            hfPatientId.Value = null;
        }
    }

    private void bindLocation()
    {
        DataSet ds = new DataSet();

        string query = "select Location,Location_ID from tblLocations ";
        if (!string.IsNullOrEmpty(Session["Locations"].ToString()))
        {
            query = query + " where Location_ID in (" + Session["Locations"] + ") AND Is_Active = 1";
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
    protected void gvPatientDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPatientDetails.PageIndex = e.NewPageIndex;
        //BindPatientIEDetails();
        BindPatientIEDetails(hfPatientId.Value, txtSearch.Text.Trim());

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindPatientIEDetails(hfPatientId.Value, txtSearch.Text.Trim());
    }
    protected void gvPatientFUDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView gvPatientFUDetails = (sender as GridView);
        hfCurrentlyOpened.Value = gvPatientFUDetails.ToolTip;
        gvPatientFUDetails.PageIndex = e.NewPageIndex;
        bindFUDetails(gvPatientFUDetails);
    }

    protected void bindFUDetails(GridView gvPatientFUDetails)
    {
        BusinessLogic bl = new BusinessLogic();
        gvPatientFUDetails.DataSource = bl.GetFUDetails(Convert.ToInt32(gvPatientFUDetails.ToolTip));
        gvPatientFUDetails.DataBind();
    }
    protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            DataRowView drv = e.Row.DataItem as DataRowView;

            if (string.IsNullOrEmpty(Convert.ToString(drv["ClaimNumber"])))
            {
                e.Row.BackColor = System.Drawing.Color.Yellow;
            }
            else if (Convert.ToInt32(drv["InsCo_ID"]) == 0)
            {
                e.Row.BackColor = System.Drawing.Color.Yellow;
            }


            string patientIEId = gvPatientDetails.DataKeys[e.Row.RowIndex].Value.ToString();
            BusinessLogic bl = new BusinessLogic();
            GridView gvPatientFUDetails = e.Row.FindControl("gvPatientFUDetails") as GridView;
            gvPatientFUDetails.ToolTip = patientIEId;
            gvPatientFUDetails.DataSource = bl.GetFUDetails(Convert.ToInt32(patientIEId));
            gvPatientFUDetails.DataBind();
        }
    }

    protected void gvPatientDetails_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvPatientDetails.PageIndex = e.NewPageIndex;
        //BindPatientIEDetails();
        BindPatientIEDetails(hfPatientId.Value, txtSearch.Text.Trim());
    }

    protected void lbtnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/Login.aspx");
    }


    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        Session["PatientIE_ID"] = null;
        Response.Redirect("Page1.aspx");
    }
    protected void lnk_openIE_Click(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        Response.Redirect("Page1.aspx?id=" + btn.CommandArgument);
    }

    protected void btnSaveSign_Click(object sender, EventArgs e)
    {
        byte[] blob = null;
        if (string.IsNullOrEmpty(hidBlobServer.Value) == false)
        {
            try
            {
                string blobstring = hidBlobServer.Value.Split(',')[1];
                blob = Convert.FromBase64String(blobstring);


                DirectoryInfo hdDirectoryInWhichToSearch = new DirectoryInfo(Server.MapPath("~/Sign/"));
                FileInfo[] filesInDir = hdDirectoryInWhichToSearch.GetFiles(patientIEIDServer.Value.ToString() + "*.*");
                string fullName = string.Empty;
                foreach (FileInfo foundFile in filesInDir)
                {
                    foundFile.Delete();
                }


                string path = HttpContext.Current.Server.MapPath("~/Sign/");
                string fname = patientIEIDServer.Value.ToString() + "_" + System.DateTime.Now.Millisecond.ToString() + ".jpg";

                string fullpath = path + fname;

                File.WriteAllBytes(fullpath, blob);

                DBHelperClass db = new DBHelperClass();
                string query = "";
                if (patientFUIDServer.Value == "0")
                    query = "delete from tblPatientIESign where PatientIE_ID=" + patientIEIDServer.Value;
                else if (patientIEIDServer.Value == "0")
                    query = "delete from tblPatientIESign where PatinetFU_ID=" + patientFUIDServer.Value;

                db.executeQuery(query);
                query = "insert into tblPatientIESign values(" + patientIEIDServer.Value + ",'" + fullpath + "'," + patientFUIDServer.Value + ",'" + hidBlobServer.Value + "',getdate(),1)";
                db.executeQuery(query);


                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "closeSignModelPopup();", true);

                string name = "";



            }
            catch (Exception ex)
            {
            }

        }
    }

    protected void lnkSignFU_Click(object sender, EventArgs e)
    {
        LinkButton lnk = sender as LinkButton;
        DBHelperClass db = new DBHelperClass();
        DataSet ds = db.selectData("select * from tblPatientIESign where PatinetFU_ID=" + lnk.CommandArgument);
        bool flag = false;
        string filename = "";
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            flag = true;
            filename = ds.Tables[0].Rows[0]["sign_path"].ToString();
        }

        ClientScript.RegisterStartupScript(this.GetType(), "PopupFU", "openSignModelPopup(0," + lnk.CommandArgument + ",'" + flag + "','" + filename + "');", true);
    }

    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkdel = sender as LinkButton;
            SqlParameter[] parameters = new SqlParameter[1];
            parameters[0] = new SqlParameter("@patientIEID", lnkdel.CommandArgument);

            int val = db.executeSP("nusp_Delete_PatientIE", parameters);
            if (val > 0)
                BindPatientIEDetails();
        }
        catch (Exception ex)
        {
            Logger.Error(ex);
        }
    }

    protected void lnkDelete_FU_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkdel = sender as LinkButton;
            SqlParameter[] parameters = new SqlParameter[1];
            parameters[0] = new SqlParameter("@patientFUID", lnkdel.CommandArgument);

            int val = db.executeSP("nusp_Delete_PatientFU", parameters);
            if (val > 0)
                BindPatientIEDetails();
        }
        catch (Exception ex)
        {
            Logger.Error(ex);
        }
    }

    protected void lnkSignIE_Click(object sender, EventArgs e)
    {
        LinkButton lnk = sender as LinkButton;

        string[] str = lnk.CommandArgument.Split(',');

        DBHelperClass db = new DBHelperClass();
        DataSet ds = db.selectData("select * from tblPatientIESign where PatientIE_ID=" + str[0]);
        bool flag = false;
        string filename = "";
        string pname = str[2] + " " + str[3];
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            flag = true;
            filename = ds.Tables[0].Rows[0]["sign_path"].ToString();
        }
        bindSignHTML(str[1], pname);
        ClientScript.RegisterStartupScript(this.GetType(), "PopupIE", "openSignModelPopup(" + str[0] + ",0,'" + flag + "','" + filename + "');", true);
    }
    public void bindSignHTML(string type, string pname)
    {
        string path = "";

        if (type.ToLower() == "nf")
            path = Server.MapPath("~/Template/NFSignpade.html");
        else if (type.ToLower() == "wc")
            path = Server.MapPath("~/Template/WCSignpade.html");

        string body = File.ReadAllText(path);

        body = body.Replace("#date", System.DateTime.Now.ToString("MM/dd/yyyy"));
        body = body.Replace("#pname", pname);

        divSignHTML.InnerHtml = body;


    }
    protected void lnkuploadsign_Click(object sender, EventArgs e)
    {
        LinkButton lnk = sender as LinkButton;

        DBHelperClass db = new DBHelperClass();
        DataSet ds = db.selectData("select * from tblPatientIESign where PatientIE_ID=" + lnk.CommandArgument);
        bool flag = false;
        string filename = "";
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            flag = true;
            filename = ds.Tables[0].Rows[0]["sign_path"].ToString();
        }

        ClientScript.RegisterStartupScript(this.GetType(), "PopupIE", "opensignupload(" + lnk.CommandArgument + ",0,'" + flag + "','" + filename + "');", true);
    }
    protected void btnuploadimage_Click(object sender, EventArgs e)
    {
        try
        {

            string path = HttpContext.Current.Server.MapPath("~/Sign/");
            string fname = patientIEIDServer.Value.ToString() + "_" + System.DateTime.Now.Millisecond.ToString() + ".jpg";
            string fullpath = path + "//" + fname;
            //if (File.Exists(fullpath))
            //{
            //    File.Delete(fullpath);
            //}
            DirectoryInfo hdDirectoryInWhichToSearch = new DirectoryInfo(Server.MapPath("~/Sign/"));
            FileInfo[] filesInDir = hdDirectoryInWhichToSearch.GetFiles(patientIEIDServer.Value.ToString() + "*.*");
            string fullName = string.Empty;
            foreach (FileInfo foundFile in filesInDir)
            {
                foundFile.Delete();
            }

            if (fupuploadsign.HasFile)
            { fupuploadsign.SaveAs(fullpath); }

            string query = "";
            if (patientFUIDServer.Value == "0")
                query = "delete from tblPatientIESign where PatientIE_ID=" + patientIEIDServer.Value;
            else if (patientIEIDServer.Value == "0")
                query = "delete from tblPatientIESign where PatinetFU_ID=" + patientFUIDServer.Value;

            db.executeQuery(query);
            query = "insert into tblPatientIESign values(" + patientIEIDServer.Value + ",'" + fname + "'," + patientFUIDServer.Value + ",'" + hidBlobServer.Value + "',getdate(),0)";
            db.executeQuery(query);

            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "closeSignuploadModalPopup();", true);
            string name = "";
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PatientIntakeList.aspx");
    }
}