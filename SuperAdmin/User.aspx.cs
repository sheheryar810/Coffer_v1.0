using System;
using System.Collections;
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
    public partial class User : System.Web.UI.Page
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

        protected void ddlName_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox ddlName = sender as RadComboBox;
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                SqlCommand cmd1 = new SqlCommand(@"Select name from company where name!='All' order by name asc ", con);
                SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1);
                ddlName.DataSource = ds1.Tables[0];
                ddlName.DataTextField = "name";
                ddlName.DataValueField = "name";
                ddlName.DataBind();
                con.Close();
            }
        }

        protected void ddlStatus_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox ddlStatus = sender as RadComboBox;
            RadComboBoxItem item1 = new RadComboBoxItem();
            item1.Text = "Manager";
            item1.Value = "Manager";
            ddlStatus.Items.Add(item1);
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Assistant";
            item2.Value = "Assistant";
            ddlStatus.Items.Add(item2);
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                DataTable table = new DataTable();
                SqlCommand cmd = new SqlCommand("SELECT * from login_tbl where company!='All' order by company asc", con);
                SqlDataAdapter data = new SqlDataAdapter(cmd);
                data.Fill(table);
                (sender as RadGrid).DataSource = table;
                con.Close();
            }
        }

        protected void RadGrid1_BatchEditCommand(object sender, GridBatchEditingEventArgs e)
        {
            foreach (GridBatchEditingCommand command in e.Commands)
            {
                Hashtable oldValues = command.OldValues;
                Hashtable newValues = command.NewValues;
                using (SqlConnection con = new SqlConnection(connectionStr))
                {
                    if (command.Type == GridBatchEditingCommandType.Update)
                    {
                        string company = newValues["ID_Name"] == null ? null : newValues["ID_Name"].ToString();
                        string status = newValues["ID_Status"] == null ? null : newValues["ID_Status"].ToString();
                        string username = newValues["username"] == null ? null : newValues["username"].ToString();
                        string password = newValues["password"] == null ? null : newValues["password"].ToString();
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();

                        string str = "UPDATE login_tbl SET company='" + company + "', username='" + username + "', password='" + password + "', status='" + status + "' where id='" + id + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                    }
                    else if (command.Type == GridBatchEditingCommandType.Insert)
                    {
                        string company = newValues["ID_Name"] == null ? null : newValues["ID_Name"].ToString();
                        string status = newValues["ID_Status"] == null ? null : newValues["ID_Status"].ToString();
                        string username = newValues["username"] == null ? null : newValues["username"].ToString();
                        string password = newValues["password"] == null ? null : newValues["password"].ToString();
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        string str = "INSERT INTO login_tbl(username,company,password,status) VALUES('" + username + "','" + company + "','" + password + "','" + status + "')";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                    }
                    else if (command.Type == GridBatchEditingCommandType.Delete)
                    {
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        string str = "DELETE FROM login_tbl WHERE id= '" + id + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                    }
                }
            }
        }

        protected void RadComboBox1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }
    }
}

