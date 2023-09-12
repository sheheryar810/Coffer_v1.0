<%@ Page Language="C#" AutoEventWireup="true" Title="Refund" CodeBehind="Refund.aspx.cs" ValidateRequest="false" EnableEventValidation="false" MasterPageFile="~/Site.Master" Inherits="Coffer_Systems.Refund" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title></title>
        <link href="styles/loader.css" rel="stylesheet" />

        <link href="assets/css/StyleSheet1.css" rel="stylesheet" />
        <script src="Scripts/jquery-3.4.1.min.js"></script>
        <script src="Scripts/bootstrap.min.js"></script>

        <script>

            // Show the loader overlay
            function showLoader() {
                document.getElementById("loader-overlay").style.display = "flex";
            }

            // Hide the loader overlay
            function hideLoader() {
                document.getElementById("loader-overlay").style.display = "none";
            }

            // Attach event handlers to capture page transitions
            document.addEventListener("DOMContentLoaded", function () {
                var links = document.getElementsByTagName("a");
                for (var i = 0; i < links.length; i++) {
                    links[i].addEventListener("click", showLoader);
                }
            });

            window.addEventListener("beforeunload", showLoader);

        </script>
        <script type="text/javascript">
            $(document).keypress(function (e) {
                //Check which key is pressed on the document or window
                if (e.which == 13) {
                    // if it is 13 that means enter key pressed, then call the function to cancel the event
                    e.preventDefault();
                }
            });

            function calculate() {

                var iata = parseFloat(document.getElementById('<%=iata.ClientID%>').value || 0);
                var mkt = parseFloat(document.getElementById('<%=mkt.ClientID%>').value || 0);
                var otherfare = parseFloat(document.getElementById('<%=other.ClientID%>').value || 0);
                var soto = parseFloat(document.getElementById('<%=soto.ClientID%>').value || 0);
                var sp = parseFloat(document.getElementById('<%=sp.ClientID%>').value || 0);
                var yd = parseFloat(document.getElementById('<%=yd.ClientID%>').value || 0);
                var pk = parseFloat(document.getElementById('<%=pk.ClientID%>').value || 0);
                var fed = parseFloat(document.getElementById('<%=fed.ClientID%>').value || 0);
                var ced = parseFloat(document.getElementById('<%=ced.ClientID%>').value || 0);
                var xz = parseFloat(document.getElementById('<%=xz.ClientID%>').value || 0);
                var whairline = parseFloat(document.getElementById('<%=whairline.ClientID%>').value || 0);
                var whclient = parseFloat(document.getElementById('<%=whclient.ClientID%>').value || 0);
                var yq = parseFloat(document.getElementById('<%=yq.ClientID%>').value || 0);
                var pb = parseFloat(document.getElementById('<%=pb.ClientID%>').value || 0);
                var oth = parseFloat(document.getElementById('<%=otherpay.ClientID%>').value || 0);
                var extra = parseFloat(document.getElementById('<%=extra.ClientID%>').value || 0);
                var ins = parseFloat(document.getElementById('<%=ins.ClientID%>').value || 0);
                var kb = parseFloat(document.getElementById('<%=kbairline.ClientID%>').value || 0);
                var service = parseFloat(document.getElementById('<%=srvc.ClientID%>').value || 0);
                var disc = parseFloat(document.getElementById('<%=disc.ClientID%>').value || 0);
                var discadj = parseFloat(document.getElementById('<%=discadj.ClientID%>').value || 0);
                var discamt = parseFloat(document.getElementById('<%=discamt.ClientID%>').value || 0);
                var comamt = parseFloat(document.getElementById('<%=comamt.ClientID%>').value || 0);
                var comm = parseFloat(document.getElementById('<%=comm.ClientID%>').value || 0);
                var comadj = parseFloat(document.getElementById('<%=comadj.ClientID%>').value || 0);
                var kbcust = parseFloat(document.getElementById('<%=kbcust.ClientID%>').value || 0);
                var cancelcharges = parseFloat(document.getElementById('<%=cnclchrg.ClientID%>').value || 0);
                var servicecharges = parseFloat(document.getElementById('<%=srvcchrg.ClientID%>').value || 0);
                var serviceamount = parseFloat(document.getElementById('<%=srvcamt.ClientID%>').value || 0);
                whair = 0;
                var tcomm = comadj + comamt;
                document.getElementById('<%=tcom.ClientID%>').value = parseFloat(tcomm).toFixed(2);

                var whairlines = (((mkt * comm) / 100) * 12) / 100;
                document.getElementById('<%=whairline.ClientID%>').value = parseFloat(whairlines).toFixed(2);

                if (comadj != "") {
                    var whairl = ((((comadj * comm) / 100) * 12) / 100) + comadj / 10;
                    var twhairpay = whairl + whairline;
                    document.getElementById('<%=whairline.ClientID%>').value = parseFloat(twhairpay).toFixed(2);
                }

                if (extra != "") {
                    var whairp = parseFloat(document.getElementById('<%=whairline.ClientID%>').value || 0);
                    var whair = (((otherfare * extra) / 100) * 12) / 100;
                    var twhairp = whair + whairp;
                    document.getElementById('<%=whairline.ClientID%>').value = parseFloat(twhairp).toFixed(2);
                }
                var totalcommission = (mkt * comm) / 100;
                document.getElementById('<%=tcom.ClientID%>').value = parseFloat(totalcommission).toFixed(2);
                document.getElementById('<%=comamt.ClientID%>').value = parseFloat(totalcommission).toFixed(2);
                var tcom = parseFloat(document.getElementById('<%=tcom.ClientID%>').value || 0);
                var disct = ((disc * mkt) / 100) + discadj;
                var extracom = (otherfare * extra) / 100;
                var income = comamt - disct + extracom;
                var totalcomm = tcom + comadj;
                var srvct = 0;
                if (service != "") {
                    srvct = (service * mkt) / 100;
                } else if (serviceamount) {
                    srvct = serviceamount;
                }
                var total = mkt + otherfare + soto;
                var taxes = sp + yd + pk + fed + xz + whairline + yq + pb + oth;
                var total = taxes + total;
                var ticketvalue = taxes - whairline + mkt;
                var clientr = total - whairline + whclient + ins + srvct - disct - kbcust - cancelcharges - servicecharges;
                var airlinep = total - kb - extracom - totalcomm - cancelcharges;

                document.getElementById('<%=discamt.ClientID%>').value = Math.round(parseFloat(disct).toFixed(2));
                document.getElementById('<%=extcom.ClientID%>').value = Math.round(parseFloat(extracom).toFixed(2));
                document.getElementById('<%=svc.ClientID%>').value = Math.round(parseFloat(ins).toFixed(2));
                document.getElementById('<%=srvcamt.ClientID%>').value = Math.round(parseFloat(srvct).toFixed(2));
                document.getElementById('<%=tsp.ClientID%>').value = Math.round(parseFloat(srvct).toFixed(2));
                document.getElementById('<%=tcom.ClientID%>').value = Math.round(parseFloat(totalcomm).toFixed(2));
                document.getElementById('<%=tincome.ClientID%>').value = Math.round(parseFloat(income).toFixed(2));
                document.getElementById('<%=ttax.ClientID%>').value = Math.round(parseFloat(taxes).toFixed(2));
                document.getElementById('<%=frtx.ClientID%>').value = Math.round(parseFloat(total).toFixed(2));
                document.getElementById('<%=tktval.ClientID%>').value = Math.round(parseFloat(ticketvalue).toFixed(2));
                document.getElementById('<%=airlinerec.ClientID%>').value = Math.round(parseFloat(airlinep).toFixed(2));
                document.getElementById('<%=clientpay.ClientID%>').value = Math.round(parseFloat(clientr).toFixed(2));
                document.getElementById('<%=voucheramt1.ClientID%>').value = Math.round(parseFloat(clientr).toFixed(2)).toLocaleString('en-US', { minimumFractionDigits: 2 });
                document.getElementById('<%=voucheramt.ClientID%>').value = Math.round(parseFloat(clientr).toFixed(2)).toLocaleString('en-US', { minimumFractionDigits: 2 });
            }
            function editBtn() {
                document.getElementById('<%=editButton.ClientID %>').style.display = 'none';
                document.getElementById('<%=addButton.ClientID %>').style.display = 'block';
            }

            function addDashes(f) {
                f.value = f.value.replace(/(\d{3})(\d{4})(\d{6})/, "$1-$2-$3").slice(0, 15);
                var tkt = document.getElementById('<%=tktno.ClientID%>').value;
            }

            function newBtn1() {

                document.getElementById('<%=editButton.ClientID %>').style.display = 'none';
                document.getElementById('<%=addButton.ClientID %>').style.display = 'block';
                var refund = parseFloat(document.getElementById('<%=refund.ClientID%>').value || 0);
                refund = refund + 1;
                document.getElementById('<%=refund.ClientID%>').value = refund;

                document.getElementById('<%=invDropDownList.ClientID%>').value = "";
                document.getElementById('<%=etkt.ClientID%>').value = "";
                document.getElementById('<%=tktDropDownList.ClientID%>').value = "";
                document.getElementById('<%=bspDropDown1.ClientID%>').value = "";
                document.getElementById('<%=xo.ClientID%>').value = "";
                document.getElementById('<%=rfdDropDownList.ClientID%>').value = "";
                document.getElementById('<%=rcptno.ClientID%>').value = "";
                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                document.getElementById("stockDate").value = today;
                document.getElementById('<%=salesperson.ClientID%>').value = "";
                document.getElementById('<%=calcomm.ClientID%>').value = "";
                document.getElementById('<%=percent.ClientID%>').value = "";
                document.getElementById('<%=agent.ClientID%>').value = "";
                document.getElementById('<%=airlineDropDownList.ClientID%>').value = "";
                document.getElementById('<%=conjtkt.ClientID%>').value = "";
                document.getElementById('<%=xono.ClientID%>').value = "";
                document.getElementById('<%=typeDropDownList.ClientID%>').value = "";
                document.getElementById('<%=sector.ClientID%>').value = "";
                document.getElementById('<%=@class.ClientID%>').value = "";
                document.getElementById('<%=coupen.ClientID%>').value = "";
                document.getElementById('<%=piatkt.ClientID%>').value = "";
                document.getElementById('<%=rfdclain.ClientID%>').value = "";
                document.getElementById('<%=invno.ClientID%>').value = "0";
                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                document.getElementById("invDate").value = today;
                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                document.getElementById("vldDate").value = today;
                document.getElementById('<%=airline.ClientID%>').value = "";
                document.getElementById('<%=DropDownList2.ClientID%>').value = "";
                document.getElementById('<%=DropDownList1.ClientID%>').value = "";
                document.getElementById('<%=iata.ClientID%>').value = "";
                document.getElementById('<%=mkt.ClientID%>').value = "";
                document.getElementById('<%=other.ClientID%>').value = "";
                document.getElementById('<%=soto.ClientID%>').value = "";
                document.getElementById('<%=sp.ClientID%>').value = "";
                document.getElementById('<%=yd.ClientID%>').value = "";
                document.getElementById('<%=pk.ClientID%>').value = "";
                document.getElementById('<%=fed.ClientID%>').value = "";
                document.getElementById('<%=ced.ClientID%>').value = "";
                document.getElementById('<%=xz.ClientID%>').value = "";
                document.getElementById('<%=whairline.ClientID%>').value = "";
                document.getElementById('<%=whclient.ClientID%>').value = "";
                document.getElementById('<%=yq.ClientID%>').value = "";
                document.getElementById('<%=pb.ClientID%>').value = "";
                document.getElementById('<%=otherpay.ClientID%>').value = "";
                document.getElementById('<%=ttax.ClientID%>').value = "";
                document.getElementById('<%=frtx.ClientID%>').value = "";
                document.getElementById('<%=fixDropDownList.ClientID%>').value = "";
                document.getElementById('<%=comm.ClientID%>').value = "";
                document.getElementById('<%=comamt.ClientID%>').value = "";
                document.getElementById('<%=comadj.ClientID%>').value = "";
                document.getElementById('<%=tcom.ClientID%>').value = "";
                document.getElementById('<%=srvc.ClientID%>').value = "";
                document.getElementById('<%=srvcamt.ClientID%>').value = "";
                document.getElementById('<%=ins.ClientID%>').value = "";
                document.getElementById('<%=transferDropDownList.ClientID%>').value = "";
                document.getElementById('<%=kbairline.ClientID%>').value = "";
                document.getElementById('<%=kbcust.ClientID%>').value = "";
                document.getElementById('<%=disc.ClientID%>').value = "";
                document.getElementById('<%=discamt.ClientID%>').value = "";
                document.getElementById('<%=discadj.ClientID%>').value = "";
                document.getElementById('<%=tsp.ClientID%>').value = "";
                document.getElementById('<%=tincome.ClientID%>').value = "";
                document.getElementById('<%=payment.ClientID%>').value = "";
                document.getElementById('<%=gds.ClientID%>').value = "";
                document.getElementById('<%=rfdpmt.ClientID%>').value = "";
                document.getElementById('<%=cnclchrg.ClientID%>').value = "";
                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                document.getElementById("saledate").value = today;
                document.getElementById('<%=airlinerec.ClientID%>').value = "";
                document.getElementById('<%=clientpay.ClientID%>').value = "";
                document.getElementById('<%=voucheramt1.ClientID%>').value = "";
                document.getElementById('<%=voucheramt.ClientID%>').value = "";
                document.getElementById('<%=svc.ClientID%>').value = "";
                document.getElementById('<%=tktval.ClientID%>').value = "";
                document.getElementById('<%=receivable.ClientID%>').value = "";
                document.getElementById('<%=srvcchrg.ClientID%>').value = "";
                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                document.getElementById("refunddate").value = today;
                document.getElementById('<%=pname.ClientID%>').value = "";
                document.getElementById('<%=customerDropDownList.ClientID%>').value = "";
                document.getElementById('<%=tktno.ClientID%>').value = "";
            }
        </script>
        <script type="text/javascript"> 
            var offset = 0;
            var count = 0;

            $(document).ready(function () {
                offset = 0;
                let queryURL = window.location.search;
                var res = new URLSearchParams(queryURL);
                var id = res.get("id");
                console.log("Refund ID: ", id, "Offset: ", offset);
                document.getElementById('<%=addButton.ClientID %>').style.display = 'none';
                $.ajax({
                    url: 'WebExpenses.asmx/GetRefundData',
                    method: 'POST',
                    dataType: 'json',
                    data: { offset: offset, id: id },
                    success: function (data) {
                        if (data[0] != undefined) {
                            document.getElementById('<%=tblid.ClientID%>').value = data[0].id;
                            document.getElementById('<%=invDropDownList.ClientID%>').value = data[0].invtype;
                            document.getElementById('<%=etkt.ClientID%>').value = data[0].etkt;
                            document.getElementById('<%=tktDropDownList.ClientID%>').value = data[0].tkttype;
                            document.getElementById('<%=bspDropDown1.ClientID%>').value = data[0].bsp;
                            document.getElementById('<%=xo.ClientID%>').value = data[0].xo;
                            document.getElementById('<%=rfdDropDownList.ClientID%>').value = data[0].rfdtype;
                            document.getElementById('<%=rcptno.ClientID%>').value = data[0].rcptno;
                            var now = data[0].stockdate.split(" ");
                            var date = now[0].split("/");
                            var today;
                            if (date.length == 1) {
                                today = date;
                            } else {
                                var month;
                                if (date[1].length != 2) {
                                    month = "0" + date[1];
                                } else {
                                    month = date[1];
                                }
                                today = date[2] + "-" + date[0] + "-" + month;
                            }
                            document.getElementById("stockDate").value = today;
                            document.getElementById('<%=salesperson.ClientID%>').value = data[0].salesperson;
                            document.getElementById('<%=calcomm.ClientID%>').value = data[0].calcom;
                            document.getElementById('<%=percent.ClientID%>').value = data[0].percentage;
                            document.getElementById('<%=agent.ClientID%>').value = data[0].agent;
                            document.getElementById('<%=airlineDropDownList.ClientID%>').value = data[0].agent;
                            document.getElementById('<%=conjtkt.ClientID%>').value = data[0].conjtkt;
                            document.getElementById('<%=xono.ClientID%>').value = data[0].xono;
                            document.getElementById('<%=typeDropDownList.ClientID%>').value = data[0].passengertype;
                            document.getElementById('<%=sector.ClientID%>').value = data[0].sector;
                            document.getElementById('<%=@class.ClientID%>').value = data[0].classification;
                            document.getElementById('<%=coupen.ClientID%>').value = data[0].coupenno;
                            document.getElementById('<%=piatkt.ClientID%>').value = data[0].piatkt;
                            document.getElementById('<%=rfdclain.ClientID%>').value = data[0].rfdclaim;
                            document.getElementById('<%=invno.ClientID%>').value = data[0].invno;
                            var now = data[0].invdate.split(" ");
                            var date = now[0].split("/");
                            var today;
                            if (date.length == 1) {
                                today = date;
                            } else {
                                var month;
                                if (date[1].length != 2) {
                                    month = "0" + date[1];
                                } else {
                                    month = date[1];
                                }
                                today = date[2] + "-" + date[0] + "-" + month;
                            }
                            document.getElementById("invDate").value = today;
                            var now = data[0].vlddate.split(" ");
                            var date = now[0].split("/");
                            var today;
                            if (date.length == 1) {
                                today = date;
                            } else {
                                var month;
                                if (date[1].length != 2) {
                                    month = "0" + date[1];
                                } else {
                                    month = date[1];
                                }
                                today = date[2] + "-" + date[0] + "-" + month;
                            }
                            document.getElementById("vldDate").value = today;
                            document.getElementById('<%=airline.ClientID%>').value = data[0].airline;
                            document.getElementById('<%=DropDownList2.ClientID%>').value = data[0].mainseg;
                            document.getElementById('<%=DropDownList1.ClientID%>').value = data[0].subseg;
                            document.getElementById('<%=iata.ClientID%>').value = data[0].iata;
                            document.getElementById('<%=mkt.ClientID%>').value = data[0].mkt;
                            document.getElementById('<%=other.ClientID%>').value = data[0].other;
                            document.getElementById('<%=soto.ClientID%>').value = data[0].soto;
                            document.getElementById('<%=sp.ClientID%>').value = data[0].sp;
                            document.getElementById('<%=yd.ClientID%>').value = data[0].yd;
                            document.getElementById('<%=pk.ClientID%>').value = data[0].pk;
                            document.getElementById('<%=fed.ClientID%>').value = data[0].fed;
                            document.getElementById('<%=ced.ClientID%>').value = data[0].ced;
                            document.getElementById('<%=xz.ClientID%>').value = data[0].xz;
                            document.getElementById('<%=whairline.ClientID%>').value = data[0].whairline;
                            document.getElementById('<%=whclient.ClientID%>').value = data[0].whclient;
                            document.getElementById('<%=yq.ClientID%>').value = data[0].yq;
                            document.getElementById('<%=pb.ClientID%>').value = data[0].pb;
                            document.getElementById('<%=otherpay.ClientID%>').value = data[0].oth;
                            document.getElementById('<%=ttax.ClientID%>').value = data[0].tax;
                            document.getElementById('<%=frtx.ClientID%>').value = data[0].frtx;
                            document.getElementById('<%=fixDropDownList.ClientID%>').value = data[0].whtfix;
                            document.getElementById('<%=comm.ClientID%>').value = data[0].comm;
                            document.getElementById('<%=comamt.ClientID%>').value = data[0].comamt;
                            document.getElementById('<%=comadj.ClientID%>').value = data[0].comadj;
                            document.getElementById('<%=tcom.ClientID%>').value = data[0].tcom;
                            document.getElementById('<%=srvc.ClientID%>').value = data[0].servicech;
                            document.getElementById('<%=srvcamt.ClientID%>').value = data[0].serviceamt;
                            document.getElementById('<%=ins.ClientID%>').value = data[0].ins;
                            document.getElementById('<%=transferDropDownList.ClientID%>').value = data[0].transferac;
                            document.getElementById('<%=kbairline.ClientID%>').value = data[0].kbairline;
                            document.getElementById('<%=kbcust.ClientID%>').value = data[0].kbcust;
                            document.getElementById('<%=disc.ClientID%>').value = data[0].disc;
                            document.getElementById('<%=discamt.ClientID%>').value = data[0].discamt;
                            document.getElementById('<%=discadj.ClientID%>').value = data[0].discadj;
                            document.getElementById('<%=tsp.ClientID%>').value = data[0].totalsp;
                            document.getElementById('<%=tincome.ClientID%>').value = data[0].totalinc;
                            document.getElementById('<%=payment.ClientID%>').value = data[0].payment;
                            document.getElementById('<%=gds.ClientID%>').value = data[0].gds;
                            document.getElementById('<%=rfdpmt.ClientID%>').value = data[0].rfdpayment;
                            document.getElementById('<%=cnclchrg.ClientID%>').value = data[0].cancelcharges;
                            var now = data[0].saledate.split(" ");
                            var date = now[0].split("/");
                            var today;
                            if (date.length == 1) {
                                today = date;
                            } else {
                                var month;
                                if (date[1].length != 2) {
                                    month = "0" + date[1];
                                } else {
                                    month = date[1];
                                }
                                today = date[2] + "-" + date[0] + "-" + month;
                            }
                            document.getElementById("saledate").value = today;
                            document.getElementById('<%=airlinerec.ClientID%>').value = data[0].airlinerec;
                            document.getElementById('<%=clientpay.ClientID%>').value = data[0].clientpay;
                            document.getElementById('<%=voucheramt1.ClientID%>').value = data[0].clientpay.toLocaleString('en-US', { minimumFractionDigits: 2 });
                            document.getElementById('<%=voucheramt.ClientID%>').value = data[0].clientpay.toLocaleString('en-US', { minimumFractionDigits: 2 });
                            document.getElementById('<%=svc.ClientID%>').value = data[0].svc;
                            document.getElementById('<%=tktval.ClientID%>').value = data[0].ticketvalue;
                            document.getElementById('<%=receivable.ClientID%>').value = data[0].receivable;
                            document.getElementById('<%=srvcchrg.ClientID%>').value = data[0].srvccharges;
                            var now = data[0].refunddate.split(" ");
                            var date = now[0].split("/");
                            var today;
                            if (date.length == 1) {
                                today = date;
                            } else {
                                var month;
                                if (date[1].length != 2) {
                                    month = "0" + date[1];
                                } else {
                                    month = date[1];
                                }
                                today = date[2] + "-" + date[0] + "-" + month;
                            }
                            document.getElementById("refunddate").value = today;
                            document.getElementById('<%=pname.ClientID%>').value = data[0].passengername;
                            document.getElementById('<%=ccode.ClientID%>').value = data[0].client;
                            document.getElementById('<%=customerDropDownList.ClientID%>').value = data[0].client;
                            document.getElementById('<%=refund.ClientID%>').value = data[0].refundno;
                            document.getElementById('<%=tktno.ClientID%>').value = data[0].ticketno;
                            offset = data[0].offset;
                        } else {
                            NoExistPopup();
                        }

                    },
                    error: function (res) {
                        alertPopup();
                    }
                });
                function GetRefundData(offset) {
                    var id = "";
                    console.log("Refund ID: ", id, "Offset: ", offset);
                    $.ajax({
                        url: 'WebExpenses.asmx/GetRefundData',
                        method: 'POST',
                        dataType: 'json',
                        data: { offset: offset, id: id },
                        success: function (data) {
                            document.getElementById('<%=tblid.ClientID%>').value = data[0].id;
                            document.getElementById('<%=invDropDownList.ClientID%>').value = data[0].invtype;
                            document.getElementById('<%=etkt.ClientID%>').value = data[0].etkt;
                            document.getElementById('<%=tktDropDownList.ClientID%>').value = data[0].tkttype;
                            document.getElementById('<%=bspDropDown1.ClientID%>').value = data[0].bsp;
                            document.getElementById('<%=xo.ClientID%>').value = data[0].xo;
                            document.getElementById('<%=rfdDropDownList.ClientID%>').value = data[0].rfdtype;
                            document.getElementById('<%=rcptno.ClientID%>').value = data[0].rcptno;
                            var now = data[0].stockdate.split(" ");
                            var date = now[0].split("/");
                            var today;
                            if (date.length == 1) {
                                today = date;
                            } else {
                                var month;
                                if (date[1].length != 2) {
                                    month = "0" + date[1];
                                } else {
                                    month = date[1];
                                }
                                today = date[2] + "-" + date[0] + "-" + month;
                            }
                            document.getElementById("stockDate").value = today;
                            document.getElementById('<%=salesperson.ClientID%>').value = data[0].salesperson;
                            document.getElementById('<%=calcomm.ClientID%>').value = data[0].calcom;
                            document.getElementById('<%=percent.ClientID%>').value = data[0].percentage;
                            document.getElementById('<%=agent.ClientID%>').value = data[0].agent;
                            document.getElementById('<%=airlineDropDownList.ClientID%>').value = data[0].agent;
                            document.getElementById('<%=conjtkt.ClientID%>').value = data[0].conjtkt;
                            document.getElementById('<%=xono.ClientID%>').value = data[0].xono;
                            document.getElementById('<%=typeDropDownList.ClientID%>').value = data[0].passengertype;
                            document.getElementById('<%=sector.ClientID%>').value = data[0].sector;
                            document.getElementById('<%=@class.ClientID%>').value = data[0].classification;
                            document.getElementById('<%=coupen.ClientID%>').value = data[0].coupenno;
                            document.getElementById('<%=piatkt.ClientID%>').value = data[0].piatkt;
                            document.getElementById('<%=rfdclain.ClientID%>').value = data[0].rfdclaim;
                            document.getElementById('<%=invno.ClientID%>').value = data[0].invno;
                            var now = data[0].invdate.split(" ");
                            var date = now[0].split("/");
                            var today;
                            if (date.length == 1) {
                                today = date;
                            } else {
                                var month;
                                if (date[1].length != 2) {
                                    month = "0" + date[1];
                                } else {
                                    month = date[1];
                                }
                                today = date[2] + "-" + date[0] + "-" + month;
                            }
                            document.getElementById("invDate").value = today;
                            var now = data[0].vlddate.split(" ");
                            var date = now[0].split("/");
                            var today;
                            if (date.length == 1) {
                                today = date;
                            } else {
                                var month;
                                if (date[1].length != 2) {
                                    month = "0" + date[1];
                                } else {
                                    month = date[1];
                                }
                                today = date[2] + "-" + date[0] + "-" + month;
                            }
                            document.getElementById("vldDate").value = today;
                            document.getElementById('<%=airline.ClientID%>').value = data[0].airline;
                            document.getElementById('<%=DropDownList2.ClientID%>').value = data[0].mainseg;
                            document.getElementById('<%=DropDownList1.ClientID%>').value = data[0].subseg;
                            document.getElementById('<%=iata.ClientID%>').value = data[0].iata;
                            document.getElementById('<%=mkt.ClientID%>').value = data[0].mkt;
                            document.getElementById('<%=other.ClientID%>').value = data[0].other;
                            document.getElementById('<%=soto.ClientID%>').value = data[0].soto;
                            document.getElementById('<%=sp.ClientID%>').value = data[0].sp;
                            document.getElementById('<%=yd.ClientID%>').value = data[0].yd;
                            document.getElementById('<%=pk.ClientID%>').value = data[0].pk;
                            document.getElementById('<%=fed.ClientID%>').value = data[0].fed;
                            document.getElementById('<%=ced.ClientID%>').value = data[0].ced;
                            document.getElementById('<%=xz.ClientID%>').value = data[0].xz;
                            document.getElementById('<%=whairline.ClientID%>').value = data[0].whairline;
                            document.getElementById('<%=whclient.ClientID%>').value = data[0].whclient;
                            document.getElementById('<%=yq.ClientID%>').value = data[0].yq;
                            document.getElementById('<%=pb.ClientID%>').value = data[0].pb;
                            document.getElementById('<%=otherpay.ClientID%>').value = data[0].oth;
                            document.getElementById('<%=ttax.ClientID%>').value = data[0].tax;
                            document.getElementById('<%=frtx.ClientID%>').value = data[0].frtx;
                            document.getElementById('<%=fixDropDownList.ClientID%>').value = data[0].whtfix;
                            document.getElementById('<%=comm.ClientID%>').value = data[0].comm;
                            document.getElementById('<%=comamt.ClientID%>').value = data[0].comamt;
                            document.getElementById('<%=comadj.ClientID%>').value = data[0].comadj;
                            document.getElementById('<%=tcom.ClientID%>').value = data[0].tcom;
                            document.getElementById('<%=srvc.ClientID%>').value = data[0].servicech;
                            document.getElementById('<%=srvcamt.ClientID%>').value = data[0].serviceamt;
                            document.getElementById('<%=ins.ClientID%>').value = data[0].ins;
                            document.getElementById('<%=transferDropDownList.ClientID%>').value = data[0].transferac;
                            document.getElementById('<%=kbairline.ClientID%>').value = data[0].kbairline;
                            document.getElementById('<%=kbcust.ClientID%>').value = data[0].kbcust;
                            document.getElementById('<%=disc.ClientID%>').value = data[0].disc;
                            document.getElementById('<%=discamt.ClientID%>').value = data[0].discamt;
                            document.getElementById('<%=discadj.ClientID%>').value = data[0].discadj;
                            document.getElementById('<%=tsp.ClientID%>').value = data[0].totalsp;
                            document.getElementById('<%=tincome.ClientID%>').value = data[0].totalinc;
                            document.getElementById('<%=payment.ClientID%>').value = data[0].payment;
                            document.getElementById('<%=gds.ClientID%>').value = data[0].gds;
                            document.getElementById('<%=rfdpmt.ClientID%>').value = data[0].rfdpayment;
                            document.getElementById('<%=cnclchrg.ClientID%>').value = data[0].cancelcharges;
                            var now = data[0].saledate.split(" ");
                            var date = now[0].split("/");
                            var today;
                            if (date.length == 1) {
                                today = date;
                            } else {
                                var month;
                                if (date[1].length != 2) {
                                    month = "0" + date[1];
                                } else {
                                    month = date[1];
                                }
                                today = date[2] + "-" + date[0] + "-" + month;
                            }
                            document.getElementById("saledate").value = today;
                            document.getElementById('<%=airlinerec.ClientID%>').value = data[0].airlinerec;
                            document.getElementById('<%=clientpay.ClientID%>').value = data[0].clientpay;
                            document.getElementById('<%=voucheramt1.ClientID%>').value = data[0].clientpay.toLocaleString('en-US', { minimumFractionDigits: 2 });
                            document.getElementById('<%=voucheramt.ClientID%>').value = data[0].clientpay.toLocaleString('en-US', { minimumFractionDigits: 2 });
                            document.getElementById('<%=svc.ClientID%>').value = data[0].svc;
                            document.getElementById('<%=tktval.ClientID%>').value = data[0].ticketvalue;
                            document.getElementById('<%=receivable.ClientID%>').value = data[0].receivable;
                            document.getElementById('<%=srvcchrg.ClientID%>').value = data[0].srvccharges;
                            var now = data[0].refunddate.split(" ");
                            var date = now[0].split("/");
                            var today;
                            if (date.length == 1) {
                                today = date;
                            } else {
                                var month;
                                if (date[1].length != 2) {
                                    month = "0" + date[1];
                                } else {
                                    month = date[1];
                                }
                                today = date[2] + "-" + date[0] + "-" + month;
                            }
                            document.getElementById("refunddate").value = today;
                            document.getElementById('<%=pname.ClientID%>').value = data[0].passengername;
                            document.getElementById('<%=customerDropDownList.ClientID%>').value = data[0].client;
                            document.getElementById('<%=refund.ClientID%>').value = data[0].refundno;
                            document.getElementById('<%=tktno.ClientID%>').value = data[0].ticketno;
                            offset = data[0].offset;
                        },
                        error: function (res) {
                            count = 1;
                            alert("This is First Record!!");
                        }
                    });

                }
                $('#fixDropDownList').change(function () {
                    var cdd = $('#fixDropDownList').val();
                    if (cdd == "Yes") {
                        $("#whairline").prop("readonly", true);
                    } else {
                        $("#whairline").prop("readonly", false);
                    }
                });
                $('#bspDropDown1').change(function () {
                    var cdd = $('#bspDropDown1').val();
                    if (cdd == "Y") {
                        document.getElementById('<%=airlineDropDownList.ClientID%>').value = '2310222';
                        document.getElementById('<%=agent.ClientID%>').value = '2310222';
                    }
                    else {
                        document.getElementById('<%=airlineDropDownList.ClientID%>').value = "";
                        document.getElementById('<%=agent.ClientID%>').value = "";
                    }
                });
                $('#tktno').change(function () {
                    var ticketno = $('#tktno').val();
                    $.ajax({
                        url: 'WebExpenses.asmx/GetRowDataInvoicesRefund',
                        method: 'POST',
                        dataType: 'json',
                        data: { ticketno: ticketno },
                        success: function (data) {
                            if (data[0] != null) {
                                document.getElementById('<%=tblid.ClientID%>').value = data[0].id;
                                document.getElementById('<%=invno.ClientID%>').value = data[0].invno;
                                document.getElementById('<%=invDropDownList.ClientID%>').value = data[0].invtype;
                                document.getElementById('<%=ccode.ClientID%>').value = data[0].clientcode;
                                document.getElementById('<%=customerDropDownList.ClientID%>').value = data[0].clientcode;
                                document.getElementById('<%=etkt.ClientID%>').value = data[0].etkt;
                                document.getElementById('<%=conjtkt.ClientID%>').value = data[0].conj;
                                document.getElementById('<%=agent.ClientID%>').value = data[0].airline;
                                document.getElementById('<%=airlineDropDownList.ClientID%>').value = data[0].airline;
                                document.getElementById('<%=tktDropDownList.ClientID%>').value = data[0].tickettype;
                                document.getElementById('<%=bspDropDown1.ClientID%>').value = data[0].bsp;
                                document.getElementById('<%=xo.ClientID%>').value = data[0].xo;
                                document.getElementById('<%=pname.ClientID%>').value = data[0].passengername;
                                document.getElementById('<%=sector.ClientID%>').value = data[0].sector;
                                document.getElementById('<%=@class.ClientID%>').value = data[0].classification;
                                document.getElementById('<%=routeDropDownList.ClientID%>').value = data[0].route;
                                document.getElementById('<%=typeDropDownList.ClientID%>').value = data[0].passengertype;
                                document.getElementById('<%=catDropDownList.ClientID%>').value = data[0].category;
                                document.getElementById('<%=DropDownList2.ClientID%>').value = data[0].mainseg;
                                document.getElementById('<%=DropDownList1.ClientID%>').value = data[0].subseg;
                                document.getElementById('<%=iata.ClientID%>').value = data[0].iata;
                                document.getElementById('<%=mkt.ClientID%>').value = data[0].mkt;
                                document.getElementById('<%=other.ClientID%>').value = data[0].other;
                                document.getElementById('<%=soto.ClientID%>').value = data[0].soto;
                                document.getElementById('<%=sp.ClientID%>').value = data[0].sp;
                                document.getElementById('<%=yd.ClientID%>').value = data[0].yd;
                                document.getElementById('<%=pk.ClientID%>').value = data[0].pk;
                                document.getElementById('<%=fed.ClientID%>').value = data[0].fed;
                                document.getElementById('<%=ced.ClientID%>').value = data[0].ced;
                                document.getElementById('<%=xz.ClientID%>').value = data[0].xz;
                                document.getElementById('<%=whairline.ClientID%>').value = data[0].whairline;
                                document.getElementById('<%=whclient.ClientID%>').value = data[0].whclient;
                                document.getElementById('<%=yq.ClientID%>').value = data[0].yq;
                                document.getElementById('<%=pb.ClientID%>').value = data[0].pb;
                                document.getElementById('<%=otherpay.ClientID%>').value = data[0].oth;
                                document.getElementById('<%=ttax.ClientID%>').value = data[0].tax;
                                document.getElementById('<%=frtx.ClientID%>').value = data[0].frtx;
                                document.getElementById('<%=fixDropDownList.ClientID%>').value = data[0].whtfix;
                                document.getElementById('<%=comm.ClientID%>').value = data[0].comm;
                                document.getElementById('<%=comamt.ClientID%>').value = data[0].comamt;
                                document.getElementById('<%=comadj.ClientID%>').value = data[0].comadj;
                                document.getElementById('<%=tcom.ClientID%>').value = data[0].tcom;
                                document.getElementById('<%=srvc.ClientID%>').value = data[0].servicech;
                                document.getElementById('<%=srvcamt.ClientID%>').value = data[0].serviceamt;
                                document.getElementById('<%=ins.ClientID%>').value = data[0].ins;
                                document.getElementById('<%=transferDropDownList.ClientID%>').value = data[0].transferac;
                                document.getElementById('<%=kbairline.ClientID%>').value = data[0].kbairline;
                                document.getElementById('<%=kbcust.ClientID%>').value = data[0].kbcust;
                                document.getElementById('<%=disc.ClientID%>').value = data[0].disc;
                                document.getElementById('<%=discamt.ClientID%>').value = data[0].discamt;
                                document.getElementById('<%=discadj.ClientID%>').value = data[0].discadj;
                                document.getElementById('<%=gds.ClientID%>').value = data[0].gds;
                                document.getElementById('<%=airlinerec.ClientID%>').value = data[0].airlinepayable;
                                document.getElementById('<%=clientpay.ClientID%>').value = data[0].receivableclient;
                                document.getElementById('<%=voucheramt1.ClientID%>').value = data[0].receivableclient.toLocaleString('en-US', { minimumFractionDigits: 2 });
                                document.getElementById('<%=voucheramt.ClientID%>').value = data[0].receivableclient.toLocaleString('en-US', { minimumFractionDigits: 2 });
                                document.getElementById('<%=tktval.ClientID%>').value = data[0].ticketvalue;
                                var now = data[0].postingdate.split(" ");
                                var date = now[0].split("/");
                                var today;
                                if (date.length == 1) {
                                    today = date;
                                } else {
                                    var month;
                                    if (date[1].length != 2) {
                                        month = "0" + date[1];
                                    } else {
                                        month = date[1];
                                    }
                                    today = date[2] + "-" + date[0] + "-" + month;
                                }
                                document.getElementById("vldDate").value = today;
                                var now = data[0].invdate.split(" ");
                                var date = now[0].split("/");
                                var today;
                                if (date.length == 1) {
                                    today = date;
                                } else {
                                    var month;
                                    if (date[1].length != 2) {
                                        month = "0" + date[1];
                                    } else {
                                        month = date[1];
                                    }
                                    today = date[2] + "-" + date[0] + "-" + month;
                                }
                                document.getElementById("invDate").value = today;
                                var now = data[0].invdate.split(" ");
                                var date = now[0].split("/");
                                var today;
                                if (date.length == 1) {
                                    today = date;
                                } else {
                                    var month;
                                    if (date[1].length != 2) {
                                        month = "0" + date[1];
                                    } else {
                                        month = date[1];
                                    }
                                    today = date[2] + "-" + date[0] + "-" + month;
                                }
                                document.getElementById("stockDate").value = today;
                            } else {
                                ticketAlertPopup();
                            }
                        },
                        error: function (res) {
                        }
                    });
                });

                $('#airlineDropDownList').change(function () {
                    var add = $('#airlineDropDownList').val();
                    document.getElementById('<%=agent.ClientID%>').value = parseFloat(add);
                });
                $('#customerDropDownList').change(function () {
                    var cdd = $('#customerDropDownList').val();
                    document.getElementById('<%=ccode.ClientID%>').value = parseFloat(cdd);
                });

                $('#DropDownList2').change(function () {
                    var dd2 = $('#DropDownList2').val();
                    if (dd2 == 2 || dd2 == 3) {
                        $("#gst").prop("disabled", true);
                        $("#gstpay").prop("disabled", true);
                    } else {
                        $("#gst").prop("disabled", false);
                        $("#gstpay").prop("disabled", false);
                    }
                    if (dd2 == 1) {
                        $('#DropDownList1').children().hide();
                        $('#DropDownList1').children('option[value="1"]').show();
                        $('#DropDownList1').children('option[value="2"]').show();
                        $('#DropDownList1').children('option[value="3"]').show();
                    }
                    else if (dd2 == 2) {
                        $('#DropDownList1').children().hide();
                        $('#DropDownList1').children('option[value="4"]').show();
                        $('#DropDownList1').children('option[value="5"]').show();
                        $('#DropDownList1').children('option[value="6"]').show();
                    }
                    else if (dd2 == 3) {
                        $('#DropDownList1').children().hide();
                        $('#DropDownList1').children('option[value="7"]').show();
                        $('#DropDownList1').children('option[value="8"]').show();
                    }
                    else if (dd2 == 4) {
                        $('#DropDownList1').children().hide();
                        $('#DropDownList1').children('option[value="9"]').show();
                        $('#DropDownList1').children('option[value="10"]').show();
                    }
                    else if (dd2 == 6) {
                        $('#DropDownList1').children().hide();
                        $('#DropDownList1').children('option[value="12"]').show();
                    }
                    else if (dd2 == 7) {
                        $('#DropDownList1').children().hide();
                        $('#DropDownList1').children('option[value="13"]').show();
                    }
                    else if (dd2 == 8) {
                        $('#DropDownList1').children().hide();
                        $('#DropDownList1').children('option[value="14"]').show();
                    }
                    else if (dd2 == 9) {
                        $('#DropDownList1').children().hide();
                        $('#DropDownList1').children('option[value="15"]').show();
                        $('#DropDownList1').children('option[value="16"]').show();
                        $('#DropDownList1').children('option[value="17"]').show();
                    }
                });

                $('#searchButton').click(function () {
                    jQuery.noConflict();
                    $('#searchPopup').modal('show');
                });
                function NoExistPopup() {
                    jQuery.noConflict();
                    $('#NoExistPopup').modal('show');
                }

                $('#searchOK').click(function () {
                    var id = document.getElementById('<%=invoiceSearch.ClientID%>').value;
                    window.location.href = "refund.aspx?id=" + id;
                });

                $('#prevbtn').click(function () {
                    offset++;
                    GetRefundData(offset);
                });

                $('#nextbtn').click(function () {
                    offset--;
                    if (count == 1) {
                        count = 0;
                        offset--;
                    }
                    if (offset >= 0) {
                        GetRefundData(offset);
                    }
                    else {
                        offset = 0;
                        alert("This is Last Record!!");
                    }
                });
            });

            function ShowPopup() {

                var code = document.getElementById('<%=ccode.ClientID%>').value;
                jQuery.noConflict();
                if (code != "") {
                    $.ajax({
                        type: "POST",
                        url: "WebExpenses.asmx/GetCustomerRefundData",
                        data: { code: code },
                        dataType: "json",
                        success: function (data) {
                            var tableView = $find("<%= RadGrid2.ClientID %>").get_masterTableView();
                            tableView.set_dataSource(data);
                            tableView.dataBind();
                            $('#MyPopup').modal('show');
                            $.ajax({
                                type: "POST",
                                url: "WebExpenses.asmx/GetCustomerInvoiceDataTotal",
                                data: { code: code },
                                dataType: "json",
                                success: function (data) {
                                    document.getElementById('<%=invtkttotal.ClientID%>').value = data[0].totalticket;
                                    document.getElementById('<%=invrcvtotal.ClientID%>').value = data[0].totalrcv;
                                    document.getElementById('<%=invbalancetotal.ClientID%>').value = data[0].totalbalance;
                                    document.getElementById('<%=customername.ClientID%>').value = data[0].name;
                                },
                                error: function () {
                                    alert("error");
                                }
                            });
                        },
                        error: function () {
                            alert("error");
                        }
                    });
                }
                else {
                    alert("No record selected");
                }
            }
        </script>

        <style>
            .form-control {
                font-size: 10px !important;
                height: 25px !important;
            }
        </style>
    </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="loader-overlay" class="loader-overlay" style="display: none;">
        <div class="loader" style="justify-items: center">
            <img src="Images/Coffer.png" alt="Loading..." class="loader-logo"  loading="lazy"/>
            <div class="loader-spinner"></div>
        </div>
    </div>
    <div id="page-wrapper">

        <div class="panel panel-info" style="background-color: #f4f7f7; font-size: 10px">
            <div class="panel-body">
                <div class="row">
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Refund #.</label>
                            <input type="text" runat="server" id="refund" style="background-color: blue; color: white; font-size: 16px !important; font-weight: bold !important" readonly clientidmode="Static" class="form-control" />
                            <input type="text" runat="server" id="tblid" style="visibility: hidden" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Invoice Type</label><br />
                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="invDropDownList" class="form-control dropdown-toggle">
                                <asp:ListItem Value="Refund">Refund</asp:ListItem>
                                <asp:ListItem Value="Void">Void</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>E.Tkt.</label>
                            <input type="text" runat="server" id="etkt" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Ticket No.</label>
                            <input type="text" runat="server" id="tktno" onchange="addDashes(this)" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Ticket Type</label><br />
                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="tktDropDownList" class="form-control dropdown-toggle">
                                <asp:ListItem Value="International">International</asp:ListItem>
                                <asp:ListItem Value="Domestic">Domestic</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>BSP</label>
                            <asp:DropDownList runat="server" Style="-webkit-appearance: none;" ClientIDMode="Static" ID="bspDropDown1" class="form-control dropdown-toggle">
                                <asp:ListItem Value="N">N</asp:ListItem>
                                <asp:ListItem Value="Y">Y</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>XO</label>
                            <input type="text" runat="server" id="xo" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Refund Type</label><br />
                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="rfdDropDownList" class="form-control dropdown-toggle">
                                <asp:ListItem Value="Normal (Cash)">Normal (Cash)</asp:ListItem>
                                <asp:ListItem Value="Credit/Debit Card (Merchant Machine Payment)">Credit/Debit Card (Merchant Machine Payment)</asp:ListItem>
                                <asp:ListItem Value="Online Bank Transfer">Online Bank Transfer</asp:ListItem>
                                <asp:ListItem Value="Cheque">Cheque</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Receipt No.</label>
                            <input type="text" runat="server" id="rcptno" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Stock Date</label>
                            <input type="date" runat="server" id="stockDate" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Sales Person</label>
                            <input type="text" runat="server" id="salesperson" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <div class="col-lg-8">
                                <label>Calculate Comm.</label>
                                <input type="text" runat="server" id="calcomm" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-4">
                                <label>%</label>
                                <input type="text" runat="server" id="percent" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Airline/Agent</label>
                            <input type="text" runat="server" id="agent" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>Airline/Agent Name</label>
                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="airlineDropDownList" class="form-control dropdown-toggle">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Conjuction Tkt.No.</label>
                            <input type="text" runat="server" id="conjtkt" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>XO No.</label>
                            <input type="text" runat="server" id="xono" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Type</label><br />
                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="typeDropDownList" class="form-control dropdown-toggle">
                                <asp:ListItem Value="Child">Child</asp:ListItem>
                                <asp:ListItem Value="Adult">Adult</asp:ListItem>
                                <asp:ListItem Value="Infant">Infant</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>PSA 1.5% (PIA)</label>
                            <input type="text" runat="server" id="psa" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Route Type</label><br />
                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="routeDropDownList" class="form-control dropdown-toggle">
                                <asp:ListItem Value="One Way">One Way</asp:ListItem>
                                <asp:ListItem Value="Return">Return</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>Category</label><br />
                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="catDropDownList" class="form-control dropdown-toggle">
                                <asp:ListItem Value="Normal">Normal</asp:ListItem>
                                <asp:ListItem Value="Normal Re-Issue">Normal Re-Issue</asp:ListItem>
                                <asp:ListItem Value="Umrah">Umrah</asp:ListItem>
                                <asp:ListItem Value="Solo Ticket">Solo Ticket</asp:ListItem>
                                <asp:ListItem Value="Hajj">Hajj</asp:ListItem>
                                <asp:ListItem Value="Visa">Visa</asp:ListItem>
                                <asp:ListItem Value="Protector">Protector</asp:ListItem>
                                <asp:ListItem Value="Medical">Medical</asp:ListItem>
                                <asp:ListItem Value="Seat Reservation">Seat Reservation</asp:ListItem>
                                <asp:ListItem Value="Visit Visa">Visit Visa</asp:ListItem>
                                <asp:ListItem Value="Transit Visa">Transit Visa</asp:ListItem>
                                <asp:ListItem Value="Other Visa Services">Other Visa Services</asp:ListItem>
                                <asp:ListItem Value="Hotel Booking">Hotel Booking</asp:ListItem>
                                <asp:ListItem Value="Domestic Tour Package">Domestic Tour Package</asp:ListItem>
                                <asp:ListItem Value="Holding FC">Holding FC</asp:ListItem>
                                <asp:ListItem Value="Holding PK">Holding PK</asp:ListItem>
                                <asp:ListItem Value="Misc">Misc</asp:ListItem>
                                <asp:ListItem Value="Other">Other</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>Client Code</label>
                            <input style="background-color: blue; color: white;" type="text" runat="server" id="ccode" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>Client Name</label>
                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="customerDropDownList" class="form-control dropdown-toggle">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>Passenger Name</label>
                            <input type="text" runat="server" id="pname" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>Sector & Description</label>
                            <input type="text" runat="server" id="sector" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Class</label>
                            <input type="text" runat="server" id="class" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>Coupen No.</label>
                            <input type="text" runat="server" id="coupen" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>PIA Auto Tkt No.</label>
                            <input type="text" runat="server" id="piatkt" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Refund Claim No.</label>
                            <input type="text" runat="server" id="rfdclain" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Inv No.</label>
                            <input type="text" runat="server" readonly id="invno" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Inv Date</label>
                            <input type="date" runat="server" id="invDate" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-1">
                            <label>Validation Date</label>
                            <input type="date" runat="server" id="vldDate" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>Airline</label>
                            <input type="text" runat="server" id="airline" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>Main Segregation</label>
                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="DropDownList2" class="form-control dropdown-toggle">
                                <asp:ListItem Value="0">0</asp:ListItem>
                                <asp:ListItem Value="1">1 Ticketing</asp:ListItem>
                                <asp:ListItem Value="2">2 Umrah</asp:ListItem>
                                <asp:ListItem Value="3">3 Hajj</asp:ListItem>
                                <asp:ListItem Value="4">4 Tours</asp:ListItem>
                                <asp:ListItem Value="5">5 Hotel Booking</asp:ListItem>
                                <asp:ListItem Value="6">6 Visa Drop Box</asp:ListItem>
                                <asp:ListItem Value="7">7 Visa Processing</asp:ListItem>
                                <asp:ListItem Value="8">8 Visa Protecting</asp:ListItem>
                                <asp:ListItem Value="9">9 Recruiting</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="margin-top: 30px">
                        <div class="col-lg-2">
                            <label>Sub Segregation</label>
                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="DropDownList1" class="form-control dropdown-toggle">
                                <asp:ListItem Value="0"></asp:ListItem>
                                <asp:ListItem Value="1">1 Normal Ticketing</asp:ListItem>
                                <asp:ListItem Value="2">2 Umrah Ticketing</asp:ListItem>
                                <asp:ListItem Value="3">3 Hajj Ticketing</asp:ListItem>
                                <asp:ListItem Value="4">4 Umrah Approval</asp:ListItem>
                                <asp:ListItem Value="5">5 Umrah Economy</asp:ListItem>
                                <asp:ListItem Value="6">6 Umrah Star</asp:ListItem>
                                <asp:ListItem Value="7">7 Hajj Economy</asp:ListItem>
                                <asp:ListItem Value="8">8 Hajj Star</asp:ListItem>
                                <asp:ListItem Value="9">9 UAE Visa</asp:ListItem>
                                <asp:ListItem Value="10">10 Other Visa</asp:ListItem>
                                <asp:ListItem Value="11">11 Hotel Booking</asp:ListItem>
                                <asp:ListItem Value="12">12 Visa Drop Box</asp:ListItem>
                                <asp:ListItem Value="13">13 Visa Processing</asp:ListItem>
                                <asp:ListItem Value="14">14 Visa Protecting</asp:ListItem>
                                <asp:ListItem Value="15">15 UAE Jobs</asp:ListItem>
                                <asp:ListItem Value="16">16 Saudia Jobs</asp:ListItem>
                                <asp:ListItem Value="17">17 Others Jobs</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <%-------------------------------------------%>

                <div class="row" style="margin-top: 30px">
                    <div class="col-lg-2">
                        <div class="row">
                            <div class="col-lg-6">
                                <label>IATA Fare</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="iata" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Mkt. Fare</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="mkt" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Other Fare</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="other" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Soto Fair</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="soto" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>SP/YI</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="sp" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>YD/SF/FTT</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="yd" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>PK/YR</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="pk" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>FED/RG/CVT</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="fed" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>CED</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="ced" readonly clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <div class="row">
                            <div class="col-lg-6">
                                <label>XZ/JO</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="xz" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>W.H. Airline</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="whairline" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>W.H.Client</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="whclient" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>YQ</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="yq" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>PB</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="pb" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Other</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="otherpay" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Total Tax</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="ttax" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Fare + Taxes</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="frtx" clientidmode="Static" onchange="calculate();" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>WHT Fix</label>
                            </div>
                            <div class="col-lg-6">
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="fixDropDownList" class="form-control dropdown-toggle">
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <div class="row">
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Comm. %</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="comm" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Com. Amt</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" readonly id="comamt" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Extra %</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="extra" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Ext.Com.</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="extcom" readonly clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Com Adj.</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="comadj" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Total Com.</label>
                            </div>
                            <div class="col-lg-6">
                                <input style="background-color: forestgreen; color: white;" type="text" runat="server" id="tcom" readonly clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="row" style="">
                            <div class="col-lg-4">
                                <label>Service Chrgs %</label>
                                <input type="text" runat="server" id="srvc" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-2 col-lg-offset-2">
                                <label>Disc.%</label>
                            </div>
                            <div class="col-lg-4">
                                <input type="text" runat="server" id="disc" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="">
                            <div class="col-lg-4">
                                <label>Service Amount</label>
                                <input type="text" runat="server" id="srvcamt" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-2  col-lg-offset-2" style="">
                                <label>Disc.Amount</label>
                            </div>
                            <div class="col-lg-4" style="">
                                <input type="text" runat="server" id="discamt" readonly clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="">
                            <div class="col-lg-4">
                                <label>Adv. WHT 6%</label>
                                <input type="text" runat="server" id="advwht" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-2 col-lg-offset-2" style="">
                                <label>Disc.Adj</label>
                            </div>
                            <div class="col-lg-4" style="">
                                <input type="text" runat="server" id="discadj" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="">
                            <div class="col-lg-2 col-lg-offset-8">
                                <label>Comm. After KB</label>
                            </div>
                            <div class="col-lg-2" style="margin-top: -10px">
                                <input type="text" runat="server" id="comkb" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="">
                            <div class="col-lg-4">
                                <label>ins./SVC</label>
                                <input type="text" runat="server" id="ins" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-2 col-lg-offset-2" style="margin-top: 15px">
                                <label>KB Airline</label>
                            </div>
                            <div class="col-lg-4" style="margin-top: 10px">
                                <input type="text" runat="server" id="kbairline" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="">
                            <div class="col-lg-4">
                                <label>Transfer A/C</label>
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="transferDropDownList" class="form-control dropdown-toggle">
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-2 col-lg-offset-2" style="margin-top: 15px">
                                <label>K.B Cust</label>
                            </div>
                            <div class="col-lg-4" style="margin-top: 10px">
                                <input type="text" runat="server" id="kbcust" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <div class="row" style="margin-top: 5px">
                            <div class="col-lg-8">
                                <label>Total SP.</label>
                                <input type="text" runat="server" id="tsp" readonly clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: -30px">
                            <div class="col-lg-8">
                                <label>Total income</label>
                                <input type="text" runat="server" id="tincome" readonly clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: -30px">
                            <div class="col-lg-8">
                                <label>Payment</label>
                                <input type="text" runat="server" id="payment" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: -30px">
                            <div class="col-lg-8">
                                <label>GDS</label>
                                <input type="text" runat="server" id="gds" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: -30px">
                            <div class="col-lg-8">
                                <label>Rfd Pmt</label>
                                <input type="text" runat="server" id="rfdpmt" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <%--//---------------------------------------%>

                <div class="col-lg-4">
                    <div class="col-lg-6">
                        <label>Cancel Charges</label>
                        <input type="text" runat="server" id="cnclchrg" onchange="calculate();" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-6">
                        <label>Sale Report Date</label>
                        <input type="date" runat="server" id="saledate" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-6">
                        <label>Service Charges</label>
                        <input type="text" runat="server" id="srvcchrg" onchange="calculate();" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-6">
                        <label>Refund/Void Date</label>
                        <input type="date" runat="server" id="refunddate" clientidmode="Static" class="form-control" />
                    </div>
                </div>
                <div class="col-lg-2">
                    <label>Airline Receivable</label>
                    <input style="background-color: red; color: white;" type="text" runat="server" id="airlinerec" clientidmode="Static" class="form-control" />
                </div>
                <div class="col-lg-3">
                    <div class="col-lg-7">
                        <label>Payment to Client</label>
                        <input style="background-color: red; color: white;" type="text" runat="server" id="clientpay" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-5">
                        <label>Svc./Ins.</label>
                        <input style="background-color: red; color: white;" type="text" runat="server" id="svc" clientidmode="Static" class="form-control" />
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="col-lg-6">
                        <label>Ticket Value</label>
                        <input style="background-color: yellow;" type="text" runat="server" id="tktval" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-6">
                        <label>Receivable</label>
                        <input style="background-color: red; color: white;" type="text" runat="server" id="receivable" clientidmode="Static" class="form-control" />
                    </div>
                </div>
            </div>
        </div>
        <center>
            <div class="row" style="margin-bottom: 2%">
                <asp:Button ID="addButton" OnClick="AddButton_Click" class="btn btn-primary" runat="server" Text="Save" />
                <asp:Button ID="newButton" OnClientClick="newBtn1(); return false" class="btn btn-primary" runat="server" Text="Add New Refund" />
                <asp:Button ID="editButton" OnClientClick="editBtn(); return false" class="btn btn-primary" runat="server" Text="Edit" />
                <asp:Button ID="delButton" OnClick="delButton_Click" class="btn btn-primary" runat="server" Text="Delete" />
                <input name="searchButton" id="searchButton" value="Search" class="btn btn-primary" title="Search" type="button">
                <input name="otherbtn" id="otherbtn" value="Other" class="btn btn-primary" title="Other" type="button">
                <input name="remarkbtn" id="remarkbtn" value="Remarks" class="btn btn-primary" title="Detailed Remarks" type="button">
                <input name="prevbtn" id="prevbtn" value="Prev" class="btn btn-primary" title="Prev" type="button">
                <input name="nextbtn" id="nextbtn" value="Next" class="btn btn-primary" title="Next" type="button">
                <input name="recieptbtn" id="recieptbtn" value="Reciept" class="btn btn-primary" title="Reciept" type="button">
                <input name="refbtn" id="refbtn" value="Change Ref #" class="btn btn-primary" title="Change Ref #" type="button">
                <input name="creditbtn" id="creditbtn" value="Credit Note" class="btn btn-primary" title="Credit Note" type="button">
                <asp:Button ID="btnShowPopup" runat="server" OnClick="btnShowPopup_Click" Text="Invoice Clearance" class="btn btn-primary" />
            </div>
        </center>
    </div>

    <!-- Bootstrap -->
    <!-- Bootstrap -->
    <!-- Modal Popup -->
    <
    <center>

        <div id="MyPopup" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; margin-left: -60%">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <h4>Refund Clear against Invoices
                        </h4>
                    </div>
                    <div class="modal-body" style="max-width: 1300px">
                        <div class="row">
                            <div class="col-lg-4">
                                <label>Customer Name:</label>
                                <input style="background-color: forestgreen; color: white" type="text" runat="server" id="customername" disabled clientidmode="Static" class="form-control" />
                            </div>
                                    <div class="col-lg-4">
                                        <label>Voucher Amount:</label>
                                        <input style="background-color: red; color: white" type="text" runat="server" id="voucheramt" disabled clientidmode="Static" class="form-control" />
                                    </div>
                        </div>
                        <div class="content">
                            <div class="panel panel-info" style="background-color: #f4f7f7">

                                <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                                    <script type="text/javascript">
                                        var grid1Validator;

                                        function gridCreated(sender, args) {

                                            // == Batch Editing - Validation Manager == 
                                            grid1Validator = new BatchExtensions.ValidationManager().init({
                                                grid: sender,
                                            });
                                        }

                                        function userAction(sender, args) {
                                            //You can use this event to alert the user that there are changes in the grid and 
                                            //cancel operations like paging, filtering, etc.
                                            //debugger;
                                            if (!grid1Validator.isValid()) {
                                                args.set_cancel(true);
                                            }
                                        }
                                    </script>
                                </telerik:RadCodeBlock>
                                <asp:Panel ID="Panel2" runat="server">
                                    <telerik:RadToolTip runat="server" ID="RadToolTip1" OffsetY="0" RenderInPageRoot="false"
                                        HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                                        ShowEvent="FromCode" Position="Center" Skin="Default">
                                    </telerik:RadToolTip>

                                    <telerik:RadGrid ID="RadGrid2" runat="server" AllowAutomaticDeletes="true" OnNeedDataSource="RadGrid2_NeedDataSource"
                                        Width="100%">
                                        <MasterTableView Width="100%" CommandItemDisplay="Top" AutoGenerateColumns="false">
                                            <CommandItemSettings ShowAddNewRecordButton="false" ShowSaveChangesButton="false" ShowCancelChangesButton="false" ShowRefreshButton="false" />
                                            <Columns>
                                                        <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true"
                                                            ForceExtractValue="Always" Display="false">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="invdate" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Inv. Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="invno" ItemStyle-Width="6%" HeaderStyle-Width="6%" HeaderText="Inv/Ref.#" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="ticketno" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderText="Ticket No." ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="receivableclient" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Amount" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="amount" ItemStyle-Width="8%" HeaderStyle-Width="8%" ReadOnly="true" HeaderText="Cleared Amount"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="balance" HeaderText="Balance" ReadOnly="true" ItemStyle-Width="8%" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="age" HeaderText="Ag." ItemStyle-Width="4%" HeaderStyle-Width="4%" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="passengername" HeaderText="Name" ItemStyle-Width="8%" HeaderStyle-Width="8%" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="sector" HeaderText="Sector" ItemStyle-Width="8%" HeaderStyle-Width="8%" ReadOnly="true"></telerik:GridBoundColumn>
                                                    </Columns>
                                        </MasterTableView>
                                        <ClientSettings AllowKeyboardNavigation="True">
                                            <KeyboardNavigationSettings AllowActiveRowCycle="true" />
                                            <Selecting AllowRowSelect="true" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                            <ClientEvents OnUserAction="userAction" OnGridCreated="gridCreated" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </asp:Panel>
                            </div>
                            <div class="row">
                                <div class="col-lg-1">
                                    <asp:Button ID="Button1" OnClick="DelInvBtn_Click" class="btn btn-primary" runat="server" Text="Delete" />
                                </div>
                                <div class="col-lg-1 col-lg-offset-2">
                                    <label style="font-size: larger">Total:</label>
                                </div>
                                <div class="col-lg-4">
                                    <div class="col-lg-4">
                                        <input style="background-color: orange" type="text" runat="server" id="invtkttotal" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                    <div class="col-lg-4">
                                        <input style="background-color: orange" type="text" runat="server" id="invrcvtotal" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                    <div class="col-lg-4">
                                        <input style="background-color: saddlebrown; color: white" type="text" runat="server" id="invbalancetotal" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">
                            Close</button>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>

        <div id="MyPopup1" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; margin-left: -60%">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <h4>Invoices Clear
                        </h4>
                    </div>
                    <div class="modal-body" style="max-width: 1300px">
                        <div class="row">
                            <div class="col-lg-4">
                                <label>Customer Name:</label>
                                <input style="background-color: blue; color: white" type="text" runat="server" id="customername1" disabled clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-4">
                                <label>Refundable:</label>
                                <input style="background-color: red; color: white" type="text" runat="server" id="voucheramt1" disabled clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-4">
                                <label>Remaining Amount:</label>
                                <input style="background-color: blue; color: white" type="text" runat="server" id="remainingamt1" disabled clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="content">
                            <div class="panel panel-info" style="background-color: #f4f7f7">

                                <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                                    <script type="text/javascript">
                                        var grid1Validator;

                                        var tamount = 0;
                                        function gridCreated(sender, args) {

                                            // == Batch Editing - Validation Manager == 
                                            grid1Validator = new BatchExtensions.ValidationManager().init({
                                                grid: sender,
                                            });
                                        }

                                        function BatchEditCellValueChanged(sender, args) {
                                            var grid = $find('<%= RadGrid3.ClientID %>');
                                            var masterTable = grid.get_masterTableView();
                                            var item = masterTable.get_dataItems()[args._row.control._itemIndexHierarchical];
                                            var cell = masterTable.getCellByColumnUniqueName(item, "amount");
                                            var amount = $telerik.$(cell).text().trim();
                                            var cell1 = masterTable.getCellByColumnUniqueName(item, "balance");

                                            tamount = tamount + parseFloat(amount);

                                            var balance = $telerik.$(cell1).text().trim();
                                            var temp = balance - amount;
                                            var voucherAmount = document.getElementById('voucheramt1').value;
                                            var voucheramt = parseFloat(voucherAmount.replace(/,/g, ''));
                                            var remainingAmount = voucheramt - parseFloat(tamount);

                                            masterTable.getCellByColumnUniqueName(item, "balance").innerHTML = temp;
                                            document.getElementById('Text7').value = (parseFloat(document.getElementById('Text5').value.replace(/,/g, '')) - tamount).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                            document.getElementById('Text6').value = tamount.toLocaleString('en-US', { minimumFractionDigits: 2 });
                                            document.getElementById('remainingamt1').value = remainingAmount.toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        }

                                        function userAction(sender, args) {
                                            //You can use this event to alert the user that there are changes in the grid and 
                                            //cancel operations like paging, filtering, etc.
                                            //debugger;
                                            if (!grid1Validator.isValid()) {
                                                args.set_cancel(true);
                                            }
                                        }
                                    </script>
                                </telerik:RadCodeBlock>
                                <asp:Panel ID="Panel1" runat="server">
                                    <telerik:RadToolTip runat="server" ID="RadToolTip2" OffsetY="0" RenderInPageRoot="false"
                                        HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                                        ShowEvent="FromCode" Position="Center" Skin="Default">
                                    </telerik:RadToolTip>

                                    <telerik:RadGrid ID="RadGrid3" runat="server" AllowAutomaticDeletes="true" OnNeedDataSource="RadGrid3_NeedDataSource" OnBatchEditCommand="RadGrid3_BatchEditCommand"
                                        Width="100%">
                                        <MasterTableView Width="100%" EditMode="Batch" CommandItemDisplay="Top" AutoGenerateColumns="false">
                                            <CommandItemSettings ShowAddNewRecordButton="false" ShowSaveChangesButton="true" ShowCancelChangesButton="true" ShowRefreshButton="false" />
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true"
                                                    ForceExtractValue="Always" Display="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="invdate" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Inv. Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="invno" ItemStyle-Width="6%" HeaderStyle-Width="6%" HeaderText="Inv/Ref.#" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="ticketno" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderText="Ticket No." ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="receivableclient" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Amount" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="amount" UniqueName="amount" ForceExtractValue="Always" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Clear Amount"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="balance" HeaderText="Balance" ItemStyle-Width="8%" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="refundable" HeaderText="Refundable" ItemStyle-Width="8%" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="age" HeaderText="Ag." ItemStyle-Width="4%" HeaderStyle-Width="4%" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="passengername" HeaderText="Name" ItemStyle-Width="8%" HeaderStyle-Width="8%" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="sector" HeaderText="Sector" ItemStyle-Width="8%" HeaderStyle-Width="8%" ReadOnly="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings AllowKeyboardNavigation="True">
                                            <KeyboardNavigationSettings AllowActiveRowCycle="true" />
                                            <Selecting AllowRowSelect="true" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                            <ClientEvents OnBatchEditCellValueChanged="BatchEditCellValueChanged" OnUserAction="userAction" OnGridCreated="gridCreated" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </asp:Panel>
                            </div>
                            <div class="row">
                                <div class="col-lg-1 col-lg-offset-3">
                                    <label style="font-size: larger">Total:</label>
                                </div>
                                <div class="col-lg-4">
                                    <div class="col-lg-4">
                                        <input style="background-color: orange" type="text" runat="server" id="Text5" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                    <div class="col-lg-4">
                                        <input style="background-color: orange" type="text" runat="server" id="Text6" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                    <div class="col-lg-4">
                                        <input style="background-color: saddlebrown; color: white" type="text" runat="server" id="Text7" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">
                            Close</button>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="decisionpopup" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body">
                            <div class="row">
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/QuestionMark.png" Style="height: 100px; width: 100px;" /><br />
                                <label>Some Invoices are already cleared in this voucher, Delete Clearance and Re-Enter</label><br />
                                <asp:Button ID="YesBtn" OnClick="YesBtn_Click" class="btn btn-primary" runat="server" Text="Yes" />
                                <button type="button" class="btn btn-danger" data-dismiss="modal">
                                    Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="ticketAlertPopup" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body">
                            <div class="row">
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/warning.png" Style="height: 100px; width: 110px;" /><br />
                                <label>Sorry, the ticket number you entered was not found in your Coffers account. </label>
                                <br />
                                <label>To process a refund/credit note, please proceed with manual entries. </label>
                                <br />
                                <label>Click 'Proceed Manually' below to continue</label><br />
                                <button type="button" class="btn btn-danger" data-dismiss="modal">
                                    Proceed Manually</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="alertPopup" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body">
                            <div class="row">
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/warning.png" Style="height: 100px; width: 110px;" /><br />
                                <label>No Record Exists. Please click on ‘Add New Refund’ to start posting.</label><br />
                                <button type="button" class="btn btn-danger" data-dismiss="modal">
                                    Proceed Manually</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="deletepopuprfd" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body">
                            <div class="row">
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/warning.png" Style="height: 100px; width: 100px;" /><br />
                                <label>Are you sure you want to delete this Refund?</label><br />
                                <asp:Button ID="Yesrfd" OnClick="Yesrfd_Click" class="btn btn-primary" runat="server" Text="Yes" />
                                <button type="button" class="btn btn-danger" data-dismiss="modal">
                                    No</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="searchPopup" class="modal fade" role="dialog">
            <div class="modal-dialog" style="background-color: #f4f7f7">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <center>
                            <h4>Search Refund
                            </h4>
                        </center>
                    </div>
                    <div class="modal-body" style="width: 600px">
                        <div class="panel-body">
                            <div class="row">
                                <label>Refund No</label>
                                <input type="number" runat="server" id="invoiceSearch" clientidmode="Static" class="form-control" /><br />
                                <input name="searchOK" id="searchOK" value="OK" class="btn btn-primary" title="Search Refund" type="button">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>

    <center>
        <div id="NoExistPopup" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body">
                            <div class="row">
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/warning.png" Style="height: 100px; width: 100px;" /><br />
                                <label>The Refund number you entered does not exists.</label><br />
                                <button type="button" class="btn btn-danger" data-dismiss="modal">
                                    Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <script type="text/javascript">

        function ShowPopup() {
            jQuery.noConflict();
            $('#MyPopup').modal('show');
        }
        function ShowPopup1() {
            jQuery.noConflict();
            $('#MyPopup1').modal('show');
        }

        function showsuccesspopup() {
            jQuery.noConflict();
            $('#successpopup').modal('show');
        }
        function showdecisionpopup() {
            jQuery.noConflict();
            $('#decisionpopup').modal('show');
        }
        function ticketAlertPopup() {
            jQuery.noConflict();
            $('#ticketAlertPopup').modal('show');
        }
        function alertPopup() {
            jQuery.noConflict();
            $('#alertPopup').modal('show');
        }
        function showdeletepopuprfd() {
            jQuery.noConflict();
            $('#deletepopuprfd').modal('show');
        }
        var balance = "";
        var count = 0;
        function rowSelectedClearance(sender, args) {
            count++;
            var grid = $find('<%= RadGrid2.ClientID %>');
            var masterTable = grid.get_masterTableView();
            var item = masterTable.get_dataItems()[args.get_itemIndexHierarchical()];
            var cell2 = masterTable.getCellByColumnUniqueName(item, "credit");
            if (count == 1) {
                var cell = masterTable.getCellByColumnUniqueName(item, "balance");
                balance = $telerik.$(cell).text().trim();
                $telerik.$(cell).text("");
            }
            var credit = $telerik.$(cell2).text(balance);
        }
    </script>
</asp:Content>
