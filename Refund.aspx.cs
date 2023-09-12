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
using Telerik.Web.UI.Chat;

namespace Coffer_Systems
{
    public partial class Refund : System.Web.UI.Page
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

                        SqlCommand cmd1 = new SqlCommand(@"Select sub_head AS full_name , code from subheads where level='4' and (company='" + Company + "' OR company='All') order by sub_head ", con);
                        SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                        DataSet ds1 = new DataSet();
                        da1.Fill(ds1);
                        customerDropDownList.DataSource = ds1.Tables[0];
                        customerDropDownList.DataTextField = "full_name";
                        customerDropDownList.DataValueField = "code";
                        customerDropDownList.DataBind();
                        customerDropDownList.Items.Insert(0, new ListItem());
                        airlineDropDownList.DataSource = ds1.Tables[0];
                        airlineDropDownList.DataTextField = "full_name";
                        airlineDropDownList.DataValueField = "code";
                        airlineDropDownList.DataBind();
                        airlineDropDownList.Items.Insert(0, new ListItem());
                        transferDropDownList.DataSource = ds1.Tables[0];
                        transferDropDownList.DataTextField = "full_name";
                        transferDropDownList.DataValueField = "code";
                        transferDropDownList.DataBind();
                        transferDropDownList.Items.Insert(0, new ListItem());
                        con.Close();
                    }
                }
            }
            catch (Exception)
            {
                Response.Redirect("Login.aspx");
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
                con.Open();
                SqlCommand cmddel = new SqlCommand("delete from refund where invno='" + refund.Value + "' and tktno='" + tktno.Value + "' and company='" + Company + "'", con);
                SqlCommand cmd1del = new SqlCommand("delete from ledger where invno='" + refund.Value + "' and tblid='" + tblid.Value + "' and tblname='RFD' and company='" + Company + "'", con);
                cmddel.ExecuteNonQuery();
                cmd1del.ExecuteNonQuery();
                string strblnc = "select top 1 balance from ledger where head='" + airlineDropDownList.SelectedValue.ToString() + "' and company='" + Company + "' order by id desc";
                SqlCommand cmdb = new SqlCommand(strblnc, con);
                var balancevalairline = 0.0;
                var balance = cmdb.ExecuteScalar();
                if (balance != null)
                {
                    if (balance.ToString() != "")
                    {
                        balancevalairline = float.Parse(balance.ToString());
                    }
                }
                balancevalairline = balancevalairline + float.Parse(airlinerec.Value.ToString());

                string strblnc1 = "select top 1 balance from ledger where head='" + customerDropDownList.SelectedValue.ToString() + "' and company='" + Company + "' order by id desc";
                SqlCommand cmdb1 = new SqlCommand(strblnc1, con);
                var balancevalclient = 0.0;
                var balance1 = cmdb1.ExecuteScalar();
                if (balance1 != null)
                {
                    if (balance1.ToString() != "")
                    {
                        balancevalclient = float.Parse(balance1.ToString());
                    }
                }
                balancevalclient = balancevalclient - float.Parse(clientpay.Value.ToString());
                var status = "";
                if (invDropDownList.SelectedItem.Text == "Refund")
                {
                    status = "RFD";
                }
                else if (invDropDownList.SelectedItem.Text == "Void")
                {
                    status = "Void";
                }
                SqlCommand cmdrfd = new SqlCommand("update invoicing set status='" + status + "' where ticketno='" + tktno.Value.ToString() + "' and company='" + Company + "'", con);
                SqlCommand cmd = new SqlCommand("INSERT INTO[dbo].[refund](balance,passengername,client,refundno,invtype,etkt,tktno,[tkttype],bsp,xo,[rfdtype],[rcptno],[stockDate],[salesperson],[calcom],[percentage],[agent],[airlinename],[connjtkt],[xono],[passengertype],[sector],[class],[coupenno],[piatkt],[rdfclaim],[invno],[invDate],[validdate],[airline],[mainseg],[subseg],iata,mkt,other,soto,sp,yd,pk,fed,ced,xz,whairline,whclient,yq,pb,oth,tax,frtx,whtfix,comm,comamt,extra,comadj,tcom,airlinepay,servicech,serviceamt,gst,gstpay,ins,transferac,[kbairline],[clientreceive],profitloss,kbcust,commkb,disc,discamt,discadj,totalsp,totalinc,payment,gds,rfdpayment,cancelchrgs,saledate,airlinerec,clientpay,svc,tktval,receivable,[srvcchrgs],refunddate,username,company) values('" + clientpay.Value.ToString() + "','" + pname.Value.ToString() + "','" + customerDropDownList.SelectedValue.ToString() + "','" + refund.Value.ToString() + "','" + invDropDownList.SelectedItem.Text + "','" + etkt.Value.ToString() + "','" + tktno.Value.ToString() + "','" + tktDropDownList.SelectedItem.Text + "','" + bspDropDown1.SelectedItem.Text + "','" + xo.Value.ToString() + "','" + rfdDropDownList.SelectedItem.Text + "','" + rcptno.Value.ToString() + "','" + stockDate.Value.ToString() + "','" + salesperson.Value.ToString() + "','" + calcomm.Value.ToString() + "','" + percent.Value.ToString() + "','" + agent.Value.ToString() + "','" + airlineDropDownList.SelectedItem.Text + "','" + conjtkt.Value.ToString() + "','" + xono.Value.ToString() + "','" + catDropDownList.SelectedItem.Text + "','" + sector.Value.ToString() + "','" + @class.Value.ToString() + "','" + coupen.Value.ToString() + "','" + piatkt.Value.ToString() + "','" + rfdclain.Value.ToString() + "','" + invno.Value.ToString() + "','" + invDate.Value.ToString() + "','" + vldDate.Value.ToString() + "','" + airline.Value.ToString() + "','" + DropDownList2.SelectedItem.Text + "','" + DropDownList1.SelectedItem.Text + "','" + iata.Value.ToString() + "','" + mkt.Value.ToString() + "','" + other.Value.ToString() + "','" + soto.Value.ToString() + "','" + sp.Value.ToString() + "','" + yd.Value.ToString() + "','" + pk.Value.ToString() + "','" + fed.Value.ToString() + "','" + ced.Value.ToString() + "','" + xz.Value.ToString() + "','" + whairline.Value.ToString() + "','" + whclient.Value.ToString() + "','" + yq.Value.ToString() + "','" + pb.Value.ToString() + "','" + other.Value.ToString() + "','" + ttax.Value.ToString() + "','" + frtx.Value.ToString() + "','" + fixDropDownList.SelectedItem.Text + "','" + comm.Value.ToString() + "','" + comamt.Value.ToString() + "','" + extra.Value.ToString() + "','" + comadj.Value.ToString() + "','" + tcom.Value.ToString() + "','0','" + srvcchrg.Value.ToString() + "','" + srvcamt.Value.ToString() + "','0','0','" + ins.Value.ToString() + "','" + transferDropDownList.SelectedItem.Text + "','" + kbairline.Value.ToString() + "','0','0','" + kbcust.Value.ToString() + "','" + comkb.Value.ToString() + "','" + disc.Value.ToString() + "','" + discamt.Value.ToString() + "','" + discadj.Value.ToString() + "','" + tsp.Value.ToString() + "','" + tincome.Value.ToString() + "','" + payment.Value.ToString() + "','" + gds.Value.ToString() + "','" + rfdpmt.Value.ToString() + "','" + cnclchrg.Value.ToString() + "','" + saledate.Value.ToString() + "','" + airlinerec.Value.ToString() + "','" + clientpay.Value.ToString() + "','" + svc.Value.ToString() + "','" + tktval.Value.ToString() + "','" + receivable.Value.ToString() + "','" + srvcchrg.Value.ToString() + "','" + refunddate.Value.ToString() + "','" + UserName + "','" + Company + "')", con);
                cmd.ExecuteNonQuery();

                SqlCommand cmdid = new SqlCommand("select max(id) from refund where company='" + Company + "'", con);
                var id = cmdid.ExecuteScalar().ToString();

                SqlCommand cmd1 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,credit,debit,username,company,invno,tblname)values('" + sector.Value.ToString() + "','" + id + "','" + refunddate.Value.ToString() + "','" + airlineDropDownList.SelectedValue.ToString() + "','0','" + airlinerec.Value.ToString() + "','" + UserName + "','" + Company + "','" + refund.Value.ToString() + "','RFD')", con);
                SqlCommand cmd2 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,credit,debit,username,company,invno,tblname)values('" + sector.Value.ToString() + "','" + id + "','" + refunddate.Value.ToString() + "','" + customerDropDownList.SelectedValue.ToString() + "','" + clientpay.Value.ToString() + "','0','" + UserName + "','" + Company + "','" + refund.Value.ToString() + "','RFD')", con);
                cmd1.ExecuteNonQuery();
                cmd2.ExecuteNonQuery();
                cmdrfd.ExecuteNonQuery();
                if (srvcamt.Value.ToString() != "" && srvcamt.Value.ToString() != "0.00" && srvcamt.Value.ToString() != "0")
                {
                    SqlCommand cmd3 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,credit,debit,username,company,invno,tblname)values('" + sector.Value.ToString() + "','" + id + "','" + refunddate.Value.ToString() + "','4000003','0','" + srvcamt.Value.ToString() + "','" + UserName + "','" + Company + "','" + refund.Value.ToString() + "','RFD')", con);
                    cmd3.ExecuteNonQuery();
                }
                if (whairline.Value.ToString() != "" && whairline.Value.ToString() != "0.00" && whairline.Value.ToString() != "0")
                {
                    SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,credit,debit,username,company,invno,tblname)values('" + sector.Value.ToString() + "','" + id + "','" + refunddate.Value.ToString() + "','3110001','" + whairline.Value.ToString() + "','0','" + UserName + "','" + Company + "','" + refund.Value.ToString() + "','RFD')", con);
                    cmd4.ExecuteNonQuery();
                }
                if (comamt.Value.ToString() != "" && comamt.Value.ToString() != "0.00" && comamt.Value.ToString() != "0")
                {
                    SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,credit,debit,username,company,invno,tblname)values('" + sector.Value.ToString() + "','" + id + "','" + refunddate.Value.ToString() + "','4000002','0','" + comamt.Value.ToString() + "','" + UserName + "','" + Company + "','" + refund.Value.ToString() + "','RFD')", con);
                    cmd4.ExecuteNonQuery();
                }
                if (whclient.Value.ToString() != "" && whclient.Value.ToString() != "0.00" && whclient.Value.ToString() != "0")
                {
                    SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,credit,debit,username,company,invno,tblname)values('" + sector.Value.ToString() + "','" + id + "','" + refunddate.Value.ToString() + "','4000001','0','" + whclient.Value.ToString() + "','" + UserName + "','" + Company + "','" + refund.Value.ToString() + "','RFD')", con);
                    cmd4.ExecuteNonQuery();
                }
                if (discamt.Value.ToString() != "" && discamt.Value.ToString() != "0.00" && discamt.Value.ToString() != "0")
                {
                    SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,credit,debit,username,company,invno,tblname)values('" + sector.Value.ToString() + "','" + id + "','" + refunddate.Value.ToString() + "','3110002','" + discamt.Value.ToString() + "','0','" + UserName + "','" + Company + "','" + refund.Value.ToString() + "','INV')", con);
                    cmd4.ExecuteNonQuery();
                }
                if (ins.Value.ToString() != "" && ins.Value.ToString() != "0.00" && ins.Value.ToString() != "0")
                {
                    SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,credit,debit,username,company,invno,tblname)values('" + sector.Value.ToString() + "','" + id + "','" + refunddate.Value.ToString() + "','4010001','0','" + ins.Value.ToString() + "','" + UserName + "','" + Company + "','" + refund.Value.ToString() + "','RFD')", con);
                    cmd4.ExecuteNonQuery();
                }
                if (kbcust.Value.ToString() != "" && kbcust.Value.ToString() != "0.00" && kbcust.Value.ToString() != "0")
                {
                    SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,credit,debit,username,company,invno,tblname)values('" + sector.Value.ToString() + "','" + id + "','" + refunddate.Value.ToString() + "','3110003','" + kbcust.Value.ToString() + "','0','" + UserName + "','" + Company + "','" + refund.Value.ToString() + "','RFD')", con);
                    cmd4.ExecuteNonQuery();
                }
                if (kbairline.Value.ToString() != "" && kbairline.Value.ToString() != "0.00" && kbairline.Value.ToString() != "0")
                {
                    SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,credit,debit,username,company,invno,tblname)values('" + sector.Value.ToString() + "','" + id + "','" + refunddate.Value.ToString() + "','4000004','0','" + kbairline.Value.ToString() + "','" + UserName + "','" + Company + "','" + refund.Value.ToString() + "','RFD')", con);
                    cmd4.ExecuteNonQuery();
                }
                con.Close();
                Response.Write("<script>alert('Refunded Successfully...')</script>");
                Response.Redirect("refund.aspx");
            }
        }
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            this.RadGrid2.DataSource = new string[] { };
        }

        [Obsolete]
        protected void DelInvBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (var con = new SqlConnection(connectionStr))
            {
                foreach (GridDataItem item in RadGrid2.Items)
                {
                    String id = item["id"].Text;

                    string strblnc = "select balance from refund where tblinvid='" + id + "'and company='" + Company + "'";
                    SqlCommand cmdblnc = new SqlCommand(strblnc, con);
                    cmdblnc.Connection.Open();
                    string balance = cmdblnc.ExecuteScalar().ToString();
                    cmdblnc.Connection.Close();
                    string strclr = "select amount from clearance where tblid='" + id + "' and tblname = 'RFD' and company='" + Company + "'";
                    SqlCommand cmdclr = new SqlCommand(strclr, con);
                    cmdclr.Connection.Open();
                    string clearance = cmdclr.ExecuteScalar().ToString();
                    cmdclr.Connection.Close();

                    float remmainingbalance = float.Parse(balance) + float.Parse(clearance);
                    string str = "update refund set balance = '" + remmainingbalance + "' where tblinvid='" + id + "' and company='" + Company + "'";
                    SqlCommand cmd = new SqlCommand(str, con);
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();



                    string strblnc1 = "select balance from invoicing where id='" + id + "'and company='" + Company + "'";
                    SqlCommand cmdblnc1 = new SqlCommand(strblnc1, con);
                    cmdblnc1.Connection.Open();
                    string balance1 = cmdblnc1.ExecuteScalar().ToString();
                    cmdblnc1.Connection.Close();
                    string strcr1 = "select credit from invoicing where id='" + id + "'and company='" + Company + "'";
                    SqlCommand cmdcr1 = new SqlCommand(strcr1, con);
                    cmdcr1.Connection.Open();
                    string credit1 = cmdcr1.ExecuteScalar().ToString();
                    cmdcr1.Connection.Close();
                    string strclr1 = "select amount from clearance where tblid='" + id + "' and tblname='RFD' and company='" + Company + "'";
                    SqlCommand cmdclr1 = new SqlCommand(strclr1, con);
                    cmdclr1.Connection.Open();
                    string clearance1 = cmdclr1.ExecuteScalar().ToString();
                    cmdclr1.Connection.Close();

                    float remmainingbalance1 = float.Parse(balance1) + float.Parse(clearance1);
                    float remmainingcredit1 = float.Parse(credit1) - float.Parse(clearance1);
                    string str1 = "update invoicing set balance = '" + remmainingbalance1 + "', credit='" + remmainingcredit1 + "' where id='" + id + "' and company='" + Company + "'";
                    SqlCommand cmd1 = new SqlCommand(str1, con);
                    cmd1.Connection.Open();
                    cmd1.ExecuteNonQuery();
                    cmd1.Connection.Close();


                    string str12 = "update ledger set status='Not Cleared' WHERE invno= '" + refund.Value + "' and tblname='RFD' and company='" + Company + "'";
                    SqlCommand cmd12 = new SqlCommand(str12, con);
                    cmd12.Connection.Open();
                    cmd12.ExecuteNonQuery();
                    cmd12.Connection.Close();

                    string str2 = "delete from clearance where tblid='" + id + "' and tblname = 'RFD' and company='" + Company + "'";
                    SqlCommand cmd2 = new SqlCommand(str2, con);
                    cmd2.Connection.Open();
                    cmd2.ExecuteNonQuery();
                    cmd2.Connection.Close();
                }
            }
            Response.Redirect("refund.aspx");
        }

        [Obsolete]
        protected void YesBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (var con = new SqlConnection(connectionStr))
            {
                float tt = 0, tc = 0, tb = 0;
                con.Open();
                DataTable table = new DataTable();
                var query = "select DATEDIFF(day,CAST(invdate AS datetime), GETDATE()) as age,(select sum(TRY_CONVERT(float, amount)) from clearance where tblname='RFD' and clearance.tblid=invoicing.id and clearance.invno='" + refund.Value + "') as amount,* from [dbo].[invoicing] where (clientcode='" + ccode.Value + "' or airline = '" + ccode.Value + "') and company='" + Company + "' and (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='RFD' and clearance.tblid=invoicing.id and clearance.invno='" + refund.Value + "')>'0' order by invdate, ticketno asc";
                var cmd = new SqlCommand(query, con);
                SqlDataAdapter data = new SqlDataAdapter(cmd);
                data.Fill(table);
                this.RadGrid2.DataSource = table;
                this.RadGrid2.Rebind();
                var query2 = "select (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='RFD' and clearance.tblid=invoicing.id and clearance.invno='" + refund.Value + "') as totalcredit,sum(TRY_CONVERT(float, receivableclient)) as totalticketvalue,sum(TRY_CONVERT(float, balance)) as totalbalance from invoicing where (clientcode='" + ccode.Value + "' or airline = '" + ccode.Value + "') and company='" + Company + "' and (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='RFD' and clearance.tblid=invoicing.id and clearance.invno='" + refund.Value + "')>'0' group by invoicing.id";
                var cmd2 = new SqlCommand(query2, con);
                SqlDataReader reader = cmd2.ExecuteReader();
                while (reader.Read())
                {
                    var totalticket = reader["totalticketvalue"].ToString();
                    tt += float.Parse(totalticket);
                    var totatcredit = reader["totalcredit"].ToString();
                    if (totatcredit == "")
                    {
                        totatcredit = "0";
                    }
                    tc += float.Parse(totatcredit);
                    var totalbalance = reader["totalbalance"].ToString();
                    tb += float.Parse(totalbalance);
                }
                invtkttotal.Value = string.Format("{0:C}", tt).Remove(0, 1);
                invrcvtotal.Value = string.Format("{0:C}", tc).Remove(0, 1);
                invbalancetotal.Value = string.Format("{0:C}", tb).Remove(0, 1);
                reader.Close();
                con.Close();
            }
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowPopup", "ShowPopup();", true);

        }

        [Obsolete]
        protected void btnShowPopup_Click(object sender, EventArgs e)
        {
            try
            {
                setValues();
                var voucherstatus = "";
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    var query1 = "select status from [dbo].[ledger] where head='" + ccode.Value.ToString() + "' and tblid='" + tblid.Value + "' and company='" + Company + "'";
                    SqlCommand cmd1 = new SqlCommand(query1, con);
                    var query2 = "select sub_head from [dbo].[subheads] where code='" + ccode.Value.ToString() + "' and (company='" + Company + "' OR company='All')";
                    SqlCommand cmd2 = new SqlCommand(query2, con);
                    var customer = cmd2.ExecuteScalar().ToString();
                    customername.Value = customer;
                    customername1.Value = customer;
                    if (cmd1.ExecuteScalar() != null)
                    {
                        voucherstatus = cmd1.ExecuteScalar().ToString();
                    }
                    con.Close();
                }
                if (voucherstatus == "Cleared")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showdecisionpopup", "showdecisionpopup();", true);
                }
                else
                {
                    using (var con = new SqlConnection(connectionStr))
                    {
                        float tt = 0, tc = 0, tb = 0;
                        con.Open();
                        DataTable table = new DataTable();
                        var query = "select  tblinvno as idinv,CASE WHEN TRY_CONVERT(float, balance) <= '" + clientpay.Value + "' THEN balance ELSE '" + clientpay.Value + "' END AS refundable, DATEDIFF(day,CAST(invdate AS datetime), GETDATE()) as age,(select sum(TRY_CONVERT(float, amount)) from clearance where tblname='BR' and clearance.tblid=invoicing.id and clearance.invno='" + invno.Value + "') as amount,* from [dbo].[invoicing] where (clientcode='" + ccode.Value.ToString() + "' or airline = '" + ccode.Value.ToString() + "') and company='" + Company + "' and balance>'0' order by invdate, ticketno asc";
                        var cmd = new SqlCommand(query, con);
                        SqlDataAdapter data = new SqlDataAdapter(cmd);
                        data.Fill(table);
                        this.RadGrid3.DataSource = table;
                        this.RadGrid3.Rebind();
                        var query2 = "select (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='BR' and clearance.tblid=invoicing.id and clearance.invno='" + invno.Value + "') as totalcredit,sum(TRY_CONVERT(float, receivableclient)) as totalticketvalue,sum(TRY_CONVERT(float, balance)) as totalbalance from invoicing where (clientcode='" + ccode.Value.ToString() + "' or airline = '" + ccode.Value.ToString() + "') and company='" + Company + "' and balance>'0' group by invoicing.id";
                        var cmd2 = new SqlCommand(query2, con);
                        SqlDataReader reader = cmd2.ExecuteReader();
                        while (reader.Read())
                        {
                            var totalticket = reader["totalticketvalue"].ToString();
                            tt += float.Parse(totalticket);
                            var totatcredit = reader["totalcredit"].ToString();
                            if (totatcredit == "")
                            {
                                totatcredit = "0";
                            }
                            tc += float.Parse(totatcredit);
                            var totalbalance = reader["totalbalance"].ToString();
                            tb += float.Parse(totalbalance);
                        }
                        Text5.Value = string.Format("{0:C}", tt).Remove(0, 1);
                        Text6.Value = string.Format("{0:C}", tc).Remove(0, 1);
                        Text7.Value = string.Format("{0:C}", tb).Remove(0, 1);
                        reader.Close();
                        con.Close();
                        con.Open();
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowPopup1", "ShowPopup1();", true);
                    }
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

        [Obsolete]
        protected void RadGrid3_BatchEditCommand(object sender, GridBatchEditingEventArgs e)
        {
            setValues();
            foreach (GridBatchEditingCommand command in e.Commands)
            {
                Hashtable oldValues = command.OldValues;
                Hashtable newValues = command.NewValues;
                string balanceval = newValues["balance"] == null ? null : newValues["balance"].ToString();
                string creditval = newValues["amount"] == null ? null : newValues["amount"].ToString();
                string id = newValues["id"] == null ? null : newValues["id"].ToString();
                float total = float.Parse(balanceval) - float.Parse(creditval);

                using (SqlConnection con = new SqlConnection(connectionStr))
                {
                    if (command.Type == GridBatchEditingCommandType.Update)
                    {
                        string strclear = "insert into clearance(invno,tblid,tblname,amount,username,company) values('" + refund.Value + "','" + id + "','RFD','" + creditval + "','" + UserName + "','" + Company + "')";
                        SqlCommand cmdclear = new SqlCommand(strclear, con);
                        cmdclear.Connection.Open();
                        cmdclear.ExecuteNonQuery();
                        cmdclear.Connection.Close();

                        string str = "UPDATE refund SET balance='" + total + "', tblinvid='" + id + "'  WHERE refundno='" + refund.Value + "' and company='" + Company + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();



                        string strInv = "UPDATE invoicing SET credit='" + creditval + "', balance='" + total + "', tblname='RFD', tblinvno='" + refund.Value + "'  WHERE id='" + id + "' and company='" + Company + "'";
                        SqlCommand cmdInv = new SqlCommand(strInv, con);
                        cmdInv.Connection.Open();
                        cmdInv.ExecuteNonQuery();
                        cmdInv.Connection.Close();

                        string str1del = "update ledger set status='Cleared' WHERE invno= '" + refund.Value + "' and tblname='RFD' and company='" + Company + "'";
                        SqlCommand cmd1 = new SqlCommand(str1del, con);
                        cmd1.Connection.Open();
                        cmd1.ExecuteNonQuery();
                        cmd1.Connection.Close();
                    }
                }
            }
            Response.Redirect("refund.aspx");
        }

        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            this.RadGrid3.DataSource = new string[] { };
        }

        protected void delButton_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showdeletepopuprfd", "showdeletepopuprfd();", true);
        }

        [Obsolete]
        protected void Yesrfd_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                SqlCommand cmddel = new SqlCommand("delete from refund where invno='" + refund.Value + "' and tktno='" + tktno.Value + "' and company='" + Company + "'", con);
                SqlCommand cmd1del = new SqlCommand("delete from ledger where invno='" + refund.Value + "' and tblid='" + tblid.Value + "' and tblname='RFD' and company='" + Company + "'", con);
                SqlCommand cmdrfd = new SqlCommand("update invoicing set status='',balance=receivableClient,credit='' where ticketno='" + tktno.Value.ToString() + "' and company='" + Company + "'", con);
                cmddel.ExecuteNonQuery();
                cmd1del.ExecuteNonQuery();
                cmdrfd.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("refund.aspx");
        }
    }
}