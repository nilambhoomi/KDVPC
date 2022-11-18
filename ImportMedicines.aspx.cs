using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using log4net;

public partial class ImportMedicines : System.Web.UI.Page
{
    ILog log = log4net.LogManager.GetLogger(typeof(ImportMedicines));
    StringBuilder sb = new StringBuilder();
    DBHelperClass db = new DBHelperClass();
    SqlConnection oSQLConn = new SqlConnection();
    SqlCommand oSQLCmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
        Logger.Info("Import Medicine");
    }

    protected void ImportFromExcel(object sender, EventArgs e)
    {
        // CHECK IF A FILE HAS BEEN SELECTED.
        if ((FileUpload.HasFile))
        {

            if (!Convert.IsDBNull(FileUpload.PostedFile) &
                FileUpload.PostedFile.ContentLength > 0)
            {

                //FIRST, SAVE THE SELECTED FILE IN THE ROOT DIRECTORY.
                FileUpload.SaveAs(Server.MapPath(".") + "\\Med\\" + FileUpload.FileName);

                // SqlBulkCopy oSqlBulk = null;

                // SET A CONNECTION WITH THE EXCEL FILE.
                OleDbConnection myExcelConn = new OleDbConnection
                    ("Provider=Microsoft.ACE.OLEDB.12.0; " +
                        "Data Source=" + Server.MapPath(".") + "\\Med\\" + FileUpload.FileName +
                        ";Extended Properties=Excel 12.0;");
                try
                {
                    myExcelConn.Open();

                    // GET DATA FROM EXCEL SHEET.
                    OleDbCommand objOleDB = new OleDbCommand("SELECT *FROM [ListingReport$]", myExcelConn);

                    // READ THE DATA EXTRACTED FROM THE EXCEL FILE.
                    OleDbDataReader objBulkReader = null;
                    objBulkReader = objOleDB.ExecuteReader();
                    DataTable dt = new DataTable();
                    dt.Load(objBulkReader);
                    myExcelConn.Close();
                    // Read data from this file, when I'm done I don't need it any more
                    File.Delete(Server.MapPath(".") + "\\Med\\" + FileUpload.FileName); // IOException: file is in use

                    foreach (DataRow row in dt.Rows)
                    {
                        string iMedID, med, ieID, fuid;
                        iMedID = "0";
                        med = string.Empty;
                        ieID = string.Empty;
                        fuid = string.Empty;
                        // On all tables' columns
                        foreach (DataColumn dc in dt.Columns)
                        {


                            if (dc.ColumnName.Equals("PatientIE"))
                            {
                                ieID = Convert.ToString(row[dc]);
                            }
                            if (dc.ColumnName.Equals("PatientFU"))
                            {
                                fuid = Convert.ToString(row[dc]);
                            }
                            if (dc.ColumnName.Equals("Drug"))
                            {
                                med = Convert.ToString(row[dc]);
                            }
                        }
                        if (!string.IsNullOrEmpty(med) && !string.IsNullOrEmpty(ieID) && string.IsNullOrEmpty(fuid))
                        {
                            SaveMediUI(ieID, med);
                        }
                        if (!string.IsNullOrEmpty(fuid) && !string.IsNullOrEmpty(med) && string.IsNullOrEmpty(ieID))
                        {
                            SaveMediUIFU(fuid, med);
                        }

                    }

                    lblConfirm.Text = "DATA IMPORTED SUCCESSFULLY.";
                    lblConfirm.Attributes.Add("style", "color:green");

                }
                catch (Exception ex)
                {

                    lblConfirm.Text = ex.Message;
                    lblConfirm.Attributes.Add("style", "color:red");

                }
                finally
                {
                    // CLEAR.
                    myExcelConn.Close();
                    //oSqlBulk.Close();
                    //oSqlBulk = null;

                    //myExcelConn = null;
                }
            }
        }
        else
        {
            lblConfirm.Text = "Please select file to Import.";
            lblConfirm.Attributes.Add("style", "color:red");
        }
    }

    public void SaveMediUI(string ieID, string med)
    {
        string _ieMode = "";
        long _ieID = Convert.ToInt64(ieID);
        //long _MedID = Convert.ToInt64(iMedID);
        string sProvider = ConfigurationManager.ConnectionStrings["connString_Test_Live"].ConnectionString;
        string SqlStr = "";
        oSQLConn.ConnectionString = sProvider;
        oSQLConn.Open();
        SqlStr = "Select * from tblPatientIEDetailPage3 WHERE PatientIE_ID = " + ieID;
        SqlDataAdapter sqlAdapt = new SqlDataAdapter(SqlStr, oSQLConn);
        SqlCommandBuilder sqlCmdBuilder = new SqlCommandBuilder(sqlAdapt);
        DataTable sqlTbl = new DataTable();
        sqlAdapt.Fill(sqlTbl);
        DataRow TblRow;

        if (sqlTbl.Rows.Count == 0)
            _ieMode = "New";
        else if (sqlTbl.Rows.Count > 0)
            _ieMode = "Update";

        if (_ieMode == "New")
            TblRow = sqlTbl.NewRow();
        else if (_ieMode == "Update" || _ieMode == "Delete")
        {
            TblRow = sqlTbl.Rows[0];
            TblRow.AcceptChanges();
        }
        else
            TblRow = null;

        if (_ieMode == "Update" || _ieMode == "New")
        {
            TblRow["Kneehyperextension"] = false;
            TblRow["PatientIE_ID"] = _ieID;
            TblRow["OtherMedicine"] = TblRow["OtherMedicine"] + Environment.NewLine + med.ToString().Trim();

            if (_ieMode == "New")
            {
                //TblRow["CreatedBy"] = "ImportUtility";
                //TblRow["CreatedDateTime"] = DateTime.Now;
                sqlTbl.Rows.Add(TblRow);
            }
            sqlAdapt.Update(sqlTbl);
        }
        else if (_ieMode == "Delete")
        {
            TblRow.Delete();
            sqlAdapt.Update(sqlTbl);
        }
        if (TblRow != null)
            TblRow.Table.Dispose();
        sqlTbl.Dispose();
        sqlCmdBuilder.Dispose();
        sqlAdapt.Dispose();
        oSQLConn.Close();
    }

    public void SaveMediUIFU(string fuID, string med)
    {
        string _fuMode = "";
        long _fuID = Convert.ToInt64(fuID);
        // long _MedID = Convert.ToInt64(iMedID);
        string sProvider = System.Configuration.ConfigurationManager.ConnectionStrings["connString_Test_Live"].ConnectionString;
        string SqlStr = "";
        oSQLConn.ConnectionString = sProvider;
        oSQLConn.Open();
        SqlStr = "Select * from tblFUPatientFUDetailPage1 WHERE PatientFU_ID = " + fuID;
        SqlDataAdapter sqlAdapt = new SqlDataAdapter(SqlStr, oSQLConn);
        SqlCommandBuilder sqlCmdBuilder = new SqlCommandBuilder(sqlAdapt);
        DataTable sqlTbl = new DataTable();
        sqlAdapt.Fill(sqlTbl);
        DataRow TblRow;

        if (sqlTbl.Rows.Count == 0)
            _fuMode = "New";
        else if (sqlTbl.Rows.Count > 0)
            _fuMode = "Update";

        if (_fuMode == "New")
            TblRow = sqlTbl.NewRow();
        else if (_fuMode == "Update" || _fuMode == "Delete")
        {
            TblRow = sqlTbl.Rows[0];
            TblRow.AcceptChanges();
        }
        else
            TblRow = null;

        if (_fuMode == "Update" || _fuMode == "New")
        {
            //TblRow["MedicationID"] = _MedID;
            TblRow["PatientFU_ID"] = _fuID;
            TblRow["OtherMedicine"] = TblRow["OtherMedicine"] + Environment.NewLine + med.ToString().Trim();

            if (_fuMode == "New")
            {
                //TblRow["UpdatedBy"] = "Admin";
                //TblRow["UpdatedDateTime"] = DateTime.Now;
                sqlTbl.Rows.Add(TblRow);
            }
            sqlAdapt.Update(sqlTbl);
        }
        else if (_fuMode == "Delete")
        {
            TblRow.Delete();
            sqlAdapt.Update(sqlTbl);
        }
        if (TblRow != null)
            TblRow.Table.Dispose();
        sqlTbl.Dispose();
        sqlCmdBuilder.Dispose();
        sqlAdapt.Dispose();
        oSQLConn.Close();
    }

}