using Coffer_Systems;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Net;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Coffer_Systems
{
    public partial class NormalInvoice : System.Web.UI.Page
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;
        public static class Global
        {
            public static int offset;
        }
        private string UserName1 { get; set; }
        private string Company1 { get; set; }
        private string GST1 { get; set; }
        private string UserID1 { get; set; }
        private string Status1 { get; set; }
        [Obsolete]
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    Global.offset = 0;
                    setValues();
                    using (SqlConnection con = new SqlConnection(connectionStr))
                    {
                        string inv = Request.QueryString["id"];
                        con.Open();

                        gstText.Value = GST1;
                        gstText1.Value = GST1;
                        int count = 0;
                        SqlCommand invoice = new SqlCommand(@"Select distinct cast(invno as int) as invno from invoicing where company='" + Company1 + "' order by cast(invno as int) DESC", con);
                        SqlDataReader reader = invoice.ExecuteReader();
                        List<string> invnolist = new List<string>();
                        while (reader.Read())
                        {
                            invnolist.Add(Convert.ToString(reader["invno"]));
                            count++;
                        }
                        reader.Close();
                        if (count > 0)
                        {
                            if (inv != null)
                            {
                                vno.InnerText = inv;
                                othvno.InnerText = inv;
                                invno.Value = inv;
                                invno1.Value = inv;
                                Global.offset = invnolist.FindIndex(arr => arr == inv);
                            }
                            else
                            {
                                vno.InnerText = invnolist[Global.offset];
                                othvno.InnerText = invnolist[Global.offset];
                                invno.Value = invnolist[Global.offset];
                                invno1.Value = invnolist[Global.offset];
                            }
                            SqlCommand cmdDate = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "'", con);
                            SqlDataReader dateReader = cmdDate.ExecuteReader();
                            while (dateReader.Read())
                            {
                                string invDates = Convert.ToDateTime(dateReader["invDate"]).ToString("yyyy-MM-dd");
                                string[] temp = invDates.Split(' ');
                                string postingdates = Convert.ToString(dateReader["postingdate"]);
                                string[] temp1 = postingdates.Split(' ');
                                string deptDates = Convert.ToDateTime(dateReader["deptDate"]).ToString("yyyy-MM-dd");
                                string[] temp2 = deptDates.Split(' ');
                                invDate.Value = temp[0];
                                invDate1.Value = temp[0];
                                othpdate.Value = temp[0];
                                postDate.Value = temp1[0];
                                postDate1.Value = temp1[0];
                                deptDate.Value = temp2[0];
                                deptDate1.Value = temp2[0];
                            }
                            dateReader.Close();
                            con.Close();
                            DataTable table = new DataTable();
                            SqlCommand cmdtable = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "'", con);
                            SqlDataAdapter data = new SqlDataAdapter(cmdtable);
                            data.Fill(table);
                            this.RadGrid2.DataSource = table;
                            this.RadGrid2.Rebind();
                            this.RadGrid3.DataSource = table;
                            this.RadGrid3.Rebind();

                            DataTable tableoth = new DataTable();
                            SqlCommand cmdoth = new SqlCommand("SELECT * FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                            SqlDataAdapter dataoth = new SqlDataAdapter(cmdoth);
                            dataoth.Fill(tableoth);
                            this.RadGrid1.DataSource = tableoth;
                            this.RadGrid1.Rebind();

                            DataTable tableoth1 = new DataTable();
                            SqlCommand cmdoth1 = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "' and ticketno like 'OTH%'", con);
                            SqlDataAdapter dataoth1 = new SqlDataAdapter(cmdoth1);
                            dataoth1.Fill(tableoth1);
                            this.RadGrid4.DataSource = tableoth1;
                            this.RadGrid4.Rebind();

                            SqlCommand cmdtotal = new SqlCommand("SELECT sum(TRY_CONVERT(INT ,amount)) FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                            con.Open();
                            var total = cmdtotal.ExecuteScalar().ToString();
                            tpayable.Value = total;
                            tpay.Value = total;
                            con.Close();

                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "getinvoiceDataTotal", "getinvoiceDataTotal('" + Global.offset + "');", true);
                        }
                        else
                        {
                            Response.Write("<script>alert('No Record Exist. Please click on ‘Add New Invoice’ to start posting.');</script>");
                        }
                        SqlCommand cmd1 = new SqlCommand(@"Select sub_head AS full_name , code from subheads where (company='" + Company1 + "' OR company='All') and level='4' order by sub_head ", con);
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
                        airlineDropDownListTemp.DataSource = ds1.Tables[0];
                        airlineDropDownListTemp.DataTextField = "full_name";
                        airlineDropDownListTemp.DataValueField = "code";
                        airlineDropDownListTemp.DataBind();
                        airlineDropDownListTemp.Items.Insert(0, new ListItem());
                        transferDropDownList.DataSource = ds1.Tables[0];
                        transferDropDownList.DataTextField = "full_name";
                        transferDropDownList.DataValueField = "code";
                        transferDropDownList.DataBind();
                        transferDropDownList.Items.Insert(0, new ListItem());
                        customerDropDownList1.DataSource = ds1.Tables[0];
                        customerDropDownList1.DataTextField = "full_name";
                        customerDropDownList1.DataValueField = "code";
                        customerDropDownList1.DataBind();
                        customerDropDownList1.Items.Insert(0, new ListItem());
                        airlineDropDownList1.DataSource = ds1.Tables[0];
                        airlineDropDownList1.DataTextField = "full_name";
                        airlineDropDownList1.DataValueField = "code";
                        airlineDropDownList1.DataBind();
                        airlineDropDownList1.Items.Insert(0, new ListItem());
                        airlineDropDownListTemp1.DataSource = ds1.Tables[0];
                        airlineDropDownListTemp1.DataTextField = "full_name";
                        airlineDropDownListTemp1.DataValueField = "code";
                        airlineDropDownListTemp1.DataBind();
                        airlineDropDownListTemp1.Items.Insert(0, new ListItem());
                        transferDropDownList1.DataSource = ds1.Tables[0];
                        transferDropDownList1.DataTextField = "full_name";
                        transferDropDownList1.DataValueField = "code";
                        transferDropDownList1.DataBind();
                        transferDropDownList1.Items.Insert(0, new ListItem());
                        IncomeDropDownList.DataSource = ds1.Tables[0];
                        IncomeDropDownList.DataTextField = "full_name";
                        IncomeDropDownList.DataValueField = "code";
                        IncomeDropDownList.DataBind();
                        IncomeDropDownList.Items.Insert(0, new ListItem());
                        customerDropDownListOth.DataSource = ds1.Tables[0];
                        customerDropDownListOth.DataTextField = "full_name";
                        customerDropDownListOth.DataValueField = "code";
                        customerDropDownListOth.DataBind();
                        customerDropDownListOth.Items.Insert(0, new ListItem());
                        con.Close();
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
                        Status1 = dr["status"].ToString();
                        UserID1 = dr["ID"].ToString();
                        UserName1 = dr["username"].ToString();
                        Company1 = dr["company"].ToString();
                        GST1 = dr["gst"].ToString();
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
            vno.InnerText = invno.Value;
            othvno.InnerText = invno.Value;
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                try
                {
                    con.Open();
                    SqlCommand cmddel = new SqlCommand("delete from invoicing where invno='" + invno.Value + "' and ticketno='" + tktno.Value + "' and company='" + Company1 + "'", con);
                    SqlCommand cmd1del = new SqlCommand("delete from ledger where invno='" + invno.Value + "' and tblid='" + tblid.Value + "' and tblname='INV' and company='" + Company1 + "'", con);
                    cmddel.ExecuteNonQuery();
                    cmd1del.ExecuteNonQuery();

                    SqlCommand cmd = new SqlCommand("INSERT INTO[dbo].[Invoicing](ticketno,invno,[InvDate],[InvType],recieptNo,[InvTitle],[ClientCode],[Customer],[Balance],[Credit],[InvRemarks],[ETkt],[Conj],[LastTicket],[Airline],[TicketPurchaseFrom],[TicketType],[BSP],[XO],[PostingDate],[Status],[PassengerName],[PassengerCNIC],[Sector],[Fare],[Class],[DeptDate],[PNR],[Route],[PassenterType],[Category],[MainSeg],[SubSeg],[Iata],[mkt],[other],[soto],[sp],[yd],[pk],[fed],[ced],[xz],[whairline],[whclient],[yq],[pb],[oth],[tax],[frtx],[whtfix],[comm],[comamt],[extra],[comadj],[tcom],[airlinepay],[servicech],[serviceamt],[gst],[gstpay],[ins],[transferac],[kbairline],[clientreceive],[profitloss],[kbcust],[commkb],[disc],[discamt],[discadj],[gds],[fc],[fcreceivable],[fcpayable],[airlinepayable],[receivableclient],[otherpayable],[profitlossamt],[ticketvalue],[username],[company]) VALUES('" + tktno.Value.ToString() + "','" + invno.Value.ToString() + "','" + invDate.Value.ToString() + "','" + invType.SelectedItem.Text + "','" + rcpt.Value.ToString() + "','" + invt.Value.ToString() + "','" + ccode.Value.ToString() + "','" + customerDropDownList.SelectedItem.Text + "','" + clientreceivable.Value.ToString() + "','" + cLimit.Value.ToString() + "','" + invR.Value.ToString() + "','" + etkt.Value.ToString() + "','" + conjDropDownList.SelectedItem.Text + "','" + altn.Value.ToString() + "','" + airlinecode.Value.ToString() + "','" + airlineDropDownList.SelectedItem.Text + "','" + tktt.SelectedItem.Text + "','" + bspDropDown.SelectedItem.Text + "','" + xo.Value.ToString() + "','" + postDate.Value.ToString() + "','" + status.Value.ToString() + "','" + passname.Value.ToString() + "','" + passcnic.Value.ToString() + "','" + sector.Value.ToString() + "','" + fare.Value.ToString() + "','" + @class.Value.ToString() + "','" + deptDate.Value.ToString() + "','" + pnr.Value.ToString() + "','" + routeDropDown.SelectedItem.Text + "','" + passengerDropDown.SelectedItem.Text + "','" + catDropdown.SelectedItem.Text + "','" + DropDownList2.SelectedItem.Text + "','" + DropDownList1.SelectedItem.Text + "','" + iata.Value.ToString() + "','" + mkt.Value.ToString() + "','" + otherfare.Value.ToString() + "','" + soto.Value.ToString() + "','" + sp.Value.ToString() + "','" + yd.Value.ToString() + "','" + pk.Value.ToString() + "','" + fed.Value.ToString() + "','" + ced.Value.ToString() + "','" + xz.Value.ToString() + "','" + whairline.Value.ToString() + "','" + whclient.Value.ToString() + "','" + yq.Value.ToString() + "','" + pb.Value.ToString() + "','" + oth.Value.ToString() + "','" + tax.Value.ToString() + "','" + frtx.Value.ToString() + "','" + fixDropDown.SelectedItem.Text + "','" + comm.Value.ToString() + "','" + comamt.Value.ToString() + "','" + extra.Value.ToString() + "','','" + tcom.Value.ToString() + "','','" + srvc.Value.ToString() + "','" + srvcamt.Value.ToString() + "','" + gstText.Value.ToString() + "','" + gstpay.Value.ToString() + "','" + ins.Value.ToString() + "','" + transferDropDownList.SelectedItem.Text + "','" + kbairline.Value.ToString() + "','','','" + kbcust.Value.ToString() + "','" + kbcomm.Value.ToString() + "','" + disc.Value.ToString() + "','" + discamt.Value.ToString() + "','" + discadj.Value.ToString() + "','" + gds.SelectedItem.Text + "','" + fcDropDown.SelectedItem.Value + "','" + fcr.Value.ToString() + "','" + fcp.Value.ToString() + "','" + airlinepayable.Value.ToString() + "','" + clientreceivable.Value.ToString() + "','" + otherpayable.Value.ToString() + "','" + plothers.Value.ToString() + "','" + tktvalue.Value.ToString() + "','" + UserName1 + "','" + Company1 + "')", con);
                    cmd.ExecuteNonQuery();
                    SqlCommand cmdid = new SqlCommand("select max(id) from invoicing where company='" + Company1 + "'", con);
                    var id = cmdid.ExecuteScalar().ToString();
                    SqlCommand cmd1 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','" + airlineDropDownList.SelectedValue.ToString() + "','0','" + airlinepayable.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                    SqlCommand cmd2 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','" + customerDropDownList.SelectedValue.ToString() + "','" + clientreceivable.Value.ToString() + "','0','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);

                    cmd1.ExecuteNonQuery();
                    cmd2.ExecuteNonQuery();
                    if (srvcamt.Value.ToString() != "" && srvcamt.Value.ToString() != "0.00" && srvcamt.Value.ToString() != "0")
                    {
                        SqlCommand cmd3 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','4000003','0','" + srvcamt.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                        cmd3.ExecuteNonQuery();
                    }
                    if (whairline.Value.ToString() != "" && whairline.Value.ToString() != "0.00" && whairline.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','3110001','" + whairline.Value.ToString() + "','0','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (tcom.Value.ToString() != "" && tcom.Value.ToString() != "0.00" && tcom.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','4000002','0','" + tcom.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (whclient.Value.ToString() != "" && whclient.Value.ToString() != "0.00" && whclient.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','4000001','0','" + whclient.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (discamt.Value.ToString() != "" && discamt.Value.ToString() != "0.00" && discamt.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','3110002','" + discamt.Value.ToString() + "','0','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (gstpay.Value.ToString() != "0" && gstpay.Value.ToString() != "" && gstpay.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','2350001','0','" + gstpay.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (ins.Value.ToString() != "" && ins.Value.ToString() != "0.00" && ins.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','4010001','0','" + ins.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (kbcust.Value.ToString() != "" && kbcust.Value.ToString() != "0.00" && kbcust.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','3110003','" + kbcust.Value.ToString() + "','0','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (kbairline.Value.ToString() != "" && kbairline.Value.ToString() != "0.00" && kbairline.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate.Value.ToString() + "','4000004','0','" + kbairline.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    con.Close();
                    DataTable table = new DataTable();
                    SqlCommand cmdtable = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmdtable);
                    data.Fill(table);
                    this.RadGrid2.DataSource = table;
                    this.RadGrid2.Rebind();
                    this.RadGrid3.DataSource = table;
                    this.RadGrid3.Rebind();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");

                }
            }
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showsuccesspopup1", "showsuccesspopup1();", true);
        }

        protected void NewButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("normalinvoice.aspx");
        }
        protected void accountButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("codingmenu.aspx");
        }

        [Obsolete]
        protected void addmore_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand("INSERT INTO[dbo].[Invoicing](ticketno,invno,[InvDate],[InvType],recieptNo,[InvTitle],[ClientCode],[Customer],[InvRemarks],[ETkt],[Conj],[LastTicket],[Airline],[TicketPurchaseFrom],[TicketType],[BSP],[XO],[PostingDate],[Status],[PassengerName],[PassengerCNIC],[Sector],[Fare],[Class],[DeptDate],[PNR],[Route],[PassenterType],[Category],[MainSeg],[SubSeg],[Iata],[mkt],[other],[soto],[sp],[yd],[pk],[fed],[ced],[xz],[whairline],[whclient],[yq],[pb],[oth],[tax],[frtx],[whtfix],[comm],[comamt],[extra],[comadj],[tcom],[airlinepay],[servicech],[serviceamt],[gst],[gstpay],[ins],[transferac],[kbairline],[clientreceive],[profitloss],[kbcust],[commkb],[disc],[discamt],[discadj],[gds],[fc],[fcreceivable],[fcpayable],[airlinepayable],[receivableclient],[otherpayable],[profitlossamt],[ticketvalue], [balance],[username],[company]) VALUES('" + tktno1.Value.ToString() + "','" + invno1.Value.ToString() + "','" + invDate1.Value.ToString() + "','" + invType1.SelectedItem.Text + "','" + rcpt1.Value.ToString() + "','" + invt1.Value.ToString() + "','" + ccode1.Value.ToString() + "','" + customerDropDownList1.SelectedItem.Text + "','" + invR1.Value.ToString() + "','" + etkt1.Value.ToString() + "','" + conjDropDownList1.SelectedItem.Text + "','" + altn1.Value.ToString() + "','" + airlinecode1.Value.ToString() + "','" + airlineDropDownList1.SelectedItem.Text + "','" + tktt1.SelectedItem.Text + "','" + bspDropDown1.SelectedItem.Text + "','" + xo1.Value.ToString() + "','" + postDate1.Value.ToString() + "','" + status1.Value.ToString() + "','" + passname1.Value.ToString() + "','" + passcnic1.Value.ToString() + "','" + sector1.Value.ToString() + "','" + fare1.Value.ToString() + "','" + class1.Value.ToString() + "','" + deptDate1.Value.ToString() + "','" + pnr1.Value.ToString() + "','" + routeDropDown1.SelectedItem.Text + "','" + passengerDropDown1.SelectedItem.Text + "','" + catDropdown1.SelectedItem.Text + "','" + DropDownList21.SelectedItem.Text + "','" + DropDownList11.SelectedItem.Text + "','" + iata1.Value.ToString() + "','" + mkt1.Value.ToString() + "','" + otherfare1.Value.ToString() + "','" + soto1.Value.ToString() + "','" + sp1.Value.ToString() + "','" + yd1.Value.ToString() + "','" + pk1.Value.ToString() + "','" + fed1.Value.ToString() + "','" + ced1.Value.ToString() + "','" + xz1.Value.ToString() + "','" + whairline1.Value.ToString() + "','" + whclient1.Value.ToString() + "','" + yq1.Value.ToString() + "','" + pb1.Value.ToString() + "','" + oth1.Value.ToString() + "','" + tax1.Value.ToString() + "','" + frtx1.Value.ToString() + "','" + fixDropDown1.SelectedItem.Text + "','" + comm1.Value.ToString() + "','" + comamt1.Value.ToString() + "','" + extra1.Value.ToString() + "','','" + tcom1.Value.ToString() + "','','" + srvc1.Value.ToString() + "','" + srvcamt1.Value.ToString() + "','" + gstText1.Value.ToString() + "','" + gstpay1.Value.ToString() + "','" + ins1.Value.ToString() + "','" + transferDropDownList1.SelectedItem.Text + "','" + kbairline1.Value.ToString() + "','','','" + kbcust1.Value.ToString() + "','" + kbcomm1.Value.ToString() + "','" + disc1.Value.ToString() + "','" + discamt1.Value.ToString() + "','" + discadj1.Value.ToString() + "','" + gds1.SelectedItem.Text + "','" + fcDropDown1.SelectedItem.Value + "','" + fcr1.Value.ToString() + "','" + fcp1.Value.ToString() + "','" + airlinepayable1.Value.ToString() + "','" + clientreceivable1.Value.ToString() + "','" + otherpayable1.Value.ToString() + "','" + plother1.Value.ToString() + "','" + tktvalue1.Value.ToString() + "','" + clientreceivable1.Value.ToString() + "','" + UserName1 + "','" + Company1 + "')", con);
                    cmd.ExecuteNonQuery();
                    SqlCommand cmdid = new SqlCommand("select max(id) from invoicing where company='" + Company1 + "'", con);
                    var id = cmdid.ExecuteScalar().ToString();
                    SqlCommand cmd1 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','" + airlineDropDownList1.SelectedValue.ToString() + "','0','" + airlinepayable1.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);
                    SqlCommand cmd2 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','" + customerDropDownList1.SelectedValue.ToString() + "','" + clientreceivable1.Value.ToString() + "','0','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);

                    cmd1.ExecuteNonQuery();
                    cmd2.ExecuteNonQuery();
                    if (srvcamt1.Value.ToString() != "" && srvcamt1.Value.ToString() != "0.00" && srvcamt1.Value.ToString() != "0")
                    {
                        SqlCommand cmd3 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','4000003','0','" + srvcamt1.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);
                        cmd3.ExecuteNonQuery();
                    }
                    if (whairline1.Value.ToString() != "" && whairline1.Value.ToString() != "0.00" && whairline1.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','3110001','" + whairline1.Value.ToString() + "','0','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (tcom1.Value.ToString() != "" && tcom1.Value.ToString() != "0.00" && tcom1.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','4000002','0','" + tcom1.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (whclient1.Value.ToString() != "" && whclient1.Value.ToString() != "0.00" && whclient1.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','4000001','0','" + whclient1.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (discamt1.Value.ToString() != "" && discamt1.Value.ToString() != "0.00" && discamt1.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','3110002','" + discamt1.Value.ToString() + "','0','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (gstpay1.Value.ToString() != "0" && gstpay1.Value.ToString() != "" && gstpay1.Value.ToString() != "0.00")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','2350001','0','" + gstpay1.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (ins1.Value.ToString() != "" && ins1.Value.ToString() != "0.00" && ins1.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','4010001','0','" + ins1.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (kbcust1.Value.ToString() != "" && kbcust1.Value.ToString() != "0.00" && kbcust1.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','3110003','" + kbcust1.Value.ToString() + "','0','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    if (kbairline1.Value.ToString() != "" && kbairline1.Value.ToString() != "0.00" && kbairline1.Value.ToString() != "0")
                    {
                        SqlCommand cmd4 = new SqlCommand("INSERT INTO[dbo].[ledger](tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + id + "','" + invDate1.Value.ToString() + "','4000004','0','" + kbairline1.Value.ToString() + "','" + UserName1 + "','" + Company1 + "','" + invno1.Value.ToString() + "','INV')", con);
                        cmd4.ExecuteNonQuery();
                    }
                    con.Close();
                    DataTable table = new DataTable();
                    SqlCommand cmdtable = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmdtable);
                    data.Fill(table);
                    this.RadGrid2.DataSource = table;
                    this.RadGrid2.Rebind();
                    this.RadGrid3.DataSource = table;
                    this.RadGrid3.Rebind();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
            }
        }

        [Obsolete]
        protected void OkBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                int count = 0;
                SqlCommand invoice = new SqlCommand(@"Select distinct cast(invno as int) as invno from invoicing where company='" + Company1 + "' order by cast(invno as int) DESC", con);
                con.Open();
                SqlDataReader reader = invoice.ExecuteReader();
                while (reader.Read())
                {
                    if ((Convert.ToString(reader["invno"]) == Number1.Value))
                    {
                        count++;
                    }
                }
                reader.Close();
                con.Close();
                if (count > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "conflictPopup", "conflictPopup();", true);
                }
                else
                {
                    SqlCommand cmd = new SqlCommand(@"update invoicing set invno='" + Number1.Value + "' where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                    SqlCommand cmd1 = new SqlCommand(@"update ledger set invno='" + Number1.Value + "' where invno='" + invno.Value + "' and tblname='INV' and company='" + Company1 + "'", con);
                    SqlCommand cmd2 = new SqlCommand(@"update others set invno='" + Number1.Value + "' where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    cmd1.ExecuteNonQuery();
                    cmd2.ExecuteNonQuery();
                    con.Close();
                    Response.Redirect("normalinvoice.aspx");
                }
            }
        }

        [Obsolete]
        protected void RadGrid1_BatchEditCommand(object sender, GridBatchEditingEventArgs e)
        {
            setValues();
            foreach (GridBatchEditingCommand command in e.Commands)
            {
                Hashtable oldValues = command.OldValues;
                Hashtable newValues = command.NewValues;
                using (SqlConnection con = new SqlConnection(connectionStr))
                {
                    if (command.Type == GridBatchEditingCommandType.Update)
                    {
                        string code = newValues["ID_Name"] == null ? null : newValues["ID_Name"].ToString();
                        string amount = newValues["amount"] == null ? null : newValues["amount"].ToString();
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        con.Open();
                        SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company1 + "' OR company='All')", con);
                        var head = cmdhead.ExecuteScalar().ToString();
                        con.Close();
                        string str = "UPDATE others SET ticketno = '" + othtktno.Value + "', code='" + code + "', amount='" + amount + "', head='" + head + "' WHERE id='" + id + "' and company='" + Company1 + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        string str1 = "UPDATE ledger SET head='" + code + "', credit='" + amount + "', debit='', date='" + othpdate.Value + "', invno='" + invno.Value + "' WHERE tblid='" + id + "' and tblname='INV' and company='" + Company1 + "'";
                        SqlCommand cmd1 = new SqlCommand(str1, con);
                        cmd1.Connection.Open();
                        cmd1.ExecuteNonQuery();
                        cmd1.Connection.Close();
                    }
                    else if (command.Type == GridBatchEditingCommandType.Insert)
                    {
                        string code = newValues["ID_Name"] == null ? null : newValues["ID_Name"].ToString();
                        string amount = newValues["amount"] == null ? null : newValues["amount"].ToString();
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        con.Open();
                        SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company1 + "' OR company='All')", con);
                        var head = cmdhead.ExecuteScalar().ToString();
                        con.Close();
                        string str = "INSERT INTO others(ticketno,username,company,code,head,amount,invno) VALUES('" + othtktno.Value + "','" + UserName1 + "','" + Company1 + "','" + code + "','" + head + "','" + amount + "','" + invno.Value + "')";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        con.Open();
                        SqlCommand cmdid = new SqlCommand(@"Select max(id) from others", con);
                        var tblid = cmdid.ExecuteScalar().ToString();
                        con.Close();
                        string str1 = "INSERT INTO ledger(username,company,head,debit,credit,date,invno,tblname,tblid) VALUES('" + UserName1 + "','" + Company1 + "','" + code + "','','" + amount + "','" + othpdate.Value + "','" + invno.Value + "','INV','" + tblid + "')";
                        SqlCommand cmd1 = new SqlCommand(str1, con);
                        cmd1.Connection.Open();
                        cmd1.ExecuteNonQuery();
                        cmd1.Connection.Close();
                    }
                    else if (command.Type == GridBatchEditingCommandType.Delete)
                    {
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        string str = "DELETE FROM others WHERE id= '" + id + "' and company='" + Company1 + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        string str1 = "DELETE FROM ledger WHERE tblid= '" + id + "' and tblname='INV' and company='" + Company1 + "'";
                        SqlCommand cmd1 = new SqlCommand(str1, con);
                        cmd1.Connection.Open();
                        cmd1.ExecuteNonQuery();
                        cmd1.Connection.Close();
                    }
                }
            }
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showotherpopup1", "showotherpopup1();", true);
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                DataTable tableoth = new DataTable();
                SqlCommand cmdoth = new SqlCommand("SELECT * FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                SqlDataAdapter dataoth = new SqlDataAdapter(cmdoth);
                dataoth.Fill(tableoth);
                this.RadGrid1.DataSource = tableoth;
                this.RadGrid1.Rebind();
                con.Close();

                DataTable tableoth1 = new DataTable();
                SqlCommand cmdoth1 = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "' and ticketno like 'OTH%'", con);
                SqlDataAdapter dataoth1 = new SqlDataAdapter(cmdoth1);
                dataoth1.Fill(tableoth1);
                this.RadGrid4.DataSource = tableoth1;
                this.RadGrid4.Rebind();

                SqlCommand cmdtotal = new SqlCommand("SELECT sum(TRY_CONVERT(INT ,amount)) FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                con.Open();
                var total = cmdtotal.ExecuteScalar().ToString();
                tpayable.Value = total;
                tpay.Value = total;
                con.Close();

                SqlCommand cmdtkt = new SqlCommand("SELECT ticketno FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                con.Open();
                if (cmdtkt.ExecuteScalar() != null)
                {
                    var othertktno = cmdtkt.ExecuteScalar().ToString();
                    othtktno.Value = othertktno;
                }
                con.Close();

            }
        }

        [Obsolete]
        protected void ddlName_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            setValues();
            RadComboBox ddlName = sender as RadComboBox;
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                SqlCommand cmd1 = new SqlCommand(@"Select sub_head AS full_name , code from subheads where level='4' and (company='" + Company1 + "'OR company='All') order by sub_head ", con);
                SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1);
                ddlName.DataSource = ds1.Tables[0];
                ddlName.DataTextField = "full_name";
                ddlName.DataValueField = "code";
                ddlName.DataBind();
                con.Close();
            }
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = new string[] { };
        }
        protected void RadComboBox1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }
        [Obsolete]
        protected void Other_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                SqlCommand cmddel = new SqlCommand("delete from invoicing where company='" + Company1 + "' and invno='" + invno.Value + "' and ticketno='" + othtktno.Value + "'", con);
                SqlCommand cmd1del = new SqlCommand("delete from ledger where invno='" + invno.Value + "' and tblid='" + tblid.Value + "' and tblname='INV' and company='" + Company1 + "'", con);
                cmddel.ExecuteNonQuery();
                cmd1del.ExecuteNonQuery();
                SqlCommand cmd = new SqlCommand("insert into invoicing(invdate, company,username,invno,ticketno,mkt,visa,accomodation1,accomodation2,transport,ziarat,food,other,totalrcv,totalpay,clientcode,customer,sector,mainseg,subseg,passengername,postingdate,category,receivableclient,airlinepayable,profitlossamt,gst,gstpay) values('" + othpdate.Value + "','" + Company1 + "','" + UserName1 + "','" + invno.Value + "','" + othtktno.Value + "','" + visarcv.Value + "','" + visarcv.Value + "','" + accomo1rcv.Value + "','" + accomo2rcv.Value + "','" + trnsrcv.Value + "','" + zrtrcv.Value + "','" + foodrcv.Value + "','" + otherrcv.Value + "','" + totalrcv.Value + "','" + tpay.Value + "','" + othccode.Value + "','" + customerDropDownListOth.SelectedItem.Text + "','" + descriptionOth.Value + "','" + DropDownList3.SelectedValue.ToString() + "','" + DropDownList4.SelectedValue.ToString() + "','" + passenger.Value + "','" + othpdate.Value + "','" + catDropdownOth.SelectedValue.ToString() + "','" + totalrcv.Value + "','" + tpay.Value + "','" + tpl.Value + "','" + gstpercent.Value + "','" + gstrcv.Value + "')", con);
                cmd.ExecuteNonQuery();
                SqlCommand cmdid = new SqlCommand("select max(id) from invoicing where company='" + Company1 + "'", con);
                var id = cmdid.ExecuteScalar().ToString();
                SqlCommand cmd1 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + descriptionOth.Value.ToString() + "','" + id + "','" + othpdate.Value.ToString() + "','" + customerDropDownListOth.SelectedValue.ToString() + "','" + totalrcv.Value.ToString() + "','0','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                cmd1.ExecuteNonQuery();
                string debit = "";
                string credit = "";
                if (Convert.ToInt32(tpl.Value) > 0)
                {
                    debit = tpl.Value;
                }
                else
                {
                    credit = tpl.Value;
                }
                SqlCommand cmd2 = new SqlCommand("INSERT INTO[dbo].[ledger](description,tblid,[date],head,debit,credit,username,company,invno,tblname)values('" + descriptionOth.Value.ToString() + "','" + id + "','" + othpdate.Value.ToString() + "','" + IncomeDropDownList.SelectedValue.ToString() + "','" + debit + "','" + credit + "','" + UserName1 + "','" + Company1 + "','" + invno.Value.ToString() + "','INV')", con);
                cmd2.ExecuteNonQuery();
                con.Close();

                DataTable table = new DataTable();
                SqlCommand cmdinv = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "'", con);
                SqlDataAdapter data = new SqlDataAdapter(cmdinv);
                data.Fill(table);
                this.RadGrid2.DataSource = table;
                this.RadGrid2.Rebind();
                this.RadGrid3.DataSource = table;
                this.RadGrid3.Rebind();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "otherPopupDescription1", "otherPopupDescription1();", true);
            }
        }

        [Obsolete]
        protected void otherBtn_Click(object sender, EventArgs e)
        {
            try
            {
                setValues();
                string str = tktno.Value.ToString();
                if (str != " ")
                {
                    string res = str.Substring(0, 3);
                    if (res == "OTH")
                    {
                        using (SqlConnection con = new SqlConnection(connectionStr))
                        {
                            con.Open();
                            DataTable table = new DataTable();
                            DataTable table1 = new DataTable();
                            SqlCommand cmd = new SqlCommand("SELECT * FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                            SqlDataAdapter data = new SqlDataAdapter(cmd);
                            data.Fill(table);
                            this.RadGrid1.DataSource = table;
                            this.RadGrid1.Rebind();
                            SqlCommand cmd1 = new SqlCommand("select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "' and ticketno like 'OTH%'", con);
                            SqlDataAdapter data1 = new SqlDataAdapter(cmd1);
                            data1.Fill(table1);
                            this.RadGrid4.DataSource = table1;
                            this.RadGrid4.Rebind();

                            if (table.ToString() != "")
                            {
                                (sender as RadGrid).DataSource = table;

                                SqlCommand cmdtotal = new SqlCommand("SELECT sum(TRY_CONVERT(INT ,amount)) FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                                var total = cmdtotal.ExecuteScalar().ToString();
                                tpayable.Value = total;
                                tpay.Value = total;
                                con.Close();
                            }
                        }
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showotherpopup1", "showotherpopup1();", true);
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        [Obsolete]
        protected void nextbtn_Click(object sender, EventArgs e)
        {
            setValues();
            Global.offset--;
            List<string> invnolist = new List<string>();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand invoiceno = new SqlCommand(@"Select distinct cast(invno as int) as invno from invoicing where company='" + Company1 + "' order by cast(invno as int) DESC", con);
                con.Open();
                SqlDataReader reader = invoiceno.ExecuteReader();
                while (reader.Read())
                {
                    invnolist.Add(Convert.ToString(reader["invno"]));
                }
                reader.Close();
                con.Close();
            }
            var invoice = "";
            if (Global.offset < 0)
            {
                Global.offset++;
                Response.Write("<script>alert('This is Last Record');</script>");
            }
            else
            {
                invoice = invnolist[Global.offset];
                using (SqlConnection con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    DataTable table = new DataTable();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM invoicing where invno='" + invoice.ToString() + "' and company='" + Company1 + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmd);
                    data.Fill(table);
                    this.RadGrid3.DataSource = table;
                    this.RadGrid3.Rebind();
                    this.RadGrid2.DataSource = table;
                    this.RadGrid2.Rebind();

                    DataTable tableoth = new DataTable();
                    SqlCommand cmdoth = new SqlCommand("SELECT * FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                    SqlDataAdapter dataoth = new SqlDataAdapter(cmdoth);
                    dataoth.Fill(tableoth);
                    this.RadGrid1.DataSource = tableoth;
                    this.RadGrid1.Rebind();

                    DataTable tableoth1 = new DataTable();
                    SqlCommand cmdoth1 = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "' and ticketno like 'OTH%'", con);
                    SqlDataAdapter dataoth1 = new SqlDataAdapter(cmdoth1);
                    dataoth1.Fill(tableoth1);
                    this.RadGrid4.DataSource = tableoth1;
                    this.RadGrid4.Rebind();

                    SqlCommand cmdtotal = new SqlCommand("SELECT sum(TRY_CONVERT(INT ,amount)) FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                    var total = cmdtotal.ExecuteScalar().ToString();
                    tpayable.Value = total;
                    tpay.Value = total;
                    con.Close();
                }
                invno.Value = invoice.ToString();
                invno1.Value = invoice.ToString();
                vno.InnerText = invoice.ToString();
                othvno.InnerText = invoice.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "getinvoiceDataTotal", "getinvoiceDataTotal('" + Global.offset + "');", true);
            }
        }
        [Obsolete]
        protected void prevbtn_Click(object sender, EventArgs e)
        {
            setValues();
            int count = 0;
            Global.offset++;
            List<string> invnolist = new List<string>();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand invoiceno = new SqlCommand(@"Select distinct cast(invno as int) as invno from invoicing where company='" + Company1 + "' order by cast(invno as int) DESC", con);
                con.Open();
                SqlDataReader reader = invoiceno.ExecuteReader();
                while (reader.Read())
                {
                    invnolist.Add(Convert.ToString(reader["invno"]));
                    count++;
                }
                reader.Close();
                con.Close();
            }
            if (Global.offset == count)
            {
                Global.offset--;
                Response.Write("<script>alert('This is First Record');</script>");
            }
            else
            {
                var invoice = invnolist[Global.offset];
                using (SqlConnection con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    DataTable table = new DataTable();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM invoicing where  invno='" + invoice.ToString() + "' and company='" + Company1 + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmd);
                    data.Fill(table);
                    this.RadGrid2.DataSource = table;
                    this.RadGrid2.Rebind();
                    this.RadGrid3.DataSource = table;
                    this.RadGrid3.Rebind();

                    DataTable tableoth = new DataTable();
                    SqlCommand cmdoth = new SqlCommand("SELECT * FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                    SqlDataAdapter dataoth = new SqlDataAdapter(cmdoth);
                    dataoth.Fill(tableoth);
                    this.RadGrid1.DataSource = tableoth;
                    this.RadGrid1.Rebind();

                    DataTable tableoth1 = new DataTable();
                    SqlCommand cmdoth1 = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "' and ticketno like 'OTH%'", con);
                    SqlDataAdapter dataoth1 = new SqlDataAdapter(cmdoth1);
                    dataoth1.Fill(tableoth1);
                    this.RadGrid4.DataSource = tableoth1;
                    this.RadGrid4.Rebind();

                    SqlCommand cmdtotal = new SqlCommand("SELECT sum(TRY_CONVERT(INT ,amount)) FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                    var total = cmdtotal.ExecuteScalar().ToString();
                    tpayable.Value = total;
                    tpay.Value = total;
                    con.Close();
                }
                invno.Value = invoice.ToString();
                invno1.Value = invoice.ToString();
                vno.InnerText = invoice.ToString();
                othvno.InnerText = invoice.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "getinvoiceDataTotal", "getinvoiceDataTotal('" + Global.offset + "');", true);
            }
        }

        [Obsolete]
        protected void newButton_Click1(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand cmd = new SqlCommand(@"Select max(cast(invno as int)) as invno from invoicing where company='" + Company1 + "'", con);
                con.Open();
                var inv = cmd.ExecuteScalar();
                if (inv.ToString() == "")
                {
                    inv = "0";
                }
                else
                {
                    inv = cmd.ExecuteScalar();
                }
                var invoice = Convert.ToInt32(inv);
                invoice++;
                invno.Value = invoice.ToString();
                invno1.Value = invoice.ToString();
                vno.InnerText = invoice.ToString();
                othvno.InnerText = invoice.ToString();
                con.Close();
            }
            modeDropDownList.Enabled = true;
            this.RadGrid1.DataSource = new string[] { };
            this.RadGrid1.Rebind();
            this.RadGrid2.DataSource = new string[] { };
            this.RadGrid2.Rebind();
            this.RadGrid3.DataSource = new string[] { };
            this.RadGrid3.Rebind();
            this.RadGrid4.DataSource = new string[] { };
            this.RadGrid4.Rebind();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "newBtn", "newBtn()", true);
        }

        protected void Unnamed_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showotherpopup2", "showotherpopup2();", true);
        }

        protected void searchButton_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "searchPopup", "searchPopup();", true);
        }

        [Obsolete]
        protected void searchOk_Click(object sender, EventArgs e)
        {
            setValues();
            if (invoiceSearch.Value.ToString() != "")
            {
                searchInvoice(invoiceSearch.Value.ToString());
            }
            else if (ticketSearch.Value.ToString() != "")
            {
                using (SqlConnection con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(@"select invno from [dbo].[invoicing] where company='" + Company1 + "' and ticketno='" + ticketSearch.Value.ToString() + "'", con);
                    object invno = cmd.ExecuteScalar();
                    if (invno != null)
                    {
                        searchInvoice(invno.ToString());
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "NoExistPopup1", "NoExistPopup1();", true);

                        invoiceSearch.Value = "";
                        ticketSearch.Value = "";
                        pnrSearch.Value = "";
                    }
                    con.Close();
                }
            }
            else if (pnrSearch.Value.ToString() != "")
            {
                using (SqlConnection con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(@"select invno from [dbo].[invoicing] where company='" + Company1 + "' and pnr='" + pnrSearch.Value.ToString() + "'", con);
                    object invno = cmd.ExecuteScalar();
                    if (invno != null)
                    {
                        searchInvoice(invno.ToString());
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "NoExistPopup1", "NoExistPopup1();", true);

                        invoiceSearch.Value = "";
                        ticketSearch.Value = "";
                        pnrSearch.Value = "";
                    }
                    con.Close();
                }
            }
        }
        [Obsolete]
        protected void searchInvoice(string invoiceNo)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                int count = 0;
                SqlCommand invoice = new SqlCommand(@"Select distinct cast(invno as int) as invno from invoicing where company='" + Company1 + "' order by cast(invno as int) DESC", con);
                SqlDataReader readerinv = invoice.ExecuteReader();
                List<string> invnolist = new List<string>();
                while (readerinv.Read())
                {
                    invnolist.Add(Convert.ToString(readerinv["invno"]));
                    count++;
                }
                readerinv.Close();
                Global.offset = invnolist.FindIndex(arr => arr == invoiceNo);

                if (Global.offset != -1)
                {
                    vno.InnerText = invoiceNo;
                    othvno.InnerText = invoiceNo;
                    invno.Value = invoiceNo;
                    invno1.Value = invoiceNo;

                    DataTable table = new DataTable();
                    SqlCommand cmdtable = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmdtable);
                    data.Fill(table);
                    this.RadGrid2.DataSource = table;
                    this.RadGrid2.Rebind();
                    this.RadGrid3.DataSource = table;
                    this.RadGrid3.Rebind();

                    DataTable tableoth = new DataTable();
                    SqlCommand cmdoth = new SqlCommand("SELECT * FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                    SqlDataAdapter dataoth = new SqlDataAdapter(cmdoth);
                    dataoth.Fill(tableoth);
                    this.RadGrid1.DataSource = tableoth;
                    this.RadGrid1.Rebind();

                    DataTable tableoth1 = new DataTable();
                    SqlCommand cmdoth1 = new SqlCommand(@"select * from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "' and ticketno like 'OTH%'", con);
                    SqlDataAdapter dataoth1 = new SqlDataAdapter(cmdoth1);
                    dataoth1.Fill(tableoth1);
                    this.RadGrid4.DataSource = tableoth1;
                    this.RadGrid4.Rebind();
                    con.Close();

                    SqlCommand cmdtotal = new SqlCommand("SELECT sum(TRY_CONVERT(INT ,amount)) FROM others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                    con.Open();
                    var total = cmdtotal.ExecuteScalar().ToString();
                    tpayable.Value = total;
                    tpay.Value = total;
                    con.Close();
                    var query = "select sum(TRY_CONVERT(float ,commkb)) as kb,sum(TRY_CONVERT(float ,tcom)) as comm,sum(TRY_CONVERT(float ,whairline)) as whair,sum(TRY_CONVERT(float ,whclient)) as whclient,sum(TRY_CONVERT(float ,otherpayable)) as otherpayable,sum(TRY_CONVERT(float ,profitlossamt)) as profitloss,sum(TRY_CONVERT(float ,receivableclient)) as receivable,sum(TRY_CONVERT(float ,discamt)) as sp,sum(TRY_CONVERT(float ,airlinepayable)) as payable,sum(TRY_CONVERT(float ,mkt)) as fare,sum(TRY_CONVERT(float ,tax)) as tax,sum(TRY_CONVERT(float ,oth)) as other from [dbo].[invoicing] where company='" + Company1 + "' and invno='" + invno.Value + "'";

                    var cmd = new SqlCommand(query, con);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        utkb.Value = Convert.ToString(reader["kb"]);
                        utkb1.Value = Convert.ToString(reader["kb"]);
                        utcomm.Value = Convert.ToString(reader["comm"]);
                        utcomm1.Value = Convert.ToString(reader["comm"]);
                        utwhair.Value = Convert.ToString(reader["whair"]);
                        utwhair1.Value = Convert.ToString(reader["whair"]);
                        utwhclient.Value = Convert.ToString(reader["whclient"]);
                        utwhclient1.Value = Convert.ToString(reader["whclient"]);
                        utotherpay.Value = Convert.ToString(reader["otherpayable"]);
                        utotherpay1.Value = Convert.ToString(reader["otherpayable"]);
                        utpl.Value = Convert.ToString(reader["profitloss"]);
                        utpl1.Value = Convert.ToString(reader["profitloss"]);
                        uttsp.Value = Convert.ToString(reader["sp"]);
                        uttsp1.Value = Convert.ToString(reader["sp"]);
                        uttrcv.Value = Convert.ToString(reader["receivable"]);
                        uttrcv1.Value = Convert.ToString(reader["receivable"]);
                        uttpay.Value = Convert.ToString(reader["payable"]);
                        uttpay1.Value = Convert.ToString(reader["payable"]);
                        uttfare.Value = Convert.ToString(reader["fare"]);
                        uttfare1.Value = Convert.ToString(reader["fare"]);
                        utttax.Value = Convert.ToString(reader["tax"]);
                        utttax1.Value = Convert.ToString(reader["tax"]);
                        uttother.Value = Convert.ToString(reader["other"]);
                        uttother1.Value = Convert.ToString(reader["other"]);
                    }

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "NoExistPopup1", "NoExistPopup1();", true);
                }
            }
            invoiceSearch.Value = "";
            ticketSearch.Value = "";
            pnrSearch.Value = "";
        }
        protected void delButton_Click1(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showdeletepopuptkt", "showdeletepopuptkt();", true);
        }
        protected void delButton_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showdeletepopupinv", "showdeletepopupinv();", true);
        }

        [Obsolete]
        protected void Yestkt_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                try
                {
                    con.Open();
                    SqlCommand cmddel = new SqlCommand("delete from invoicing where invno='" + invno.Value + "' and ticketno='" + tktno.Value + "' and company='" + Company1 + "'", con);
                    SqlCommand cmd1del = new SqlCommand("delete from ledger where invno='" + invno.Value + "' and tblid='" + tblid.Value + "' and tblname='INV' and company='" + Company1 + "'", con);
                    SqlCommand cmd2del = new SqlCommand("delete from others where invno='" + invno.Value + "' and ticketn0='" + tktno.Value + "' and company='" + Company1 + "'", con);
                    cmddel.ExecuteNonQuery();
                    cmd1del.ExecuteNonQuery();
                    cmd2del.ExecuteNonQuery();
                    con.Close();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
            }
            Response.Redirect("normalinvoice.aspx");
        }

        [Obsolete]
        protected void Yesinv_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                try
                {
                    con.Open();
                    SqlCommand cmddel = new SqlCommand("delete from invoicing where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                    SqlCommand cmd1del = new SqlCommand("delete from ledger where invno='" + invno.Value + "' and tblname='INV' and company='" + Company1 + "'", con);
                    SqlCommand cmd2del = new SqlCommand("delete from others where invno='" + invno.Value + "' and company='" + Company1 + "'", con);
                    cmddel.ExecuteNonQuery();
                    cmd1del.ExecuteNonQuery();
                    cmd2del.ExecuteNonQuery();
                    con.Close();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
            }
            Response.Redirect("normalinvoice.aspx");
        }
    }
}