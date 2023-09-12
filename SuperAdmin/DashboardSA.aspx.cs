using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Coffer_Systems
{
    public partial class DashboardSA : System.Web.UI.Page
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;
        public static class Global
        {
            public static int offset;
        }
        private string UserName { get; set; }
        private string Company1 { get; set; }
        private string GST { get; set; }
        private string UserID { get; set; }
        private string Status { get; set; }
        [Obsolete]
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                setValues();
                if (Company1 != "")
                {
                    if (!Page.IsPostBack)
                    {
                        user.Text = UserName;
                        using (SqlConnection con = new SqlConnection(connectionStr))
                        {
                            con.Open();
                            SqlCommand countuser = new SqlCommand("SELECT count(id) from login_tbl where company!='All'", con);
                            string usercount = countuser.ExecuteScalar().ToString();
                            userscount.InnerText = usercount.ToString();
                            SqlCommand countcompany = new SqlCommand("SELECT count(id) from company where name!='All'", con);
                            string companycount = countcompany.ExecuteScalar().ToString();
                            companiescount.InnerText = companycount.ToString();
                            con.Close();
                        }
                    }
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                    Response.Write("<script>alert('Application Expired');</script>");
                }
            }
            catch (Exception)
            {
                Response.Redirect("../Login.aspx");
                Response.Write("<script>alert('Application Expired');</script>");
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
                        Company1 = dr["company"].ToString();
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
    }
}