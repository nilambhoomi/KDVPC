using IntakeSheet.BLL;
using IntakeSheet.DAL;
using IntakeSheet.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using Newtonsoft.Json;
using System.Web.Services;
using System.Collections;
using System.Web.Script.Serialization;

public partial class POCFUSummary : System.Web.UI.Page
{
    DBHelperClass gDbhelperobj = new DBHelperClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uname"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (Session["patientFUId"] == null && Session["PatientIE_ID"] == null)
        {
            Session["bodyPartsList"] = null;
            Response.Redirect("AddFu.aspx");

        }
        if (!IsPostBack)
        {
            bindPOC();
        }
    }
    public void bindPOC(bool isinhouse = false)
    {
        try
        {
            DBHelperClass db = new DBHelperClass();

            string SqlStr = @"Select Mcode, 
                        CASE 
                              WHEN p.Requested is not null 
                               THEN Convert(varchar,p.ProcedureDetail_ID) +'_R'
                              ELSE 
                        		case when p.Scheduled is not null
                        			THEN  Convert(varchar,p.ProcedureDetail_ID) +'_S'
                        		ELSE
                        		   CASE
                        				WHEN p.Executed is not null
                        				THEN Convert(varchar,p.ProcedureDetail_ID) +'_E'
                              END  END END as ID, 
                        CASE 
                              WHEN p.Requested is not null 
                               THEN p.Heading
                              ELSE 
                        		case when p.Scheduled is not null
                        			THEN p.S_Heading
                        		ELSE
                        		   CASE
                        				WHEN p.Executed is not null
                        				THEN p.E_Heading
                              END  END END as Heading, 
                        	  CASE 
                              WHEN p.Requested is not null 
                               THEN p.PDesc
                              ELSE 
                        		case when p.Scheduled is not null
                        			THEN p.S_PDesc
                        		ELSE
                        		   CASE
                        				WHEN p.Executed is not null
                        				THEN p.E_PDesc
                              END  END END as PDesc,
 CASE 
                              WHEN p.Requested is not null 
                               THEN p.Requested
                              ELSE 
                        		case when p.Scheduled is not null
                        			THEN p.Scheduled
                        		ELSE
                        		   CASE
                        				WHEN p.Executed is not null
                        				THEN p.Executed
                              END  END END as PDate,
                              BodyPart,
                              ISNULL(pp.INhouseProcbit,0) INhouse
                        	 -- ,p.Requested,p.Heading RequestedHeading,p.Scheduled,p.S_Heading ScheduledHeading,p.Executed,p.E_Heading ExecutedHeading
                         from tblProceduresDetail p  inner join tblProcedures pp on pp.MCODE = p.MCODE and p.BodyPart= pp.BodyPart ";
            //@"WHERE PatientIE_ID = " + Session["PatientIE_ID"].ToString() + " and PatientFU_ID = " + Session["patientFUId"].ToString() + "  and IsConsidered=0  Order By BodyPart,Heading";


            if (ddlInhouse.SelectedValue.Equals("-1"))
            {
                SqlStr += "WHERE PatientIE_ID = " + Session["PatientIE_ID"].ToString() + " and PatientFU_ID = " + Session["patientFUId"].ToString() + "  and IsConsidered=0 Order By BodyPart,Heading";
            }
            else if (ddlInhouse.SelectedValue.Equals("1"))
            {
                SqlStr += "WHERE PatientIE_ID = " + Session["PatientIE_ID"].ToString() + " and PatientFU_ID = " + Session["patientFUId"].ToString() + "  and IsConsidered=0 and pp.INhouseProcbit = 1  Order By BodyPart,Heading ";
            }
            else if (ddlInhouse.SelectedValue.Equals("0"))
            {
                SqlStr += "WHERE PatientIE_ID = " + Session["PatientIE_ID"].ToString() + " and PatientFU_ID = " + Session["patientFUId"].ToString() + "  and IsConsidered=0 and pp.INhouseProcbit = 0  Order By BodyPart,Heading";
            }


            DataSet dsPOC = db.selectData(SqlStr);

            string strPoc = "";
            if (dsPOC != null && dsPOC.Tables[0].Rows.Count > 0)
            {
                repSummery.DataSource = dsPOC;
                repSummery.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void ddlInhouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlInhouse.SelectedValue != "-1" && ddlInhouse.SelectedValue.Equals("1"))
        { bindPOC(true); }
        else
        { bindPOC(false); }
    }
}