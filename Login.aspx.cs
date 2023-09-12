using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Threading;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace Coffer_Systems
{
    public partial class Login : System.Web.UI.Page
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;
        string UserName1, Status1, hostName1, IP1;

        protected string GetHostName1()
        {
            return hostName1;
        }

        [Obsolete]
        protected void forceSignIn_Click1(object sender, EventArgs e)
        {
            hostName1 = Dns.GetHostName();
            IP1 = Dns.GetHostByName(hostName1).AddressList[0].ToString();

            SqlConnection con = new SqlConnection(connectionStr);
            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * FROM Login_TBL lt join company c on c.name=lt.company Where officeID='" + officeID.Value + "' and UserName='" + userName.Value.ToString() + "' and Password='" + password.Value.ToString() + "' and Convert(Date, GetDate(), 101)<=todate";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    Status1 = dr["status"].ToString();
                    UserName1 = dr["username"].ToString();

                    SqlCommand cmd3 = con.CreateCommand();
                    cmd3.CommandText = "update Login_TBL set ipAddress='" + IP1 + "' Where username='" + UserName1 + "'";
                    cmd3.ExecuteNonQuery();

                    if (Status1 == "Super Admin")
                    {
                        Response.Redirect("SuperAdmin/DashboardSA.aspx", false);
                    }
                    else
                    {
                        Response.Redirect("MainMenu.aspx", false);
                    }
                }
            }
            con.Close();

        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [Obsolete]
        protected void LoginButton_Click(object sender, EventArgs e)
        {
            try
            {

                hostName1 = Dns.GetHostName();
                IP1 = Dns.GetHostByName(hostName1).AddressList[0].ToString();

                SqlConnection con = new SqlConnection(connectionStr);
                con.Open();
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * FROM Login_TBL lt join company c on c.name=lt.company Where officeID='" + officeID.Value + "' and UserName='" + userName.Value.ToString() + "' and Password='" + password.Value.ToString() + "' and Convert(Date, GetDate(), 101)<=todate";
                cmd.ExecuteNonQuery();
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        Status1 = dr["status"].ToString();
                        UserName1 = dr["username"].ToString();

                        SqlCommand cmd2 = con.CreateCommand();
                        cmd2.CommandText = "select ipAddress from Login_TBL Where UserName='" + userName.Value.ToString() + "'";
                        object ipAddress = cmd2.ExecuteScalar();
                        if (ipAddress == null || ipAddress.ToString() == "")
                        {
                            SqlCommand cmd1 = con.CreateCommand();
                            cmd1.CommandText = "update Login_TBL set ipAddress='" + IP1 + "' Where username='" + UserName1 + "'";
                            cmd1.ExecuteNonQuery();
                            if (Status1 == "Super Admin")
                            {
                                Response.Redirect("SuperAdmin/DashboardSA.aspx", false);
                            }
                            else
                            {
                                Response.Redirect("MainMenu.aspx", false);
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alertPopup", "alertPopup();", true);
                        }
                    }
                }
                else
                {
                    Response.Write("<script>alert('Username or Password is invalid. Please try again.')</script>");
                }
                con.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}