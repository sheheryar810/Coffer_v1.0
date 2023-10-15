using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Coffer_Systems
{
    public partial class Login : System.Web.UI.Page
    {
        private string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                // It's a postback, set the password field value
                password.Value = Request.Form[password.UniqueID];
            }
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            try
            {
                string officeId = officeID.Value;
                string usernameValue = userName.Value;
                string passwordValue = password.Value;

                if (string.IsNullOrEmpty(officeId) || string.IsNullOrEmpty(usernameValue) || string.IsNullOrEmpty(passwordValue))
                {
                    Response.Write("<script>alert('Please fill in all the required fields.')</script>");
                    return;
                }

                string hostName = Dns.GetHostName();
                string ipAddress = Dns.GetHostByName(hostName).AddressList[0].ToString();

                using (SqlConnection con = new SqlConnection(connectionStr))
                {
                    con.Open();

                    string query = "SELECT * FROM Login_TBL lt JOIN company c ON c.name = lt.company " +
                                   "WHERE officeID = @officeID AND UserName = @userName AND Password = @password " +
                                   "AND CONVERT(DATE, GETDATE(), 101) <= todate";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@officeID", officeId);
                        cmd.Parameters.AddWithValue("@userName", usernameValue);
                        cmd.Parameters.AddWithValue("@password", passwordValue);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    string status = reader["status"].ToString();
                                    string username = reader["username"].ToString();
                                    string ipAddress1 = reader["ipAddress"].ToString();

                                    if (string.IsNullOrEmpty(ipAddress1))
                                    {
                                        reader.Close();
                                        SqlCommand updateCmd = new SqlCommand(
                                            "UPDATE Login_TBL SET ipAddress = @ipAddress WHERE username = @username", con);
                                        updateCmd.Parameters.AddWithValue("@ipAddress", ipAddress);
                                        updateCmd.Parameters.AddWithValue("@username", username);
                                        updateCmd.ExecuteNonQuery();

                                        string redirectUrl = status == "Super Admin"
                                            ? "SuperAdmin/DashboardSA.aspx"
                                            : "MainMenu.aspx";

                                        Response.Redirect(redirectUrl, false);
                                        break;
                                    }
                                    else
                                    {
                                        hiddenPassword.Value = passwordValue;
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertPopup", "alertPopup();", true);
                                        return;
                                    }
                                }
                            }
                            else
                            {
                                Response.Write("<script>alert('Username or Password is invalid. Please try again.')</script>");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void forceSignIn_Click1(object sender, EventArgs e)
        {
            try
            {
                string hostName = Dns.GetHostName();
                string ipAddress = Dns.GetHostByName(hostName).AddressList[0].ToString();

                using (SqlConnection con = new SqlConnection(connectionStr))
                {
                    con.Open();

                    string query = "SELECT * FROM Login_TBL lt JOIN company c ON c.name = lt.company " +
                                   "WHERE officeID = @officeID AND UserName = @userName AND Password = @password " +
                                   "AND CONVERT(DATE, GETDATE(), 101) <= todate";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@officeID", officeID.Value);
                        cmd.Parameters.AddWithValue("@userName", userName.Value.ToString());
                        cmd.Parameters.AddWithValue("@password", password.Value.ToString());

                        DataTable dt = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dt.Rows)
                            {
                                string status = dr["status"].ToString();
                                string username = dr["username"].ToString();

                                SqlCommand cmd3 = con.CreateCommand();
                                cmd3.CommandText = "UPDATE Login_TBL SET ipAddress = @ipAddress WHERE username = @username";
                                cmd3.Parameters.AddWithValue("@ipAddress", ipAddress);
                                cmd3.Parameters.AddWithValue("@username", username);
                                cmd3.ExecuteNonQuery();

                                string redirectUrl = status == "Super Admin"
                                    ? "SuperAdmin/DashboardSA.aspx"
                                    : "MainMenu.aspx";

                                Response.Redirect(redirectUrl, true);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}
