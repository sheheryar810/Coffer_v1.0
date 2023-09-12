using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.com.hisoftware.api2;

namespace Coffer_Systems
{
    public partial class CashPayment : System.Web.UI.Page
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
                        SqlCommand invoice = new SqlCommand(@"Select distinct cast(invno as int) as invno from cashPayment where company='" + Company + "' order by cast(invno as int) DESC", con);
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
                                Label1.InnerText = inv;
                                Label2.InnerText = inv;
                                invno.Value = inv;
                                Global.offset = invnolist.FindIndex(arr => arr == inv);
                            }
                            else
                            {
                                vno.InnerText = invnolist[Global.offset];
                                Label1.InnerText = invnolist[Global.offset];
                                Label2.InnerText = invnolist[Global.offset];
                                invno.Value = invnolist[Global.offset];
                            }
                            DataTable table = new DataTable();
                            SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM cashPayment where  invno='" + invno.Value + "' and company='" + Company + "'", con);
                            SqlDataAdapter data = new SqlDataAdapter(cmd);
                            data.Fill(table);
                            this.RadGrid1.DataSource = table;
                            this.RadGrid1.Rebind();
                            SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,credit)) from ledger where invno='" + invno.Value + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                            SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,debit)) from ledger where invno='" + invno.Value + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                            var credit1 = cmdcredit.ExecuteScalar().ToString();
                            var debit1 = cmddebit.ExecuteScalar().ToString();
                            int creditVal = int.Parse(credit1);
                            int debitVal = int.Parse(debit1);
                            credit.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                            debit.Value = string.Format("{0:C}", debitVal).Remove(0, 1);
                            SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invno.Value + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                            var code = cmdcode.ExecuteScalar().ToString();
                            if (code != "")
                            {
                                SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                                var head = cmdhead.ExecuteScalar().ToString();
                                Text1.Value = head;
                                accname.Value = head;
                            }
                            con.Close();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alertPopup", "alertPopup();", true);
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
                SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM cashpayment where  invno='" + invno.Value + "' and company='" + Company + "'", con);
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
                SqlCommand invoiceno = new SqlCommand(@"Select distinct cast(invno as int) as invno from cashPayment where company='" + Company + "' order by cast(invno as int) DESC", con);
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
                    SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM cashpayment where  invno='" + invoice.ToString() + "' and company='" + Company + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmd);
                    data.Fill(table);
                    this.RadGrid1.DataSource = table;
                    this.RadGrid1.Rebind();
                    SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,credit)) from ledger where invno='" + invoice.ToString() + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                    SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,debit)) from ledger where invno='" + invoice.ToString() + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                    var credit1 = cmdcredit.ExecuteScalar().ToString();
                    var debit1 = cmddebit.ExecuteScalar().ToString();
                    int creditVal = int.Parse(credit1);
                    int debitVal = int.Parse(debit1);
                    credit.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                    debit.Value = string.Format("{0:C}", debitVal).Remove(0, 1);
                    SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invoice.ToString() + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                    var code = cmdcode.ExecuteScalar().ToString();
                    SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                    var head = cmdhead.ExecuteScalar().ToString();
                    Text1.Value = head;
                    accname.Value = head;
                    con.Close();
                }
                invno.Value = invoice.ToString();
                vno.InnerText = invoice.ToString();
                Label1.InnerText = invoice.ToString();
                Label2.InnerText = invoice.ToString();
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
                SqlCommand invoiceno = new SqlCommand(@"Select distinct cast(invno as int) as invno from cashPayment where company='" + Company + "' order by cast(invno as int) DESC", con);
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
                    SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM cashpayment where  invno='" + invoice.ToString() + "' and company='" + Company + "'", con);
                    SqlDataAdapter data = new SqlDataAdapter(cmd);
                    data.Fill(table);
                    this.RadGrid1.DataSource = table;
                    this.RadGrid1.Rebind();
                    SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,credit)) from ledger where invno='" + invoice.ToString() + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                    SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,debit)) from ledger where invno='" + invoice.ToString() + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                    var credit1 = cmdcredit.ExecuteScalar().ToString();
                    var debit1 = cmddebit.ExecuteScalar().ToString();
                    int creditVal = int.Parse(credit1);
                    int debitVal = int.Parse(debit1);
                    credit.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                    debit.Value = string.Format("{0:C}", debitVal).Remove(0, 1);
                    SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invoice.ToString() + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                    var code = cmdcode.ExecuteScalar().ToString();
                    SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                    var head = cmdhead.ExecuteScalar().ToString();
                    Text1.Value = head;
                    accname.Value = head;
                    con.Close();
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
                SqlCommand cmd1 = new SqlCommand(@"Select code +' '+ sub_head AS full_name , code from subheads where level='4'  and (company='" + Company + "' OR company='All') order by sub_head ", con);
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
            var debitVal = 0.0;
            var creditVal = 0.0;
            int count = 0, dcount = 0;
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
            }
            if (debitVal == creditVal)
            {
                var tbl = "BP";

                foreach (GridBatchEditingCommand command in e.Commands)
                {
                    Hashtable newValues = command.NewValues;
                    Hashtable oldValues = command.OldValues;

                    string code = newValues["ID_Name"] == null ? null : newValues["ID_Name"].ToString();
                    if (code == "11001")
                    {
                        tbl = "CP";
                    }
                }
                credit.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                debit.Value = string.Format("{0:C}", debitVal).Remove(0, 1);
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
                            string amount = newValues["amount"] == null ? null : float.Parse(newValues["amount"].ToString(), CultureInfo.InvariantCulture.NumberFormat).ToString();
                            string date = newValues["date"] == null ? oldValues["date"].ToString() : newValues["date"].ToString();
                            string id = newValues["id"] == null ? null : newValues["id"].ToString();

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

                            string str = "UPDATE cashpayment SET code='" + code + "', transactiontype='" + transactiontype + "', description='" + description + "', seggregation='" + seggregation + "', receipt='" + receipt + "', cheque='" + cheque + "', amount='" + amount + "', date='" + dateString + "', invno='" + invno.Value + "' WHERE id='" + id + "' and company='" + Company + "'";
                            SqlCommand cmd = new SqlCommand(str, con);
                            cmd.Connection.Open();
                            cmd.ExecuteNonQuery();
                            cmd.Connection.Close();
                            string str1 = "UPDATE ledger SET balance='" + balanceval + "', description='" + description + "', head='" + code + "', credit='" + credit + "', debit='" + debit + "', date='" + dateString + "', invno='" + invno.Value + "' WHERE tblid='" + id + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'";
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
                            string str = "INSERT INTO cashpayment(username,company,code,transactiontype,description,seggregation,receipt,cheque,amount,date,invno) VALUES('" + UserName + "','" + Company + "','" + code + "','" + transactiontype + "','" + description + "','" + seggregation + "','" + receipt + "','" + cheque + "','" + amount + "', '" + dateString + "','" + invno.Value + "')";
                            SqlCommand cmd = new SqlCommand(str, con);
                            cmd.Connection.Open();
                            cmd.ExecuteNonQuery();
                            cmd.Connection.Close();
                            con.Open();
                            SqlCommand cmdid = new SqlCommand(@"Select max(id) from cashPayment", con);
                            var tblid = cmdid.ExecuteScalar().ToString();
                            con.Close();
                            string str1 = "INSERT INTO ledger(balance,username,company,description,head,debit,credit,date,invno,tblname,tblid) VALUES('" + balanceval + "','" + UserName + "','" + Company + "','" + description + "','" + code + "','" + debit + "','" + credit + "','" + dateString + "','" + invno.Value + "','" + tbl + "','" + tblid + "')";
                            SqlCommand cmd1 = new SqlCommand(str1, con);
                            cmd1.Connection.Open();
                            cmd1.ExecuteNonQuery();
                            cmd1.Connection.Close();
                        }
                        else if (command.Type == GridBatchEditingCommandType.Delete)
                        {
                            dcount++;
                            string id = newValues["id"] == null ? null : newValues["id"].ToString();
                            string str = "DELETE FROM cashpayment WHERE id= '" + id + "' and company='" + Company + "'";
                            SqlCommand cmd = new SqlCommand(str, con);
                            cmd.Connection.Open();
                            cmd.ExecuteNonQuery();
                            cmd.Connection.Close();
                            string str1 = "DELETE FROM ledger WHERE tblid= '" + id + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'";
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
        protected void RadComboBox1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        [Obsolete]
        protected void NewBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand cmd = new SqlCommand(@"Select max(cast(invno as int)) as invno from cashPayment  where company='" + Company + "'", con);
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
            this.RadGrid1.DataSource = new string[] { };
            this.RadGrid1.Rebind();
        }

        [Obsolete]
        protected void OkBtn_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                SqlCommand cmd = new SqlCommand(@"update cashPayment set invno='" + Text2.Value + "' where invno='" + invno.Value + "' and company='" + Company + "'", con);
                SqlCommand cmd1 = new SqlCommand(@"update ledger set invno='" + Text2.Value + "' where invno='" + invno.Value + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                con.Open();
                cmd.ExecuteNonQuery();
                cmd1.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("cashPayment.aspx");
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
                SqlCommand invoice = new SqlCommand(@"Select distinct cast(invno as int) as invno from cashPayment where company='" + Company + "' order by cast(invno as int) DESC", con);
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
                        SqlCommand cmd = new SqlCommand("SELECT id, code, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM cashPayment where  invno='" + invno.Value + "' and company='" + Company + "'", con);
                        SqlDataAdapter data = new SqlDataAdapter(cmd);
                        data.Fill(table);
                        this.RadGrid1.DataSource = table;
                        this.RadGrid1.Rebind();
                        SqlCommand cmdcredit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,credit)) from ledger where invno='" + invno.Value + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                        SqlCommand cmddebit = new SqlCommand(@"Select sum(TRY_CONVERT(float ,debit)) from ledger where invno='" + invno.Value + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                        var credit1 = cmdcredit.ExecuteScalar().ToString();
                        var debit1 = cmddebit.ExecuteScalar().ToString();

                        int creditVal = int.Parse(credit1);
                        int debitVal = int.Parse(debit1);
                        credit.Value = string.Format("{0:C}", creditVal).Remove(0, 1);
                        debit.Value = string.Format("{0:C}", debitVal).Remove(0, 1);
                        SqlCommand cmdcode = new SqlCommand(@"Select head from ledger where credit!='0' and credit!='' and invno='" + invno.Value + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                        var code = cmdcode.ExecuteScalar().ToString();
                        if (code != "")
                        {
                            SqlCommand cmdhead = new SqlCommand(@"Select sub_head from subheads where code='" + code + "' and (company='" + Company + "' OR company='All')", con);
                            var head = cmdhead.ExecuteScalar().ToString();
                            Text1.Value = head;
                            accname.Value = head;
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
                SqlCommand cmd = new SqlCommand(@"delete from cashPayment where invno='" + invno.Value + "' and company='" + Company + "'", con);
                SqlCommand cmd1 = new SqlCommand(@"delete from ledger where invno='" + invno.Value + "' and (tblname='BP' or tblname='CP') and company='" + Company + "'", con);
                con.Open();
                cmd.ExecuteNonQuery();
                cmd1.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("CashPayment.aspx");
        }
    }
}

