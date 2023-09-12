using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net;

namespace Coffer_Systems
{
    public partial class SiteMaster : MasterPage
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;

        [Obsolete]
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                string hostName1 = Dns.GetHostName();
                string IP1 = Dns.GetHostByName(hostName1).AddressList[0].ToString();

                SqlConnection conIP = new SqlConnection(connectionStr);
                conIP.Open();

                SqlCommand cmdIP = conIP.CreateCommand();
                cmdIP.CommandType = CommandType.Text;
                cmdIP.CommandText = "select * FROM Login_TBL lt join company c on c.name=lt.company Where ipAddress='" + IP1 + "'";
                cmdIP.ExecuteNonQuery();
                DataTable dtIP = new DataTable();
                SqlDataAdapter daIP = new SqlDataAdapter(cmdIP);
                daIP.Fill(dtIP);
                if (dtIP.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtIP.Rows)
                    {
                        string OfficeID1 = dr["officeID"].ToString();
                        string Status1 = dr["status"].ToString();
                        string UserID1 = dr["ID"].ToString();
                        string UserName1 = dr["username"].ToString();
                        string Company1 = dr["company"].ToString();
                        string GST1 = dr["gst"].ToString();

                        usernameLabel.Text = UserName1;
                        usernameLabel.ForeColor = System.Drawing.Color.Black;

                        officeIDLabel.Text = "CofferID: " + OfficeID1;
                        officeIDLabel.ForeColor = System.Drawing.Color.Black;
                    }

                    SqlCommand cmd1IP = conIP.CreateCommand();
                    cmd1IP.CommandType = CommandType.Text;
                    cmd1IP.CommandText = "select imageData FROM Login_TBL Where ipAddress='" + IP1 + "'";
                    object imageIP = cmd1IP.ExecuteScalar();
                    if (!Convert.IsDBNull(imageIP)) 
                    {
                        byte[] bytes = (byte[])imageIP;
                        string strBase64 = Convert.ToBase64String(bytes);
                        profilePic.ImageUrl = "data:Image/png;base64," + strBase64;
                    }
                    conIP.Close();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}