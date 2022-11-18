using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;

public partial class patientdocuments : System.Web.UI.Page
{
    DBHelperClass db = new DBHelperClass();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["uname"] == null)
            Response.Redirect("Login.aspx");
        if (!IsPostBack)
        {
            getData();

        }
    }

    private void getData()
    {
        try
        {
            if (Request["PID"] != null)
            {
                string query = ("select * from tblPatientDocument where PatientID= " + Request["PID"] + "");
                DataSet ds = db.selectData(query);
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    gvDocument.DataSource = ds;
                    gvDocument.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (fup.HasFiles)
            {
                string upload_folder_path = "~/PatientDocument/" + Request["PID"].ToString();


                if (!Directory.Exists(upload_folder_path))
                    Directory.CreateDirectory(Server.MapPath(upload_folder_path));


                foreach (HttpPostedFile uploadedFile in fup.PostedFiles)
                {
                    string filename = uploadedFile.FileName;
                    if (checkName(filename, Request["PID"].ToString()) == false)
                    {
                        // string filename = System.DateTime.Now.Millisecond.ToString() + "_" + uploadedFile.FileName;
                        string query = "insert into tblPatientDocument values('" + filename + "','" + System.DateTime.Now.ToString() + "','" + upload_folder_path + "/" + filename + "'," + Request["PID"].ToString() + ")";
                        db.executeQuery(query);

                        uploadedFile.SaveAs(System.IO.Path.Combine(Server.MapPath(upload_folder_path), uploadedFile.FileName));
                    }
                    // listofuploadedfiles.Text += String.Format("{0}<br />", uploadedFile.FileName);
                }
            }
            getData();
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {

        DBHelperClass db = new DBHelperClass();
        Button btn = sender as Button;
        string query = "select * from tblPatientDocument where Document_ID=" + btn.CommandArgument;
        DataSet ds = db.selectData(query);

        string path = @"https://docs.google.com/viewer?url=#url&embedded=true";
        string url = "https://www.paintrax.com/" + ds.Tables[0].Rows[0]["path"].ToString().Replace("~", "");

        path = path.Replace("#url", url);
        //iframeDocument.Src = path;

        // iframeDocument.Src = @"https://docs.google.com/viewer?url=http://infolab.stanford.edu/pub/papers/google.pdf&embedded=true";

        // ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopup();", true);
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        DBHelperClass db = new DBHelperClass();
        Button btn = sender as Button;
        string query = "delete from tblPatientDocument where Document_ID=" + btn.CommandArgument;
        db.executeQuery(query);
        getData();
    }

    private bool checkName(string fname, string pid)
    {
        bool _flag = true;
        try
        {
            DataSet dt = db.selectData("Select * from tblPatientDocument where DocName='" + fname + "' and PatientID=" + pid);

            if (dt != null && dt.Tables[0].Rows.Count > 0)
                _flag = true;
            else
                _flag = false;

        }
        catch (Exception ex)
        {
            _flag = true;
        }
        return _flag;
    }

 protected void btnDownload_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        string path = btn.CommandArgument.Split('#')[0];
        string fileName = btn.CommandArgument.Split('#')[1];

        WebClient req = new WebClient();
        HttpResponse response = HttpContext.Current.Response;
        string filePath = path;
        response.Clear();
        response.ClearContent();
        response.ClearHeaders();
        response.Buffer = true;
        response.AddHeader("Content-Disposition", @"attachment;filename=""" + fileName + @"""");
        byte[] data = req.DownloadData(Server.MapPath(filePath));
        response.BinaryWrite(data);
        response.End();

    }
}