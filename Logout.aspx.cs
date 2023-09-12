using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Coffer_Systems
{
    public partial class Logout : System.Web.UI.Page
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;

        [Obsolete]
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string hostName = Dns.GetHostName();
                string IP = Dns.GetHostByName(hostName).AddressList[0].ToString();
                SqlConnection con = new SqlConnection(connectionStr);
                con.Open();
                SqlCommand cmd1 = con.CreateCommand();
                cmd1.CommandText = "update Login_TBL set ipAddress='' Where ipAddress='" + IP + "'";
                cmd1.ExecuteNonQuery();
                Response.Redirect("login.aspx");
            }
        }
    }
}