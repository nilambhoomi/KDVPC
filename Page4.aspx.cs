using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;



public partial class Page4 : System.Web.UI.Page
{
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
                DBHelperClass db = new DBHelperClass();
                DataSet ds = db.selectData("select FreeForm from tblPatientIEDetailPage1 where PatientIE_ID=" + Session["PatientIE_ID"].ToString());
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txt_FreeForm.Text = ds.Tables[0].Rows[0][0].ToString();
                    bindChkValues(txt_FreeForm.Text);
                }

            }
        }
        Logger.Info(Session["uname"].ToString() + "- Visited in Page3 for -" + Convert.ToString(Session["LastNameIE"]) + Convert.ToString(Session["FirstNameIE"]) + "-" + DateTime.Now);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DBHelperClass db = new DBHelperClass();
        string query = "";

        query = "update  tblPatientIEDetailPage1 set FreeForm='" + txt_FreeForm.Text + "' where PatientIE_ID=" + Session["PatientIE_ID"].ToString();


        int val = db.executeQuery(query);

        if (val > 0)
        {
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), Guid.NewGuid().ToString(), "openPopup('mymodelmessage')", true);
            Logger.Info(Session["UserId"].ToString() + "--" + Session["uname"].ToString().Trim() + "-- Create IE - Page4 " + Session["PatientIE_ID"].ToString() + "--" + DateTime.Now);
            if (pageHDN.Value != null && pageHDN.Value != "")
            {
                Response.Redirect(pageHDN.Value.ToString());
            }
            else
            {
                Response.Redirect("Page5.aspx");
            }
        }

    }

    private void bindChkValues(string strVal)
    {
        if (!string.IsNullOrEmpty(strVal))
        {
            foreach (Control child in pnlCheckbox.Controls)
            {
                if (child is CheckBox)
                {
                    CheckBox chk = child as CheckBox;
                    if (chk.Text.Contains(','))
                    {
                        chk.Text = chk.Text.Replace(',', ' ');
                    }
                    if (strVal.Contains(chk.Text.TrimStart().ToLower()))
                    {
                        chk.Checked = true;
                    }
                }
            }
        }
    }

    protected void A_Fall_History_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Answering_The_Door_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Appliances_Laundry_Appliances_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Bending_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Carrying_Large_Objects_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Carrying_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Cleaning_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Cognitive_Impairment_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Decrease_In_Sensitivity_To_Heat_Pain_Pressure_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Diminished_Sense_Of_Touch_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Doing_Laundry_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Driving_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Emptying_The_Mailbox_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Getting_Dressed_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Getting_In_And_Out_Of_The_Home_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Getting_In_And_Out_Of_Bed_Chairs_Sofas_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Hearing_Problems_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Holding_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Household_Chores_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Incontinence_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Kneeling_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Lack_Of_Coordination_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Lifting_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Lifting_Heavy_Or_Bulky_Objects__CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Limited_Reach_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Moving_About_In_Individual_Rooms_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Moving_From_One_Room_To_Another_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Opening_Closing_Or_Locking_Windows_And_Doors_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Operating_Light_Switches_Faucets_Kitchen_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Physical_Weakness_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Playing_With_Children_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Poor_Grip_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Poor_Vision_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Poor_Balance_Gait_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Preparing_Meals_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Pulling_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Pushing_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Reaching_Items_In_Closets_And_Cabinets_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Reduced_Mobility_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Sex_Sexual_Dysfunction_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Sitting_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Socializing_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Sports_Activities_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Standing_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Stooping_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Twisting_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Use_Of_Cane_Walker_Wheelchair_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Using_The_Stairs_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Using_The_Bathtub_Or_Shower_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Using_The_Kitchen_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Using_The_Toilet_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Using_The_Telephone_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Walking_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }

    protected void Working_CheckedChanged(object sender, EventArgs e)
    {
        constructstring();
    }
    protected void lbtnProcedureDetails_Click(object sender, EventArgs e)
    {
        if (Session["PatientIE_ID"] != null)
        {
            Response.Redirect("~/TimeSheet.aspx?PId=" + Convert.ToString(Session["PatientIE_ID"]));
        }
    }
    private void constructstring()
    {
        string text = string.Empty;
        text = "The patient complains of difficulty with,";

        if (A_Fall_History.Checked)
        { text += A_Fall_History.Text + ","; }
        if (Answering_The_Door.Checked)
        { text += Answering_The_Door.Text + ","; }
        if (Appliances_Laundry_Appliances.Checked)
        { text += Appliances_Laundry_Appliances.Text + ","; }
        if (Bending.Checked)
        { text += Bending.Text + ","; }
        if (Carrying_Large_Objects.Checked)
        { text += Carrying_Large_Objects.Text + ","; }
        if (Carrying.Checked)
        { text += Carrying.Text + ","; }
        if (Cleaning.Checked)
        { text += Cleaning.Text + ","; }
        if (Cognitive_Impairment.Checked)
        { text += Cognitive_Impairment.Text + ","; }
        if (Decrease_In_Sensitivity_To_Heat_Pain_Pressure.Checked)
        { text += Decrease_In_Sensitivity_To_Heat_Pain_Pressure.Text + ","; }
        if (Diminished_Sense_Of_Touch.Checked)
        { text += Diminished_Sense_Of_Touch.Text + ","; }
        if (Doing_Laundry.Checked)
        { text += Doing_Laundry.Text + ","; }
        if (Driving.Checked)
        { text += Driving.Text + ","; }
        if (Emptying_The_Mailbox.Checked)
        { text += Emptying_The_Mailbox.Text + ","; }
        if (Getting_Dressed.Checked)
        { text += Getting_Dressed.Text + ","; }
        if (Getting_In_And_Out_Of_The_Home.Checked)
        { text += Getting_In_And_Out_Of_The_Home.Text + ","; }
        if (Getting_In_And_Out_Of_Bed_Chairs_Sofas.Checked)
        { text += Getting_In_And_Out_Of_Bed_Chairs_Sofas.Text + ","; }
        if (Hearing_Problems.Checked)
        { text += Hearing_Problems.Text + ","; }
        if (Holding.Checked)
        { text += Holding.Text + ","; }
        if (Household_Chores.Checked)
        { text += Household_Chores.Text + ","; }
        if (Incontinence.Checked)
        { text += Incontinence.Text + ","; }
        if (Kneeling.Checked)
        { text += Kneeling.Text + ","; }
        if (Lack_Of_Coordination.Checked)
        { text += Lack_Of_Coordination.Text + ","; }
        if (Lifting.Checked)
        { text += Lifting.Text + ","; }
        if (Lifting_Heavy_Or_Bulky_Objects_.Checked)
        { text += Lifting_Heavy_Or_Bulky_Objects_.Text + ","; }
        if (Limited_Reach.Checked)
        { text += Limited_Reach.Text + ","; }
        if (Moving_About_In_Individual_Rooms.Checked)
        { text += Moving_About_In_Individual_Rooms.Text + ","; }
        if (Moving_From_One_Room_To_Another.Checked)
        { text += Moving_From_One_Room_To_Another.Text + ","; }
        if (Opening_Closing_Or_Locking_Windows_And_Doors.Checked)
        { text += Opening_Closing_Or_Locking_Windows_And_Doors.Text + ","; }
        if (Operating_Light_Switches_Faucets_Kitchen.Checked)
        { text += Operating_Light_Switches_Faucets_Kitchen.Text + ","; }
        if (Physical_Weakness.Checked)
        { text += Physical_Weakness.Text + ","; }
        if (Playing_With_Children.Checked)
        { text += Playing_With_Children.Text + ","; }
        if (Poor_Grip.Checked)
        { text += Poor_Grip.Text + ","; }
        if (Poor_Vision.Checked)
        { text += Poor_Vision.Text + ","; }
        if (Poor_Balance_Gait.Checked)
        { text += Poor_Balance_Gait.Text + ","; }
        if (Preparing_Meals.Checked)
        { text += Preparing_Meals.Text + ","; }
        if (Pulling.Checked)
        { text += Pulling.Text + ","; }
        if (Pushing.Checked)
        { text += Pushing.Text + ","; }
        if (Reaching_Items_In_Closets_And_Cabinets.Checked)
        { text += Reaching_Items_In_Closets_And_Cabinets.Text + ","; }
        if (Reduced_Mobility.Checked)
        { text += Reduced_Mobility.Text + ","; }
        if (Sex_Sexual_Dysfunction.Checked)
        { text += Sex_Sexual_Dysfunction.Text + ","; }
        if (Sitting.Checked)
        { text += Sitting.Text + ","; }
        if (Socializing.Checked)
        { text += Socializing.Text + ","; }
        if (Sports_Activities.Checked)
        { text += Sports_Activities.Text + ","; }
        if (Standing.Checked)
        { text += Standing.Text + ","; }
        if (Stooping.Checked)
        { text += Stooping.Text + ","; }
        if (Twisting.Checked)
        { text += Twisting.Text + ","; }
        if (Use_Of_Cane_Walker_Wheelchair.Checked)
        { text += Use_Of_Cane_Walker_Wheelchair.Text + ","; }
        if (Using_The_Stairs.Checked)
        { text += Using_The_Stairs.Text + ","; }
        if (Using_The_Bathtub_Or_Shower.Checked)
        { text += Using_The_Bathtub_Or_Shower.Text + ","; }
        if (Using_The_Kitchen.Checked)
        { text += Using_The_Kitchen.Text + ","; }
        if (Using_The_Toilet.Checked)
        { text += Using_The_Toilet.Text + ","; }
        if (Using_The_Telephone.Checked)
        { text += Using_The_Telephone.Text; }
        if (Walking.Checked)
        { text += Walking.Text + ","; }
        if (Working.Checked)
        { text += Working.Text + ","; }

        string result = text.ToLower().Replace("the patient complains of difficulty with,", "The patient complains of difficulty with");
        txt_FreeForm.Text = result.TrimEnd(',');
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MenuHighlight();", true);
    }
}