using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		Functions();

	}

	public void Functions()
	{
		string message = "";
		Process proc = null;
		try
		{
			string batDir = string.Format(@"c:\windows");
			proc = new Process();
			proc.StartInfo.WorkingDirectory = batDir;
			proc.StartInfo.FileName = "notepad.exe";
			proc.StartInfo.Arguments = "d:mytextfile.txt";
			proc.Start();
			//proc.StartInfo.RedirectStandardInput = false;
			//proc.StartInfo.RedirectStandardOutput = true;
			//proc.StartInfo.CreateNoWindow = true;
			//proc.StartInfo.UseShellExecute = false;
			//proc.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
			//proc.EnableRaisingEvents = true;
			//proc.WaitForExit();


			//string batDir = string.Format(@"D:\");
			//proc = new Process();
			//proc.StartInfo.WorkingDirectory = batDir;
			//proc.StartInfo.FileName = "testing.bat";
			//proc.StartInfo.Arguments = "mytextfile.txt";
			//proc.Start();


			//proc.StartInfo.CreateNoWindow = true;
			//proc.WaitForExit();
			////MessageBox.Show("Bat file executed !!");

			//string batDir1 = string.Format(@"c:\PainTrax");
			//Process notePad = new Process();
			//notePad.StartInfo.WorkingDirectory = batDir1;
			//notePad.StartInfo.FileName = "ReportGen.exe";
			//notePad.StartInfo.Arguments = "IE3069UID3";
			//notePad.Start();

			//System.Diagnostics.Process.Start(@"C:\Windows\notepad.exe d:fileslist.txt");

			message = "--------------------------Success---------------------------------";
			message += Environment.NewLine;
			string path = HostingEnvironment.MapPath("~/logFile.txt");
			using (StreamWriter writer = new StreamWriter(path, true))
			{
				writer.WriteLine(message);
				writer.Close();
			}
		}
		catch (Exception ex)
		{
			message = string.Format("Time: {0}", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
			message += Environment.NewLine;

			message += Environment.NewLine;
			message += string.Format("Message: {0}", ex.Message);
			message += Environment.NewLine;
			message += string.Format("StackTrace: {0}", ex.StackTrace);
			message += Environment.NewLine;
			message += string.Format("Source: {0}", ex.Source);
			message += Environment.NewLine;
			message += string.Format("TargetSite: {0}", ex.TargetSite.ToString());
			message += Environment.NewLine;
			message += "-----------------------------------------------------------";
			message += Environment.NewLine;
			string path = HostingEnvironment.MapPath("~/logFile.txt");
			using (StreamWriter writer = new StreamWriter(path, true))
			{
				writer.WriteLine(message);
				writer.Close();
			}
		}
	}
}