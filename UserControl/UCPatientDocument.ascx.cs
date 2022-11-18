﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_UCPatientDocument : System.Web.UI.UserControl
{
    DBHelperClass db = new DBHelperClass();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["uname"] == null)
            Response.Redirect("Login.aspx");
        if (!IsPostBack)
        {
            if (Session["PatientIE_ID"] == null)
            {

                Response.Redirect("Page1.aspx");

            }
            else
            {
                getData();
            }
        }
    }

    private void getData()
    {
        try
        {
            if (Session["PatientId"] != null)
            {
                string query = ("select * from tblPatientDocument where PatientID= " + Session["PatientId"] + "");
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
                string upload_folder_path = "~/PatientDocument/" + Session["PatientId"];

                if (!Directory.Exists(upload_folder_path))
                    Directory.CreateDirectory(Server.MapPath(upload_folder_path));


                foreach (HttpPostedFile uploadedFile in fup.PostedFiles)
                {
                    string filename = uploadedFile.FileName + "_" + System.DateTime.Now.Millisecond.ToString();
                    string query = "insert into tblPatientDocument values('" + filename + "','" + System.DateTime.Now.ToString() + "','" + upload_folder_path + "/" + filename + "'," + Session["PatientId"].ToString() + ")";
                    db.executeQuery(query);

                    uploadedFile.SaveAs(System.IO.Path.Combine(Server.MapPath(upload_folder_path), filename));
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