using Antlr.Runtime;
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
using System.Web.Script.Serialization;
using System.Web.Services;
using static Telerik.Web.UI.ComboBox.ComboBoxStyles;

namespace Coffer_Systems
{
    /// <summary>
    /// Summary description for WebExpenses
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebExpenses : System.Web.Services.WebService
    {
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;
        private string StatusIP, UserIDIP, UserNameIP, CompanyIP, GSTIP;

        [WebMethod]
        [Obsolete]
        public void GetValuesIP()
        {
            SqlConnection con2 = new SqlConnection(connectionStr);
            con2.Open();
            string hostName = Dns.GetHostName();
            string IP = Dns.GetHostByName(hostName).AddressList[0].ToString();
            SqlCommand cmd1 = con2.CreateCommand();
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
                    StatusIP = dr1["status"].ToString();
                    UserIDIP = dr1["ID"].ToString();
                    UserNameIP = dr1["username"].ToString();
                    CompanyIP = dr1["company"].ToString();
                    GSTIP = dr1["gst"].ToString();

                }
            }
        }
        [WebMethod]
        [Obsolete]
        public void getAccountName(string value)
        {
            GetValuesIP();
            var query = "select sub_head from [dbo].[subheads] where code='" + value + "' and (company='" + CompanyIP + "' OR company='All')";
            using (var con1 = new SqlConnection(connectionStr))
            {
                var cmd = new SqlCommand(query, con1);
                var list2 = new List<GetBank>();
                con1.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    var bank = new GetBank();
                    bank.name = Convert.ToString(reader["sub_head"]);
                    list2.Add(bank);
                }
                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.Write(js.Serialize(list2));
            }
        }

        [WebMethod]
        [Obsolete]
        public void getCities(string value)
        {
            var query = "select distinct name,citycode from cities where countrycode='" + value + "'";
            using (var con = new SqlConnection(connectionStr))
            {
                var cmd = new SqlCommand(query, con);
                var list2 = new List<GetCity>();
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    var city = new GetCity();
                    city.name = Convert.ToString(reader["name"]);
                    city.code = Convert.ToString(reader["citycode"]);
                    list2.Add(city);
                }
                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.Write(js.Serialize(list2));
            }
        }
        [WebMethod]
        [Obsolete]
        public void GetAccount()
        {
            GetValuesIP();
            var query = "select * from [dbo].[subheads] where (company='" + CompanyIP + "' OR company='All') order by code";
            using (var con = new SqlConnection(connectionStr))
            {
                var cmd = new SqlCommand(query, con);
                var list2 = new List<GetBank>();
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                var count = 1;
                while (reader.Read())
                {
                    var bank = new GetBank();
                    if (Convert.ToString(reader["airdomestic"]) != "")
                    {
                        bank.commdom = Convert.ToString(reader["airdomestic"]);
                    }
                    else if (Convert.ToString(reader["clientdomestic"]) != "")
                    {
                        bank.commdom = Convert.ToString(reader["clientdomestic"]);
                    }
                    else
                    {
                        bank.commdom = "";
                    }
                    if (Convert.ToString(reader["airinternational"]) != "")
                    {
                        bank.commair = Convert.ToString(reader["airinternational"]);
                    }
                    else if (Convert.ToString(reader["clientinternational"]) != "")
                    {
                        bank.commair = Convert.ToString(reader["clientinternational"]);
                    }
                    else
                    {
                        bank.commair = "";
                    }
                    bank.seq = count++;
                    bank.branch = Convert.ToString(reader["branch"]);
                    bank.code = Convert.ToString(reader["code"]);
                    bank.name = Convert.ToString(reader["sub_head"]);
                    bank.scode = Convert.ToString(reader["scode"]);
                    bank.id = Convert.ToString(reader["idtype"]);
                    bank.city = Convert.ToString(reader["city"]);
                    bank.level = Convert.ToString(reader["level"]);
                    bank.accounttype = Convert.ToString(reader["type"]);
                    bank.classification = Convert.ToString(reader["class"]);
                    bank.transaction = Convert.ToString(reader["transaction"]);
                    bank.opening = Convert.ToString(reader["opening"]);
                    list2.Add(bank);
                }
                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.Write(js.Serialize(list2));
            }
        }

        [WebMethod]
        [Obsolete]
        public void GetInvoiceData(int offset)
        {
            try
            {
                GetValuesIP();
                var reciepts = "select distinct cast(invno as int) as invno from invoicing  where company='" + CompanyIP + "' order by cast(invno as int) desc";
                var arlist1 = new ArrayList();
                using (var con = new SqlConnection(connectionStr))
                {
                    var cmd = new SqlCommand(reciepts, con);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var reciept = Convert.ToString(reader["invno"]);
                        arlist1.Add(reciept);
                    }
                    reader.Close();
                    con.Close();
                }
                var recieptNo = arlist1[offset];
                var query = "select * from [dbo].[invoicing] where company='" + CompanyIP + "' and invno='" + recieptNo + "'";
                using (var con = new SqlConnection(connectionStr))
                {
                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<GetBank>();
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var bank = new GetBank();
                        bank.id = Convert.ToString(reader["id"]);
                        bank.invno = Convert.ToString(reader["invno"]);
                        bank.ticket = Convert.ToString(reader["ticketno"]);
                        bank.name = Convert.ToString(reader["passengerName"]);
                        bank.sector = Convert.ToString(reader["sector"]);
                        bank.basic = Convert.ToString(reader["mkt"]);
                        bank.tax = Convert.ToString(reader["tax"]);
                        bank.other = Convert.ToString(reader["oth"]);
                        bank.total = Convert.ToString(reader["discamt"]);
                        bank.receivable = Convert.ToString(reader["receivableclient"]);
                        bank.payable = Convert.ToString(reader["airlinepayable"]);
                        bank.status = Convert.ToString(reader["status"]);
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }
        [WebMethod]
        [Obsolete]
        public void GetInvoiceDataTotal(int offset)
        {
            try
            {
                GetValuesIP();
                var reciepts = "select distinct cast(invno as int) as invno from invoicing  where company='" + CompanyIP + "' order by cast(invno as int) desc";
                var arlist1 = new ArrayList();
                using (var con = new SqlConnection(connectionStr))
                {
                    var cmd = new SqlCommand(reciepts, con);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var reciept = Convert.ToString(reader["invno"]);
                        arlist1.Add(reciept);
                    }
                    reader.Close();
                    con.Close();
                }
                var recieptNo = arlist1[offset];
                var query = "select sum(TRY_CONVERT(float ,commkb)) as kb,sum(TRY_CONVERT(float ,tcom)) as comm,sum(TRY_CONVERT(float ,whairline)) as whair,sum(TRY_CONVERT(float ,whclient)) as whclient,sum(TRY_CONVERT(float ,otherpayable)) as otherpayable,sum(TRY_CONVERT(float ,profitlossamt)) as profitloss,sum(TRY_CONVERT(float ,receivableclient)) as receivable,sum(TRY_CONVERT(float ,discamt)) as sp,sum(TRY_CONVERT(float ,airlinepayable)) as payable,sum(TRY_CONVERT(float ,mkt)) as fare,sum(TRY_CONVERT(float ,tax)) as tax,sum(TRY_CONVERT(float ,oth)) as other from [dbo].[invoicing] where company='" + CompanyIP + "' and invno='" + recieptNo + "'";
                using (var con = new SqlConnection(connectionStr))
                {
                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<GetBank>();
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var bank = new GetBank();
                        bank.kb = Convert.ToString(reader["kb"]);
                        bank.comm = Convert.ToString(reader["comm"]);
                        bank.whair = Convert.ToString(reader["whair"]);
                        bank.whclient = Convert.ToString(reader["whclient"]);
                        bank.otherpayable = Convert.ToString(reader["otherpayable"]);
                        bank.profitloss = Convert.ToString(reader["profitloss"]);
                        bank.sp = Convert.ToString(reader["sp"]);
                        bank.receivable = Convert.ToString(reader["receivable"]);
                        bank.payable = Convert.ToString(reader["payable"]);
                        bank.fare = Convert.ToString(reader["fare"]);
                        bank.tax = Convert.ToString(reader["tax"]);
                        bank.other = Convert.ToString(reader["other"]);
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }

        }
        [WebMethod]
        [Obsolete]
        public void GetRefundData(int offset, string id)
        {
            try
            {
                GetValuesIP();
                var reciepts = "select distinct cast(refundno as int) as refundno from refund where company='" + CompanyIP + "' order by cast(refundno as int) desc";
                List<string> arlist = new List<string>();
                using (var con = new SqlConnection(connectionStr))
                {
                    var cmd = new SqlCommand(reciepts, con);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var reciept = Convert.ToString(reader["refundno"]);
                        arlist.Add(reciept);
                    }
                    reader.Close();
                    con.Close();
                }
                var recieptNo = "";
                if (id != null && id != "")
                {
                    offset = arlist.FindIndex(arr => arr == id);
                    if(offset == -1) {
                        recieptNo = "-1";
                    }
                    else
                    {
                        recieptNo = arlist[offset].ToString();
                    }
                }
                else
                {
                    recieptNo = arlist[offset].ToString();
                }
                var query = "select * from [dbo].[refund] where company='" + CompanyIP + "' and refundno='" + recieptNo + "'";
                using (var con = new SqlConnection(connectionStr))
                {
                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<Invoice>();
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var invoice = new Invoice();
                        invoice.id = Convert.ToString(reader["id"]);
                        invoice.invtype = Convert.ToString(reader["invType"]);
                        invoice.etkt = Convert.ToString(reader["etkt"]);
                        invoice.tickettype = Convert.ToString(reader["tkttype"]);
                        invoice.bsp = Convert.ToString(reader["bsp"]);
                        invoice.xo = Convert.ToString(reader["xo"]);
                        invoice.rfdtype = Convert.ToString(reader["rfdtype"]);
                        invoice.rcptno = Convert.ToString(reader["rcptno"]);
                        invoice.stockdate = Convert.ToString(reader["stockdate"]);
                        invoice.salesperson = Convert.ToString(reader["salesperson"]);
                        invoice.calcom = Convert.ToString(reader["calcom"]);
                        invoice.percentage = Convert.ToString(reader["percentage"]);
                        invoice.agent = Convert.ToString(reader["agent"]);
                        invoice.conjtkt = Convert.ToString(reader["connjtkt"]);
                        invoice.xono = Convert.ToString(reader["xono"]);
                        invoice.passengertype = Convert.ToString(reader["passengertype"]);
                        invoice.sector = Convert.ToString(reader["sector"]);
                        invoice.classification = Convert.ToString(reader["class"]);
                        invoice.coupenno = Convert.ToString(reader["coupenno"]);
                        invoice.piatkt = Convert.ToString(reader["piatkt"]);
                        invoice.rfdclaim = Convert.ToString(reader["rdfclaim"]);
                        invoice.invno = Convert.ToString(reader["invno"]);
                        invoice.invdate = Convert.ToString(reader["invdate"]);
                        invoice.vlddate = Convert.ToString(reader["validdate"]);
                        invoice.airline = Convert.ToString(reader["airline"]);
                        invoice.mainseg = Convert.ToString(reader["mainseg"]);
                        invoice.subseg = Convert.ToString(reader["subseg"]);
                        invoice.iata = Convert.ToString(reader["iata"]);
                        invoice.mkt = Convert.ToString(reader["mkt"]);
                        invoice.other = Convert.ToString(reader["other"]);
                        invoice.soto = Convert.ToString(reader["soto"]);
                        invoice.sp = Convert.ToString(reader["sp"]);
                        invoice.yd = Convert.ToString(reader["yd"]);
                        invoice.pk = Convert.ToString(reader["pk"]);
                        invoice.fed = Convert.ToString(reader["fed"]);
                        invoice.ced = Convert.ToString(reader["ced"]);
                        invoice.xz = Convert.ToString(reader["xz"]);
                        invoice.whairline = Convert.ToString(reader["whairline"]);
                        invoice.whclient = Convert.ToString(reader["whclient"]);
                        invoice.yq = Convert.ToString(reader["yq"]);
                        invoice.pb = Convert.ToString(reader["pb"]);
                        invoice.oth = Convert.ToString(reader["oth"]);
                        invoice.tax = Convert.ToString(reader["tax"]);
                        invoice.frtx = Convert.ToString(reader["frtx"]);
                        invoice.whtfix = Convert.ToString(reader["whtfix"]);
                        invoice.comm = Convert.ToString(reader["comm"]);
                        invoice.comamt = Convert.ToString(reader["comamt"]);
                        invoice.comadj = Convert.ToString(reader["comadj"]);
                        invoice.tcom = Convert.ToString(reader["tcom"]);
                        invoice.airlinepay = Convert.ToString(reader["airlinepay"]);
                        invoice.servicech = Convert.ToString(reader["servicech"]);
                        invoice.serviceamt = Convert.ToString(reader["serviceamt"]);
                        invoice.ins = Convert.ToString(reader["ins"]);
                        invoice.transferac = Convert.ToString(reader["transferac"]);
                        invoice.kbairline = Convert.ToString(reader["kbairline"]);
                        invoice.clientreceive = Convert.ToString(reader["clientreceive"]);
                        invoice.profitloss = Convert.ToString(reader["profitloss"]);
                        invoice.kbcust = Convert.ToString(reader["kbcust"]);
                        invoice.commkb = Convert.ToString(reader["commkb"]);
                        invoice.disc = Convert.ToString(reader["disc"]);
                        invoice.discamt = Convert.ToString(reader["discamt"]);
                        invoice.discadj = Convert.ToString(reader["discadj"]);
                        invoice.gds = Convert.ToString(reader["gds"]);
                        invoice.totalsp = Convert.ToString(reader["totalsp"]);
                        invoice.totalinc = Convert.ToString(reader["totalinc"]);
                        invoice.saledate = Convert.ToString(reader["saledate"]);
                        invoice.payment = Convert.ToString(reader["payment"]);
                        invoice.rfdpayment = Convert.ToString(reader["rfdpayment"]);
                        invoice.cancelcharges = Convert.ToString(reader["cancelchrgs"]);
                        invoice.airlinerec = Convert.ToString(reader["airlinerec"]);
                        invoice.clientpay = Convert.ToString(reader["clientpay"]);
                        invoice.ticketvalue = Convert.ToString(reader["tktval"]);
                        invoice.receivable = Convert.ToString(reader["receivable"]);
                        invoice.srvccharges = Convert.ToString(reader["srvcchrgs"]);
                        invoice.refunddate = Convert.ToString(reader["refundDate"]);
                        invoice.svc = Convert.ToString(reader["svc"]);
                        invoice.passengername = Convert.ToString(reader["passengername"]);
                        invoice.client = Convert.ToString(reader["client"]);
                        invoice.refundno = Convert.ToString(reader["refundno"]);
                        invoice.ticketno = Convert.ToString(reader["tktno"]);
                        invoice.offset = offset;
                        list2.Add(invoice);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    js.MaxJsonLength = Int32.MaxValue;
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

        [WebMethod]
        [Obsolete]
        public void GetJVData(int offset)
        {
            try
            {
                GetValuesIP();
                var reciepts = "select distinct invno from journalvoucher where company='" + CompanyIP + "' order by invno desc";
                var arlist = new ArrayList();
                using (var con = new SqlConnection(connectionStr))
                {
                    var cmd = new SqlCommand(reciepts, con);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var reciept = Convert.ToString(reader["invno"]);
                        arlist.Add(reciept);
                    }
                    reader.Close();
                    con.Close();
                }
                var recieptNo = arlist[offset];
                var query = "select * from [dbo].[journalvoucher] where company='" + CompanyIP + "' and invno='" + recieptNo + "'";
                using (var con = new SqlConnection(connectionStr))
                {
                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<GetBank>();
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var bank = new GetBank();
                        bank.invno = Convert.ToString(reader["invno"]);
                        bank.code = Convert.ToString(reader["code"]);
                        bank.name = Convert.ToString(reader["name"]);
                        bank.transaction = Convert.ToString(reader["transaction_type"]);
                        bank.description = Convert.ToString(reader["description"]);
                        bank.segregation = Convert.ToString(reader["seggregation"]);
                        bank.reciept = Convert.ToString(reader["receipt"]);
                        bank.cheque = Convert.ToString(reader["cheque"]);
                        bank.amount = Convert.ToString(reader["amount"]);
                        bank.date = Convert.ToDateTime(reader["date"]);
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

        [WebMethod]
        [Obsolete]
        public void deleteRecordLedger(string id, string tbl)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    string str = "select receivableclient from invoicing WHERE id='" + id + "' and company='" + CompanyIP + "'";
                    SqlCommand cmd = new SqlCommand(str, con);
                    cmd.Connection.Open();
                    var balance1 = cmd.ExecuteScalar();
                    cmd.Connection.Close();
                    string str2 = "UPDATE invoicing SET credit='', balance='" + balance1 + "' WHERE id='" + id + "' and company='" + CompanyIP + "'";
                    SqlCommand cmd2 = new SqlCommand(str2, con);
                    cmd2.Connection.Open();
                    cmd2.ExecuteNonQuery();
                    cmd2.Connection.Close();
                    string str1 = "DELETE FROM ledger WHERE tblid= '" + id + "' and tblname='" + tbl + "' and company='" + CompanyIP + "'";
                    SqlCommand cmd1 = new SqlCommand(str1, con);
                    cmd1.Connection.Open();
                    cmd1.ExecuteNonQuery();
                    cmd1.Connection.Close();
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

        [WebMethod]
        [Obsolete]
        public void GetCustomerInvoiceDataTotal(string code)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    var query1 = "select sub_head from [dbo].[subheads] where code='" + code.ToString() + "' and (company='" + CompanyIP + "' OR company='All')";
                    SqlCommand cmd1 = new SqlCommand(query1, con);
                    string name = cmd1.ExecuteScalar().ToString();
                    var querytotal = "select sum(TRY_CONVERT(float ,receivableclient)) as totalticket,sum(TRY_CONVERT(float ,balance)) as totalbalance,sum(TRY_CONVERT(float ,credit)) as totalrcv from invoicing where invdate <= GETDATE() and (clientcode='" + code + "' or airline='"+ code +"') and company='" + CompanyIP + "' and balance>'0'";
                    var cmdtotal = new SqlCommand(querytotal, con);
                    var list2 = new List<GetBank>();

                    SqlDataReader readertotal = cmdtotal.ExecuteReader();
                    while (readertotal.Read())
                    {
                        var bank = new GetBank();
                        bank.name = name;
                        bank.totalbalance = Convert.ToString(readertotal["totalbalance"]);
                        bank.totalrcv = Convert.ToString(readertotal["totalrcv"]);
                        bank.totalticket = Convert.ToString(readertotal["totalticket"]);
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

        [WebMethod]
        [Obsolete]
        public void GetCustomerPendingInvoiceDataTotal(string code)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    var query1 = "select head from [dbo].[subheads] where sub_head='" + code.ToString() + "' and (company='" + CompanyIP + "' OR company='All')";
                    SqlCommand cmd1 = new SqlCommand(query1, con);
                    var querytotal = "select (select sub_head from subheads where code='" + code + "' and ld.head=subheads.code) as name,(select sum(TRY_CONVERT(float ,amount)) from clearance where ld.tblid=clearance.tblid and ld.tblname='INV') as debit,(select sum(TRY_CONVERT(float ,amount)) from clearance where ld.tblid=clearance.tblid and ld.tblname='RFD') as credit,(select sum(TRY_CONVERT(float ,balance)) from invoicing where ld.head='" + code + "' and invoicing.id=ld.tblid) as balance,(select sum(TRY_CONVERT(float ,balance)) from refund where ld.head='" + code + "' and refund.id=ld.tblid) as rfdbalance from ledger ld join invoicing inv on ld.tblid=inv.id where head='" + code + "' and ld.company='" + CompanyIP + "' and inv.balance > '0'";
                    var cmdtotal = new SqlCommand(querytotal, con);
                    var list2 = new List<GetBank>();
                    double totalbalance = 0;
                    double totalcredit = 0;
                    double totaldebit = 0;
                    SqlDataReader readertotal = cmdtotal.ExecuteReader();
                    while (readertotal.Read())
                    {
                        var bank = new GetBank();
                        var debit = Convert.ToString(readertotal["debit"]);
                        if (debit != "")
                        {
                            totaldebit = totaldebit + double.Parse(debit);
                        }
                        else
                        {
                            debit = "0";
                        }
                        bank.totaldebit = totaldebit.ToString();
                        var credit = Convert.ToString(readertotal["credit"]);
                        if (credit != "")
                        {
                            totalcredit = totalcredit + double.Parse(credit);
                        }
                        else
                        {
                            credit = "0";
                        }
                        bank.totalcredit = totalcredit.ToString(); 
                        var balance = Convert.ToString(readertotal["balance"]);
                        var rfdbalance = Convert.ToString(readertotal["rfdbalance"]);
                        if (balance != "")
                        {
                            totalbalance = totalbalance + double.Parse(balance);
                        }
                        else
                        {
                            balance = "0";
                        }
                        if (rfdbalance != "")
                        {
                            totalbalance = totalbalance + double.Parse(rfdbalance);
                        }
                        else
                        {
                            rfdbalance = "0";
                        }
                        bank.totalbalance = totalbalance.ToString();
                        if (totaldebit > totalcredit)
                        {
                            bank.type = "DEBIT";
                        }
                        else
                        {
                            bank.type = "CREDIT";
                        }
                        bank.totalamount = "0";
                        bank.name = Convert.ToString(readertotal["name"]);
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

        [WebMethod]
        [Obsolete]
        public void GetCustomerRefundData(string code)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    var code1 = "";
                    var query1 = "select code from [dbo].[subheads] where sub_head='" + code.ToString() + "' and (company='" + CompanyIP + "' OR company='All')";
                    SqlCommand cmd1 = new SqlCommand(query1, con);
                    if (cmd1.ExecuteScalar() != null)
                    {
                        code1 = cmd1.ExecuteScalar().ToString();
                    }
                    else
                    {
                        code1 = code;
                    }
                    var query = "select * from [dbo].[invoicing] where clientcode='" + code1 + "' and company='" + CompanyIP + "' order by invdate, ticketno asc";

                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<GetBank>();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var bank = new GetBank();
                        bank.id = Convert.ToString(reader["id"]);
                        bank.invno = Convert.ToString(reader["invno"]);
                        bank.date = Convert.ToDateTime(reader["invdate"]);
                        bank.ticket = Convert.ToString(reader["ticketno"]);
                        bank.amount = Convert.ToString(reader["ticketvalue"]);
                        bank.credit = Convert.ToString(reader["credit"]);
                        bank.balance = Convert.ToString(reader["balance"]);
                        bank.name = Convert.ToString(reader["passengername"]);
                        bank.sector = Convert.ToString(reader["sector"]);
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }

        }

        [WebMethod]
        [Obsolete]
        public void GetCustomerInvoiceData(string code)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    var code1 = "";
                    var query1 = "select code from [dbo].[subheads] where sub_head='" + code.ToString() + "' and (company='" + CompanyIP + "' OR company='All')";
                    SqlCommand cmd1 = new SqlCommand(query1, con);
                    if (cmd1.ExecuteScalar() != null)
                    {
                        code1 = cmd1.ExecuteScalar().ToString();
                    }
                    else
                    {
                        code1 = code;
                    }
                    var query = "select id,invdate,ticketno,invno,balance,credit,receivableclient,passengername,sector,DATEDIFF(day,CAST(invDate AS datetime), GETDATE()) AS age from [dbo].[invoicing] where invdate <= GETDATE() and (clientcode='" + code1 + "' or airline='"+ code1 +"') and company='" + CompanyIP + "' and balance>'0' order by invdate, ticketno asc";

                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<GetInvoice>();
                    SqlDataReader reader1 = cmd.ExecuteReader();
                    Console.WriteLine(reader1.ToString());
                    while (reader1.Read())
                    {
                        var invoice = new GetInvoice();
                        invoice.id = reader1["id"].ToString();
                        invoice.invno = reader1["invno"].ToString();
                        invoice.ticket = reader1["ticketno"].ToString();
                        invoice.amount = reader1["receivableclient"].ToString();
                        invoice.credit = reader1["credit"].ToString();
                        invoice.balance = reader1["balance"].ToString();
                        invoice.name = reader1["passengername"].ToString();
                        invoice.sector = reader1["sector"].ToString();
                        invoice.age = reader1["age"].ToString();
                        invoice.date = Convert.ToDateTime(reader1["invdate"]);
                        list2.Add(invoice);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }

        }

        [WebMethod]
        [Obsolete]
        public void GetCustomerPendingInvoiceData(string code)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    var code1 = "";
                    var query1 = "select code from [dbo].[subheads] where sub_head='" + code.ToString() + "' and (company='" + CompanyIP + "' OR company='All')";
                    SqlCommand cmd1 = new SqlCommand(query1, con);
                    if (cmd1.ExecuteScalar() != null)
                    {
                        code1 = cmd1.ExecuteScalar().ToString();
                    }
                    else
                    {
                        code1 = code;
                    }
                    var query = "select balance,(select tblname from ledger where tblname='INV' and ledger.invno=invoicing.invno and ledger.head='"+ code1 + "' and ledger.tblid=invoicing.id) as vtp,invdate,invno,ticketno,pnr,passengercnic,passengername+' '+sector as description,receivableClient as amount,(select sum(TRY_CONVERT(float ,amount)) from clearance where invoicing.id=clearance.tblid) as debit,(select credit from ledger where tblname='INV' and ledger.invno=invoicing.invno and ledger.head='" + code1 +"' and ledger.tblid=invoicing.id) as credit,(SELECT DATEDIFF(day,CAST(date AS datetime), GETDATE()) AS DateDiff from ledger where ledger.tblid=invoicing.id and ledger.tblname='INV' and ledger.head='"+ code1 + "') as age from invoicing  where invdate <= GETDATE() and (clientcode='" + code1 + "' or airline='" + code1 + "') and company='" + CompanyIP + "' and balance>'0' union select balance,(select tblname from ledger where tblname='RFD' and ledger.invno=refund.invno and ledger.head='"+ code1 + "' and ledger.tblid=refund.id) as vtp,invdate,invno,tktno,(select pnr from invoicing where invoicing.invno=refund.invno and invoicing.ticketno=refund.tktno) as pnr,(select passengercnic from invoicing where invoicing.invno=refund.invno and invoicing.ticketno=refund.tktno) as passengercnic,passengername+' '+sector as description,clientpay as amount,(select debit from ledger where tblname='RFD' and ledger.invno=refund.invno and ledger.head='" + code1 + "' and ledger.tblid=refund.id) as debit,(select sum(TRY_CONVERT(float ,amount)) from clearance where refund.id=clearance.tblid) as credit,(SELECT DATEDIFF(day,CAST(date AS datetime), GETDATE()) AS DateDiff from ledger where ledger.tblid=refund.id and tblname='RFD' and ledger.head='" + code1 + "') as age from refund where invdate <= GETDATE() and (client='" + code1 + "' or agent='"+ code1 +"') and company='" + CompanyIP + "' and balance>'0' order by invdate, ticketno asc";
                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<GetBank>();
                    SqlDataReader reader = cmd.ExecuteReader();
                    //float balance = 0;
                    while (reader.Read())
                    {
                        var bank = new GetBank();
                        bank.vtp = Convert.ToString(reader["vtp"]);
                        bank.invno = Convert.ToString(reader["invno"]);
                        bank.date = Convert.ToDateTime(reader["invdate"]);
                        bank.ticket = Convert.ToString(reader["ticketno"]);
                        bank.pnr = Convert.ToString(reader["pnr"]);
                        bank.description = Convert.ToString(reader["description"]);
                        bank.passno = Convert.ToString(reader["passengercnic"]);
                        bank.amount = Convert.ToString(reader["amount"]);
                        bank.debit = Convert.ToString(reader["debit"]);
                        bank.age = Convert.ToString(reader["age"]);
                        bank.balance = Convert.ToString(reader["balance"]);
                        if (bank.debit == "" || bank.debit == "0")
                        {
                            bank.debit = "";
                        }
                        bank.credit = Convert.ToString(reader["credit"]);
                        if (bank.credit == "" || bank.credit == "0")
                        {
                            bank.credit = "";
                        }
                        //balance = balance - float.Parse(bank.credit) + float.Parse(bank.debit);
                        //if (balance >= 0)
                        //{
                        //    bank.type = "DB";
                        //}
                        //else
                        //{
                        //    bank.type = "CR";
                        //}
                        //bank.balance = balance.ToString().Replace('-', ' ');
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

        [WebMethod]
        [Obsolete]
        public void GetRowDataInvoices(string ticketno)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    var query = "select * from invoicing where ticketno='" + ticketno + "' and company='" + CompanyIP + "'";
                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<Invoice>();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var invoice = new Invoice();
                        invoice.id = Convert.ToString(reader["id"]);
                        invoice.invdate = Convert.ToString(reader["invDate"]);
                        invoice.invtype = Convert.ToString(reader["invType"]);
                        invoice.invtitle = Convert.ToString(reader["invTitle"]);
                        invoice.clientcode = Convert.ToString(reader["clientcode"]);
                        invoice.balance = Convert.ToString(reader["balance"]);
                        invoice.credit = Convert.ToString(reader["credit"]);
                        invoice.customer = Convert.ToString(reader["customer"]);
                        invoice.invremarks = Convert.ToString(reader["invremarks"]);
                        invoice.etkt = Convert.ToString(reader["etkt"]);
                        invoice.conj = Convert.ToString(reader["conj"]);
                        invoice.lastticket = Convert.ToString(reader["lastticket"]);
                        invoice.airline = Convert.ToString(reader["airline"]);
                        invoice.ticketpurchasefrom = Convert.ToString(reader["ticketpurchasefrom"]);
                        invoice.tickettype = Convert.ToString(reader["TicketType"]);
                        invoice.bsp = Convert.ToString(reader["bsp"]);
                        invoice.xo = Convert.ToString(reader["xo"]);
                        invoice.postingdate = Convert.ToString(reader["postingdate"]);
                        invoice.status = Convert.ToString(reader["status"]);
                        invoice.passengername = Convert.ToString(reader["passengername"]);
                        invoice.sector = Convert.ToString(reader["sector"]);
                        invoice.fare = Convert.ToString(reader["fare"]);
                        invoice.classification = Convert.ToString(reader["class"]);
                        invoice.deptdate = Convert.ToString(reader["deptdate"]);
                        invoice.pnr = Convert.ToString(reader["pnr"]);
                        invoice.route = Convert.ToString(reader["route"]);
                        invoice.passengertype = Convert.ToString(reader["passentertype"]);
                        invoice.category = Convert.ToString(reader["category"]);
                        invoice.mainseg = Convert.ToString(reader["mainseg"]);
                        invoice.subseg = Convert.ToString(reader["subseg"]);
                        invoice.iata = Convert.ToString(reader["iata"]);
                        invoice.mkt = Convert.ToString(reader["mkt"]);
                        invoice.other = Convert.ToString(reader["other"]);
                        invoice.soto = Convert.ToString(reader["soto"]);
                        invoice.sp = Convert.ToString(reader["sp"]);
                        invoice.yd = Convert.ToString(reader["yd"]);
                        invoice.pk = Convert.ToString(reader["pk"]);
                        invoice.fed = Convert.ToString(reader["fed"]);
                        invoice.ced = Convert.ToString(reader["ced"]);
                        invoice.xz = Convert.ToString(reader["xz"]);
                        invoice.whairline = Convert.ToString(reader["whairline"]);
                        invoice.whclient = Convert.ToString(reader["whclient"]);
                        invoice.yq = Convert.ToString(reader["yq"]);
                        invoice.pb = Convert.ToString(reader["pb"]);
                        invoice.oth = Convert.ToString(reader["oth"]);
                        invoice.tax = Convert.ToString(reader["tax"]);
                        invoice.frtx = Convert.ToString(reader["frtx"]);
                        invoice.whtfix = Convert.ToString(reader["whtfix"]);
                        invoice.comm = Convert.ToString(reader["comm"]);
                        invoice.comamt = Convert.ToString(reader["comamt"]);
                        invoice.extra = Convert.ToString(reader["extra"]);
                        invoice.comadj = Convert.ToString(reader["comadj"]);
                        invoice.tcom = Convert.ToString(reader["tcom"]);
                        invoice.airlinepay = Convert.ToString(reader["airlinepay"]);
                        invoice.servicech = Convert.ToString(reader["servicech"]);
                        invoice.serviceamt = Convert.ToString(reader["serviceamt"]);
                        invoice.gst = Convert.ToString(reader["gst"]);
                        invoice.gstpay = Convert.ToString(reader["gstpay"]);
                        invoice.ins = Convert.ToString(reader["ins"]);
                        invoice.transferac = Convert.ToString(reader["transferac"]);
                        invoice.kbairline = Convert.ToString(reader["kbairline"]);
                        invoice.clientreceive = Convert.ToString(reader["clientreceive"]);
                        invoice.profitloss = Convert.ToString(reader["profitloss"]);
                        invoice.kbcust = Convert.ToString(reader["kbcust"]);
                        invoice.commkb = Convert.ToString(reader["commkb"]);
                        invoice.disc = Convert.ToString(reader["disc"]);
                        invoice.discamt = Convert.ToString(reader["discamt"]);
                        invoice.discadj = Convert.ToString(reader["discadj"]);
                        invoice.gds = Convert.ToString(reader["gds"]);
                        invoice.fc = Convert.ToString(reader["fc"]);
                        invoice.fcreceivable = Convert.ToString(reader["fcreceivable"]);
                        invoice.fcpayable = Convert.ToString(reader["fcpayable"]);
                        invoice.airlinepayable = Convert.ToString(reader["airlinepayable"]);
                        invoice.receivableclient = Convert.ToString(reader["receivableclient"]);
                        invoice.otherpayable = Convert.ToString(reader["otherpayable"]);
                        invoice.profitlossamt = Convert.ToString(reader["profitlossamt"]);
                        invoice.ticketvalue = Convert.ToString(reader["ticketvalue"]);
                        invoice.PassengerCNIC = Convert.ToString(reader["PassengerCNIC"]);
                        invoice.rcptno = Convert.ToString(reader["recieptNo"]);
                        invoice.invno = Convert.ToString(reader["invno"]);
                        invoice.visa = Convert.ToString(reader["visa"]);
                        invoice.accomodation1 = Convert.ToString(reader["accomodation1"]);
                        invoice.accomodation2 = Convert.ToString(reader["accomodation2"]);
                        invoice.transport = Convert.ToString(reader["transport"]);
                        invoice.ziarat = Convert.ToString(reader["ziarat"]);
                        invoice.food = Convert.ToString(reader["food"]);
                        list2.Add(invoice);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    js.MaxJsonLength = Int32.MaxValue;
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

        [WebMethod]
        [Obsolete]
        public void GetRowDataInvoicesRefund(string ticketno)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    var query = "select (select id from refund where refund.tktno=invoicing.ticketno) as rfdid,* from invoicing where ticketno='" + ticketno + "' and company='" + CompanyIP + "'";
                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<Invoice>();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var invoice = new Invoice();
                        invoice.id = Convert.ToString(reader["rfdid"]);
                        invoice.invdate = Convert.ToString(reader["invdate"]);
                        invoice.invtype = Convert.ToString(reader["invType"]);
                        invoice.invtitle = Convert.ToString(reader["invTitle"]);
                        invoice.clientcode = Convert.ToString(reader["clientcode"]);
                        invoice.balance = Convert.ToString(reader["balance"]);
                        invoice.credit = Convert.ToString(reader["credit"]);
                        invoice.customer = Convert.ToString(reader["customer"]);
                        invoice.invremarks = Convert.ToString(reader["invremarks"]);
                        invoice.etkt = Convert.ToString(reader["etkt"]);
                        invoice.conj = Convert.ToString(reader["conj"]);
                        invoice.lastticket = Convert.ToString(reader["lastticket"]);
                        invoice.airline = Convert.ToString(reader["airline"]);
                        invoice.ticketpurchasefrom = Convert.ToString(reader["ticketpurchasefrom"]);
                        invoice.tickettype = Convert.ToString(reader["TicketType"]);
                        invoice.bsp = Convert.ToString(reader["bsp"]);
                        invoice.xo = Convert.ToString(reader["xo"]);
                        invoice.postingdate = Convert.ToString(reader["postingdate"]);
                        invoice.status = Convert.ToString(reader["status"]);
                        invoice.passengername = Convert.ToString(reader["passengername"]);
                        invoice.sector = Convert.ToString(reader["sector"]);
                        invoice.fare = Convert.ToString(reader["fare"]);
                        invoice.classification = Convert.ToString(reader["class"]);
                        invoice.deptdate = Convert.ToString(reader["deptdate"]);
                        invoice.pnr = Convert.ToString(reader["pnr"]);
                        invoice.route = Convert.ToString(reader["route"]);
                        invoice.passengertype = Convert.ToString(reader["passentertype"]);
                        invoice.category = Convert.ToString(reader["category"]);
                        invoice.mainseg = Convert.ToString(reader["mainseg"]);
                        invoice.subseg = Convert.ToString(reader["subseg"]);
                        invoice.iata = Convert.ToString(reader["iata"]);
                        invoice.mkt = Convert.ToString(reader["mkt"]);
                        invoice.other = Convert.ToString(reader["other"]);
                        invoice.soto = Convert.ToString(reader["soto"]);
                        invoice.sp = Convert.ToString(reader["sp"]);
                        invoice.yd = Convert.ToString(reader["yd"]);
                        invoice.pk = Convert.ToString(reader["pk"]);
                        invoice.fed = Convert.ToString(reader["fed"]);
                        invoice.ced = Convert.ToString(reader["ced"]);
                        invoice.xz = Convert.ToString(reader["xz"]);
                        invoice.whairline = Convert.ToString(reader["whairline"]);
                        invoice.whclient = Convert.ToString(reader["whclient"]);
                        invoice.yq = Convert.ToString(reader["yq"]);
                        invoice.pb = Convert.ToString(reader["pb"]);
                        invoice.oth = Convert.ToString(reader["oth"]);
                        invoice.tax = Convert.ToString(reader["tax"]);
                        invoice.frtx = Convert.ToString(reader["frtx"]);
                        invoice.whtfix = Convert.ToString(reader["whtfix"]);
                        invoice.comm = Convert.ToString(reader["comm"]);
                        invoice.comamt = Convert.ToString(reader["comamt"]);
                        invoice.extra = Convert.ToString(reader["extra"]);
                        invoice.comadj = Convert.ToString(reader["comadj"]);
                        invoice.tcom = Convert.ToString(reader["tcom"]);
                        invoice.airlinepay = Convert.ToString(reader["airlinepay"]);
                        invoice.servicech = Convert.ToString(reader["servicech"]);
                        invoice.serviceamt = Convert.ToString(reader["serviceamt"]);
                        invoice.gst = Convert.ToString(reader["gst"]);
                        invoice.gstpay = Convert.ToString(reader["gstpay"]);
                        invoice.ins = Convert.ToString(reader["ins"]);
                        invoice.transferac = Convert.ToString(reader["transferac"]);
                        invoice.kbairline = Convert.ToString(reader["kbairline"]);
                        invoice.clientreceive = Convert.ToString(reader["clientreceive"]);
                        invoice.profitloss = Convert.ToString(reader["profitloss"]);
                        invoice.kbcust = Convert.ToString(reader["kbcust"]);
                        invoice.commkb = Convert.ToString(reader["commkb"]);
                        invoice.disc = Convert.ToString(reader["disc"]);
                        invoice.discamt = Convert.ToString(reader["discamt"]);
                        invoice.discadj = Convert.ToString(reader["discadj"]);
                        invoice.gds = Convert.ToString(reader["gds"]);
                        invoice.fc = Convert.ToString(reader["fc"]);
                        invoice.fcreceivable = Convert.ToString(reader["fcreceivable"]);
                        invoice.fcpayable = Convert.ToString(reader["fcpayable"]);
                        invoice.airlinepayable = Convert.ToString(reader["airlinepayable"]);
                        invoice.receivableclient = Convert.ToString(reader["receivableclient"]);
                        invoice.otherpayable = Convert.ToString(reader["otherpayable"]);
                        invoice.profitlossamt = Convert.ToString(reader["profitlossamt"]);
                        invoice.ticketvalue = Convert.ToString(reader["ticketvalue"]);
                        invoice.PassengerCNIC = Convert.ToString(reader["PassengerCNIC"]);
                        invoice.rcptno = Convert.ToString(reader["recieptNo"]);
                        invoice.invno = Convert.ToString(reader["invno"]);
                        list2.Add(invoice);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    js.MaxJsonLength = Int32.MaxValue;
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

        [WebMethod]
        [Obsolete]
        public void GetCustomerLedger(string cdd, string vdd, string fromDate, string toDate, string tkt, string pnr, string passport, string desc, string headCol, string tblCol, string tktCol, string pnrCol, string passportCol, string descCol)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    var customerCondition = "";
                    var voucherCondition = "";
                    var dateCondition = "";
                    var descriptionCondition = "";
                    var ticketCondition = "";
                    var ticketCondition1 = "";
                    var ticketConditionRFD = "";
                    var ticketConditionRFD1 = "";
                    var ticketOverallCondition = "";
                    var pnrCondition = "";
                    var pnrCondition1 = "";
                    var passportCondition = "";
                    var passportCondition1 = "";
                    if (cdd != "")
                    {
                        customerCondition = "and " + headCol + " = '" + cdd + "'";
                    }
                    if (vdd != "")
                    {
                        voucherCondition = "and " + tblCol + " = '" + vdd + "'";
                    }
                    if (toDate != "")
                    {
                        dateCondition = "and date between '" + fromDate + "' and '" + toDate + "'";
                    }
                    if (tkt != "")
                    {
                        ticketCondition = "and " + tktCol + " = '" + tkt + "'";
                        ticketCondition1 = "and invno = (select invno from invoicing where " + tktCol + " = '" + tkt + "' and ledger.tblid=invoicing.id)";
                        ticketConditionRFD = "and tktno = '" + tkt + "'";
                        ticketConditionRFD1 = "invno = (select invno from refund where tktno = '" + tkt + "' and ledger.tblid=refund.id)";
                        ticketOverallCondition = ticketCondition1 + " OR " + ticketConditionRFD1;
                    }
                    if (pnr != "")
                    {
                        pnrCondition = "and " + pnrCol + " = '" + pnr + "'";
                        pnrCondition1 = "and invno = (select invno from invoicing where " + pnrCol + " = '" + pnr + "' and ledger.tblid=invoicing.id)";
                    }
                    if (passport != "")
                    {
                        passportCondition = "and " + passportCol + " = '" + passport + "'";
                        passportCondition1 = "and invno = (select invno from invoicing where " + passportCol + " = '" + passport + "' and ledger.tblid=invoicing.id)";
                    }
                    if (desc != "")
                    {
                        descriptionCondition = "and " + descCol + " Like '%" + desc + "%'";
                    }

                    var query = "select tblname,DATEDIFF(day,CAST(date AS datetime), GETDATE()) AS age, date, invno,(select ticketno from invoicing where ledger.invno=invoicing.invno and ledger.tblname='INV' and ledger.tblid=invoicing.id " + ticketCondition + ") as ticketno,(select ticketno from others where ledger.invno=others.invno and ledger.tblname='INV' and ledger.tblid=others.id ) as othticket,(select tktno from refund where ledger.invno=refund.invno and ledger.tblname='RFD' and ledger.tblid=refund.id " + ticketConditionRFD + ") as ticketnorfd,(select pnr from invoicing where ledger.invno=invoicing.invno and ledger.tblname='INV' and ledger.tblid=invoicing.id " + pnrCondition + ") as pnr, (select passengerCNIC from invoicing where ledger.invno=invoicing.invno and ledger.tblname='INV' and ledger.tblid=invoicing.id " + passportCondition + ") as passport,(select passengername+' '+sector from invoicing where ledger.invno=invoicing.invno and ledger.tblname='INV' and ledger.tblid=invoicing.id " + ticketCondition + ") as invoiceDescription, description, CASE WHEN debit = '0' OR debit = '0.00' THEN '' ELSE debit END AS debit,CASE WHEN credit = '0' OR credit = '0.00' THEN '' ELSE credit END AS credit,balance,(select passengername from invoicing where ledger.invno=invoicing.invno and ledger.tblname='INV' and ledger.tblid=invoicing.id ) as passengername from ledger where date <= GETDATE() and company='" + CompanyIP + "' " + customerCondition + " " + voucherCondition + " " + dateCondition + " " + descriptionCondition + " " + pnrCondition1 + " " + passportCondition1 + " " + ticketOverallCondition + " order by CASE WHEN description = 'Opening Balance' THEN 0 ELSE 1 END, date asc";

                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<GetBank>();
                    SqlDataReader reader = cmd.ExecuteReader();
                    Double balance = 0;
                    while (reader.Read())
                    {
                        var bank = new GetBank();
                        bank.vouchertype = Convert.ToString(reader["tblname"]);
                        bank.date = Convert.ToDateTime(reader["date"]);
                        bank.invno = Convert.ToString(reader["invno"]);
                        bank.age = Convert.ToString(reader["age"]);
                        bank.passengername = Convert.ToString(reader["passengername"]);
                        if (Convert.ToString(reader["ticketno"]) != "")
                        {
                            bank.ticket = Convert.ToString(reader["ticketno"]);
                        }
                        else if (Convert.ToString(reader["ticketnorfd"]) != "")
                        {
                            bank.ticket = Convert.ToString(reader["ticketnorfd"]);
                        }
                        else
                        {
                            bank.ticket = Convert.ToString(reader["othticket"]);
                        }
                        bank.pnr = Convert.ToString(reader["pnr"]);
                        bank.passport = Convert.ToString(reader["passport"]);
                        bank.description = Convert.ToString(reader["description"]);
                        if (bank.description == "")
                        {
                            bank.description = Convert.ToString(reader["invoiceDescription"]);
                        }
                        bank.debit = Convert.ToString(reader["debit"]);
                        bank.credit = Convert.ToString(reader["credit"]);
                        string debit = "";
                        string credit = "";
                        if (bank.debit == "")
                        {
                            debit = "0";
                        }
                        else
                        {
                            debit = bank.debit;
                        }
                        if (bank.credit == "")
                        {
                            credit = "0";
                        }
                        else
                        {
                            credit = bank.credit;
                        }
                        balance = balance - Double.Parse(credit) + Double.Parse(debit);
                        balance = Math.Round(balance, 2);
                        if (bank.vouchertype == "OP")
                        {
                            bank.debit = "";
                            bank.credit = "";
                        }
                        if (balance >= 0)
                        {
                            bank.type = "DB";
                        }
                        else
                        {
                            bank.type = "CR";
                        }
                        bank.balance = balance.ToString().Replace('-', ' ');
                        if (bank.balance == "0")
                        {
                            bank.balance = "";
                        }
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }

        }
        

        [WebMethod]
        [Obsolete]
        public void GetCustomerLedgerSearch(string variable)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();

                    var cmdLedger = new SqlCommand("select top 1 head from ledger where head='" + variable + "' and company='"+ CompanyIP +"'", con);
                    var cdd = cmdLedger.ExecuteScalar();
                    var cmdVoucher = new SqlCommand("select top 1 tblname from ledger where tblname='" + variable + "' and company='"+ CompanyIP +"'", con);
                    var vdd = cmdVoucher.ExecuteScalar();
                    var cmdTicket = new SqlCommand("select top 1 ticketno from invoicing where ticketno='" + variable + "' and company='"+ CompanyIP +"'", con);
                    var tkt = cmdTicket.ExecuteScalar();
                    var cmdPnr = new SqlCommand("select top 1 pnr from invoicing where pnr='" + variable + "' and company='"+ CompanyIP +"'", con);
                    var pnr = cmdPnr.ExecuteScalar();
                    var cmdPassport = new SqlCommand("select top 1 passengercnic from invoicing where passengercnic='" + variable + "' and company='"+ CompanyIP +"'", con);
                    var passport = cmdPassport.ExecuteScalar();
                    var cmdDesc = new SqlCommand("select top 1 description from ledger where description Like '%" + variable + "%' and company='"+ CompanyIP +"'", con);
                    var desc = cmdDesc.ExecuteScalar();
                    var cmdDesc1 = new SqlCommand("select CONCAT(passengername,sector) from invoicing where CONCAT(passengername,sector) Like '%" + variable + "%' and company='"+ CompanyIP +"'", con);
                    var desc1 = cmdDesc1.ExecuteScalar();
                    var cmdCredit = new SqlCommand("select top 1 credit from ledger where credit='" + variable + "' and company='" + CompanyIP + "'", con);
                    var creditVal = cmdCredit.ExecuteScalar();
                    var cmdDebit = new SqlCommand("select top 1 debit from ledger where debit='" + variable + "' and company='" + CompanyIP + "'", con);
                    var debitVal = cmdDebit.ExecuteScalar();
                    var cmdInv = new SqlCommand("select top 1 invno from ledger where invno='" + variable + "' and company='" + CompanyIP + "'", con);
                    var invNoVal = cmdInv.ExecuteScalar();

                    var customerCondition = "";
                    var voucherCondition = "";
                    var descriptionCondition = "";
                    var ticketCondition = "";
                    var ticketCondition1 = "";
                    var ticketConditionRFD = "";
                    var ticketConditionRFD1 = "";
                    var ticketOverallCondition = "";
                    var pnrCondition = "";
                    var pnrCondition1 = "";
                    var passportCondition = "";
                    var passportCondition1 = "";
                    var dbcrCondition = "";
                    var invCondition = "";

                    if (cdd != null)
                    {
                        customerCondition = "and head = '" + variable + "'";
                    }
                    if (vdd != null)
                    {
                        voucherCondition = "and tblname = '" + variable + "'";
                    }
                    if (tkt != null)
                    {
                        ticketCondition = "and ticketno = '" + tkt + "'";
                        ticketCondition1 = "and invno = (select invno from invoicing where ticketno = '" + tkt + "' and ledger.tblid=invoicing.id)";
                        ticketConditionRFD = "and tktno = '" + tkt + "'";
                        ticketConditionRFD1 = "invno = (select invno from refund where tktno = '" + tkt + "' and ledger.tblid=refund.id)";
                        ticketOverallCondition = ticketCondition1 + " OR " + ticketConditionRFD1;
                    }
                    if (pnr != null)
                    {
                        pnrCondition = "and pnr = '" + pnr + "'";
                        pnrCondition1 = "and invno = (select invno from invoicing where pnr = '" + variable + "' and ledger.tblid=invoicing.id)";
                    }
                    if (passport != null)
                    {
                        passportCondition = "and passengercnic = '" + variable + "'";
                        passportCondition1 = "and invno = (select invno from invoicing where passengercnic = '" + variable + "' and ledger.tblid=invoicing.id)";
                    }
                    if (desc != null)
                    {
                        descriptionCondition = "and description Like '%" + variable + "%'";
                    }
                    if (desc1 != null)
                    {
                        descriptionCondition = "and description = (select CONCAT(passengername,sector) from invoicing where CONCAT(passengername,sector) Like '%" + variable + "%' and ledger.tblid=invoicing.id)";
                    }
                    if (debitVal != null)
                    {
                        dbcrCondition = "and debit = '" + variable + "'";
                    }
                    if (creditVal != null)
                    {
                        dbcrCondition = "and credit = '" + variable + "'";
                    }
                    if (creditVal != null && debitVal != null)
                    {
                        dbcrCondition = "and (debit = '" + variable + "' OR credit = '" + variable + "')";
                    }
                    if (invNoVal != null)
                    {
                        invCondition = "or invno = '" + variable + "'";
                    }
                    var query = "select tblname,DATEDIFF(day,CAST(date AS datetime), GETDATE()) AS age, date, invno,(select ticketno from invoicing where ledger.invno=invoicing.invno and ledger.tblname='INV' and ledger.tblid=invoicing.id " + ticketCondition + ") as ticketno,(select ticketno from others where ledger.invno=others.invno and ledger.tblname='INV' and ledger.tblid=others.id ) as othticket,(select tktno from refund where ledger.invno=refund.invno and ledger.tblname='RFD' and ledger.tblid=refund.id " + ticketConditionRFD + ") as ticketnorfd,(select pnr from invoicing where ledger.invno=invoicing.invno and ledger.tblname='INV' and ledger.tblid=invoicing.id " + pnrCondition + ") as pnr, (select passengerCNIC from invoicing where ledger.invno=invoicing.invno and ledger.tblname='INV' and ledger.tblid=invoicing.id " + passportCondition + ") as passport,(select passengername+' '+sector from invoicing where ledger.invno=invoicing.invno and ledger.tblname='INV' and ledger.tblid=invoicing.id " + ticketCondition + ") as invoiceDescription, description, CASE WHEN debit = '0' OR debit = '0.00' THEN '' ELSE debit END AS debit,CASE WHEN credit = '0' OR credit = '0.00' THEN '' ELSE credit END AS credit,balance,(select passengername from invoicing where ledger.invno=invoicing.invno and ledger.tblname='INV' and ledger.tblid=invoicing.id ) as passengername from ledger where date <= GETDATE() and company='" + CompanyIP + "' " + customerCondition + " " + voucherCondition + " " + descriptionCondition + " " + pnrCondition1 + " " + passportCondition1 + " " + ticketOverallCondition + " " + dbcrCondition + " " + invCondition + " order by CASE WHEN description = 'Opening Balance' THEN 0 ELSE 1 END, date asc";

                    var cmd = new SqlCommand(query, con);
                    var list2 = new List<GetBank>();
                    SqlDataReader reader = cmd.ExecuteReader();
                    Double balance = 0;
                    while (reader.Read())
                    {
                        var bank = new GetBank();
                        bank.vouchertype = Convert.ToString(reader["tblname"]);
                        bank.date = Convert.ToDateTime(reader["date"]);
                        bank.invno = Convert.ToString(reader["invno"]);
                        bank.age = Convert.ToString(reader["age"]);
                        bank.passengername = Convert.ToString(reader["passengername"]);
                        if (Convert.ToString(reader["ticketno"]) != "")
                        {
                            bank.ticket = Convert.ToString(reader["ticketno"]);
                        }
                        else if (Convert.ToString(reader["ticketnorfd"]) != "")
                        {
                            bank.ticket = Convert.ToString(reader["ticketnorfd"]);
                        }
                        else
                        {
                            bank.ticket = Convert.ToString(reader["othticket"]);
                        }
                        bank.pnr = Convert.ToString(reader["pnr"]);
                        bank.passport = Convert.ToString(reader["passport"]);
                        bank.description = Convert.ToString(reader["description"]);
                        if (bank.description == "")
                        {
                            bank.description = Convert.ToString(reader["invoiceDescription"]);
                        }
                        bank.debit = Convert.ToString(reader["debit"]);
                        bank.credit = Convert.ToString(reader["credit"]);
                        string debit = "";
                        string credit = "";
                        if (bank.debit == "")
                        {
                            debit = "0";
                        }
                        else
                        {
                            debit = bank.debit;
                        }
                        if (bank.credit == "")
                        {
                            credit = "0";
                        }
                        else
                        {
                            credit = bank.credit;
                        }
                        balance = balance - Double.Parse(credit) + Double.Parse(debit);
                        balance = Math.Round(balance, 2);
                        if (bank.vouchertype == "OP")
                        {
                            bank.debit = "";
                            bank.credit = "";
                        }
                        if (balance >= 0)
                        {
                            bank.type = "DB";
                        }
                        else
                        {
                            bank.type = "CR";
                        }
                        bank.balance = balance.ToString().Replace('-', ' ');
                        if (bank.balance == "0")
                        {
                            bank.balance = "";
                        }
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }

        }

        [WebMethod]
        [Obsolete]
        public void GetCustomerLedgerTotal(string cdd, string vdd, string fromDate, string toDate, string tkt, string pnr, string passport, string desc, string headCol, string tblCol, string tktCol, string pnrCol, string passportCol, string descCol)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    var customerCondition = "";
                    var voucherCondition = "";
                    var dateCondition = "";
                    var descriptionCondition = "";
                    var ticketCondition = "";
                    var ticketConditionRFD = "";
                    var ticketOverallCondition = "";
                    var pnrCondition = "";
                    var passportCondition = "";
                    Double totalbalance = 0;
                    Double totalcredit = 0;
                    Double totaldebit = 0;
                    if (cdd != "")
                    {
                        customerCondition = "and " + headCol + " = '" + cdd + "'";
                    }
                    if (vdd != "")
                    {
                        voucherCondition = "and " + tblCol + " = '" + vdd + "'";
                    }
                    if (toDate != "")
                    {
                        dateCondition = "and date between '" + fromDate + "' and '" + toDate + "'";
                    }
                    if (tkt != "")
                    {
                        ticketCondition = "and invno = (select invno from invoicing where " + tktCol + " = '" + tkt + "' and ledger.tblid=invoicing.id)";
                        ticketConditionRFD = "invno = (select invno from refund where tktno = '" + tkt + "' and ledger.tblid=refund.id)";
                        ticketOverallCondition = ticketCondition + " OR " + ticketConditionRFD;
                    }
                    if (pnr != "")
                    {
                        pnrCondition = "and invno = (select invno from invoicing where " + pnrCol + " = '" + pnr + "' and ledger.tblid=invoicing.id)";
                    }
                    if (passport != "")
                    {
                        passportCondition = "and invno = (select invno from invoicing where " + passportCol + " = '" + passport + "' and ledger.tblid=invoicing.id)";
                    }
                    if (desc != "")
                    {
                        descriptionCondition = "and " + descCol + " like '%" + desc + "%'";
                    }

                    var querytotal = "select tblname,sum(TRY_CONVERT(float ,credit)) as totalcredit,sum(TRY_CONVERT(float ,debit)) as totaldebit,sum(TRY_CONVERT(float ,balance)) as totalbalance from ledger where date <= GETDATE() and company='" + CompanyIP + "' " + customerCondition + " " + voucherCondition + " " + dateCondition + " " + descriptionCondition + " " + pnrCondition + " " + passportCondition + " " + ticketOverallCondition + " group by company,tblname";
                    var cmdtotal = new SqlCommand(querytotal, con);
                    var list2 = new List<GetBank>();

                    SqlDataReader readertotal = cmdtotal.ExecuteReader();
                    while (readertotal.Read())
                    {
                        var bank = new GetBank();
                        bank.vouchertype = Convert.ToString(readertotal["tblname"]);
                        bank.totalcredit = Convert.ToString(readertotal["totalcredit"]);
                        bank.totaldebit = Convert.ToString(readertotal["totaldebit"]);

                        if (bank.vouchertype == "OP")
                        {
                            totalbalance = totalbalance - Double.Parse(bank.totalcredit) + Double.Parse(bank.totaldebit);
                        }
                        else
                        {
                            totalcredit = totalcredit + Double.Parse(bank.totalcredit);
                            totaldebit = totaldebit + Double.Parse(bank.totaldebit);
                            totalbalance = totalbalance - Double.Parse(bank.totalcredit) + Double.Parse(bank.totaldebit);
                        }

                        if (Double.Parse(bank.totalcredit) > Double.Parse(bank.totaldebit))
                        {
                            bank.type = "CREDIT";
                        }
                        else
                        {
                            bank.type = "DEBIT";
                        }
                        bank.totalcredit = totalcredit.ToString();
                        bank.totaldebit = totaldebit.ToString();
                        bank.totalbalance = totalbalance.ToString().Replace('-', ' ');
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

        [WebMethod]
        [Obsolete]
        public void GetCustomerLedgerSearchTotal(string variable)
        {
            try
            {
                GetValuesIP();
                using (var con = new SqlConnection(connectionStr))
                {
                    con.Open();
                    Double totalbalance = 0;
                    Double totalcredit = 0;
                    Double totaldebit = 0;

                    var cmdLedger = new SqlCommand("select top 1 head from ledger where head='" + variable + "' and company='" + CompanyIP + "'", con);
                    var cdd = cmdLedger.ExecuteScalar();
                    var cmdVoucher = new SqlCommand("select top 1 tblname from ledger where tblname='" + variable + "' and company='" + CompanyIP + "'", con);
                    var vdd = cmdVoucher.ExecuteScalar();
                    var cmdTicket = new SqlCommand("select top 1 ticketno from invoicing where ticketno='" + variable + "' and company='" + CompanyIP + "'", con);
                    var tkt = cmdTicket.ExecuteScalar();
                    var cmdPnr = new SqlCommand("select top 1 pnr from invoicing where pnr='" + variable + "' and company='" + CompanyIP + "'", con);
                    var pnr = cmdPnr.ExecuteScalar();
                    var cmdPassport = new SqlCommand("select top 1 passengercnic from invoicing where passengercnic='" + variable + "' and company='" + CompanyIP + "'", con);
                    var passport = cmdPassport.ExecuteScalar();
                    var cmdDesc = new SqlCommand("select top 1 description from ledger where description Like '%" + variable + "%' and company='" + CompanyIP + "'", con);
                    var desc = cmdDesc.ExecuteScalar();
                    var cmdDesc1 = new SqlCommand("select CONCAT(passengername,sector) from invoicing where CONCAT(passengername,sector) Like '%" + variable + "%' and company='" + CompanyIP + "'", con);
                    var desc1 = cmdDesc1.ExecuteScalar();
                    var cmdCredit = new SqlCommand("select top 1 credit from ledger where credit='" + variable + "' and company='" + CompanyIP + "'", con);
                    var creditVal = cmdCredit.ExecuteScalar();
                    var cmdDebit = new SqlCommand("select top 1 debit from ledger where debit='" + variable + "' and company='" + CompanyIP + "'", con);
                    var debitVal = cmdDebit.ExecuteScalar();
                    var cmdInv = new SqlCommand("select top 1 invno from ledger where invno='" + variable + "' and company='" + CompanyIP + "'", con);
                    var invNoVal = cmdInv.ExecuteScalar();

                    var customerCondition = "";
                    var voucherCondition = "";
                    var descriptionCondition = "";
                    var ticketCondition = "";
                    var ticketCondition1 = "";
                    var ticketConditionRFD = "";
                    var ticketConditionRFD1 = "";
                    var ticketOverallCondition = "";
                    var pnrCondition = "";
                    var pnrCondition1 = "";
                    var passportCondition = "";
                    var passportCondition1 = "";
                    var dbcrCondition = "";
                    var invCondition = "";

                    if (cdd != null)
                    {
                        customerCondition = "and head = '" + variable + "'";
                    }
                    if (vdd != null)
                    {
                        voucherCondition = "and tblname = '" + variable + "'";
                    }
                    if (tkt != null)
                    {
                        ticketCondition = "and ticketno = '" + tkt + "'";
                        ticketCondition1 = "and invno = (select invno from invoicing where ticketno = '" + tkt + "' and ledger.tblid=invoicing.id)";
                        ticketConditionRFD = "and tktno = '" + tkt + "'";
                        ticketConditionRFD1 = "invno = (select invno from refund where tktno = '" + tkt + "' and ledger.tblid=refund.id)";
                        ticketOverallCondition = ticketCondition1 + " OR " + ticketConditionRFD1;
                    }
                    if (pnr != null)
                    {
                        pnrCondition = "and pnr = '" + pnr + "'";
                        pnrCondition1 = "and invno = (select invno from invoicing where pnr = '" + variable + "' and ledger.tblid=invoicing.id)";
                    }
                    if (passport != null)
                    {
                        passportCondition = "and passengercnic = '" + variable + "'";
                        passportCondition1 = "and invno = (select invno from invoicing where passengercnic = '" + variable + "' and ledger.tblid=invoicing.id)";
                    }
                    if (desc != null)
                    {
                        descriptionCondition = "and description Like '%" + variable + "%'";
                    }
                    if (desc1 != null)
                    {
                        descriptionCondition = "and description = (select CONCAT(passengername,sector) from invoicing where CONCAT(passengername,sector) Like '%" + variable + "%' and ledger.tblid=invoicing.id)";
                    }
                    if (debitVal != null)
                    {
                        dbcrCondition = "and debit = '" + variable + "'";
                    }
                    if (creditVal != null)
                    {
                        dbcrCondition = "and credit = '" + variable + "'";
                    }
                    if (creditVal != null && debitVal != null)
                    {
                        dbcrCondition = "and (debit = '" + variable + "' OR credit = '" + variable + "')";
                    }
                    if (invNoVal != null)
                    {
                        invCondition = "or invno = '" + variable + "'";
                    }

                    var querytotal = "select tblname,sum(TRY_CONVERT(float ,credit)) as totalcredit,sum(TRY_CONVERT(float ,debit)) as totaldebit,sum(TRY_CONVERT(float ,balance)) as totalbalance from ledger where date <= GETDATE() and company='" + CompanyIP + "' " + customerCondition + " " + voucherCondition + " " + descriptionCondition + " " + pnrCondition1 + " " + passportCondition1 + " " + ticketOverallCondition + " " + dbcrCondition + " " + invCondition + " group by company,tblname";
                    var cmdtotal = new SqlCommand(querytotal, con);
                    var list2 = new List<GetBank>();

                    SqlDataReader readertotal = cmdtotal.ExecuteReader();
                    while (readertotal.Read())
                    {
                        var bank = new GetBank();
                        bank.vouchertype = Convert.ToString(readertotal["tblname"]);
                        bank.totalcredit = Convert.ToString(readertotal["totalcredit"]);
                        bank.totaldebit = Convert.ToString(readertotal["totaldebit"]);

                        if (bank.vouchertype == "OP")
                        {
                            totalbalance = totalbalance - Double.Parse(bank.totalcredit) + Double.Parse(bank.totaldebit);
                        }
                        else
                        {
                            totalcredit = totalcredit + Double.Parse(bank.totalcredit);
                            totaldebit = totaldebit + Double.Parse(bank.totaldebit);
                            totalbalance = totalbalance - Double.Parse(bank.totalcredit) + Double.Parse(bank.totaldebit);
                        }

                        if (Double.Parse(bank.totalcredit) > Double.Parse(bank.totaldebit))
                        {
                            bank.type = "CREDIT";
                        }
                        else
                        {
                            bank.type = "DEBIT";
                        }
                        bank.totalcredit = totalcredit.ToString();
                        bank.totaldebit = totaldebit.ToString();
                        bank.totalbalance = totalbalance.ToString().Replace('-', ' ');
                        list2.Add(bank);
                    }
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(list2));
                }
            }
            catch (Exception ex)
            {
                Context.Response.Write(ex);
            }
        }

    }
}