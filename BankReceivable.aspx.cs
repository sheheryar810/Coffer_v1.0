using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Windows.Controls;
using Telerik.Web.UI;
using Telerik.Web.UI.com.hisoftware.api2;
using Telerik.Web.UI.Editor.DialogControls;
using Telerik.Web.UI.PivotGrid.Core.Totals;

namespace Coffer_Systems
{
    public partial class BankReceivable : System.Web.UI.Page
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;
        public static class Global
        {
            public static int offset;
        }
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
                    Global.offset = 0;
                    string inv = Request.QueryString["id"];
                    setValues();
                    using (SqlConnection con = new SqlConnection(connectionStr))
                    {
                        int count = 0;
                        SqlCommand invoice = new SqlCommand(@"Select distinct cast(invno as int) as invno from BankReceivable where company='" + Company + "' order by cast(invno as int) DESC", con);
                        con.Open();
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
                                invno.Value = inv;
                                Label1.InnerText = inv;
                                Label2.InnerText = inv;
                                Global.offset = invnolist.FindIndex(arr => arr == inv);
                            }
                            else
                            {
                                vno.InnerText = invnolist[Global.offset];
                                invno.Value = invnolist[Global.offset];
                                Label1.InnerText = invnolist[Global.offset];
                                Label2.InnerText = invnolist[Global.offset];

                            }
                            SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,credit)) from ledger where invno='" + invno.Value + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                            SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,debit)) from ledger where invno='" + invno.Value + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                            SqlCommand cmdstatus = new SqlCommand(@"Select status from ledger where credit!='0' and credit!='' and invno='" + invno.Value + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                            var credit1 = cmdcredit.ExecuteScalar().ToString();
                            var debit1 = cmddebit.ExecuteScalar().ToString();
                            var status1 = cmdstatus.ExecuteScalar();
                            string status = status1 != null ? status1.ToString() : string.Empty;
                            int creditVal = int.Parse(credit1);
                            int debitVal = int.Parse(debit1);
                            credit.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                            debit.Value = string.Format("{0:C}", debitVal).Remove(0, 1);
                            voucheramt.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                            voucheramt1.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                            if (status.ToString() == "")
                            {
                                status = "Not Cleared";
                            }
                            voucherstatus.Value = status;
                            SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invno.Value + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                            var code = cmdcode.ExecuteScalar().ToString();
                            if (code != "")
                            {
                                SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                                var head = cmdhead.ExecuteScalar().ToString();
                                Text1.Value = head;
                                accname.Value = head;
                                customername.Value = head;
                                customername1.Value = head;
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alertPopup", "alertPopup();", true);
                        }
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
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                DataTable table = new DataTable();
                SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM BankReceivable where  invno='" + invno.Value + "' and company='" + Company + "' order by id", con);
                SqlDataAdapter data = new SqlDataAdapter(cmd);
                data.Fill(table);
                (sender as RadGrid).DataSource = table;
                con.Close();
            }

        }
        [Obsolete]
        protected void PrevBtn_Click(object sender, EventArgs e)
        {
            setValues();

            int count = 0;
            Global.offset++;
            List<string> invnolist = new List<string>();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand invoiceno = new SqlCommand(@"Select distinct cast(invno as int) as invno from BankReceivable where company='" + Company + "' order by cast(invno as int) DESC", con);
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
                    SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM BankReceivable where  invno='" + invoice.ToString() + "' and company='" + Company + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmd);
                    data.Fill(table);
                    this.RadGrid1.DataSource = table;
                    this.RadGrid1.Rebind();
                    SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,credit)) from ledger where invno='" + invoice.ToString() + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                    SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,debit)) from ledger where invno='" + invoice.ToString() + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                    SqlCommand cmdstatus = new SqlCommand(@"Select status from ledger where credit!='0' and credit!='' and invno='" + invnolist[Global.offset] + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                    var credit1 = cmdcredit.ExecuteScalar().ToString();
                    var debit1 = cmddebit.ExecuteScalar().ToString();
                    var status = cmdstatus.ExecuteScalar().ToString();
                    int creditVal = int.Parse(credit1);
                    int debitVal = int.Parse(debit1);
                    credit.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                    debit.Value = string.Format("{0:C}", debitVal).Remove(0, 1);
                    voucheramt.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                    voucheramt1.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                    if (status == "")
                    {
                        status = "Not Cleared";
                    }
                    voucherstatus.Value = status;
                    SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invnolist[Global.offset] + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                    var code = cmdcode.ExecuteScalar().ToString();
                    SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                    var head = cmdhead.ExecuteScalar().ToString();
                    Text1.Value = head;
                    accname.Value = head;
                    customername.Value = head;
                    customername1.Value = head;
                }
                invno.Value = invoice.ToString();
                vno.InnerText = invoice.ToString();
                Label1.InnerText = invoice.ToString();
                Label2.InnerText = invoice.ToString();
            }
            //
        }
        [Obsolete]
        protected void NextBtn_Click(object sender, EventArgs e)
        {

            setValues();
            Global.offset--;
            List<string> invnolist = new List<string>();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand invoiceno = new SqlCommand(@"Select distinct cast(invno as int) as invno from BankReceivable where company='" + Company + "' order by cast(invno as int) DESC", con);
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
                    DataTable table = new DataTable();
                    SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM BankReceivable where  invno='" + invoice.ToString() + "' and company='" + Company + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmd);
                    data.Fill(table);
                    this.RadGrid1.DataSource = table;
                    this.RadGrid1.Rebind();
                    con.Open();
                    SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,credit)) from ledger where invno='" + invoice.ToString() + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                    SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,debit)) from ledger where invno='" + invoice.ToString() + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                    SqlCommand cmdstatus = new SqlCommand(@"Select status from ledger where credit!='0' and credit!='' and invno='" + invoice.ToString() + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                    var credit1 = cmdcredit.ExecuteScalar().ToString();
                    var debit1 = cmddebit.ExecuteScalar().ToString();
                    var status = cmdstatus.ExecuteScalar().ToString();
                    int creditVal = int.Parse(credit1);
                    int debitVal = int.Parse(debit1);
                    credit.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                    debit.Value = string.Format("{0:C}", debitVal).Remove(0, 1);
                    voucheramt.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                    voucheramt1.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                    if (status == "")
                    {
                        status = "Not Cleared";
                    }
                    voucherstatus.Value = status;
                    SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invoice.ToString() + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                    var code = cmdcode.ExecuteScalar().ToString();
                    SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                    var head = cmdhead.ExecuteScalar().ToString();
                    Text1.Value = head;
                    accname.Value = head;
                    customername.Value = head;
                    customername1.Value = head;
                }
                invno.Value = invoice.ToString();
                vno.InnerText = invoice.ToString();
                Label1.InnerText = invoice.ToString();
                Label2.InnerText = invoice.ToString();
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
                SqlCommand cmd1 = new SqlCommand(@"Select code +' '+ sub_head AS full_name , code from subheads where level='4' and (company='" + Company + "' OR company='All') order by sub_head ", con);
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
        [Obsolete]
        protected void ddltransactiontype_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            setValues();
            RadComboBox ddltransactiontype = sender as RadComboBox;
            RadComboBoxItem item1 = new RadComboBoxItem();
            item1.Text = "DB";
            item1.Value = "DB";
            ddltransactiontype.Items.Add(item1);
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "CR";
            item2.Value = "CR";
            ddltransactiontype.Items.Add(item2);

        }
        [Obsolete]
        protected void RadGrid1_BatchEditCommand(object sender, GridBatchEditingEventArgs e)
        {
            try
            {
                setValues();
                var debitVal = 0.0;
                var creditVal = 0.0;
                int count = 0, dcount = 0;
                var flag = true;
                foreach (GridBatchEditingCommand command in e.Commands)
                {
                    Hashtable oldValues = command.OldValues;
                    Hashtable newValues = command.NewValues;
                    if (oldValues["amount"] == newValues["amount"])
                    {
                        flag = true;
                    }
                    else
                    {
                        flag = false;
                    }
                }
                if (!flag)
                {
                    foreach (GridBatchEditingCommand command in e.Commands)
                    {
                        Hashtable oldValues = command.OldValues;
                        Hashtable newValues = command.NewValues;
                        using (SqlConnection con = new SqlConnection(connectionStr))
                        {
                            if (command.Type == GridBatchEditingCommandType.Update)
                            {
                                string transactiontype = newValues["ID_transactiontype"] == null ? null : newValues["ID_transactiontype"].ToString();
                                if (transactiontype == "DB")
                                {
                                    debitVal += newValues["amount"] == null ? 0.00 : float.Parse(newValues["amount"].ToString());
                                }
                                else
                                {
                                    creditVal += newValues["amount"] == null ? 0.00 : float.Parse(newValues["amount"].ToString());
                                }
                            }
                            else if (command.Type == GridBatchEditingCommandType.Insert)
                            {
                                string transactiontype = newValues["ID_transactiontype"] == null ? null : newValues["ID_transactiontype"].ToString();
                                if (transactiontype == "DB")
                                {
                                    debitVal += newValues["amount"] == null ? 0.00 : float.Parse(newValues["amount"].ToString());
                                }
                                else
                                {
                                    creditVal += newValues["amount"] == null ? 0.00 : float.Parse(newValues["amount"].ToString());
                                }
                            }
                            else if (command.Type == GridBatchEditingCommandType.Delete)
                            {
                                string transactiontype = newValues["ID_transactiontype"] == null ? null : newValues["ID_transactiontype"].ToString();
                                if (transactiontype == "DB")
                                {
                                    debitVal -= newValues["amount"] == null ? 0.00 : float.Parse(newValues["amount"].ToString());
                                }
                                else
                                {
                                    creditVal -= newValues["amount"] == null ? 0.00 : float.Parse(newValues["amount"].ToString());
                                }
                            }
                        }
                        credit.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                        voucheramt.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                        voucheramt1.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                        debit.Value = string.Format("{0:C}", debitVal).Remove(0, 1);
                    }
                }
                if (debitVal == creditVal)
                {
                    var tbl = "BR";

                    foreach (GridBatchEditingCommand command in e.Commands)
                    {
                        Hashtable newValues = command.NewValues;
                        Hashtable oldValues = command.OldValues;

                        string code = newValues["ID_Name"] == null ? null : newValues["ID_Name"].ToString();
                        if (code == "11001")
                        {
                            tbl = "CR";
                        }
                    }

                    foreach (GridBatchEditingCommand command in e.Commands)
                    {
                        Hashtable oldValues = command.OldValues;
                        Hashtable newValues = command.NewValues;
                        using (SqlConnection con = new SqlConnection(connectionStr))
                        {
                            if (command.Type == GridBatchEditingCommandType.Update)
                            {
                                count++;
                                string code = newValues["ID_Name"] == null ? null : newValues["ID_Name"].ToString();
                                string transactiontype = newValues["ID_transactiontype"] == null ? null : newValues["ID_transactiontype"].ToString();
                                string description = newValues["description"] == null ? null : newValues["description"].ToString();
                                string seggregation = newValues["seggregation"] == null ? null : newValues["seggregation"].ToString();
                                string receipt = newValues["receipt"] == null ? null : newValues["receipt"].ToString();
                                string cheque = newValues["cheque"] == null ? null : newValues["cheque"].ToString();
                                string amount = newValues["amount"] == null ? "0" : float.Parse(newValues["amount"].ToString(), CultureInfo.InvariantCulture.NumberFormat).ToString();
                                string date = newValues["date"] == null ? oldValues["date"].ToString() : newValues["date"].ToString();

                                var formattedDate = date.Split(' ');
                                formattedDate = formattedDate[0].Split('/');
                                var day = "";
                                var month = "";
                                if (formattedDate[1].Length != 2)
                                {
                                    month = "0" + formattedDate[1];
                                }
                                else
                                {
                                    month = formattedDate[1];
                                }
                                if (formattedDate[0].Length != 2)
                                {
                                    day = "0" + formattedDate[0];
                                }
                                else
                                {
                                    day = formattedDate[0];
                                }
                                var dateString = formattedDate[2] + "-" + month + "-" + day;

                                string id = newValues["id"] == null ? null : newValues["id"].ToString();
                                string debit = "0";
                                string credit = "0";
                                string strblnc = "select balance from ledger where tblname='" + tbl + "' and tblid='" + id + "' and head='" + code + "' and company='" + Company + "'";
                                SqlCommand cmdb = new SqlCommand(strblnc, con);
                                cmdb.Connection.Open();
                                var balanceval = 0.0;
                                var balance = cmdb.ExecuteScalar();
                                cmdb.Connection.Close();
                                if (balance != null)
                                {
                                    if (balance.ToString() != "")
                                    {
                                        balanceval = float.Parse(balance.ToString());
                                    }
                                }
                                string strcred = "select debit from ledger where tblname='" + tbl + "' and tblid='" + id + "' and head='" + code + "' and company='" + Company + "'";
                                SqlCommand cmdc = new SqlCommand(strcred, con);
                                cmdc.Connection.Open();
                                var debitval = 0.0;
                                var ldebit = cmdc.ExecuteScalar();
                                cmdc.Connection.Close();
                                if (ldebit != null)
                                {
                                    if (ldebit.ToString() != "")
                                    {
                                        debitval = float.Parse(ldebit.ToString());
                                    }
                                }
                                string strdeb = "select credit from ledger where tblname='" + tbl + "' and tblid='" + id + "' and head='" + code + "' and company='" + Company + "'";
                                SqlCommand cmdd = new SqlCommand(strdeb, con);
                                cmdd.Connection.Open();
                                var creditval = 0.0;
                                var lcredit = cmdd.ExecuteScalar();
                                cmdd.Connection.Close();
                                if (lcredit != null)
                                {
                                    if (lcredit.ToString() != "")
                                    {
                                        creditval = float.Parse(lcredit.ToString());
                                    }
                                }
                                if (transactiontype == "DB")
                                {
                                    debit = amount;
                                    var difference = float.Parse(debit) - debitval + creditval;
                                    balanceval = balanceval + difference;
                                }
                                else
                                {
                                    credit = amount;
                                    var difference = float.Parse(credit) - creditval + debitval;
                                    balanceval = balanceval - difference;
                                }
                                string str = "UPDATE BankReceivable SET code='" + code + "', transactiontype='" + transactiontype + "', description='" + description + "', seggregation='" + seggregation + "', receipt='" + receipt + "', cheque='" + cheque + "', amount='" + amount + "', date='" + dateString + "', invno='" + invno.Value + "' WHERE id='" + id + "' and company='" + Company + "'";
                                SqlCommand cmd = new SqlCommand(str, con);
                                cmd.Connection.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Connection.Close();
                                string str1 = "UPDATE ledger SET balance='" + balanceval + "',description='" + description + "', head='" + code + "', credit='" + credit + "', debit='" + debit + "', date='" + dateString + "', invno='" + invno.Value + "' WHERE tblid='" + id + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'";
                                SqlCommand cmd1 = new SqlCommand(str1, con);
                                cmd1.Connection.Open();
                                cmd1.ExecuteNonQuery();
                                cmd1.Connection.Close();
                            }
                            else if (command.Type == GridBatchEditingCommandType.Insert)
                            {
                                string code = newValues["ID_Name"] == null ? null : newValues["ID_Name"].ToString();
                                string transactiontype = newValues["ID_transactiontype"] == null ? null : newValues["ID_transactiontype"].ToString();
                                string description = newValues["description"] == null ? null : newValues["description"].ToString();
                                string seggregation = newValues["seggregation"] == null ? null : newValues["seggregation"].ToString();
                                string receipt = newValues["receipt"] == null ? null : newValues["receipt"].ToString();
                                string cheque = newValues["cheque"] == null ? null : newValues["cheque"].ToString();
                                string amount = newValues["amount"] == null ? "0" : float.Parse(newValues["amount"].ToString(), CultureInfo.InvariantCulture.NumberFormat).ToString();
                                string date = newValues["date"] == null ? oldValues["date"].ToString() : newValues["date"].ToString();

                                var formattedDate = date.Split(' ');
                                formattedDate = formattedDate[0].Split('/');
                                var day = "";
                                var month = "";
                                if (formattedDate[1].Length != 2)
                                {
                                    month = "0" + formattedDate[1];
                                }
                                else
                                {
                                    month = formattedDate[1];
                                }
                                if (formattedDate[0].Length != 2)
                                {
                                    day = "0" + formattedDate[0];
                                }
                                else
                                {
                                    day = formattedDate[0];
                                }
                                var dateString = formattedDate[2] + "-" + month + "-" + day;
                                string debit = "0";
                                string credit = "0";
                                string strblnc = "select top 1 balance from ledger where head='" + code + "' and company='" + Company + "' order by id desc";
                                SqlCommand cmdb = new SqlCommand(strblnc, con);
                                cmdb.Connection.Open();
                                var balanceval = 0.0;
                                var balance = cmdb.ExecuteScalar();
                                cmdb.Connection.Close();
                                if (balance != null)
                                {
                                    if (balance.ToString() != "")
                                    {
                                        balanceval = float.Parse(balance.ToString());
                                    }
                                }
                                if (transactiontype == "DB")
                                {
                                    debit = amount;
                                    balanceval = balanceval + float.Parse(debit);
                                }
                                else
                                {
                                    credit = amount;
                                    balanceval = balanceval - float.Parse(credit);
                                }
                                string str = "INSERT INTO BankReceivable(username,company,code,transactiontype,description,seggregation,receipt,cheque,amount,date,invno) VALUES('" + UserName + "','" + Company + "','" + code + "','" + transactiontype + "','" + description + "','" + seggregation + "','" + receipt + "','" + cheque + "','" + amount + "', '" + dateString + "','" + invno.Value + "')";
                                SqlCommand cmd = new SqlCommand(str, con);
                                cmd.Connection.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Connection.Close();
                                con.Open();
                                SqlCommand cmdid = new SqlCommand(@"Select max(id) from BankReceivable", con);
                                var tblid = cmdid.ExecuteScalar().ToString();
                                con.Close();
                                string str1 = "INSERT INTO ledger(balance,username,company,description,head,debit,credit,date,invno,tblname,tblid,status) VALUES('" + balanceval + "','" + UserName + "','" + Company + "','" + description + "','" + code + "','" + debit + "','" + credit + "','" + dateString + "','" + invno.Value + "','" + tbl + "','" + tblid + "','Not Cleared')";
                                SqlCommand cmd1 = new SqlCommand(str1, con);
                                cmd1.Connection.Open();
                                cmd1.ExecuteNonQuery();
                                cmd1.Connection.Close();
                            }
                            else if (command.Type == GridBatchEditingCommandType.Delete)
                            {
                                dcount++;
                                string id = newValues["id"] == null ? null : newValues["id"].ToString();
                                string str = "DELETE FROM BankReceivable WHERE id= '" + id + "' and company='" + Company + "'";
                                SqlCommand cmd = new SqlCommand(str, con);
                                cmd.Connection.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Connection.Close();
                                string str1 = "DELETE FROM ledger WHERE tblid= '" + id + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'";
                                SqlCommand cmd1 = new SqlCommand(str1, con);
                                cmd1.Connection.Open();
                                cmd1.ExecuteNonQuery();
                                cmd1.Connection.Close();
                            }
                        }
                    }
                    if (count > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showupdatepopup", "showupdatepopup();", true);
                    }
                    else if (dcount > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showdeletepopup", "showdeletepopup();", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showsuccesspopup", "showsuccesspopup();", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showfailurepopup", "showfailurepopup();", true);
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
            
        }
        protected void RadComboBox1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        [Obsolete]
        protected void NewBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand cmd = new SqlCommand(@"Select max(cast(invno as int)) as invno from BankReceivable where company='" + Company + "'", con);
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
                vno.InnerText = invoice.ToString();
                Label1.InnerText = invoice.ToString();
                Label2.InnerText = invoice.ToString();
                con.Close();
            }

            credit.Value = "";
            debit.Value = "";
            accname.Value = "";
            voucherstatus.Value = "Not Cleared";
            this.RadGrid1.DataSource = new string[] { };
            this.RadGrid1.Rebind();
            
        }

        [Obsolete]
        protected void OkBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand cmd = new SqlCommand(@"update BankReceivable set invno='" + Text2.Value + "' where invno='" + invno.Value + "' and company='" + Company + "'", con);
                SqlCommand cmd1 = new SqlCommand(@"update ledger set invno='" + Text2.Value + "' where invno='" + invno.Value + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                con.Open();
                cmd.ExecuteNonQuery();
                cmd1.ExecuteNonQuery();
                con.Close();
            }
             Response.Redirect("BankReceivable.aspx");
        }

        [Obsolete]
        protected void RadGrid3_BatchEditCommand(object sender, GridBatchEditingEventArgs e)
        {
            setValues();
            float totalAmount = 0;
            try
            {
                foreach (GridBatchEditingCommand command in e.Commands)
                {
                    Hashtable newValues = command.NewValues;
                    string amount = newValues["amount"] == null ? null : newValues["amount"].ToString();
                    totalAmount += float.Parse(amount);
                }
                if (totalAmount <= float.Parse(voucheramt.Value) && totalAmount != 0)
                {
                    //remainingamt.Value = (float.Parse(voucheramt.Value) - totalAmount).ToString();
                    //remainingamt1.Value = (float.Parse(voucheramt.Value) - totalAmount).ToString();
                    foreach (GridBatchEditingCommand command in e.Commands)
                    {
                        Hashtable oldValues = command.OldValues;
                        Hashtable newValues = command.NewValues;
                        string balanceval = newValues["balance"] == null ? "0" : newValues["balance"].ToString();
                        string creditval = newValues["amount"] == null ? "0" : newValues["amount"].ToString();
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        float total = float.Parse(balanceval) - float.Parse(creditval);

                        using (SqlConnection con = new SqlConnection(connectionStr))
                        {
                            if (command.Type == GridBatchEditingCommandType.Update)
                            {

                                string strclear = "insert into clearance(invno,tblid,tblname,amount,username,company) values('" + invno.Value + "','" + id + "','BR','" + creditval + "','" + UserName + "','" + Company + "')";
                                SqlCommand cmdclear = new SqlCommand(strclear, con);
                                cmdclear.Connection.Open();
                                cmdclear.ExecuteNonQuery();
                                cmdclear.Connection.Close();

                                string str = "UPDATE invoicing SET credit='" + creditval + "', balance='" + total + "', tblname='BR', tblinvno='" + invno.Value + "'  WHERE id='" + id + "' and company='" + Company + "'";
                                SqlCommand cmd = new SqlCommand(str, con);
                                cmd.Connection.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Connection.Close();
                                string str1del = "update ledger set status='Cleared' WHERE invno= '" + invno.Value + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'";
                                SqlCommand cmd1 = new SqlCommand(str1del, con);
                                cmd1.Connection.Open();
                                cmd1.ExecuteNonQuery();
                                cmd1.Connection.Close();
                            }
                        }
                    }
                     Response.Redirect("BankReceivable.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showfailurepopupclearance", "showfailurepopupclearance();", true);
                }
                
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            this.RadGrid3.DataSource = new string[] { };
        }
        protected void RadGrid2_BatchEditCommand(object sender, GridBatchEditingEventArgs e)
        {
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

                    string strblnc = "select balance from invoicing where id='" + id + "'and company='" + Company + "'";
                    SqlCommand cmdblnc = new SqlCommand(strblnc, con);
                    cmdblnc.Connection.Open();
                    string balance = cmdblnc.ExecuteScalar().ToString();
                    cmdblnc.Connection.Close();
                    string strcr = "select credit from invoicing where id='" + id + "'and company='" + Company + "'";
                    SqlCommand cmdcr = new SqlCommand(strcr, con);
                    cmdcr.Connection.Open();
                    string credit = cmdcr.ExecuteScalar().ToString();
                    cmdcr.Connection.Close();
                    string strclr = "select amount from clearance where tblid='" + id + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'";
                    SqlCommand cmdclr = new SqlCommand(strclr, con);
                    cmdclr.Connection.Open();
                    string clearance = cmdclr.ExecuteScalar().ToString();
                    cmdclr.Connection.Close();

                    float remmainingbalance = float.Parse(balance) + float.Parse(clearance);
                    float remmainingcredit = float.Parse(credit) - float.Parse(clearance);
                    string str = "update invoicing set balance = '" + remmainingbalance + "', credit='" + remmainingcredit + "' where id='" + id + "' and company='" + Company + "'";
                    SqlCommand cmd = new SqlCommand(str, con);
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();

                    string str2 = "delete from clearance where tblid='" + id + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'";
                    SqlCommand cmd2 = new SqlCommand(str2, con);
                    cmd2.Connection.Open();
                    cmd2.ExecuteNonQuery();
                    cmd2.Connection.Close();
                }
                string str1 = "update ledger set status='Not Cleared' WHERE invno= '" + invno.Value + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'";
                SqlCommand cmd1 = new SqlCommand(str1, con);
                cmd1.Connection.Open();
                cmd1.ExecuteNonQuery();
                cmd1.Connection.Close();
                voucherstatus.Value = "Not Cleared";
            }
            
            //Response.Redirect("BankReceivable.aspx");
        }

        [Obsolete]
        protected void btnShowPopup_Click(object sender, EventArgs e)
        {
            try
            {
                setValues();
                if (voucherstatus.Value == "Cleared")
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
                        var code1 = "";
                        var query1 = "select code from [dbo].[subheads] where sub_head='" + Text1.Value.ToString() + "' and (company='" + Company + "' OR company='All')";
                        SqlCommand cmd1 = new SqlCommand(query1, con);
                        code1 = cmd1.ExecuteScalar().ToString();
                        var query = "select DATEDIFF(day,CAST(invdate AS datetime), GETDATE()) as age,(select sum(TRY_CONVERT(float, amount)) from clearance where tblname='BR' and clearance.tblid=invoicing.id and clearance.invno='" + invno.Value + "') as amount,* from [dbo].[invoicing] where (clientcode='" + code1 + "' or airline = '" + code1 + "') and company='" + Company + "' and balance>'0' order by invdate, ticketno asc";
                        var cmd = new SqlCommand(query, con);
                        SqlDataAdapter data = new SqlDataAdapter(cmd);
                        data.Fill(table);
                        this.RadGrid3.DataSource = table;
                        this.RadGrid3.Rebind();
                        var query2 = "select (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='BR' and clearance.tblid=invoicing.id and clearance.invno='" + invno.Value + "') as totalcredit,sum(TRY_CONVERT(float, receivableclient)) as totalticketvalue,sum(TRY_CONVERT(float, balance)) as totalbalance from invoicing where (clientcode='" + code1 + "' or airline = '" + code1 + "') and company='" + Company + "' and balance>'0' group by invoicing.id";
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
                        Text3.Value = string.Format("{0:C}", tt).Remove(0, 1);
                        Text4.Value = string.Format("{0:C}", tc).Remove(0, 1);
                        Text5.Value = string.Format("{0:C}", tb).Remove(0, 1);
                        reader.Close();
                        con.Close();
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowPopup1", "ShowPopup1();", true);
                    }
                }
                
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
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
                var code1 = "";
                var query1 = "select code from [dbo].[subheads] where sub_head='" + Text1.Value.ToString() + "' and (company='" + Company + "' OR company='All')";
                SqlCommand cmd1 = new SqlCommand(query1, con);
                code1 = cmd1.ExecuteScalar().ToString();
                var query = "select DATEDIFF(day,CAST(invdate AS datetime), GETDATE()) as age,(select sum(TRY_CONVERT(float, amount)) from clearance where tblname='BR' and clearance.tblid=invoicing.id and clearance.invno='" + invno.Value + "') as amount,* from [dbo].[invoicing] where (clientcode='" + code1 + "' or airline = '" + code1 + "') and company='" + Company + "' and (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='BR' and clearance.tblid=invoicing.id and clearance.invno='" + invno.Value + "')>'0' order by invdate, ticketno asc";
                var cmd = new SqlCommand(query, con);
                SqlDataAdapter data = new SqlDataAdapter(cmd);
                data.Fill(table);
                this.RadGrid2.DataSource = table;
                this.RadGrid2.Rebind();
                var query2 = "select (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='BR' and clearance.tblid=invoicing.id and clearance.invno='" + invno.Value + "') as totalcredit,sum(TRY_CONVERT(float, receivableclient)) as totalticketvalue,sum(TRY_CONVERT(float, balance)) as totalbalance from invoicing where (clientcode='" + code1 + "' or airline = '" + code1 + "') and company='" + Company + "' and (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='BR' and clearance.tblid=invoicing.id and clearance.invno='" + invno.Value + "')>'0' group by invoicing.id";
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
        protected void Unnamed_DataBinding(object sender, EventArgs e)
        {
            GridDateTimeColumn col = RadGrid1.MasterTableView.GetColumn("date") as GridDateTimeColumn;
            col.DefaultInsertValue = DateTime.Now.ToShortDateString();
        }
        protected void searchButton_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "searchPopup", "searchPopup();", true);
        }
        [Obsolete]
        protected void searchOk_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                int count = 0;
                SqlCommand invoice = new SqlCommand(@"Select distinct cast(invno as int) as invno from BankReceivable where company='" + Company + "' order by cast(invno as int) DESC", con);
                con.Open();
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
                    Global.offset = invnolist.FindIndex(arr => arr == invoiceSearch.Value);
                    if (Global.offset != -1)
                    {
                        vno.InnerText = invoiceSearch.Value;
                        invno.Value = invoiceSearch.Value;
                        Label1.InnerText = invoiceSearch.Value;
                        Label2.InnerText = invoiceSearch.Value;
                        DataTable table = new DataTable();
                        SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM BankReceivable where  invno='" + invno.Value + "' and company='" + Company + "'", con);
                        SqlDataAdapter data = new SqlDataAdapter(cmd);
                        data.Fill(table);
                        this.RadGrid1.DataSource = table;
                        this.RadGrid1.Rebind();
                        SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,credit)) from ledger where invno='" + invno.Value + "' and  (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                        SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,debit)) from ledger where invno='" + invno.Value + "' and  (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                        SqlCommand cmdstatus = new SqlCommand(@"Select status from ledger where credit!='0' and credit!='' and invno='" + invno.Value + "' and  (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                        var credit1 = cmdcredit.ExecuteScalar().ToString();
                        var debit1 = cmddebit.ExecuteScalar().ToString();
                        var status1 = cmdstatus.ExecuteScalar();
                        var status = "";
                        if (status1 != null)
                        {
                            status = cmdstatus.ExecuteScalar().ToString();
                        }
                        int creditVal = int.Parse(credit1);
                        int debitVal = int.Parse(debit1);
                        credit.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                        debit.Value = string.Format("{0:C}", debitVal).Remove(0, 1);
                        voucheramt.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                        voucheramt1.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                        if (status == "")
                        {
                            status = "Not Cleared";
                        }
                        voucherstatus.Value = status;
                        SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invno.Value + "' and  (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                        var code = cmdcode.ExecuteScalar().ToString();
                        if (code != "")
                        {
                            SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                            var head = cmdhead.ExecuteScalar().ToString();
                            Text1.Value = head;
                            accname.Value = head;
                            customername.Value = head;
                            customername1.Value = head;
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "NoExistPopup", "NoExistPopup();", true);
                    }
                }
            }
            invoiceSearch.Value = "";
            
        }

        protected void DelBtn_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showdeletepopup1", "showdeletepopup1();", true);
        }

        [Obsolete]
        protected void Yes_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand cmd = new SqlCommand(@"delete from BankReceivable where invno='" + invno.Value + "' and company='" + Company + "'", con);
                SqlCommand cmd1 = new SqlCommand(@"delete from ledger where invno='" + invno.Value + "' and (tblname='BR' or tblname='CR') and company='" + Company + "'", con);
                con.Open();
                cmd.ExecuteNonQuery();
                cmd1.ExecuteNonQuery();
                con.Close();
            }
            
            Response.Redirect("BankReceivable.aspx");
        }
    }
}
