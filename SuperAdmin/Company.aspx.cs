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
using Telerik.Pdf;
using Telerik.Web.UI;
using Telerik.Web.UI.Chat;

namespace Coffer_Systems
{
    public partial class Company : System.Web.UI.Page
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
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                DataTable table = new DataTable();
                SqlCommand cmd = new SqlCommand("SELECT * from company where name!='All' order by name asc", con);
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
                    var officeId=officeID.Value.ToString();
                    if (command.Type == GridBatchEditingCommandType.Update)
                    {
                        string name = newValues["name"] == null ? null : newValues["name"].ToString();
                        string gst = newValues["gst"] == null ? null : newValues["gst"].ToString();
                        string country = newValues["ID_Country"] == null ? null : newValues["ID_Country"].ToString();
                        string city = newValues["ID_City"] == null ? null : newValues["ID_City"].ToString();
                        string fromdate = newValues["fromdate"] == null ? null : newValues["fromdate"].ToString();
                        string todate = newValues["todate"] == null ? null : newValues["todate"].ToString();
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        if (officeId == "")
                        {
                            officeId = newValues["officeID"] == null ? null : newValues["officeID"].ToString();
                        }

                        string str = "UPDATE company SET gst='"+ gst +"', name='" + name + "', country='" + country + "', city='" + city + "', officeID='" + officeId + "', fromdate='" + fromdate + "', todate='" + todate + "' where id='" + id + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                    }
                    else if (command.Type == GridBatchEditingCommandType.Insert)
                    {
                        string name = newValues["name"] == null ? null : newValues["name"].ToString();
                        string gst = newValues["gst"] == null ? null : newValues["gst"].ToString();
                        string country = newValues["ID_Country"] == null ? null : newValues["ID_Country"].ToString();
                        string city = newValues["ID_City"] == null ? null : newValues["ID_City"].ToString();
                        string fromdate = newValues["fromdate"] == null ? null : newValues["fromdate"].ToString();
                        string todate = newValues["todate"] == null ? null : newValues["todate"].ToString();
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        if (officeId == "")
                        {
                            officeId = newValues["officeID"] == null ? null : newValues["officeID"].ToString();
                        }
                        string str = "INSERT INTO company(gst,name,country,city,officeID,fromdate,todate) VALUES('" + gst + "','" + name + "','" + country + "','" + city + "','" + officeId + "','" + fromdate + "','" + todate + "')";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                    }
                    else if (command.Type == GridBatchEditingCommandType.Delete)
                    {
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        string str = "DELETE FROM company WHERE id= '" + id + "'";
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
        protected void ddlCountry_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox ddlCountry = sender as RadComboBox;
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                SqlCommand cmd1 = new SqlCommand(@"Select * from countries where code='PK' order by name", con);
                SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1);
                ddlCountry.DataSource = ds1.Tables[0];
                ddlCountry.DataTextField = "name";
                ddlCountry.DataValueField = "code";
                ddlCountry.DataBind();
                con.Close();
            }
        }
        protected void ddlCity_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox ddlCity = sender as RadComboBox;
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                SqlCommand cmd1 = new SqlCommand(@"select distinct Name,citycode from cities where countryCode='PK' order by name", con);
                SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1);
                ddlCity.DataSource = ds1.Tables[0];
                ddlCity.DataTextField = "name";
                ddlCity.DataValueField = "citycode";
                ddlCity.DataBind();
                con.Close();
            }
        }
    }
}
