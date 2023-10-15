using Microsoft.Reporting.WebForms;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Coffer_Systems
{
    public partial class TrailBalanceReport : System.Web.UI.Page
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;
        private string UserName { get; set; }
        private string Company { get; set; }
        private string GST { get; set; }
        private string UserID { get; set; }
        private string Status { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        [Obsolete]
        protected void setValues()
        {
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                string hostName5 = Dns.GetHostName();
                string IP5 = Dns.GetHostByName(hostName5).AddressList[0].ToString();
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * FROM Login_TBL lt join company c on c.name=lt.company Where ipAddress='" + IP5 + "'";
                cmd.ExecuteNonQuery();
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        Status = dr["status"].ToString();
                        UserID = dr["ID"].ToString();
                        UserName = dr["username"].ToString();
                        Company = dr["company"].ToString();
                        GST = dr["gst"].ToString();
                    }
                    con.Close();
                }
                else
                {
                    con.Close();
                    Response.Redirect("Login.aspx");
                }
            }
        }
        [Obsolete]
        private void GenerateReport(string reportPath, string storedProcedureName)
        {
            setValues();
            ReportViewer.ProcessingMode = ProcessingMode.Local;
            ReportViewer.LocalReport.ReportPath = Server.MapPath(reportPath);
            this.ReportViewer.LocalReport.ReportEmbeddedResource = reportPath;

            DateTime date1 = DateTime.ParseExact(fromDate.Value, "yyyy-MM-dd", null);
            string FromDate = date1.ToString("dd/MM/yyyy");

            DateTime date2 = DateTime.ParseExact(toDate.Value, "yyyy-MM-dd", null);
            string ToDate = date2.ToString("dd/MM/yyyy");

            DateTime CurrentDate = DateTime.Now;

            ReportParameter rp = new ReportParameter("Company", Company);
            ReportParameter rp1 = new ReportParameter("FromDate", FromDate);
            ReportParameter rp2 = new ReportParameter("ToDate", ToDate);
            ReportParameter rp3 = new ReportParameter("CurrentDate", CurrentDate.ToString());
            this.ReportViewer.LocalReport.SetParameters(new ReportParameter[] { rp, rp1, rp2, rp3 });
            // Customize ReportViewer settings
            ReportViewer.Width = Unit.Percentage(70);

            SqlConnection con = new SqlConnection(connectionStr);
            con.Open();
            SqlCommand cmd = new SqlCommand(storedProcedureName, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@FromDate", fromDate.Value);
            cmd.Parameters.AddWithValue("@ToDate", toDate.Value);
            cmd.Parameters.AddWithValue("@Company", Company);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            sda.Fill(dt);

            SqlDataReader sdr = cmd.ExecuteReader();
            ReportViewer.ProcessingMode = ProcessingMode.Local;
            ReportViewer.LocalReport.ReportPath = Server.MapPath(reportPath);


            ReportDataSource datasource = new ReportDataSource("DataSet1", dt);

            ReportViewer.LocalReport.DataSources.Clear();
            ReportViewer.LocalReport.DataSources.Add(datasource);

            ReportViewer.DataBind();
        }

        [Obsolete]
        protected void generateBtn_Click(object sender, EventArgs e)
        {
            if (ReportType.SelectedValue == "1")
            {
                GenerateReport("~/TrailBalanceReport.rdlc", "[GetFilteredTrialBalance]");
            }
            else if (ReportType.SelectedValue == "2")
            {
                GenerateReport("~/BalanceSheet.rdlc", "[GetBalanceSheet]");
            }
            else if (ReportType.SelectedValue == "3")
            {
                GenerateReport("~/ProfitLoss.rdlc", "[GetProfitLoss]");
            }
        }

    }
}