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
using Telerik.Web.UI.com.hisoftware.api2;

namespace Coffer_Systems
{
    public partial class BankPayment : System.Web.UI.Page
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
                        SqlCommand invoice = new SqlCommand(@"Select distinct cast(invno as int) as invno from BankPayment where company='" + Company + "'  order by cast(invno as int) DESC", con);
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
                            SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,credit)) from ledger where invno='" + invnolist[Global.offset] + "' and tblname='BP' and company='" + Company + "'", con);
                            SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,debit)) from ledger where invno='" + invnolist[Global.offset] + "' and tblname='BP' and company='" + Company + "'", con);
                            var credit1 = cmdcredit.ExecuteScalar().ToString();
                            var debit1 = cmddebit.ExecuteScalar().ToString();
                            credit.Value = credit1;
                            debit.Value = debit1;
                            SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invnolist[Global.offset] + "' and tblname='BP' and company='" + Company + "'", con);
                            var code = cmdcode.ExecuteScalar().ToString();
                            SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                            var head = cmdhead.ExecuteScalar().ToString();
                            Text1.Value = head;
                            accname.Value = head;
                            con.Close();
                        }
                        else
                        {
                            Response.Write("<script>alert('No Record Exist\r\nPlease click on ‘Add New Voucher’ to start posting');</script>");
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
                SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM BankPayment where  invno='" + invno.Value + "' and company='" + Company + "'", con);
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
                SqlCommand invoiceno = new SqlCommand(@"Select distinct cast(invno as int) as invno from BankPayment where company='" + Company + "' order by cast(invno as int) DESC", con);
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
                    SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM BankPayment where  invno='" + invoice.ToString() + "' and company='" + Company + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmd);
                    data.Fill(table);
                    this.RadGrid1.DataSource = table;
                    this.RadGrid1.Rebind();
                    SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,credit)) from ledger where invno='" + invoice.ToString() + "' and tblname='BP' and company='" + Company + "'", con);
                    SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,debit)) from ledger where invno='" + invoice.ToString() + "' and tblname='BP' and company='" + Company + "'", con);
                    var credit1 = cmdcredit.ExecuteScalar().ToString();
                    var debit1 = cmddebit.ExecuteScalar().ToString();
                    credit.Value = credit1;
                    debit.Value = debit1;
                    SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invoice.ToString() + "' and tblname='BP' and company='" + Company + "'", con);
                    var code = cmdcode.ExecuteScalar().ToString();
                    SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                    var head = cmdhead.ExecuteScalar().ToString();
                    Text1.Value = head;
                    accname.Value = head;
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
                SqlCommand invoiceno = new SqlCommand(@"Select distinct cast(invno as int) as invno from BankPayment where company='" + Company + "' order by cast(invno as int) DESC", con);
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
                    SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM BankPayment where  invno='" + invoice.ToString() + "' and company='" + Company + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmd);
                    data.Fill(table);
                    this.RadGrid1.DataSource = table;
                    this.RadGrid1.Rebind();
                    con.Open();
                    SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,credit)) from ledger where invno='" + invoice.ToString() + "' and tblname='BP' and company='" + Company + "'", con);
                    SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(INT ,debit)) from ledger where invno='" + invoice.ToString() + "' and tblname='BP' and company='" + Company + "'", con);
                    var credit1 = cmdcredit.ExecuteScalar().ToString();
                    var debit1 = cmddebit.ExecuteScalar().ToString();
                    credit.Value = credit1;
                    debit.Value = debit1;
                    SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invoice.ToString() + "' and tblname='BP' and company='" + Company + "'", con);
                    var code = cmdcode.ExecuteScalar().ToString();
                    SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')7", con);
                    var head = cmdhead.ExecuteScalar().ToString();
                    Text1.Value = head;
                    accname.Value = head;
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
                SqlCommand cmd1 = new SqlCommand(@"Select sub_head AS full_name , code from subheads where level='4' and (company='" + Company + "'OR company='All') order by sub_head ", con);
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
                        string strblnc = "select balance from ledger where tblname='BP' and tblid='" + id + "' and head='" + code + "' and company='" + Company + "'";
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
                        string strcred = "select debit from ledger where tblname='BP' and tblid='" + id + "' and head='" + code + "' and company='" + Company + "'";
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
                        string strdeb = "select credit from ledger where tblname='BP' and tblid='" + id + "' and head='" + code + "' and company='" + Company + "'";
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

                        string str = "UPDATE BankPayment SET code='" + code + "', transactiontype='" + transactiontype + "', description='" + description + "', seggregation='" + seggregation + "', receipt='" + receipt + "', cheque='" + cheque + "', amount='" + amount + "', date='" + date + "', invno='" + invno.Value + "' WHERE id='" + id + "' and company='" + Company + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        string str1 = "UPDATE ledger SET balance='" + balanceval + "',description='" + description + "', head='" + code + "', credit='" + credit + "', debit='" + debit + "', date='" + date + "', invno='" + invno.Value + "' WHERE tblid='" + id + "' and tblname='BP' and company='" + Company + "'";
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
                        string str = "INSERT INTO BankPayment(username,company,code,transactiontype,description,seggregation,receipt,cheque,amount,date,invno) VALUES('" + UserName + "','" + Company + "','" + code + "','" + transactiontype + "','" + description + "','" + seggregation + "','" + receipt + "','" + cheque + "','" + amount + "', '" + date + "','" + invno.Value + "')";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        con.Open();
                        SqlCommand cmdid = new SqlCommand(@"Select max(id) from BankPayment", con);
                        var tblid = cmdid.ExecuteScalar().ToString();
                        con.Close();
                        string str1 = "INSERT INTO ledger(balance,username,company,description,head,debit,credit,date,invno,tblname,tblid) VALUES('" + balanceval + "','" + UserName + "','" + Company + "','" + description + "','" + code + "','" + debit + "','" + credit + "','" + date + "','" + invno.Value + "','BP','" + tblid + "')";
                        SqlCommand cmd1 = new SqlCommand(str1, con);
                        cmd1.Connection.Open();
                        cmd1.ExecuteNonQuery();
                        cmd1.Connection.Close();
                    }
                    else if (command.Type == GridBatchEditingCommandType.Delete)
                    {
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        string str = "DELETE FROM BankPayment WHERE id= '" + id + "' and company='" + Company + "'";
                        SqlCommand cmd = new SqlCommand(str, con);
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        string str1 = "DELETE FROM ledger WHERE tblid= '" + id + "' and tblname='BP' and company='" + Company + "'";
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
                con.Open();
                SqlCommand cmd = new SqlCommand(@"Select max(cast(invno as int)) as invno from BankPayment where company='" + Company + "'", con);
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
            Text1.Value = "";
            this.RadGrid1.DataSource = new string[] { };
            this.RadGrid1.Rebind();
        }

        [Obsolete]
        protected void DelBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand cmd = new SqlCommand(@"delete from BankPayment where invno='" + invno.Value + "' and company='" + Company + "'", con);
                SqlCommand cmd1 = new SqlCommand(@"delete from ledger where invno='" + invno.Value + "' and tblname='BP' and company='" + Company + "'", con);
                con.Open();
                cmd.ExecuteNonQuery();
                cmd1.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("BankPayment.aspx");
        }

        [Obsolete]
        protected void OkBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand cmd = new SqlCommand(@"update BankPayment set invno='" + Text2.Value + "' where invno='" + invno.Value + "' and company='" + Company + "'", con);
                SqlCommand cmd1 = new SqlCommand(@"update ledger set invno='" + Text2.Value + "' where invno='" + invno.Value + "' and tblname='BP' and company='" + Company + "'", con);
                con.Open();
                cmd.ExecuteNonQuery();
                cmd1.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("BankPayment.aspx");
        }
    }
}

