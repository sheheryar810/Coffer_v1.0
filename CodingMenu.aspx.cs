using Antlr.Runtime;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Chat;

namespace Coffer_Systems.Coding
{
    public partial class CodingMenu : System.Web.UI.Page
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
                if (Page.IsPostBack == false)
                {
                    setValues();
                    using (SqlConnection con = new SqlConnection(connectionStr))
                    {
                        con.Open();

                        SqlCommand cmd1 = new SqlCommand(@"Select sub_head AS full_name, code from subheads where (company='" + Company + "' OR company='All') and level='4' order by sub_head ", con);
                        SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                        DataSet ds1 = new DataSet();
                        da1.Fill(ds1);
                        customerDropDownList1.DataSource = ds1.Tables[0];
                        customerDropDownList1.DataTextField = "full_name";
                        customerDropDownList1.DataValueField = "code";
                        customerDropDownList1.DataBind();
                        customerDropDownList1.Items.Insert(0, new ListItem());
                        customerDropDownList2.DataSource = ds1.Tables[0];
                        customerDropDownList2.DataTextField = "full_name";
                        customerDropDownList2.DataValueField = "code";
                        customerDropDownList2.DataBind();
                        customerDropDownList2.Items.Insert(0, new ListItem());
                        SqlCommand debitopening = new SqlCommand(@"Select sum(CAST(debit as float)) from ledger where company='" + Company + "' and tblname='OP' ", con);
                        SqlCommand creditopening = new SqlCommand(@"Select sum(CAST(credit as float)) from ledger where company='" + Company + "' and tblname='OP' ", con);
                        var debitop = debitopening.ExecuteScalar();
                        if (debitop.ToString() != "")
                        {
                            optotalDebit.Value = debitopening.ExecuteScalar().ToString();
                        }
                        var creditop = creditopening.ExecuteScalar();
                        if (creditop.ToString() != "")
                        {
                            optotalCredit.Value = creditopening.ExecuteScalar().ToString();
                        }
                        SqlCommand openingDtae = new SqlCommand(@"Select top 1 date from ledger where (company='" + Company + "' OR company='All') and tblname='OP' ", con);
                        string date= Convert.ToDateTime(openingDtae.ExecuteScalar()).ToString("yyyy-MM-dd");
                        openingDate.Value = date;
                        con.Close();
                        maxId();
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
        protected void maxId()
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                SqlCommand fixassetcmd = new SqlCommand("select max(code) from subheads where code like '100%' and code!='100' and (company='" + Company + "' OR company='All')", con);
                var fixassetscode = fixassetcmd.ExecuteScalar();
                if (fixassetscode.ToString() == "")
                {
                    fixassetscode = 1000000;
                }
                else
                {
                    fixassetscode = Convert.ToInt32(fixassetcmd.ExecuteScalar());
                }
                Application["FixedAsset"] = fixassetscode;
                SqlCommand curassetcmd = new SqlCommand("select max(code) from subheads where code like '110%' and code!='11001' and (company='" + Company + "' OR company='All')", con);
                var curassetscode = curassetcmd.ExecuteScalar();
                if (curassetscode.ToString() == "")
                {
                    curassetscode = 1100000;
                }
                else
                {
                    curassetscode = Convert.ToInt32(curassetcmd.ExecuteScalar());
                }
                Application["CurrentAsset"] = curassetscode;
                SqlCommand bankcmd = new SqlCommand("select max(code) from subheads where code like '111%' and code!='111' and (company='" + Company + "' OR company='All')", con);
                var bankcode = bankcmd.ExecuteScalar();
                if (bankcode.ToString() == "")
                {
                    bankcode = 1110000;
                }
                else
                {
                    bankcode = Convert.ToInt32(bankcmd.ExecuteScalar());
                }
                Application["Bank"] = bankcode;
                SqlCommand accreccmd = new SqlCommand("select max(code) from subheads where code like '112%' and code!='112' and (company='" + Company + "' OR company='All')", con);
                var accreccode = accreccmd.ExecuteScalar();
                if (accreccode.ToString() == "")
                {
                    accreccode = 1120000;
                }
                else
                {
                    accreccode = Convert.ToInt32(accreccmd.ExecuteScalar());
                }
                Application["AccReceivable"] = accreccode;
                SqlCommand clientcmd = new SqlCommand("select max(code) from subheads where code like '113%' and code!='113' and (company='" + Company + "' OR company='All')", con);
                var clientcode = clientcmd.ExecuteScalar();
                if (clientcode.ToString() == "")
                {
                    clientcode = 1130000;
                }
                else
                {
                    clientcode = Convert.ToInt32(clientcmd.ExecuteScalar());
                }
                Application["Client"] = clientcode;
                SqlCommand refundcmd = new SqlCommand("select max(code) from subheads where code like '114%' and code!='114' and (company='" + Company + "' OR company='All')", con);
                var refundcode = refundcmd.ExecuteScalar();
                if (refundcode.ToString() == "")
                {
                    refundcode = 1140000;
                }
                else
                {
                    refundcode = Convert.ToInt32(refundcmd.ExecuteScalar());
                }
                Application["Refund"] = refundcode;
                SqlCommand advancecmd = new SqlCommand("select max(code) from subheads where code like '115%' and code!='115' and (company='" + Company + "' OR company='All')", con);
                var advancecode = advancecmd.ExecuteScalar();
                if (advancecode.ToString() == "")
                {
                    advancecode = 1150000;
                }
                else
                {
                    advancecode = Convert.ToInt32(advancecmd.ExecuteScalar());
                }
                Application["Advance"] = advancecode;
                SqlCommand securitycmd = new SqlCommand("select max(code) from subheads where code like '116%' and code!='116' and (company='" + Company + "' OR company='All')", con);
                var securitycode = securitycmd.ExecuteScalar();
                if (securitycode.ToString() == "")
                {
                    securitycode = 1160000;
                }
                else
                {
                    securitycode = Convert.ToInt32(securitycmd.ExecuteScalar());
                }
                Application["Security"] = securitycode;
                SqlCommand taxcmd = new SqlCommand("select max(code) from subheads where code like '117%' and code!='117' and (company='" + Company + "' OR company='All')", con);
                var taxcode = taxcmd.ExecuteScalar();
                if (taxcode.ToString() == "")
                {
                    taxcode = 1170000;
                }
                else
                {
                    taxcode = Convert.ToInt32(taxcmd.ExecuteScalar());
                }
                Application["Tax"] = taxcode;
                SqlCommand capitalcmd = new SqlCommand("select max(code) from subheads where code like '210%' and code!='210' and (company='" + Company + "' OR company='All')", con);
                var capitalcode = capitalcmd.ExecuteScalar();
                if (capitalcode.ToString() == "")
                {
                    capitalcode = 2100000;
                }
                else
                {
                    capitalcode = Convert.ToInt32(capitalcmd.ExecuteScalar());
                }
                Application["Capital"] = capitalcode;
                SqlCommand plcmd = new SqlCommand("select max(code) from subheads where code like '220%' and code!='220' and (company='" + Company + "' OR company='All')", con);
                var plcode = plcmd.ExecuteScalar();
                if (plcode.ToString() == "")
                {
                    plcode = 2200000;
                }
                else
                {
                    plcode = Convert.ToInt32(plcmd.ExecuteScalar());
                }
                Application["ProfitLoss"] = plcode;
                SqlCommand accpaycmd = new SqlCommand("select max(code) from subheads where code like '231%' and code!='231' and (company='" + Company + "' OR company='All')", con);
                var accpaycode = accpaycmd.ExecuteScalar();
                if (accpaycode.ToString() == "")
                {
                    accpaycode = 2310000;
                }
                else
                {
                    accpaycode = Convert.ToInt32(accpaycmd.ExecuteScalar());
                }
                Application["AccPayable"] = accpaycode;
                SqlCommand otherpaycmd = new SqlCommand("select max(code) from subheads where code like '232%' and code!='232' and (company='" + Company + "' OR company='All')", con);
                var otherpaycode = otherpaycmd.ExecuteScalar();
                if (otherpaycode.ToString() == "")
                {
                    otherpaycode = 2320000;
                }
                else
                {
                    otherpaycode = Convert.ToInt32(otherpaycmd.ExecuteScalar());
                }
                Application["OtherPayable"] = otherpaycode;
                SqlCommand paycmd = new SqlCommand("select max(code) from subheads where code like '234%' and code!='234' and (company='" + Company + "' OR company='All')", con);
                var paycode = paycmd.ExecuteScalar();
                if (paycode.ToString() == "")
                {
                    paycode = 2340000;
                }
                else
                {
                    paycode = Convert.ToInt32(paycmd.ExecuteScalar());
                }
                Application["Payables"] = paycode;
                SqlCommand taxpaycmd = new SqlCommand("select max(code) from subheads where code like '235%' and code!='235' and (company='" + Company + "' OR company='All')", con);
                var taxpaycode = taxpaycmd.ExecuteScalar();
                if (taxpaycode.ToString() == "")
                {
                    taxpaycode = 2350000;
                }
                else
                {
                    taxpaycode = Convert.ToInt32(taxpaycmd.ExecuteScalar());
                }
                Application["TaxPayables"] = taxpaycode;
                SqlCommand prepaidcmd = new SqlCommand("select max(code) from subheads where code like '236%' and code!='236' and (company='" + Company + "' OR company='All')", con);
                var prepaidcode = prepaidcmd.ExecuteScalar();
                if (prepaidcode.ToString() == "")
                {
                    prepaidcode = 2360000;
                }
                else
                {
                    prepaidcode = Convert.ToInt32(prepaidcmd.ExecuteScalar());
                }
                Application["Prepaid"] = prepaidcode;
                SqlCommand expensecmd = new SqlCommand("select max(code) from subheads where code like '311%' and (company='" + Company + "' OR company='All')", con);
                var expensecode = expensecmd.ExecuteScalar();
                if (expensecode.ToString() == "")
                {
                    expensecode = 3110000;
                }
                else
                {
                    expensecode = Convert.ToInt32(expensecmd.ExecuteScalar());
                }
                Application["Expense"] = expensecode;
                SqlCommand genexpensecmd = new SqlCommand("select max(code) from subheads where code like '340%' and code!='340' and (company='" + Company + "' OR company='All')", con);
                var genexpensecode = genexpensecmd.ExecuteScalar();
                if (genexpensecode.ToString() == "")
                {
                    genexpensecode = 3400000;
                }
                else
                {
                    genexpensecode = Convert.ToInt32(genexpensecmd.ExecuteScalar());
                }
                Application["GenExpense"] = genexpensecode;
                SqlCommand fincmd = new SqlCommand("select max(code) from subheads where code like '341%' and code!='341' and (company='" + Company + "' OR company='All')", con);
                var fincode = fincmd.ExecuteScalar();
                if (fincode.ToString() == "")
                {
                    fincode = 3410000;
                }
                else
                {
                    fincode = Convert.ToInt32(fincmd.ExecuteScalar());
                }
                Application["Financial"] = fincode;
                SqlCommand revenuecmd = new SqlCommand("select max(code) from subheads where code like '400%' and code!='400' and (company='" + Company + "' OR company='All')", con);
                var revenuecode = revenuecmd.ExecuteScalar();
                if (revenuecode.ToString() == "")
                {
                    revenuecode = 4000000;
                }
                else
                {
                    revenuecode = Convert.ToInt32(revenuecmd.ExecuteScalar());
                }
                Application["Revenue"] = revenuecode;
                SqlCommand incomecmd = new SqlCommand("select max(code) from subheads where code like '401%' and code!='401' and (company='" + Company + "' OR company='All')", con);
                var incomecode = incomecmd.ExecuteScalar();
                if (incomecode.ToString() == "")
                {
                    incomecode = 4010000;
                }
                else
                {
                    incomecode = Convert.ToInt32(incomecmd.ExecuteScalar());
                }
                Application["Income"] = incomecode;
                con.Close();
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
                SqlCommand cmd = new SqlCommand("SELECT ROW_NUMBER() Over(ORDER BY code ASC) AS seq,id,code,sub_head,branch,scode,city,level,type,class,idtype,case when (select debit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and debit!='')>'0' then 'DB' when (select credit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and credit!='')>'0' then 'CR' else '' END as [transaction], case when (select debit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and debit!='')>'0' then (select debit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and debit!='') when (select credit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and credit!='')>'0' then (select credit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and credit!='') else '' END as opening FROM subheads where (company='" + Company + "' OR company='All')", con);
                SqlDataAdapter data = new SqlDataAdapter(cmd);
                data.Fill(table);
                (sender as RadGrid).DataSource = table;
                con.Close();
            }
        }
        [Obsolete]
        protected void RadGrid1_BatchEditCommand(object sender, GridBatchEditingEventArgs e)
        {
            setValues();
                int count = 0, dcount = 0;
            foreach (GridBatchEditingCommand command in e.Commands)
            {
                Hashtable oldValues = command.OldValues;
                Hashtable newValues = command.NewValues;
                using (SqlConnection con = new SqlConnection(connectionStr))
                {
                    if (command.Type == GridBatchEditingCommandType.Update)
                    {
                                count++;
                        string branch = newValues["branch"] == null ? null : newValues["branch"].ToString();
                        string code = newValues["code"] == null ? null : newValues["code"].ToString();
                        string sub_head = newValues["sub_head"] == null ? null : newValues["sub_head"].ToString();
                        string scode = newValues["scode"] == null ? null : newValues["scode"].ToString();
                        string idtype = newValues["ID_idtype"] == null ? null : newValues["ID_idtype"].ToString();
                        string level = newValues["ID_level"] == null ? null : newValues["ID_level"].ToString();
                        string type = newValues["ID_type"] == null ? null : newValues["ID_type"].ToString();
                        string city = newValues["city"] == null ? null : newValues["city"].ToString();
                        string classification = newValues["ID_class"] == null ? null : newValues["ID_class"].ToString();
                        string transaction = newValues["ID_transaction"] == null ? null : newValues["ID_transaction"].ToString();
                        string opening = newValues["opening"] == null ? null : float.Parse(newValues["opening"].ToString(), CultureInfo.InvariantCulture.NumberFormat).ToString();
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();

                        string debit = "";
                        string credit = "";
                        if (transaction == "DB")
                        {
                            debit = opening;
                        }
                        else if (transaction == "CR")
                        {
                            credit = opening;
                            opening = '-' + opening;
                        }
                        string str1 = "UPDATE subheads SET branch='" + branch + "', code='" + code + "', [transaction]='" + transaction + "', sub_head='" + sub_head + "', scode='" + scode + "', idtype='" + idtype + "', level='" + level + "', type='" + type + "', class='" + classification + "', city='" + city + "', opening='" + opening + "' WHERE id='" + id + "' and (company='" + Company + "' OR company='All')";
                        SqlCommand cmd1 = new SqlCommand(str1, con);
                        cmd1.Connection.Open();
                        cmd1.ExecuteNonQuery();
                        cmd1.Connection.Close();
                        string str2 = "DELETE FROM ledger WHERE tblid= '" + id + "' and tblname='OP' and company='" + Company + "'";
                        SqlCommand cmd2 = new SqlCommand(str2, con);
                        cmd2.Connection.Open();
                        cmd2.ExecuteNonQuery();
                        cmd2.Connection.Close();
                        if (opening != "")
                        {
                            string str0 = "insert into ledger(balance,description,head,credit,debit,date,tblid,tblname,company,username) values('" + opening + "','Opening Balance','" + code + "','" + credit + "','" + debit + "','" + openingDate.Value.ToString() + "','" + id + "','OP','" + Company + "','" + UserName + "')";
                            SqlCommand cmd0 = new SqlCommand(str0, con);
                            cmd0.Connection.Open();
                            cmd0.ExecuteNonQuery();
                            cmd0.Connection.Close();
                        }
                    }
                    else if (command.Type == GridBatchEditingCommandType.Delete)
                    {
                                dcount++;
                        string id = newValues["id"] == null ? null : newValues["id"].ToString();
                        string str3 = "DELETE FROM subheads WHERE id= '" + id + "' and level!='4' and company='" + Company + "'";
                        SqlCommand cmd3 = new SqlCommand(str3, con);
                        cmd3.Connection.Open();
                        cmd3.ExecuteNonQuery();
                        cmd3.Connection.Close();
                        string str1 = "DELETE FROM ledger WHERE tblid= '" + id + "' and tblname='OP' and (company='" + Company + "' OR company='All')";
                        SqlCommand cmd1 = new SqlCommand(str1, con);
                        cmd1.Connection.Open();
                        cmd1.ExecuteNonQuery();
                        cmd1.Connection.Close();
                    }
                }
            }

            string opDate;
            using (SqlConnection con1 = new SqlConnection(connectionStr))
            {
                con1.Open();
                SqlCommand openingDtae = new SqlCommand(@"Select top 1 date from ledger where (company='" + Company + "' OR company='All') and tblname='OP' ", con1);
                opDate = Convert.ToDateTime(openingDtae.ExecuteScalar()).ToString("yyyy-MM-dd");
                con1.Close();
            }
            if (opDate != openingDate.Value)
            {
                using (SqlConnection con2 = new SqlConnection(connectionStr))
                {
                    string str = "update ledger set date='" + openingDate.Value.ToString() + "' WHERE tblname= 'OP' and  (company='" + Company + "' OR company='All')";
                    SqlCommand cmd = new SqlCommand(str, con2);
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                }
                bindGrid();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "updatepopup1", "updatepopup1();", true);
            }

            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showsuccesspopup1", "showsuccesspopup1();", true);
            }
            else if (dcount > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showdeletepopup1", "showdeletepopup1();", true);
            }
        }

        protected void RadComboBox1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }
        [Obsolete]
        protected void bindGrid()
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                DataTable table = new DataTable();
                SqlCommand cmd = new SqlCommand("SELECT ROW_NUMBER() Over(ORDER BY code ASC) AS seq,id,code,sub_head,branch,scode,city,level,type,class,idtype,case when (select debit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and debit!='')>'0' then 'DB' when (select credit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and credit!='')>'0' then 'CR' else '' END as [transaction], case when (select debit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and debit!='')>'0' then (select debit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and debit!='') when (select credit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and credit!='')>'0' then (select credit from ledger where company='" + Company + "' and ledger.head=subheads.code and tblname = 'OP' and credit!='') else '' END as opening FROM subheads where (company='" + Company + "' OR company='All')", con);
                SqlDataAdapter data = new SqlDataAdapter(cmd);
                data.Fill(table);
                RadGrid1.DataSource = table;
                RadGrid1.Rebind();
                SqlCommand debitopening = new SqlCommand(@"Select sum(CAST(debit as float)) from ledger where company='" + Company + "' and tblname='OP' ", con);
                SqlCommand creditopening = new SqlCommand(@"Select sum(CAST(credit as float)) from ledger where company='" + Company + "' and tblname='OP' ", con);
                var debitop = debitopening.ExecuteScalar();
                if (debitop.ToString() != "")
                {
                    optotalDebit.Value = debitopening.ExecuteScalar().ToString();
                }
                var creditop = creditopening.ExecuteScalar();
                if (creditop.ToString() != "")
                {
                    optotalCredit.Value = creditopening.ExecuteScalar().ToString();
                }
                con.Close();
            }
        }

        [Obsolete]
        protected void saveBtn_Click(object sender, EventArgs e)
        {
            setValues();
            string str = code.Value.ToString();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                string res = str.Substring(0, 3);
                var classification = "";
                var idtype = "";
                if (res == "111")
                {
                    idtype = "B";
                }
                if (res == "112")
                {
                    classification = "Acc. Receivable";
                }
                else if (res == "114" || res == "100" || res == "111" || res == "115" || res == "116" || res == "117")
                {
                    classification = "Gen. Asset";
                }
                else if (res == "210" || res == "220" || res == "232" || res == "235" || res == "236")
                {
                    classification = "Gen. Liability";
                }
                else if (res == "234" || res == "231")
                {
                    classification = "Acc. Payable";
                }
                else if (res == "311" || res == "340")
                {
                    classification = "Operating Expense";
                }
                else if (res == "341")
                {
                    classification = "Financial Charges";
                }
                else if (res == "400" || res == "401")
                {
                    classification = "Revenue";
                }
                con.Open();
                SqlCommand cmd = new SqlCommand("insert into subheads(idtype,level,type,sub_head,code,class,username,company) values('" + idtype + "','4','Detail','" + title.Value.ToString() + "','" + code.Value.ToString() + "','" + classification + "','" + UserName + "','" + Company + "')", con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            int newcode = int.Parse(str);
            newcode++;
            code.Value = newcode.ToString();
            title.Value = "";
            bindGrid();
            maxId();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showsuccesspopup", "showsuccesspopup();", true);
        }

        [Obsolete]
        protected void removeOpening_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("update subheads set opening='',[transaction]='' where (company='" + Company + "' OR company='All')", con);
                SqlCommand cmd1 = new SqlCommand("delete from ledger where company='" + Company + "' and tblname='OP'", con);
                cmd.ExecuteNonQuery();
                cmd1.ExecuteNonQuery();
                con.Close();
            }
            bindGrid();
            Response.Redirect("codingmenu.aspx");
        }
        [Obsolete]
        protected void saveClientCom_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("update subheads set clientdomestic='" + clientdom.Value.ToString() + "', clientinternational='" + clientintl.Value.ToString() + "'  where (company='" + Company + "' OR company='All') and code='" + clientcode.Value.ToString() + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();
                bindGrid();
            }
        }
        [Obsolete]
        protected void saveAirCom_Click(object sender, EventArgs e)
        {
            setValues();
            using (SqlConnection con = new SqlConnection(connectionStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("update subheads set airdomestic='" + airdom.Value.ToString() + "', airdomesticextra='" + airdomextra.Value.ToString() + "', airinternational='" + airintl.Value.ToString() + "',airinternationalextra='" + airintlextra.Value.ToString() + "', commkb='" + commkbDropDownList.SelectedItem.Text + "' where (company='" + Company + "' OR company='All') and code='" + aircode.Value.ToString() + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();
                bindGrid();
            }
        }
        protected void ddltype_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox ddltype = sender as RadComboBox;
            RadComboBoxItem item1 = new RadComboBoxItem();
            item1.Text = "Detail";
            item1.Value = "Detail";
            ddltype.Items.Add(item1);
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Group";
            item2.Value = "Group";
            ddltype.Items.Add(item2);
        }

        protected void ddllevel_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox ddllevel = sender as RadComboBox;
            RadComboBoxItem item1 = new RadComboBoxItem();
            item1.Text = "1";
            item1.Value = "1";
            ddllevel.Items.Add(item1);
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "2";
            item2.Value = "2";
            ddllevel.Items.Add(item2);
            RadComboBoxItem item3 = new RadComboBoxItem();
            item3.Text = "3";
            item3.Value = "3";
            ddllevel.Items.Add(item3);
            RadComboBoxItem item4 = new RadComboBoxItem();
            item4.Text = "4";
            item4.Value = "4";
            ddllevel.Items.Add(item4);
        }

        protected void ddlidtype_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox ddlidtype = sender as RadComboBox;
            RadComboBoxItem item1 = new RadComboBoxItem();
            item1.Text = "N";
            item1.Value = "N";
            ddlidtype.Items.Add(item1);
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "B";
            item2.Value = "B";
            ddlidtype.Items.Add(item2);
            RadComboBoxItem item3 = new RadComboBoxItem();
            item3.Text = "C";
            item3.Value = "C";
            ddlidtype.Items.Add(item3);
        }

        protected void ddltransaction_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox ddltransaction = sender as RadComboBox;
            RadComboBoxItem item1 = new RadComboBoxItem();
            item1.Text = "DB";
            item1.Value = "DB";
            ddltransaction.Items.Add(item1);
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "CR";
            item2.Value = "CR";
            ddltransaction.Items.Add(item2);
        }

        protected void ddlclass_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            RadComboBox ddlclass = sender as RadComboBox;
            RadComboBoxItem item1 = new RadComboBoxItem();
            item1.Text = "Gen. Asset";
            item1.Value = "Gen. Asset";
            ddlclass.Items.Add(item1);
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Acc.Receivable";
            item2.Value = "Acc.Receivable";
            ddlclass.Items.Add(item2);
            RadComboBoxItem item3 = new RadComboBoxItem();
            item3.Text = "Gen.Liability";
            item3.Value = "Gen.Liability";
            ddlclass.Items.Add(item3);
            RadComboBoxItem item4 = new RadComboBoxItem();
            item4.Text = "Acc.Payable";
            item4.Value = "Acc.Payable";
            ddlclass.Items.Add(item4);
            RadComboBoxItem item5 = new RadComboBoxItem();
            item5.Text = "Cost of Sale";
            item5.Value = "Cost of Sale";
            ddlclass.Items.Add(item5);
            RadComboBoxItem item6 = new RadComboBoxItem();
            item6.Text = "Operating Expense";
            item6.Value = "Operating Expense";
            ddlclass.Items.Add(item6);
            RadComboBoxItem item7 = new RadComboBoxItem();
            item7.Text = "Financial Charges";
            item7.Value = "Financial Charges";
            ddlclass.Items.Add(item7);
            RadComboBoxItem item8 = new RadComboBoxItem();
            item8.Text = "Revenue";
            item8.Value = "Revenue";
            ddlclass.Items.Add(item8);
        }

        [Obsolete]
        protected void passOk_Click(object sender, EventArgs e)
        {
            setValues();
            try
            {
                SqlConnection con = new SqlConnection(connectionStr);
                con.Open();
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select username FROM Login_TBL lt join company c on c.name=lt.company Where status='Manager' and UserName='" + UserName + "' and Password='" + managerPassword.Value.ToString() + "' and Convert(Date, GetDate(), 101)<=todate";
                var username1 = cmd.ExecuteScalar().ToString();
                if (username1 != "")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "managerpopuptrue", "managerpopuptrue();", true);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "show", "show();", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "managerpopupfalse", "managerpopupfalse();", true);
                }
                con.Close();
            }catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "managerpopupfalse", "managerpopupfalse();", true);
            }
        }
    }
}