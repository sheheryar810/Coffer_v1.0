using Antlr.Runtime;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.ExportInfrastructure;

namespace Coffer_Systems
{
    public partial class CashReceivable : System.Web.UI.Page
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
                    setValues();
                    using (SqlConnection con = new SqlConnection(connectionStr))
                    {
                        int count = 0;
                        SqlCommand invoice = new SqlCommand(@"Select distinct cast(invno as int) as invno from CashReceivable where company='" + Company + "'  order by cast(invno as int) DESC", con);
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
                            vno.InnerText = invnolist[Global.offset];
                            invno.Value = invnolist[Global.offset];
                            SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,credit)) from ledger where invno='" + invnolist[Global.offset] + "' and tblname='CR' and company='" + Company + "'", con);
                            SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,debit)) from ledger where invno='" + invnolist[Global.offset] + "' and tblname='CR' and company='" + Company + "'", con);
                            SqlCommand cmdstatus = new SqlCommand(@"Select status from ledger where credit!='0' and credit!='' and invno='" + invnolist[Global.offset] + "' and tblname='CR' and company='" + Company + "'", con);
                            var credit1 = cmdcredit.ExecuteScalar().ToString();
                            var debit1 = cmddebit.ExecuteScalar().ToString();
                            var status = cmdstatus.ExecuteScalar().ToString();
                            credit.Value = credit1;
                            debit.Value = debit1;
                            voucheramt.Value = credit1;
                            voucheramt1.Value = credit1;
                            if (status == "")
                            {
                                status = "Not Cleared";
                            }
                            voucherstatus.Value = status;
                            SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invnolist[Global.offset] + "' and tblname='CR' and company='" + Company + "'", con);
                            var code = cmdcode.ExecuteScalar().ToString();
                            SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                            var head = cmdhead.ExecuteScalar().ToString();
                            Text1.Value = head;
                            accname.Value = head;
                            customername.Value = head;
                            customername1.Value = head;
                            con.Close();
                        }
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
                SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM cashReceivable where  invno='" + invno.Value + "' and company='" + Company + "'", con);
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
                SqlCommand invoiceno = new SqlCommand(@"Select distinct cast(invno as int) as invno from CashReceivable where company='" + Company + "' order by cast(invno as int) DESC", con);
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
                    SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM CashReceivable where  invno='" + invoice.ToString() + "' and company='" + Company + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmd);
                    data.Fill(table);
                    this.RadGrid1.DataSource = table;
                    this.RadGrid1.Rebind();
                    SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,credit)) from ledger where invno='" + invoice.ToString() + "' and tblname='CR' and company='" + Company + "'", con);
                    SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,debit)) from ledger where invno='" + invoice.ToString() + "' and tblname='CR' and company='" + Company + "'", con);
                    SqlCommand cmdstatus = new SqlCommand(@"Select status from ledger where credit!='0' and credit!='' and invno='" + invnolist[Global.offset] + "' and tblname='CR' and company='" + Company + "'", con);
                    var credit1 = cmdcredit.ExecuteScalar().ToString();
                    var debit1 = cmddebit.ExecuteScalar().ToString();
                    var status = cmdstatus.ExecuteScalar().ToString();
                    credit.Value = credit1;
                    debit.Value = debit1;
                    voucheramt.Value = credit1;
                    voucheramt1.Value = credit1;
                    if (status == "")
                    {
                        status = "Not Cleared";
                    }
                    voucherstatus.Value = status;
                    SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invnolist[Global.offset] + "' and tblname='CR' and company='" + Company + "'", con);
                    var code = cmdcode.ExecuteScalar().ToString();
                    SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                    var head = cmdhead.ExecuteScalar().ToString();
                    Text1.Value = head;
                    accname.Value = head;
                    customername.Value = head;
                    customername1.Value = head;
                    con.Close();
                }
                invno.Value = invoice.ToString();
                vno.InnerText = invoice.ToString();
            }
        }
        [Obsolete]
        protected void NextBtn_Click(object sender, EventArgs e)
        {
            setValues();
            Global.offset--;
            List<string> invnolist = new List<string>();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand invoiceno = new SqlCommand(@"Select distinct cast(invno as int) as invno from CashReceivable where company='" + Company + "' order by cast(invno as int) DESC", con);
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
                    SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM CashReceivable where  invno='" + invoice.ToString() + "' and company='" + Company + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmd);
                    data.Fill(table);
                    this.RadGrid1.DataSource = table;
                    this.RadGrid1.Rebind();
                    con.Open();
                    SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,credit)) from ledger where invno='" + invoice.ToString() + "' and tblname='CR' and company='" + Company + "'", con);
                    SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,debit)) from ledger where invno='" + invoice.ToString() + "' and tblname='CR' and company='" + Company + "'", con);
                    SqlCommand cmdstatus = new SqlCommand(@"Select status from ledger where credit!='0' and credit!='' and invno='" + invnolist[Global.offset] + "' and tblname='CR' and company='" + Company + "'", con);
                    var credit1 = cmdcredit.ExecuteScalar().ToString();
                    var debit1 = cmddebit.ExecuteScalar().ToString();
                    var status = cmdstatus.ExecuteScalar().ToString();
                    credit.Value = credit1;
                    debit.Value = debit1;
                    voucheramt.Value = credit1;
                    voucheramt1.Value = credit1;
                    if (status == "")
                    {
                        status = "Not Cleared";
                    }
                    voucherstatus.Value = status;
                    SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invnolist[Global.offset] + "' and tblname='CR' and company='" + Company + "'", con);
                    var code = cmdcode.ExecuteScalar().ToString();
                    SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                    var head = cmdhead.ExecuteScalar().ToString();
                    Text1.Value = head;
                    accname.Value = head;
                    customername.Value = head;
                    customername1.Value = head;
                    con.Close();
                }
                invno.Value = invoice.ToString();
                vno.InnerText = invoice.ToString();
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
                SqlCommand cmd1 = new SqlCommand(@"Select sub_head AS full_name , code from subheads where level='4'  and (company='" + Company + "' OR company='All') order by sub_head ", con);
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
                        string transactiontype = newValues["ID_transactiontype"] == null ? null : newValues["ID_transactiontype"].ToString();
                        string description = newValues["description"] == null ? null : newValues["description"].ToString();
                        string seggregation = newValues["seggregation"] == null ? null : newValues["seggregation"].ToString();
                        string receipt = newValues["receipt"] == null ? null : newValues["receipt"].ToString();
                        string cheque = newValues["cheque"] == null ? null : newValues["cheque"].ToString();
                        string amount = newValues["amount"] == null ? null : newValues["amount"].ToString();
                        string date = newValues["date"] == null ? null : newValues["date"].ToString();
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        string debit = "";
                        string credit = "";
                        string strblnc = "select balance from ledger where tblname='CR' and tblid='" + id + "' and head='" + code + "' and company='" + Company + "'";
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
                        string strcred = "select debit from ledger where tblname='CR' and tblid='" + id + "' and head='" + code + "' and company='" + Company + "'";
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
                        string strdeb = "select credit from ledger where tblname='CR' and tblid='" + id + "' and head='" + code + "' and company='" + Company + "'";
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
                        string str = "UPDATE cashReceivable SET code='" + code + "', transactiontype='" + transactiontype + "', description='" + description + "', seggregation='" + seggregation + "', receipt='" + receipt + "', cheque='" + cheque + "', amount='" + amount + "', date='" + date + "', invno='" + invno.Value + "' WHERE id='" + id + "' and company='" + Company + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        string str1 = "UPDATE ledger SET balance='" + balanceval + "', description='" + description + "', head='" + code + "', credit='" + credit + "', debit='" + debit + "', date='" + date + "', invno='" + invno.Value + "' WHERE tblid='" + id + "' and tblname='CR' and company='" + Company + "'";
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
                        string amount = newValues["amount"] == null ? null : newValues["amount"].ToString();
                        string date = newValues["date"] == null ? null : newValues["date"].ToString();
                        string debit = "";
                        string credit = "";
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
                        string str = "INSERT INTO cashReceivable(username,company,code,transactiontype,description,seggregation,receipt,cheque,amount,date,invno) VALUES('" + UserName + "','" + Company + "','" + code + "','" + transactiontype + "','" + description + "','" + seggregation + "','" + receipt + "','" + cheque + "','" + amount + "', '" + date + "','" + invno.Value + "')";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        con.Open();
                        SqlCommand cmdid = new SqlCommand(@"Select max(id) from cashReceivable", con);
                        var tblid = cmdid.ExecuteScalar().ToString();
                        con.Close();
                        string str1 = "INSERT INTO ledger(balance,username,company,description,head,debit,credit,date,invno,tblname,tblid,status) VALUES('" + balanceval + "','" + UserName + "','" + Company + "','" + description + "','" + code + "','" + debit + "','" + credit + "','" + date + "','" + invno.Value + "','CR','" + tblid + "','Not Cleared')";
                        SqlCommand cmd1 = new SqlCommand(str1, con);
                        cmd1.Connection.Open();
                        cmd1.ExecuteNonQuery();
                        cmd1.Connection.Close();
                    }
                    else if (command.Type == GridBatchEditingCommandType.Delete)
                    {
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        string str = "DELETE FROM cashReceivable WHERE id= '" + id + "' and company='" + Company + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        string str1 = "DELETE FROM ledger WHERE tblid= '" + id + "' and tblname='CR' and company='" + Company + "'";
                        SqlCommand cmd1 = new SqlCommand(str1, con);
                        cmd1.Connection.Open();
                        cmd1.ExecuteNonQuery();
                        cmd1.Connection.Close();
                    }
                }
            }
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showsuccesspopup", "showsuccesspopup();", true);
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
                SqlCommand cmd = new SqlCommand(@"Select max(cast(invno as int)) as invno from cashReceivable where company='" + Company + "'", con);
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
                con.Close();
            }

            credit.Value = "";
            debit.Value = "";
            accname.Value = "";
            this.RadGrid1.DataSource = new string[] { };
            this.RadGrid1.Rebind();
        }

        [Obsolete]
        protected void DelBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand cmd = new SqlCommand(@"delete from cashReceivable where invno='" + invno.Value + "' and company='" + Company + "'", con);
                SqlCommand cmd1 = new SqlCommand(@"delete from ledger where invno='" + invno.Value + "' and tblname='CR' and company='" + Company + "'", con);
                con.Open();
                cmd.ExecuteNonQuery();
                cmd1.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("CashReceivable.aspx");
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
                        string strclear = "insert into clearance(invno,tblid,tblname,amount,username,company) values('" + invno.Value + "','" + id + "','CR','" + creditval + "','" + UserName + "','" + Company + "')";
                        SqlCommand cmdclear = new SqlCommand(strclear, con);
                        cmdclear.Connection.Open();
                        cmdclear.ExecuteNonQuery();
                        cmdclear.Connection.Close();

                        string str = "UPDATE invoicing SET credit='" + creditval + "', balance='" + total + "', tblname='CR', tblinvno='" + invno.Value + "'  WHERE id='" + id + "' and company='" + Company + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        string str1del = "update ledger set status='Cleared' WHERE invno= '" + invno.Value + "' and tblname='CR' and company='" + Company + "'";
                        SqlCommand cmd1 = new SqlCommand(str1del, con);
                        cmd1.Connection.Open();
                        cmd1.ExecuteNonQuery();
                        cmd1.Connection.Close();
                    }
                }
            }
            Response.Redirect("CashReceivable.aspx");
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
                        con.Open();
                        DataTable table = new DataTable();
                        var code1 = "";
                        var query1 = "select code from [dbo].[subheads] where sub_head='" + Text1.Value.ToString() + "' and (company='" + Company + "' OR company='All')";
                        SqlCommand cmd1 = new SqlCommand(query1, con);
                        code1 = cmd1.ExecuteScalar().ToString();
                        var query = "select (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='CR' and clearance.tblid=invoicing.id) as amount,* from [dbo].[invoicing] where clientcode='" + code1 + "' and company='" + Company + "' and balance>'0' and status!='RFD' order by invdate asc";
                        var cmd = new SqlCommand(query, con);
                        SqlDataAdapter data = new SqlDataAdapter(cmd);
                        data.Fill(table);
                        this.RadGrid3.DataSource = table;
                        this.RadGrid3.Rebind();
                        var query2 = "select (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='CR' and clearance.tblid=invoicing.id) as totalcredit,sum(TRY_CONVERT(float, ticketvalue)) as totalticketvalue,sum(TRY_CONVERT(float, balance)) as totalbalance from invoicing where clientcode='" + code1 + "' and company='" + Company + "' and balance>'0' and status!='RFD' group by invoicing.id";
                        var cmd2 = new SqlCommand(query2, con);
                        SqlDataReader reader = cmd2.ExecuteReader();
                        while (reader.Read())
                        {
                            Text3.Value = reader["totalticketvalue"].ToString();
                            Text4.Value = reader["totalcredit"].ToString();
                            Text5.Value = reader["totalbalance"].ToString();
                        }
                        reader.Close();
                        con.Close();
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
        protected void OkBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand cmd = new SqlCommand(@"update CashReceivable set invno='" + Text2.Value + "' where invno='" + invno.Value + "' and company='" + Company + "'", con);
                SqlCommand cmd1 = new SqlCommand(@"update ledger set invno='" + Text2.Value + "' where invno='" + invno.Value + "' and tblname='CR' and company='" + Company + "'", con);
                con.Open();
                cmd.ExecuteNonQuery();
                cmd1.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("CashReceivable.aspx");
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
                    string strclr = "select amount from clearance where tblid='" + id + "' and tblname = 'CR' and company='" + Company + "'";
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
                    string str1 = "update ledger set status='Not Cleared' WHERE invno= '" + invno.Value + "' and tblname='CR' and company='" + Company + "'";
                    SqlCommand cmd1 = new SqlCommand(str1, con);
                    cmd1.Connection.Open();
                    cmd1.ExecuteNonQuery();
                    cmd1.Connection.Close();

                    string str2 = "delete from clearance where tblid='" + id + "' and tblname = 'CR' and company='" + Company + "'";
                    SqlCommand cmd2 = new SqlCommand(str2, con);
                    cmd2.Connection.Open();
                    cmd2.ExecuteNonQuery();
                    cmd2.Connection.Close();
                }
            }
            Response.Redirect("CashReceivable.aspx");
        }

        [Obsolete]
        protected void YesBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (var con = new SqlConnection(connectionStr))
            {
                con.Open();
                DataTable table = new DataTable();
                var code1 = "";
                var query1 = "select code from [dbo].[subheads] where sub_head='" + Text1.Value.ToString() + "' and (company='" + Company + "' OR company='All')";
                SqlCommand cmd1 = new SqlCommand(query1, con);
                code1 = cmd1.ExecuteScalar().ToString();
                var query = "select (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='CR' and clearance.tblid=invoicing.id) as amount,* from [dbo].[invoicing] where clientcode='" + code1 + "' and company='" + Company + "' and balance>'0' and status!='RFD' order by invdate asc";
                var cmd = new SqlCommand(query, con);
                SqlDataAdapter data = new SqlDataAdapter(cmd);
                data.Fill(table);
                this.RadGrid2.DataSource = table;
                this.RadGrid2.Rebind();
                var query2 = "select (select sum(TRY_CONVERT(float, amount)) from clearance where tblname='CR' and clearance.tblid=invoicing.id) as totalcredit,sum(TRY_CONVERT(float, ticketvalue)) as totalticketvalue,sum(TRY_CONVERT(float, balance)) as totalbalance from invoicing where clientcode='" + code1 + "' and company='" + Company + "' and balance>'0' and status!='RFD' group by invoicing.id";
                var cmd2 = new SqlCommand(query2, con);
                SqlDataReader reader = cmd2.ExecuteReader();
                while (reader.Read())
                {
                    invtkttotal.Value = reader["totalticketvalue"].ToString();
                    invrcvtotal.Value = reader["totalcredit"].ToString();
                    invbalancetotal.Value = reader["totalbalance"].ToString();
                }
                reader.Close();
                con.Close();
            }
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowPopup", "ShowPopup();", true);
        }
    }
}

