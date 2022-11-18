using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pdfPrepare : System.Web.UI.Page
{
    public void loadpdflist()
    {
        ddlPdf.Items.Clear();
        string[] filePaths = Directory.GetFiles(Server.MapPath("~/MapPdf"));
        ddlPdf.Items.Add(" -- Select Pdf --");
        for (int i = 0; i < filePaths.Length; i++)
        {
            if (filePaths[i].ToLower().EndsWith("pdf"))
                ddlPdf.Items.Add(filePaths[i].Substring(filePaths[i].LastIndexOf("\\") + 1));
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            loadpdflist();
        }
    }
    protected void addTextBox(string pdffile)
    {
        PdfReader pdfReader = null;
        PdfStamper pdfStamper = null;
        bool isFile=false, isTable=false,isChange=false;
        try
        {
            pdfReader = new PdfReader(pdffile);
            File.Delete(Server.MapPath("Files/_temp_man_text.pdf"));
            pdfStamper = new PdfStamper(pdfReader, new FileStream(Server.MapPath("Files/_temp_man_text.pdf"), FileMode.Create));
            AcroFields pdfFormFields = pdfStamper.AcroFields;
            foreach (KeyValuePair<string, iTextSharp.text.pdf.AcroFields.Item> de in pdfReader.AcroFields.Fields)
            {
               
                if (de.Key.ToString().ToLower() == "txttable" )
                    isFile = true;
                if (de.Key.ToString().ToLower() == "txttable")
                    isTable = true;

            }
            if (!isFile)
            {
                TextField tfile = new TextField(pdfStamper.Writer, new iTextSharp.text.Rectangle(0, 0, 50, 50), "");
                tfile.FieldName = "txtFile";
                tfile.Visibility = 1;
                if(chkMandatory.Checked)
                {
                    tfile.Text = "FileName";
                }
                pdfStamper.AddAnnotation(tfile.GetTextField(), 1);
                isChange = true;
            }
            if (!isTable)
            {
                TextField ttable = new TextField(pdfStamper.Writer, new iTextSharp.text.Rectangle(50, 0, 100, 50), "");
                ttable.FieldName = "txtTable";
                ttable.Visibility = 1;
                if (chkMandatory.Checked)
                {
                    ttable.Text = "View_Pdf";
                }
                pdfStamper.AddAnnotation(ttable.GetTextField(), 1);
                isChange = true;
            }
            pdfStamper.Close();
            pdfReader.Close();
            if (isChange)
            {
                File.Delete(pdffile);
                File.Move(Server.MapPath("Files/_temp_man_text.pdf"), pdffile);
            }
            
        }
        catch (Exception ex)
        {
            pdfStamper.Close();
            pdfReader.Close();
        }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (FilePdf.HasFile && FilePdf.FileName.ToLower().EndsWith(".pdf"))
        {
            try
            {
                FilePdf.SaveAs(Server.MapPath("MapPdf/" + FilePdf.FileName));
                loadpdflist();
                if(chkMandatory.Checked )
                {
                    addTextBox(Server.MapPath("MapPdf/" + FilePdf.FileName));
                }
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertBox", "alert('Pdf File Uploaded')", true);

            }
            catch (Exception ex)
            {
                lblPdf.Text = "Error !" + ex.Message;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertBox", "alert('Select Pdf File First')", true);

        }
    }

    protected void btnAddText_Click(object sender, EventArgs e)
    {
        if (ddlPdf.Text != " -- Select Pdf --")
        {
            addTextBox(Server.MapPath("MapPdf/" +ddlPdf.Text));
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertBox", "alert('Select Pdf First')", true);
        }
    }
}