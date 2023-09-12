using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Chat;

namespace Coffer_Systems
{
    public partial class Ledger : System.Web.UI.Page
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;
        private string UserName { get; set; }
        private string Company { get; set; }
        private string GST { get; set; }
        private string UserID { get; set; }
        private string Status { get; set; }
        [Obsolete]
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    setValues();
                    using (SqlConnection con = new SqlConnection(connectionStr))
                    {
                        con.Open();

                        SqlCommand cmd1 = new SqlCommand(@"Select sub_head AS full_name, code from subheads where level='4' and (company='" + Company + "' OR company='All') order by sub_head ", con);
                        SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                        DataSet ds1 = new DataSet();
                        da1.Fill(ds1);
                        customerDropDownList.DataSource = ds1.Tables[0];
                        customerDropDownList.DataTextField = "full_name";
                        customerDropDownList.DataValueField = "code";
                        customerDropDownList.DataBind();
                        customerDropDownList.Items.Insert(0, new ListItem());

                        SqlCommand cmd2 = new SqlCommand(@"Select distinct tblname from ledger where (company='" + Company + "' OR company='All') order by tblname ", con);
                        SqlDataAdapter da2 = new SqlDataAdapter(cmd2);
                        DataSet ds2= new DataSet();
                        da2.Fill(ds2);
                        vTypeDropDownList.DataSource = ds2.Tables[0];
                        vTypeDropDownList.DataTextField = "tblname";
                        vTypeDropDownList.DataValueField = "tblname";
                        vTypeDropDownList.DataBind();
                        vTypeDropDownList.Items.Insert(0, new ListItem("All", ""));
                    }
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
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = new string[] { };
        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            this.RadGrid2.DataSource = new string[] { };
        }
        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            this.RadGrid3.DataSource = new string[] { };
        }
        protected override void RaisePostBackEvent(IPostBackEventHandler source, string eventArgument)
        {
            base.RaisePostBackEvent(source, eventArgument);
        }
    }
}