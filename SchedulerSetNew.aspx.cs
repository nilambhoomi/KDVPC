using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class SchedulerSetNew : System.Web.UI.Page
{
    SchDbHelper db = new SchDbHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uname"] == null)
        { Response.Redirect("Login.aspx"); }


        if (!IsPostBack)
        {
            //Response.Write(Request.QueryString["appoint"].ToString());
            var values = JsonConvert.DeserializeObject<Dictionary<string, string>>(Request.QueryString["appoint"].ToString());
         //   Response.Write(values["AppointmentId"]);
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "Location_Id";
            ddlLocation.DataSource = db.GetData("select * from tblLocations  where Is_Active='True' Order By Location ");
            ddlLocation.DataBind();
//            ddlLocation.Items.Insert(0, new ListItem("Please Select", "0"));
            ddlLocation.SelectedValue = values["Location_ID"];
            lblFollowupDetail.Text = values["title"];
            txtFollowedUpOn.Text = Convert.ToDateTime(values["AppointmentDate"]+" "+ values["AppointmentStart"]).ToString("MM/dd/yyyy hh:mm tt").Replace('-', '/');// "03/25/2020 10:00 am";/// Request.QueryString["date"].ToString();
            //if (HttpContext.Current.Session["Location"] == null)
            //{
            //    ddlLocation.SelectedIndex = -1;
            //}
            //else
            //{
            //    ddlLocation.SelectedValue = Convert.ToString(Session["Location"]);
            //}


            // DataTable dt = db.GetData(@"select * from View_Appointment where id=" + Request.QueryString ["id"]);
            // if (dt.Rows.Count > 0)
            // {
            //     lblFollowupDetail.Text = dt.Rows[0]["title"].ToString();
            //     ddlLocation.SelectedValue = dt.Rows[0]["Location_Id"].ToString();
            // }
            //txtFollowedUpOn.Text = Convert.ToDateTime(Request.QueryString["date"]).ToString("MM/dd/yyyy hh:mm tt").Replace('-', '/');// "03/25/2020 10:00 am";/// Request.QueryString["date"].ToString();
            txtFollowedUpOn.Focus();

            
        }
    }

    protected void btnSet_Click(object sender, EventArgs e)
    {
        var values = JsonConvert.DeserializeObject<Dictionary<string, string>>(Request.QueryString["appoint"].ToString());

//        if (ddlLocation.SelectedIndex == 0)
//        {
//           ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Select Location First')", true);
//            return;
//        }
        CultureInfo culture = new CultureInfo("en-US");
        DateTime d = Convert.ToDateTime(txtFollowedUpOn.Text, culture);
        string AppointmentDate = d.ToString("yyyy-MM-dd HH:mm").Replace(" ", "T");
        if (!db.CheckDate(AppointmentDate, Convert.ToInt16(ddlLocation.SelectedValue)))
        {
            db.UpdateDate(values["AppointmentId"], txtFollowedUpOn.Text.Trim(), ddlLocation.SelectedValue);
            //            db.UpdateDate(Request.QueryString["id"].ToString(), txtFollowedUpOn.Text.Trim(), ddlLocation.SelectedValue);
            Response.Write("<script>parent.closemodal()</script>");
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Appointment already exsits')", true);
        }

        
      
    }
}