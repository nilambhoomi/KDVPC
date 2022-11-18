using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Text;
using System.IO;

public partial class Masterlogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //string query = "select * from masterlogin";
        //SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connString_WFP"].ConnectionString);

        //SqlCommand cm = new SqlCommand(query, cn);

        //SqlDataAdapter da = new SqlDataAdapter(cm);
        //DataSet ds = new DataSet();

        //da.Fill(ds);

        //if (ds.Tables[0].Rows.Count > 0)
        //{

        //    List<ListItem> lstwebsite = new List<ListItem>();
        //    lstwebsite.Add(new ListItem(" ", "Select Website"));
        //    foreach (DataRow dtRow in ds.Tables[0].Rows)
        //    {
        //        // On all tables' columns
        //        lstwebsite.Add(new ListItem(Convert.ToString(dtRow[3]), Convert.ToString(dtRow[3])));
        //    }
        //    ddlmasterwebsite.DataSource = lstwebsite;
        //    ddlmasterwebsite.DataBind();
        //}


    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string query = "select * from masterlogin where UserMasterId='" + txtUserMasterID.Text + "'";
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connString_Test_Live"].ConnectionString);

        SqlCommand cm = new SqlCommand(query, cn);

        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();

        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {

            StringBuilder sb = new StringBuilder();
            sb.Append("<html>");
            sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
            sb.AppendFormat("<form name='form' action='{0}' method='post'>", ds.Tables[0].Rows[0]["websiteLink"].ToString());
            sb.AppendFormat("<input type='hidden' name='UserMasterId' value='{0}'>", ds.Tables[0].Rows[0]["UserMasterId"].ToString());
            sb.AppendFormat("<input type='hidden' name='UserId' value='{0}'>", txt_uname.Text);
            sb.AppendFormat("<input type='hidden' name='password' value='{0}'>", txt_pass.Text);
            // Other params go here
            sb.Append("</form>");
            sb.Append("</body>");
            sb.Append("</html>");

            Response.Write(sb.ToString());

            Response.End();

            Response.Redirect(ds.Tables[0].Rows[0]["websiteLink"].ToString() + "?");
        }
        else
        {
            lblmess.Attributes.Add("style", "display:block");
        }

    }
}