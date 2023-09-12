using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Coffer_Systems
{
    public partial class MainMenu : System.Web.UI.Page
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;

        [Obsolete]
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    string hostName = Dns.GetHostName();
                    string IP = Dns.GetHostByName(hostName).AddressList[0].ToString();
                    SqlConnection con = new SqlConnection(connectionStr);
                    con.Open();
                    SqlCommand cmd1 = con.CreateCommand();
                    cmd1.CommandText = "select ipaddress from login_tbl where ipAddress='" + IP + "'";
                    object ipAddress = cmd1.ExecuteScalar();
                    if (ipAddress == null)
                    {
                        Response.Redirect("login.aspx");
                    }
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
        protected void logout_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("login.aspx");
        }

        protected void coding_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("codingmenu.aspx");
        }


        protected void sale_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("normalinvoice.aspx");
        }


        protected void ledger_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ledger.aspx");
        }

        protected void jv_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("jourvalVoucher.aspx");
        }

        protected void hv_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("hotelvoucher.aspx");
        }

        protected void refund_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("refund.aspx");
        }

        protected void Unnamed_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("CashReceivable.aspx");
        }

        protected void Unnamed_Click1(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("CashPayment.aspx");
        }

        protected void Unnamed_Click2(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("bankReceivable.aspx");
        }

        protected void Unnamed_Click3(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("bankPayment.aspx");
        }

        protected void Unnamed_Click4(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("inquiry.aspx");
        }

        protected void Unnamed_Click5(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("UserProfile.aspx");
        }

        protected void ReportBtn_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("TrailBalanceReport.aspx");
        }
    }
}