using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UploadDocument : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uname"] == null)
            Response.Redirect("Login.aspx");
            LoadGrid();
          
            if (!Page.IsPostBack)
            {
                getExtension();
                LoadGrid();
            }
    }
    public void LoadGrid()
    {
        string root = Server.MapPath("~/Locations/") + DropDownList1.SelectedValue;
        //string root = @"F:\Locations\" + DropDownList1.SelectedValue;
        string[] fileEntries = Directory.GetFiles(root);
        List<ListItem> files = new List<ListItem>();
        foreach (var filename in fileEntries)
        {
            var fname = filename.Split('\\').Last();
            files.Add(new ListItem(fname));
            Session["filevalue"] = DropDownList1.SelectedValue;
        }
        gvDocument.DataSource = files;
        gvDocument.DataBind();
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        DropDownList1.SelectedValue = DropDownList1.SelectedItem.Value;
        Session["dirvalue"] = DropDownList1.SelectedValue;
        string root = Server.MapPath("~/Locations/") + DropDownList1.SelectedValue;
        string[] fileEntries = Directory.GetFiles(root);
        List<ListItem> files = new List<ListItem>();
        foreach (var filename in fileEntries)
        {
            var fn = filename.Split('\\').Last();
            files.Add(new ListItem(fn));
            Session["filevalue"] = DropDownList1.SelectedValue;
        }
        gvDocument.DataSource = files;
        gvDocument.DataBind();       
    }
    public static HttpResponse GetHttpResponse()
    {
        return HttpContext.Current.Response;
    }


    protected void btnView_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
        string filePath = Server.MapPath("~/Locations/") + gvDocument.DataKeys[gvrow.RowIndex].Value.ToString();

        Response.Write(String.Format("<script>window.open('{0}','_blank');</script>", "viewImage.aspx?fn=" + filePath));
    }
    protected void gvDocument_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Download")
        {
            Response.Clear();
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("content-disposition", "filename=" + e.CommandArgument);
            Response.TransmitFile(Server.MapPath("~/Locations/")+DropDownList1.SelectedValue+"\\"+ e.CommandArgument.ToString());
            Response.End();

        }
        if (e.CommandName == "Preview")
        {
            string filePath = "Locations//" + DropDownList1.SelectedValue + "//" + e.CommandArgument;
            string path = @"https://docs.google.com/viewer?url=#url&embedded=true";
            string url = "https://www.paintrax.com/" + filePath;
            path = path.Replace("#url", url);

            Response.Redirect(path);
            //Response.Write("<script>window.open('" + path + "','_new');</script>");
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
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        GridViewRow gvrow = btn.NamingContainer as GridViewRow;
        string filePath = Server.MapPath("~/Locations/") + gvDocument.DataKeys[gvrow.RowIndex].Value.ToString();
        Response.ContentType = "image/jpg";
        Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filePath + "\"");
        Response.TransmitFile(Server.MapPath(filePath));
        Response.End();
    } 
    
    public static void DownLoadFileFromServer(string path)
    {

        //This is used to get Project Location.

        string filePath = path;
        //This is used to get the current response.

        HttpResponse res = GetHttpResponse();

        res.Clear();
        res.AppendHeader("content-disposition", "attachment; filename=" + filePath);

        res.ContentType = "application/octet-stream";

        res.WriteFile(filePath);

        res.Flush();

        res.End();

    }
    public void getExtension()
    {
        //DropDownList1.Items.Clear();
        List<string> dirList = new List<string>();

        DirectoryInfo[] dir = new DirectoryInfo(Server.MapPath("~/Locations/")).GetDirectories("*.*", SearchOption.AllDirectories);
        foreach (DirectoryInfo d in dir)
        {
            dirList.Add(d.Name);
        }

        for (int i = 0; i < dirList.Count; i++)
        {

            Console.WriteLine(dirList[i]);
            DropDownList1.Items.Add(dirList[i]);           

        }



    }

    protected void btnCreateFolder_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath("~/Locations/") + txtFolderName.Text;

        Directory.CreateDirectory(path);
        //FileStream fs = File.Create(path + "\\Filename.xml");
        DropDownList1.Items.Clear();
        getExtension();
        LoadGrid();
    }
    private void DeleteDirectory(string path)
    {

        // Delete all files from the Directory

        foreach (string filename in Directory.GetFiles(path))
        {

            File.Delete(filename);

        }

        // Check all child Directories and delete files

        foreach (string subfolder in Directory.GetDirectories(path))
        {

            DeleteDirectory(subfolder);

        }

        Directory.Delete(path);

        Label1.Text = "Directory deleted successfully";


    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath("~/Locations/") +DropDownList1.SelectedValue;

        if (Directory.Exists(path))
        {

            DeleteDirectory(path);
            //LoadGrid();

        }

        else
        {

            Label1.Text = "Directory not exits";

        }
    }
    protected void btnRename_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath("~/Locations/");
        //string path = Server.MapPath("~");
        string Fromfol = "\\"+DropDownList1.SelectedValue;
        string Tofol = "\\"+txtBindFolderName.Text;
        Directory.Move(path + Fromfol, path + Tofol);
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (fup.HasFile)
        {
            string root = Server.MapPath("~/Locations/") + DropDownList1.SelectedValue + "\\";
            fup.SaveAs(root + fup.FileName);
            Label1.Text = "File Uploaded";
            Label1.ForeColor = System.Drawing.Color.ForestGreen;


            LoadGrid();
        }
        else
        {
            Label1.Text = "Please Select your file";
            Label1.ForeColor = System.Drawing.Color.Red;
        }  
    }

    
    public void ProcessDirectory(string targetDirectory, ref DataTable dt)
    {
        string[] fileEntries = Directory.GetFiles(targetDirectory);
        foreach (string fileName in fileEntries)
        {
            FileInfo fi = new FileInfo(fileName);
            dt.Rows.Add(null, fi.Name, targetDirectory);
        }
        string[] subdirectoryEntries = Directory.GetDirectories(targetDirectory);
        foreach (string subdirectory in subdirectoryEntries)
        {
            ProcessDirectory(subdirectory, ref dt);
        }
    }
}