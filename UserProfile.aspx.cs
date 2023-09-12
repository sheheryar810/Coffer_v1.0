using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Coffer_Systems
{
    public partial class UserProfile : System.Web.UI.Page
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;
        string UserName, Company, GST, UserID, Status;

        [Obsolete]
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack == false)
            {
                setValues();
                lblMessage.Visible = false;

                SqlConnection con = new SqlConnection(connectionStr);
                con.Open();

                string hostName = Dns.GetHostName();
                string IP = Dns.GetHostByName(hostName).AddressList[0].ToString();
                SqlCommand cmd1 = con.CreateCommand();
                cmd1.CommandType = CommandType.Text;
                cmd1.CommandText = "select * FROM Login_TBL lt join company c on c.name=lt.company Where ipAddress='" + IP + "'";
                cmd1.ExecuteNonQuery();
                DataTable dt1 = new DataTable();
                SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                da1.Fill(dt1);
                if (dt1.Rows.Count > 0)
                {
                    foreach (DataRow dr1 in dt1.Rows)
                    {
                        Status = dr1["status"].ToString();
                        UserID = dr1["ID"].ToString();
                        UserName = dr1["username"].ToString();
                        Company = dr1["company"].ToString();
                        GST = dr1["gst"].ToString();
                    }

                    SqlCommand cmd3 = con.CreateCommand();
                    cmd3.CommandType = CommandType.Text;
                    cmd3.CommandText = "select imageData FROM Login_TBL Where UserName='" + UserName + "'";
                    object image = cmd3.ExecuteScalar();
                    if (!Convert.IsDBNull(image))
                    {
                        byte[] bytes = (byte[])image;
                        string strBase64 = Convert.ToBase64String(bytes);
                        Image1.ImageUrl = "data:Image/png;base64," + strBase64;
                    }
                    SqlCommand cmd = con.CreateCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * FROM Login_TBL Where UserName='" + UserName + "'";
                    cmd.ExecuteNonQuery();
                    DataTable dt = new DataTable();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    foreach (DataRow dr in dt.Rows)
                    {
                        user.Value = dr["UserName"].ToString();
                        email.Value = dr["email"].ToString();
                    }
                    con.Close();
                }
                else
                {
                    Response.Redirect("login.aspx");
                }
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
        protected void AddButton_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                string emailaddress = email.Value.ToString();
                con.Open();
                SqlCommand cmd = new SqlCommand("select id FROM Login_TBL Where UserName='" + UserName + "' and password='" + oldpass.Value.ToString() + "'", con);

                SqlCommand cmd1 = con.CreateCommand();
                cmd1.CommandType = CommandType.Text;
                cmd1.CommandText = "update Login_TBL set email='" + emailaddress + "' where UserName='" + UserName + "'";
                cmd1.ExecuteNonQuery();
                if (oldpass.Value.ToString() != "")
                {
                    string id = cmd.ExecuteScalar().ToString();
                    if (id.Length > 0)
                    {
                        if (pass1.Value.ToString() == pass2.Value.ToString())
                        {
                            SqlCommand cmd2 = con.CreateCommand();
                            cmd2.CommandType = CommandType.Text;
                            cmd2.CommandText = "update Login_TBL set password='" + pass2.Value.ToString() + "' where UserName='" + UserName + "' and password='" + oldpass.Value.ToString() + "'";
                            cmd2.ExecuteNonQuery();
                        }
                    }
                }
                con.Close();
            }
        }

        [Obsolete]
        protected void txtGetImage_Click(object sender, EventArgs e)
        {
            setValues();
            if (fileUpload.HasFile)
            {
                //To create a PostedFile
                HttpPostedFile File = fileUpload.PostedFile;
                string fileName = Path.GetFileName(File.FileName);
                string fileExtension = Path.GetExtension(File.FileName);
                int fileSize = File.ContentLength;
                if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".bmp" || fileExtension.ToLower() == ".jpeg" || fileExtension.ToLower() == ".png")
                {
                    Stream stream = File.InputStream;
                    BinaryReader binaryReader = new BinaryReader(stream);
                    byte[] bytes = binaryReader.ReadBytes((int)stream.Length);
                    using (SqlConnection con = new SqlConnection(connectionStr))
                    {
                        con.Open();
                        SqlCommand cmd = con.CreateCommand();
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "update Login_TBL set imageData=@imageData, name=@fileName where  UserName='" + user.Value.ToString() + "'";
                        SqlParameter param = new SqlParameter();
                        param.ParameterName = "@imageData";
                        param.Value = bytes;
                        SqlParameter param1 = new SqlParameter();
                        param1.ParameterName = "@fileName";
                        param1.Value = fileName;
                        cmd.Parameters.Add(param);
                        cmd.Parameters.Add(param1);
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                    lblMessage.Visible = true;
                    lblMessage.Text = "Upload Successful";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    string strBase64 = Convert.ToBase64String(bytes);
                    Image1.ImageUrl = "data:Image/png;base64," + strBase64;
                    HtmlImage image = Master.FindControl("profilePic") as HtmlImage;
                    (Page.Master.FindControl("profilePic") as System.Web.UI.WebControls.Image).ImageUrl = "data:Image/png;base64," + strBase64;
                }
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Only Images (.jpg, .bmp, .jpeg, .png) can be uploaded";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}