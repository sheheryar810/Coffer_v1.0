<%@ Page Language="C#" Title="Normal Invoice" AutoEventWireup="true" ValidateRequest="false" EnableEventValidation="false" CodeBehind="~/NormalInvoice.aspx.cs" MasterPageFile="~/Site.Master" Inherits="Coffer_Systems.NormalInvoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <head>
        <title></title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link href="assets/css/StyleSheet1.css" rel="stylesheet" />
        <!-- GOOGLE FONTS-->
                        <link href="styles/loader.css" rel="stylesheet" />

        <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
        <link href="Content/fontawesome.min.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js" type="text/javascript"></script>

        <script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" defer></script>
        <script src="assets/js/datatables.js"></script>

        <script type="text/javascript">

            $(document).keypress(function (e) {
                //Check which key is pressed on the document or window
                if (e.which == 13) {
                    // if it is 13 that means enter key pressed, then call the function to cancel the event
                    e.preventDefault();
                }
            });

            function showsuccesspopup1() {
                jQuery.noConflict();
                $('#successpopup1').modal('show');
            }

            function conflictPopup() {
                jQuery.noConflict();
                $('#conflictPopup').modal('show');
            }

            function addDashes(f) {
                f.value = f.value.replace(/(\d{3})(\d{4})(\d{6})/, "$1-$2-$3").slice(0,15);
                var tkt = document.getElementById('<%=tktno.ClientID%>').value;
                tkt = "2310" + tkt.substr(0, 3);
                document.getElementById('<%=airlinecode.ClientID%>').value = tkt;
                document.getElementById('<%=airlineDropDownList.ClientID%>').value = tkt;
                document.getElementById('<%=airlineDropDownListTemp.ClientID%>').value = tkt;
            }

            function addDashes1(f) {
                f.value = f.value.replace(/(\d{3})(\d{4})(\d{6})/, "$1-$2-$3").slice(0, 15);
                var tkt = document.getElementById('<%=tktno1.ClientID%>').value;
                tkt = "2310" + tkt.substr(0, 3);
                document.getElementById('<%=airlinecode1.ClientID%>').value = tkt;
                document.getElementById('<%=airlineDropDownList1.ClientID%>').value = tkt;
                document.getElementById('<%=airlineDropDownListTemp1.ClientID%>').value = tkt;
            }

            function getinvoiceDataTotal(offset) {
                $.ajax({
                    url: 'WebExpenses.asmx/GetInvoiceDataTotal',
                    method: 'POST',
                    dataType: 'json',
                    data: { offset: offset },
                    success: function (data) {
                        document.getElementById('<%=utkb.ClientID%>').value = data[0].kb;
                        document.getElementById('<%=utcomm.ClientID%>').value = data[0].comm;
                        document.getElementById('<%=utwhair.ClientID%>').value = data[0].whair;
                        document.getElementById('<%=utwhclient.ClientID%>').value = data[0].whclient;
                        document.getElementById('<%=utotherpay.ClientID%>').value = data[0].otherpayable;
                        document.getElementById('<%=utpl.ClientID%>').value = data[0].profitloss;
                        document.getElementById('<%=uttfare.ClientID%>').value = data[0].fare;
                        document.getElementById('<%=utttax.ClientID%>').value = data[0].tax;
                        document.getElementById('<%=uttother.ClientID%>').value = data[0].other;
                        document.getElementById('<%=uttsp.ClientID%>').value = data[0].sp;
                        document.getElementById('<%=uttrcv.ClientID%>').value = data[0].receivable;
                        document.getElementById('<%=uttpay.ClientID%>').value = data[0].payable;
                        document.getElementById('<%=utkb1.ClientID%>').value = data[0].kb;
                        document.getElementById('<%=utcomm1.ClientID%>').value = data[0].comm;
                        document.getElementById('<%=utwhair1.ClientID%>').value = data[0].whair;
                        document.getElementById('<%=utwhclient1.ClientID%>').value = data[0].whclient;
                        document.getElementById('<%=utotherpay1.ClientID%>').value = data[0].otherpayable;
                        document.getElementById('<%=utpl1.ClientID%>').value = data[0].profitloss;
                        document.getElementById('<%=uttfare1.ClientID%>').value = data[0].fare;
                        document.getElementById('<%=utttax1.ClientID%>').value = data[0].tax;
                        document.getElementById('<%=uttother1.ClientID%>').value = data[0].other;
                        document.getElementById('<%=uttsp1.ClientID%>').value = data[0].sp;
                        document.getElementById('<%=uttrcv1.ClientID%>').value = data[0].receivable;
                        document.getElementById('<%=uttpay1.ClientID%>').value = data[0].payable;
                    },
                    error: function () {
                    }
                });
            }
            function editBtn() {
                document.getElementById('<%=EditButton.ClientID %>').style.display = 'none';
                document.getElementById('<%=AddButton.ClientID %>').style.display = 'block';

            }
        </script>
        <script>
            var whcount = 0;
            var whcount1 = 0;
            function calculate() {

                var iata = parseFloat(document.getElementById('<%=iata.ClientID%>').value || 0);
                var mkt = parseFloat(document.getElementById('<%=mkt.ClientID%>').value || 0);
                var otherfare = parseFloat(document.getElementById('<%=otherfare.ClientID%>').value || 0);
                var soto = parseFloat(document.getElementById('<%=soto.ClientID%>').value || 0);
                var sp = parseFloat(document.getElementById('<%=sp.ClientID%>').value || 0);
                var yd = parseFloat(document.getElementById('<%=yd.ClientID%>').value || 0);
                var pk = parseFloat(document.getElementById('<%=pk.ClientID%>').value || 0);
                var fed = parseFloat(document.getElementById('<%=fed.ClientID%>').value || 0);
                var ced = parseFloat(document.getElementById('<%=ced.ClientID%>').value || 0);
                var xz = parseFloat(document.getElementById('<%=xz.ClientID%>').value || 0);
                var whclient = parseFloat(document.getElementById('<%=whclient.ClientID%>').value || 0);
                var yq = parseFloat(document.getElementById('<%=yq.ClientID%>').value || 0);
                var pb = parseFloat(document.getElementById('<%=pb.ClientID%>').value || 0);
                var oth = parseFloat(document.getElementById('<%=oth.ClientID%>').value || 0);
                var extra = parseFloat(document.getElementById('<%=extra.ClientID%>').value || 0);
                var ins = parseFloat(document.getElementById('<%=ins.ClientID%>').value || 0);
                var service = parseFloat(document.getElementById('<%=srvc.ClientID%>').value || 0);
                var disc = parseFloat(document.getElementById('<%=disc.ClientID%>').value || 0);
                var discadj = parseFloat(document.getElementById('<%=discadj.ClientID%>').value || 0);
                var discamt = parseFloat(document.getElementById('<%=discamt.ClientID%>').value || 0);
                var gstper = parseFloat(document.getElementById('<%=gstText.ClientID%>').value || 0);
                var comm = parseFloat(document.getElementById('<%=comm.ClientID%>').value || 0);
                var comadj = parseFloat(document.getElementById('<%=comadj.ClientID%>').value || 0);
                var comamt = parseFloat(document.getElementById('<%=comamt.ClientID%>').value || 0);
                var kbcust = parseFloat(document.getElementById('<%=kbcust.ClientID%>').value || 0);
                var kb = parseFloat(document.getElementById('<%=kbairline.ClientID%>').value || 0);
                var serviceamount = parseFloat(document.getElementById('<%=srvcamt.ClientID%>').value || 0);
                var tcomm = comadj + comamt;
                document.getElementById('<%=tcom.ClientID%>').value = parseFloat(tcomm).toFixed(2);

                if (whcount == 0) {
                    var whairlines = (((mkt * comm) / 100) * 12) / 100;
                    document.getElementById('<%=whairline.ClientID%>').value = parseFloat(whairlines).toFixed(2);
                }
                var whairline = parseFloat(document.getElementById('<%=whairline.ClientID%>').value || 0);

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
                var gstpayable = parseFloat(document.getElementById('<%=gstpay.ClientID%>').value || 0);
                var gst = parseFloat(document.getElementById('<%=gstText.ClientID%>').value || 0);
                var srvct = 0;
                if (service != "") {
                    srvct = (service * mkt) / 100;
                } else if (serviceamount) {
                    srvct = serviceamount;
                }
                var gstpay = 0;
                gstpay = ((srvct * gst) / 100);
                var disct = ((disc * mkt) / 100) + discadj;
                var extracom = (otherfare * extra) / 100;
                var totalcom = extracom + tcom;
                var total = mkt + otherfare + soto;
                var taxes = sp + yd + pk + fed + xz + whairline + yq + pb + oth;
                var ticketvalue = taxes + mkt;
                var totaltaxes = taxes + total;
                var clientr = totaltaxes - whairline + whclient + ins + srvct - disct + gstpay - kbcust;
                var airlinep = totaltaxes - kb - totalcom;
                var profitloss = clientr - airlinep;
                document.getElementById('<%=srvcamt.ClientID%>').value = Math.round(parseFloat(srvct).toFixed(2));
                document.getElementById('<%=frtx.ClientID%>').value = Math.round(parseFloat(totaltaxes).toFixed(2));
                document.getElementById('<%=tax.ClientID%>').value = Math.round(parseFloat(taxes).toFixed(2));
                document.getElementById('<%=tktvalue.ClientID%>').value = Math.round(parseFloat(ticketvalue).toFixed(2));
                document.getElementById('<%=clientreceivable.ClientID%>').value = Math.round(parseFloat(clientr).toFixed(2));
                document.getElementById('<%=airlinepayable.ClientID%>').value = Math.round(parseFloat(airlinep).toFixed(2));
                document.getElementById('<%=plothers.ClientID%>').value = Math.round(parseFloat(profitloss).toFixed(2));
                document.getElementById('<%=discamt.ClientID%>').value = Math.round(parseFloat(disct).toFixed(2));
                document.getElementById('<%=gstpay.ClientID%>').value = Math.round(parseFloat(gstpay).toFixed(2));
                document.getElementById('<%=extcom.ClientID%>').value = Math.round(parseFloat(extracom).toFixed(2));
                document.getElementById('<%=tcom.ClientID%>').value = Math.round(parseFloat(totalcom).toFixed(2));
            }
            function calculatewhairline() {
                whcount++;
                var iata = parseFloat(document.getElementById('<%=iata.ClientID%>').value || 0);
                var mkt = parseFloat(document.getElementById('<%=mkt.ClientID%>').value || 0);
                var otherfare = parseFloat(document.getElementById('<%=otherfare.ClientID%>').value || 0);
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
                var oth = parseFloat(document.getElementById('<%=oth.ClientID%>').value || 0);
                var extra = parseFloat(document.getElementById('<%=extra.ClientID%>').value || 0);
                var ins = parseFloat(document.getElementById('<%=ins.ClientID%>').value || 0);
                var service = parseFloat(document.getElementById('<%=srvc.ClientID%>').value || 0);
                var disc = parseFloat(document.getElementById('<%=disc.ClientID%>').value || 0);
                var discadj = parseFloat(document.getElementById('<%=discadj.ClientID%>').value || 0);
                var discamt = parseFloat(document.getElementById('<%=discamt.ClientID%>').value || 0);
                var gstper = parseFloat(document.getElementById('<%=gstText.ClientID%>').value || 0);
                var comm = parseFloat(document.getElementById('<%=comm.ClientID%>').value || 0);
                var comadj = parseFloat(document.getElementById('<%=comadj.ClientID%>').value || 0);
                var comamt = parseFloat(document.getElementById('<%=comamt.ClientID%>').value || 0);
                var kbcust = parseFloat(document.getElementById('<%=kbcust.ClientID%>').value || 0);
                var kb = parseFloat(document.getElementById('<%=kbairline.ClientID%>').value || 0);
                var gstpay = parseFloat(document.getElementById('<%=gstpay.ClientID%>').value || 0);

                var total = mkt + otherfare + soto;
                var taxes = sp + yd + pk + fed + xz + whairline + yq + pb + oth;
                var ticketvalue = taxes + mkt;
                var totaltaxes = taxes + total;
                var clientr = totaltaxes - whairline + whclient + ins + service - discamt + gstpay - kbcust;
                var airlinep = totaltaxes - kb - comamt;
                var profitloss = clientr - airlinep;
                document.getElementById('<%=frtx.ClientID%>').value = Math.round(parseFloat(totaltaxes).toFixed(2));
                document.getElementById('<%=tax.ClientID%>').value = Math.round(parseFloat(taxes).toFixed(2));
                document.getElementById('<%=tktvalue.ClientID%>').value = Math.round(parseFloat(ticketvalue).toFixed(2));
                document.getElementById('<%=clientreceivable.ClientID%>').value = Math.round(parseFloat(clientr).toFixed(2));
                document.getElementById('<%=airlinepayable.ClientID%>').value = Math.round(parseFloat(airlinep).toFixed(2));
                document.getElementById('<%=plothers.ClientID%>').value = Math.round(parseFloat(profitloss).toFixed(2));

            }

            function calculate1() {

                var iata = parseFloat(document.getElementById('<%=iata1.ClientID%>').value || 0);
                var mkt = parseFloat(document.getElementById('<%=mkt1.ClientID%>').value || 0);
                var otherfare = parseFloat(document.getElementById('<%=otherfare1.ClientID%>').value || 0);
                var soto = parseFloat(document.getElementById('<%=soto1.ClientID%>').value || 0);
                var sp = parseFloat(document.getElementById('<%=sp1.ClientID%>').value || 0);
                var yd = parseFloat(document.getElementById('<%=yd1.ClientID%>').value || 0);
                var pk = parseFloat(document.getElementById('<%=pk1.ClientID%>').value || 0);
                var fed = parseFloat(document.getElementById('<%=fed1.ClientID%>').value || 0);
                var ced = parseFloat(document.getElementById('<%=ced1.ClientID%>').value || 0);
                var xz = parseFloat(document.getElementById('<%=xz1.ClientID%>').value || 0);
                var whclient = parseFloat(document.getElementById('<%=whclient1.ClientID%>').value || 0);
                var yq = parseFloat(document.getElementById('<%=yq1.ClientID%>').value || 0);
                var pb = parseFloat(document.getElementById('<%=pb1.ClientID%>').value || 0);
                var oth = parseFloat(document.getElementById('<%=oth1.ClientID%>').value || 0);
                var extra = parseFloat(document.getElementById('<%=extra1.ClientID%>').value || 0);
                var ins = parseFloat(document.getElementById('<%=ins1.ClientID%>').value || 0);
                var service = parseFloat(document.getElementById('<%=srvc1.ClientID%>').value || 0);
                var disc = parseFloat(document.getElementById('<%=disc1.ClientID%>').value || 0);
                var discadj = parseFloat(document.getElementById('<%=discadj1.ClientID%>').value || 0);
                var discamt = parseFloat(document.getElementById('<%=discamt1.ClientID%>').value || 0);
                var gstper = parseFloat(document.getElementById('<%=gstText1.ClientID%>').value || 0);
                var comm = parseFloat(document.getElementById('<%=comm1.ClientID%>').value || 0);
                var comadj = parseFloat(document.getElementById('<%=comadj1.ClientID%>').value || 0);
                var comamt = parseFloat(document.getElementById('<%=comamt1.ClientID%>').value || 0);
                var kbcust = parseFloat(document.getElementById('<%=kbcust1.ClientID%>').value || 0);
                var kb = parseFloat(document.getElementById('<%=kbairline1.ClientID%>').value || 0);
                var serviceamount = parseFloat(document.getElementById('<%=srvcamt1.ClientID%>').value || 0);
                var tcomm = comadj + comamt;
                document.getElementById('<%=tcom1.ClientID%>').value = parseFloat(tcomm).toFixed(2);

                if (whcount1 == 0) {
                    var whairlines = (((mkt * comm) / 100) * 12) / 100;
                    document.getElementById('<%=whairline1.ClientID%>').value = parseFloat(whairlines).toFixed(2);
                }
                var whairline = parseFloat(document.getElementById('<%=whairline1.ClientID%>').value || 0);

                if (comadj != "") {
                    var whairl = ((((comadj * comm) / 100) * 12) / 100) + comadj / 10;
                    var twhairpay = whairl + whairline;
                    document.getElementById('<%=whairline1.ClientID%>').value = parseFloat(twhairpay).toFixed(2);
                }
                if (extra != "") {
                    var whairp = parseFloat(document.getElementById('<%=whairline1.ClientID%>').value || 0);
                    var whair = (((otherfare * extra) / 100) * 12) / 100;
                    var twhairp = whair + whairp;
                    document.getElementById('<%=whairline1.ClientID%>').value = parseFloat(twhairp).toFixed(2);
                }

                var totalcommission = (mkt * comm) / 100;
                document.getElementById('<%=tcom1.ClientID%>').value = parseFloat(totalcommission).toFixed(2);
                document.getElementById('<%=comamt1.ClientID%>').value = parseFloat(totalcommission).toFixed(2);
                var tcom = parseFloat(document.getElementById('<%=tcom1.ClientID%>').value || 0);
                var gstpayable = parseFloat(document.getElementById('<%=gstpay1.ClientID%>').value || 0);
                var gst = parseFloat(document.getElementById('<%=gstText1.ClientID%>').value || 0);
                var srvct = 0;
                if (service != "") {
                    srvct = (service * mkt) / 100;
                } else if (serviceamount) {
                    srvct = serviceamount;
                }
                var gstpay = 0;
                gstpay = ((srvct * gst) / 100);
                var disct = ((disc * mkt) / 100) + discadj;
                var extracom = (otherfare * extra) / 100;
                var totalcom = extracom + tcom;
                var total = mkt + otherfare + soto;
                var taxes = sp + yd + pk + fed + xz + whairline + yq + pb + oth;
                var ticketvalue = taxes + mkt;
                var totaltaxes = taxes + total;
                var clientr = totaltaxes - whairline + whclient + ins + srvct - disct + gstpay - kbcust;
                var airlinep = totaltaxes - kb - totalcom;
                var profitloss = clientr - airlinep;
                document.getElementById('<%=srvcamt1.ClientID%>').value = Math.round(parseFloat(srvct).toFixed(2));
                document.getElementById('<%=frtx1.ClientID%>').value = Math.round(parseFloat(totaltaxes).toFixed(2));
                document.getElementById('<%=tax1.ClientID%>').value = Math.round(parseFloat(taxes).toFixed(2));
                document.getElementById('<%=tktvalue1.ClientID%>').value = Math.round(parseFloat(ticketvalue).toFixed(2));
                document.getElementById('<%=clientreceivable1.ClientID%>').value = Math.round(parseFloat(clientr).toFixed(2));
                document.getElementById('<%=airlinepayable1.ClientID%>').value = Math.round(parseFloat(airlinep).toFixed(2));
                document.getElementById('<%=plother1.ClientID%>').value = Math.round(parseFloat(profitloss).toFixed(2));
                document.getElementById('<%=discamt1.ClientID%>').value = Math.round(parseFloat(disct).toFixed(2));
                document.getElementById('<%=gstpay1.ClientID%>').value = Math.round(parseFloat(gstpay).toFixed(2));
                document.getElementById('<%=extcom1.ClientID%>').value = Math.round(parseFloat(extracom).toFixed(2));
                document.getElementById('<%=tcom1.ClientID%>').value = Math.round(parseFloat(totalcom).toFixed(2));
            }
            function calculatewhairline1() {
                whcount1++;
                var iata = parseFloat(document.getElementById('<%=iata1.ClientID%>').value || 0);
                var mkt = parseFloat(document.getElementById('<%=mkt1.ClientID%>').value || 0);
                var otherfare = parseFloat(document.getElementById('<%=otherfare1.ClientID%>').value || 0);
                var soto = parseFloat(document.getElementById('<%=soto1.ClientID%>').value || 0);
                var sp = parseFloat(document.getElementById('<%=sp1.ClientID%>').value || 0);
                var yd = parseFloat(document.getElementById('<%=yd1.ClientID%>').value || 0);
                var pk = parseFloat(document.getElementById('<%=pk1.ClientID%>').value || 0);
                var fed = parseFloat(document.getElementById('<%=fed1.ClientID%>').value || 0);
                var ced = parseFloat(document.getElementById('<%=ced1.ClientID%>').value || 0);
                var xz = parseFloat(document.getElementById('<%=xz1.ClientID%>').value || 0);
                var whairline = parseFloat(document.getElementById('<%=whairline1.ClientID%>').value || 0);
                var whclient = parseFloat(document.getElementById('<%=whclient1.ClientID%>').value || 0);
                var yq = parseFloat(document.getElementById('<%=yq1.ClientID%>').value || 0);
                var pb = parseFloat(document.getElementById('<%=pb1.ClientID%>').value || 0);
                var oth = parseFloat(document.getElementById('<%=oth1.ClientID%>').value || 0);
                var extra = parseFloat(document.getElementById('<%=extra1.ClientID%>').value || 0);
                var ins = parseFloat(document.getElementById('<%=ins1.ClientID%>').value || 0);
                var service = parseFloat(document.getElementById('<%=srvc1.ClientID%>').value || 0);
                var disc = parseFloat(document.getElementById('<%=disc1.ClientID%>').value || 0);
                var discadj = parseFloat(document.getElementById('<%=discadj1.ClientID%>').value || 0);
                var discamt = parseFloat(document.getElementById('<%=discamt1.ClientID%>').value || 0);
                var gstper = parseFloat(document.getElementById('<%=gstText1.ClientID%>').value || 0);
                var comm = parseFloat(document.getElementById('<%=comm1.ClientID%>').value || 0);
                var comadj = parseFloat(document.getElementById('<%=comadj1.ClientID%>').value || 0);
                var comamt = parseFloat(document.getElementById('<%=comamt1.ClientID%>').value || 0);
                var kbcust = parseFloat(document.getElementById('<%=kbcust1.ClientID%>').value || 0);
                var kb = parseFloat(document.getElementById('<%=kbairline1.ClientID%>').value || 0);
                var gstpay = parseFloat(document.getElementById('<%=gstpay1.ClientID%>').value || 0);

                var total = mkt + otherfare + soto;
                var taxes = sp + yd + pk + fed + xz + whairline + yq + pb + oth;
                var ticketvalue = taxes + mkt;
                var totaltaxes = taxes + total;
                var clientr = totaltaxes - whairline + whclient + ins + service - discamt + gstpay - kbcust;
                var airlinep = totaltaxes - kb - comamt;
                var profitloss = clientr - airlinep;
                document.getElementById('<%=frtx1.ClientID%>').value = Math.round(parseFloat(totaltaxes).toFixed(2));
                document.getElementById('<%=tax1.ClientID%>').value = Math.round(parseFloat(taxes).toFixed(2));
                document.getElementById('<%=tktvalue1.ClientID%>').value = Math.round(parseFloat(ticketvalue).toFixed(2));
                document.getElementById('<%=clientreceivable1.ClientID%>').value = Math.round(parseFloat(clientr).toFixed(2));
                document.getElementById('<%=airlinepayable1.ClientID%>').value = Math.round(parseFloat(airlinep).toFixed(2));
                document.getElementById('<%=plother1.ClientID%>').value = Math.round(parseFloat(profitloss).toFixed(2));

            }

            function delBtn() {
                ////////document.getElementById('<%=tktno.ClientID%>').value = "0";
                document.getElementById('<%=tktno1.ClientID%>').value = "0";
                //document.getElementById('<%=othtktno.ClientID%>').value = "0";

            }
            function newBtn() {
                document.getElementById('<%=tktno.ClientID%>').value = "";
                document.getElementById('<%=tktno1.ClientID%>').value = "0";
                //document.getElementById('<%=othtktno.ClientID%>').value = "0";

                $("#tktno").prop("readonly", false);
                $("#modeDropDownList").prop("disabled", false);
                document.getElementById('<%=EditButton.ClientID %>').style.display = 'none';
                document.getElementById('<%=AddButton.ClientID %>').style.display = 'block';

                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                document.getElementById("invDate").value = today;
                document.getElementById("postDate").value = today;
                document.getElementById("deptDate").value = today;
                document.getElementById('<%=invType.ClientID%>').value = "";
                document.getElementById('<%=ccode.ClientID%>').value = "";
                document.getElementById('<%=customerDropDownList.ClientID%>').value = "";
                document.getElementById('<%=airlinecode.ClientID%>').value = "";
                document.getElementById('<%=airlineDropDownList.ClientID%>').value = "";
                document.getElementById('<%=airlineDropDownListTemp.ClientID%>').value = "";
                document.getElementById('<%=invt.ClientID%>').value = "";
                document.getElementById('<%=invR.ClientID%>').value = "";
                document.getElementById('<%=altn.ClientID%>').value = "";
                document.getElementById('<%=tktt.ClientID%>').value = "";
                document.getElementById('<%=xo.ClientID%>').value = "";
                document.getElementById('<%=status.ClientID%>').value = "";
                document.getElementById('<%=passname.ClientID%>').value = "";
                document.getElementById('<%=sector.ClientID%>').value = "";
                document.getElementById('<%=fare.ClientID%>').value = "";
                document.getElementById('<%=@class.ClientID%>').value = "";
                document.getElementById('<%=pnr.ClientID%>').value = "";
                document.getElementById('<%=cBalance.ClientID%>').value = "";
                document.getElementById('<%=cLimit.ClientID%>').value = "";
                document.getElementById('<%=iata.ClientID%>').value = "";
                document.getElementById('<%=mkt.ClientID%>').value = "";
                document.getElementById('<%=otherfare.ClientID%>').value = "";
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
                document.getElementById('<%=oth.ClientID%>').value = "";
                document.getElementById('<%=tax.ClientID%>').value = "";
                document.getElementById('<%=frtx.ClientID%>').value = "";
                document.getElementById('<%=comm.ClientID%>').value = "";
                document.getElementById('<%=comamt.ClientID%>').value = "";
                document.getElementById('<%=comadj.ClientID%>').value = "";
                document.getElementById('<%=tcom.ClientID%>').value = "";
                document.getElementById('<%=srvc.ClientID%>').value = "";
                document.getElementById('<%=srvcamt.ClientID%>').value = "";
                document.getElementById('<%=gstpay.ClientID%>').value = "";
                document.getElementById('<%=ins.ClientID%>').value = "";
                document.getElementById('<%=kbairline.ClientID%>').value = "";
                document.getElementById('<%=kbcust.ClientID%>').value = "";
                document.getElementById('<%=kbcomm.ClientID%>').value = "";
                document.getElementById('<%=disc.ClientID%>').value = "";
                document.getElementById('<%=discamt.ClientID%>').value = "";
                document.getElementById('<%=discadj.ClientID%>').value = "";
                document.getElementById('<%=gds.ClientID%>').value = "";
                document.getElementById('<%=fcDropDown.ClientID%>').value = "";
                document.getElementById('<%=fcp.ClientID%>').value = "";
                document.getElementById('<%=fcr.ClientID%>').value = "";
                document.getElementById('<%=airlinepayable.ClientID%>').value = "";
                document.getElementById('<%=clientreceivable.ClientID%>').value = "";
                document.getElementById('<%=otherpayable.ClientID%>').value = "";
                document.getElementById('<%=plothers.ClientID%>').value = "";
                document.getElementById('<%=tktvalue.ClientID%>').value = "";
                document.getElementById('<%=passcnic.ClientID%>').value = "";
                document.getElementById('<%=rcpt.ClientID%>').value = "";
                document.getElementById('<%=utkb.ClientID%>').value = "";
                document.getElementById('<%=utcomm.ClientID%>').value = "";
                document.getElementById('<%=utwhair.ClientID%>').value = "";
                document.getElementById('<%=utwhclient.ClientID%>').value = "";
                document.getElementById('<%=utotherpay.ClientID%>').value = "";
                document.getElementById('<%=utpl.ClientID%>').value = "";
                document.getElementById('<%=uttfare.ClientID%>').value = "";
                document.getElementById('<%=utttax.ClientID%>').value = "";
                document.getElementById('<%=uttother.ClientID%>').value = "";
                document.getElementById('<%=uttsp.ClientID%>').value = "";
                document.getElementById('<%=uttrcv.ClientID%>').value = "";
                document.getElementById('<%=uttpay.ClientID%>').value = "";
                document.getElementById('<%=utkb1.ClientID%>').value = "";
                document.getElementById('<%=utcomm1.ClientID%>').value = "";
                document.getElementById('<%=utwhair1.ClientID%>').value = "";
                document.getElementById('<%=utwhclient1.ClientID%>').value = "";
                document.getElementById('<%=utotherpay1.ClientID%>').value = "";
                document.getElementById('<%=utpl1.ClientID%>').value = "";
                document.getElementById('<%=uttfare1.ClientID%>').value = "";
                document.getElementById('<%=utttax1.ClientID%>').value = "";
                document.getElementById('<%=uttother1.ClientID%>').value = "";
                document.getElementById('<%=uttsp1.ClientID%>').value = "";
                document.getElementById('<%=uttrcv1.ClientID%>').value = "";
                document.getElementById('<%=uttpay1.ClientID%>').value = "";

                document.getElementById('<%=othccode.ClientID%>').value = "";
                document.getElementById('<%=customerDropDownListOth.ClientID%>').value = "";
                document.getElementById('<%=passenger.ClientID%>').value = "";
                document.getElementById('<%=descriptionOth.ClientID%>').value = "";
                document.getElementById('<%=visarcv.ClientID%>').value = "";
                document.getElementById('<%=accomo1rcv.ClientID%>').value = "";
                document.getElementById('<%=accomo2rcv.ClientID%>').value = "";
                document.getElementById('<%=trnsrcv.ClientID%>').value = "";
                document.getElementById('<%=zrtrcv.ClientID%>').value = "";
                document.getElementById('<%=foodrcv.ClientID%>').value = "";
                document.getElementById('<%=otherrcv.ClientID%>').value = "";
                document.getElementById('<%=totalrcv.ClientID%>').value = "";
                document.getElementById('<%=trcv.ClientID%>').value = "";
                document.getElementById('<%=tpay.ClientID%>').value = "";
                document.getElementById('<%=tpl.ClientID%>').value = "";
                document.getElementById('<%=tpayable.ClientID%>').value = "";
                document.getElementById('<%=description.ClientID%>').value = "";
                document.getElementById('<%=othpassportno.ClientID%>').value = "";
            }

            function addmore() {

                if (document.getElementById('<%=tktno.ClientID%>').value == "") {
                    document.getElementById('<%=tktno.ClientID%>').value = "0";
                }
                //document.getElementById('<%=tktno1.ClientID%>').value = "0";
                //document.getElementById('<%=othtktno.ClientID%>').value = "0";

                jQuery.noConflict();
                $('#AttachPopup').modal('show');
            }
        </script>
        <script type="text/javascript"> 
            var offset = 0;

            $(document).ready(function () {

                ////////document.getElementById('<%=othtktno.ClientID%>').value = "0";
                document.getElementById('<%=tktno.ClientID%>').value = "0";
                document.getElementById('<%=tktno1.ClientID%>').value = "0";
                document.getElementById('<%=EditButton.ClientID %>').style.display = 'none';

                $('#modeDropDownList').change(function () {
                    var mdd = $('#modeDropDownList').val();
                    if (mdd == "other") {

                        var a = "OTH";
                        const aa = 1000;
                        const ab = 9999;
                        const ba = 100000;
                        const bb = 999999;
                        const aaa = Math.random() * (ab - aa + 1);
                        const bbb = Math.random() * (bb - ba + 1);
                        const other = a + "-" + Math.ceil(aaa) + "-" + Math.ceil(bbb);
                        document.getElementById('<%=tktno.ClientID%>').value = other;
                        document.getElementById('<%=othtktno.ClientID%>').value = other;
                        document.getElementById('<%=othertkt.ClientID%>').value = other;
                        jQuery.noConflict();
                        $('#OthPopup').modal('show');
                    }
                    else if (mdd == "pnr") {
                        var a = "PNR";
                        const aa = 1000;
                        const ab = 9999;
                        const ba = 100000;
                        const bb = 999999;
                        const aaa = Math.random() * (ab - aa + 1);
                        const bbb = Math.random() * (bb - ba + 1);
                        const pnr = a + "-" + Math.ceil(aaa) + "-" + Math.ceil(bbb);
                        document.getElementById('<%=tktno.ClientID%>').value = pnr;
                    }
                });

                $('#customerDropDownList').change(function () {
                    var cdd = $('#customerDropDownList').val();
                    document.getElementById('<%=ccode.ClientID%>').value = parseFloat(cdd);
                });
                $('#tktt').change(function () {
                    var cdd = $('#tktt').val();
                    if (cdd == "Domestic") {
                        $("#iata").prop("disabled", true);
                    } else {
                        $("#iata").prop("disabled", false);
                    }
                });
                $('#tktt1').change(function () {
                    var cdd = $('#tktt1').val();
                    if (cdd == "Domestic") {
                        $("#iata1").prop("disabled", true);
                    } else {
                        $("#iata1").prop("disabled", false);
                    }
                });
                $('#conjDropDownList').change(function () {
                    var cdd = $('#conjDropDownList').val();
                    if (cdd == "Y") {
                        var tkt = document.getElementById('<%=tktno.ClientID%>').value;
                        document.getElementById('<%=altn.ClientID%>').value = tkt.substr(0, 13);
                    } else {
                        document.getElementById('<%=altn.ClientID%>').value = "";
                    }
                });
                $('#fixDropDown').change(function () {
                    var cdd = $('#fixDropDown').val();
                    if (cdd == "Yes") {
                        $("#whairline").prop("readonly", true);
                    } else {
                        $("#whairline").prop("readonly", false);
                    }
                });
                $('#conjDropDownList1').change(function () {
                    var cdd = $('#conjDropDownList1').val();
                    if (cdd == "Y") {
                        var tkt = document.getElementById('<%=tktno1.ClientID%>').value;
                        document.getElementById('<%=altn1.ClientID%>').value = tkt.substr(0, 13);
                    } else {
                        document.getElementById('<%=altn1.ClientID%>').value = "";
                    }
                });
                $('#fixDropDown1').change(function () {
                    var cdd = $('#fixDropDown1').val();
                    if (cdd == "Yes") {
                        $("#whairline1").prop("readonly", true);
                    } else {
                        $("#whairline1").prop("readonly", false);
                    }
                });
                $('#customerDropDownList1').change(function () {
                    var cdd = $('#customerDropDownList1').val();
                    document.getElementById('<%=ccode1.ClientID%>').value = parseFloat(cdd);
                });
                $('#customerDropDownListOth').change(function () {
                    var cdd = $('#customerDropDownListOth').val();
                    document.getElementById('<%=othccode.ClientID%>').value = parseFloat(cdd);
                    document.getElementById('<%=ccode.ClientID%>').value = parseFloat(cdd);
                    document.getElementById('<%=customerDropDownList.ClientID%>').value = parseFloat(cdd);
                });
                $('#airlineDropDownList').change(function () {
                    var cdd = $('#airlineDropDownList').val();
                    document.getElementById('<%=airlinecode.ClientID%>').value = parseFloat(cdd);
                });
                $('#IncomeDropDownList').change(function () {
                    var cdd = $('#IncomeDropDownList').val();
                    document.getElementById('<%=incacname.ClientID%>').value = parseFloat(cdd);
                });
                $('#airlineDropDownList1').change(function () {
                    var cdd = $('#airlineDropDownList1').val();
                    document.getElementById('<%=airlinecode1.ClientID%>').value = parseFloat(cdd);
                });
                $('#bspDropDown').change(function () {
                    var cdd = $('#bspDropDown').val();
                    if (cdd == "Y") {
                        document.getElementById('<%=airlineDropDownList.ClientID%>').value = '2310222';
                        document.getElementById('<%=airlinecode.ClientID%>').value = '2310222';
                    }
                    else {
                        document.getElementById('<%=airlineDropDownList.ClientID%>').value = "";
                        document.getElementById('<%=airlinecode.ClientID%>').value = "";
                    }
                });
                $('#bspDropDown1').change(function () {
                    var cdd = $('#bspDropDown1').val();
                    if (cdd == "Y") {
                        document.getElementById('<%=airlineDropDownList1.ClientID%>').value = '2310222';
                        document.getElementById('<%=airlinecode1.ClientID%>').value = '2310222';
                    }
                    else {
                        document.getElementById('<%=airlineDropDownList1.ClientID%>').value = "";
                        document.getElementById('<%=airlinecode1.ClientID%>').value = "";
                    }
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
                $('#DropDownList21').change(function () {
                    var dd2 = $('#DropDownList21').val();
                    if (dd2 == 2 || dd2 == 3) {
                        $("#gst1").prop("disabled", true);
                        $("#gstpay1").prop("disabled", true);
                    } else {
                        $("#gst1").prop("disabled", false);
                        $("#gstpay1").prop("disabled", false);
                    }
                    if (dd2 == 1) {
                        $('#DropDownList11').children().hide();
                        $('#DropDownList11').children('option[value="1"]').show();
                        $('#DropDownList11').children('option[value="2"]').show();
                        $('#DropDownList11').children('option[value="3"]').show();
                    }
                    else if (dd2 == 2) {
                        $('#DropDownList11').children().hide();
                        $('#DropDownList11').children('option[value="4"]').show();
                        $('#DropDownList11').children('option[value="5"]').show();
                        $('#DropDownList11').children('option[value="6"]').show();
                    }
                    else if (dd2 == 3) {
                        $('#DropDownList11').children().hide();
                        $('#DropDownList11').children('option[value="7"]').show();
                        $('#DropDownList11').children('option[value="8"]').show();
                    }
                    else if (dd2 == 4) {
                        $('#DropDownList11').children().hide();
                        $('#DropDownList11').children('option[value="9"]').show();
                        $('#DropDownList11').children('option[value="10"]').show();
                    }
                    else if (dd2 == 6) {
                        $('#DropDownList11').children().hide();
                        $('#DropDownList11').children('option[value="12"]').show();
                    }
                    else if (dd2 == 7) {
                        $('#DropDownList11').children().hide();
                        $('#DropDownList11').children('option[value="13"]').show();
                    }
                    else if (dd2 == 8) {
                        $('#DropDownList11').children().hide();
                        $('#DropDownList11').children('option[value="14"]').show();
                    }
                    else if (dd2 == 9) {
                        $('#DropDownList11').children().hide();
                        $('#DropDownList11').children('option[value="15"]').show();
                        $('#DropDownList11').children('option[value="16"]').show();
                        $('#DropDownList11').children('option[value="17"]').show();
                    }
                });
            });
        </script>
        
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

        <style>
            .popupDialog {
                max-width: 99vw;
            }

            .form-control {
                font-size: 10px !important;
                height: 25px !important;
            }
        </style>
    </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <div id="loader-overlay" class="loader-overlay" style="display: none;">
    <div class="loader" style="justify-items:center">
        <img src="Images/Coffer.png" alt="Loading..." class="loader-logo"  loading="lazy"/>
        <div class="loader-spinner"></div>
    </div>
</div>
    <div id="page-wrapper">
        <div class="panel panel-info" style="background-color: #f4f7f7; font-size: 10px">
            <div class="panel-body">
                <div class="row" style="margin-top: 30px">
                    <div class="col-lg-1">
                        <label>Invoice #</label>
                        <input type="text" runat="server" id="invno" style="background-color: red; color: yellow; font-size: 16px !important; font-weight: bold !important" readonly clientidmode="Static" class="form-control" />
                        <input type="text" runat="server" id="othertkt" style="visibility: hidden" clientidmode="Static" class="form-control" />
                        <input type="text" runat="server" id="tblid" style="visibility: hidden" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Invoice Date</label>
                        <input type="date" runat="server" id="invDate" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Invoice Type</label><br />
                        <asp:DropDownList runat="server" ClientIDMode="Static" ID="invType" class="form-control dropdown-toggle">
                            <asp:ListItem Value="Normal (Cash)">Normal (Cash)</asp:ListItem>
                            <asp:ListItem Value="Credit/Debit Card (Merchant Machine Payment)">Credit/Debit Card (Merchant Machine Payment)</asp:ListItem>
                            <asp:ListItem Value="Online Bank Transfer">Online Bank Transfer</asp:ListItem>
                            <asp:ListItem Value="Cheque">Cheque</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-1">
                        <label>Receipt No.</label>
                        <input type="text" runat="server" id="rcpt" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Inv.Title C/O</label>
                        <input type="text" runat="server" id="invt" clientidmode="Static" class="form-control" />
                    </div>
                </div>
                <div class="row" style="margin-top: 30px">
                    <div class="col-lg-1">
                        <label>Client Code</label>
                        <input type="text" runat="server" id="ccode" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Customer Name:</label><br />
                        <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="customerDropDownList" class="form-control dropdown-toggle">
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-1">
                        <label>Current Balance</label>
                        <input type="text" style="background-color: lightgreen" runat="server" id="cBalance" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Credit Limit</label>
                        <input type="text" runat="server" style="background-color: red; color: yellow" id="cLimit" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Invoice Remarks</label>
                        <input type="text" runat="server" id="invR" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-5">
                        <label>Carrier Name</label>
                        <asp:DropDownList runat="server" Style="-webkit-appearance: none;" ClientIDMode="Static" ID="airlineDropDownListTemp" class="form-control dropdown-toggle">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="row" style="margin-top: 30px">
                    <div class="col-lg-1">
                        <label>Mode</label><br />
                        <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="modeDropDownList" class="form-control dropdown-toggle">
                            <asp:ListItem Value="normal">Ticket Sales</asp:ListItem>
                            <asp:ListItem Value="pnr">PNR Ticket Only</asp:ListItem>
                            <asp:ListItem Value="other">Other Services</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <div class="col-lg-3">
                            <label>E.Tkt.</label>
                            <input type="text" runat="server" id="etkt" value="Y" clientidmode="Static" class="form-control" />
                        </div>
                        <div class="col-lg-6">
                            <label>Ticket No</label>
                            <input type="text" required runat="server" onchange="addDashes(this)" style="font-size: 9px !important" id="tktno" clientidmode="Static" class="form-control" />
                        </div>
                        <div class="col-lg-3">
                            <label>Conj.</label>
                            <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="conjDropDownList" class="form-control dropdown-toggle">
                                <asp:ListItem Value="N">N</asp:ListItem>
                                <asp:ListItem Value="Y">Y</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="col-lg-4">
                            <label>Attach Last Ticket</label>
                            <input type="text" runat="server" id="altn" clientidmode="Static" class="form-control" />
                        </div>
                        <div class="col-lg-3">
                            <label>Airline/Agent(CR)</label>
                            <input type="text" runat="server" id="airlinecode" clientidmode="Static" class="form-control" />
                        </div>
                        <div class="col-lg-5">
                            <label>Ticket Purchase From</label>
                            <asp:DropDownList runat="server" Style="-webkit-appearance: none;" ClientIDMode="Static" ID="airlineDropDownList" class="form-control dropdown-toggle">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <div class="col-lg-6">
                            <label>Ticket Type</label><br />
                            <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="tktt" class="form-control dropdown-toggle">
                                <asp:ListItem Value="International">International</asp:ListItem>
                                <asp:ListItem Value="Domestic">Domestic</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-lg-3">
                            <label>BSP</label>
                            <asp:DropDownList runat="server" Style="-webkit-appearance: none;" ClientIDMode="Static" ID="bspDropDown" class="form-control dropdown-toggle">
                                <asp:ListItem Value="N">N</asp:ListItem>
                                <asp:ListItem Value="Y">Y</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-lg-3">
                            <label>XO</label>
                            <input type="text" style="font-size: 10px" runat="server" id="xo" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div>
                        <div class="col-lg-1">
                            <label>Issue/Posting Dt</label>
                            <input type="date" runat="server" id="postDate" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div class="col-lg-1">
                        <label>Status</label>
                        <input type="text" runat="server" id="status" clientidmode="Static" class="form-control" />
                    </div>
                </div>
                <div class="row" style="margin-top: 30px">
                    <div class="col-lg-2">
                        <label>Passenger Name</label>
                        <input type="text" runat="server" id="passname" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Passenger CNIC</label>
                        <input type="text" runat="server" id="passcnic" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Sector / Hotel / Service Description</label>
                        <input type="text" runat="server" id="sector" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Fare Basis</label>
                        <input type="text" runat="server" id="fare" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Class</label>
                        <input type="text" runat="server" id="class" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Dept. Date</label>
                        <input type="date" runat="server" id="deptDate" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>PNR #</label>
                        <input type="text" runat="server" id="pnr" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Route Type</label><br />
                        <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="routeDropDown" class="form-control dropdown-toggle">
                            <asp:ListItem Value="1">One Way</asp:ListItem>
                            <asp:ListItem Value="2">Return</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-1">
                        <label>Passenger Type</label><br />
                        <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="passengerDropDown" class="form-control dropdown-toggle">
                            <asp:ListItem Value="Child">Child</asp:ListItem>
                            <asp:ListItem Value="Adult">Adult</asp:ListItem>
                            <asp:ListItem Value="Infant">Infant</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-1">
                        <label>Category</label><br />
                        <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="catDropdown" class="form-control dropdown-toggle">
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
            </div>
            <div class="col-lg-12">
                <div class="row" style="margin-top: 30px">
                    <div class="col-lg-1">
                        <label>Main Segregation</label>
                        <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="DropDownList2" class="form-control dropdown-toggle">
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
                    <div class="col-lg-1">
                        <label>Sub Segregation</label>
                        <asp:DropDownList Style="-webkit-appearance: none; background-color: red; color: white" runat="server" ClientIDMode="Static" ID="DropDownList1" class="form-control dropdown-toggle">
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
                                <label>Basic Fare</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="mkt" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Other Fare</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="otherfare" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Soto Fare</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="soto" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>SP/YI</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="sp" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>YD/SF/FTT</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="yd" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>PK/YR</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="pk" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>FED/RG/CVT</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="fed" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>CED</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="ced" readonly clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <div class="row">
                            <div class="col-lg-6">
                                <label>XZ/JO</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="xz" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>W.H.Airline</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="whairline" onchange="calculatewhairline()" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>W.H.Client</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="whclient" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>YQ</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="yq" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>PB</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="pb" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>OTH</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="oth" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>Taxes</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" id="tax" onchange="calculatetax();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>FR + TX</label>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" runat="server" readonly id="frtx" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-6">
                                <label>WHT Fix</label>
                            </div>
                            <div class="col-lg-6">
                                <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="fixDropDown" class="form-control dropdown-toggle">
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <div class="row" style="margin-top: -30px">
                            <center>
                                <h4 style="background-color: darkgreen; color: white">----Airline---</h4>
                            </center>
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
                                <input type="text" runat="server" style="background-color: limegreen; color: white" id="tcom" readonly clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="row" style="margin-top: -30px">
                            <center>
                                <h4 style="background-color: orange; color: white">***Client Service Charges & Client Discount***</h4>
                            </center>
                            <div class="col-lg-4">
                                <label>PSF %</label>
                                <input type="text" runat="server" id="srvc" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-2 col-lg-offset-2">
                                <label>Disc.%</label>
                            </div>
                            <div class="col-lg-4">
                                <input type="text" runat="server" id="disc" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-4">
                                <label>PSF Amount</label>
                                <input type="text" runat="server" onchange="calculate();" id="srvcamt" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-2  col-lg-offset-2">
                                <label>Disc.Amount</label>
                            </div>
                            <div class="col-lg-4">
                                <input type="text" runat="server" id="discamt" readonly clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-2">
                                <label>GST%</label>
                            </div>
                            <div class="col-lg-2">
                                <input type="text" runat="server" style="padding: 2px" readonly id="gstText" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-2 col-lg-offset-2">
                                <label>Disc.Adj</label>
                            </div>
                            <div class="col-lg-4">
                                <input type="text" runat="server" id="discadj" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 30px">
                            <div class="col-lg-4">
                                <label>GST Payable</label>
                                <input type="text" runat="server" onchange="calculate();" id="gstpay" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-4" style="margin-top: -10px">
                                <label>Comm. After KB</label>
                            </div>
                            <div class="col-lg-2" style="margin-top: -20px">
                                <input type="text" runat="server" id="kbcomm" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-4">
                                <label>ins./SVC</label>
                                <input type="text" runat="server" id="ins" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-4">
                                <label>Transfer A/C</label>
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="transferDropDownList" class="form-control dropdown-toggle">
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-4">
                                <label>KB Airline</label>
                                <input type="text" runat="server" id="kbairline" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-3">
                                <label>K.B Cust</label>
                                <input type="text" runat="server" id="kbcust" onchange="calculate();" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">

                        <div class="row" style="margin-top: -30px">
                            <div class="col-lg-8">
                                <label>GDS</label>
                                <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="gds" class="form-control dropdown-toggle">
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="row" style="margin-top: -30px">
                            <div class="col-lg-8">
                                <label>FC</label>
                                <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="fcDropDown" class="form-control dropdown-toggle">
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row" style="margin-top: -30px">
                            <div class="col-lg-8">
                                <label>F/C Receivable</label>
                                <input type="text" runat="server" id="fcr" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: -30px">
                            <div class="col-lg-8">
                                <label>F/C Payable</label>
                                <input type="text" runat="server" id="fcp" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <%--//---------------------------------------%>

                    <div class="col-lg-1 col-lg-offset-4">
                        <label>Airline Payable</label>
                        <input style="background-color: red; color: white" type="text" runat="server" readonly id="airlinepayable" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Reveivable Client</label>
                        <input style="background-color: red; color: white" type="text" runat="server" readonly id="clientreceivable" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Other Payable</label>
                        <input style="background-color: red; color: white" type="text" runat="server" readonly id="otherpayable" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Profit/Loss</label>
                        <input style="background-color: hotpink" type="text" runat="server" readonly id="plothers" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Ticket Value</label>
                        <input style="background-color: yellow" type="text" runat="server" readonly id="tktvalue" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2 col-lg-offset-1">
                        <asp:Button ID="addmore" OnClientClick="addmore(); return false" class="btn btn-primary" runat="server" Text="Attach More" />
                        <asp:Button ID="otherBtn" OnClick="otherBtn_Click" runat="server" class="btn btn-primary" Text="Other" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="content">
            <div class="col-lg-12">
                <div class="panel panel-info" style="background-color: #f4f7f7">

                    <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                        <script type="text/javascript">
                            function rowSelected1(sender, args) {

                                document.getElementById('<%=AddButton.ClientID %>').style.display = 'none';
                                    document.getElementById('<%=EditButton.ClientID %>').style.display = 'block';
                                $("#tktno").prop("readonly", true);

                                    var grid = $find('<%= RadGrid3.ClientID %>');
                                    var masterTable = grid.get_masterTableView();
                                    var item = masterTable.get_dataItems()[args.get_itemIndexHierarchical()];
                                    var cell = masterTable.getCellByColumnUniqueName(item, "ticketno");
                                    var ticketno = $telerik.$(cell).text().trim();
                                    $.ajax({
                                        url: 'WebExpenses.asmx/GetRowDataInvoices',
                                        method: 'POST',
                                        dataType: 'json',
                                        data: { ticketno: ticketno },
                                        success: function (data) {
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
                                                var day;
                                                if (date[0].length != 2) {
                                                    day = "0" + date[0];
                                                } else {
                                                    day = date[0];
                                                }
                                                today = date[2] + "-" + day + "-" + month;
                                            }
                                            console.log(today);
                                            document.getElementById("invDate").value = today;
                                            document.getElementById("invDate1").value = today;
                                            document.getElementById('<%=tblid.ClientID%>').value = data[0].id;
                                            document.getElementById('<%=invType.ClientID%>').value = data[0].invtype;
                                            document.getElementById('<%=invType1.ClientID%>').value = data[0].invtype;
                                            document.getElementById('<%=invt.ClientID%>').value = data[0].invtitle;
                                            document.getElementById('<%=invt1.ClientID%>').value = data[0].invtitle;
                                            document.getElementById('<%=invR.ClientID%>').value = data[0].invremarks;
                                            document.getElementById('<%=invR1.ClientID%>').value = data[0].invremarks;
                                            document.getElementById('<%=ccode.ClientID%>').value = data[0].clientcode;
                                            document.getElementById('<%=ccode1.ClientID%>').value = data[0].clientcode;
                                            document.getElementById('<%=othccode.ClientID%>').value = data[0].clientcode;
                                            document.getElementById('<%=customerDropDownList.ClientID%>').value = data[0].clientcode;
                                            document.getElementById('<%=customerDropDownList1.ClientID%>').value = data[0].clientcode;
                                            document.getElementById('<%=customerDropDownListOth.ClientID%>').value = data[0].clientcode;
                                            document.getElementById('<%=etkt.ClientID%>').value = data[0].etkt;
                                            document.getElementById('<%=etkt1.ClientID%>').value = data[0].etkt;
                                            document.getElementById('<%=conjDropDownList.ClientID%>').value = data[0].conj;
                                            document.getElementById('<%=conjDropDownList1.ClientID%>').value = data[0].conj;
                                            document.getElementById('<%=altn.ClientID%>').value = data[0].lastticket;
                                            document.getElementById('<%=altn1.ClientID%>').value = data[0].lastticket;
                                            document.getElementById('<%=airlinecode.ClientID%>').value = data[0].airline;
                                            document.getElementById('<%=airlinecode1.ClientID%>').value = data[0].airline;
                                            document.getElementById('<%=airlineDropDownList.ClientID%>').value = data[0].airline;
                                            document.getElementById('<%=airlineDropDownList1.ClientID%>').value = data[0].airline;
                                            document.getElementById('<%=airlineDropDownListTemp.ClientID%>').value = data[0].airline;
                                            document.getElementById('<%=airlineDropDownListTemp1.ClientID%>').value = data[0].airline;
                                            document.getElementById('<%=tktt.ClientID%>').value = data[0].tickettype;
                                            document.getElementById('<%=tktt1.ClientID%>').value = data[0].tickettype;
                                            document.getElementById('<%=bspDropDown.ClientID%>').value = data[0].bsp;
                                            document.getElementById('<%=bspDropDown1.ClientID%>').value = data[0].bsp;
                                            document.getElementById('<%=xo.ClientID%>').value = data[0].xo;
                                            document.getElementById('<%=xo1.ClientID%>').value = data[0].xo;
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
                                                var day;
                                                if (date[0].length != 2) {
                                                    day = "0" + date[0];
                                                } else {
                                                    day = date[0];
                                                }
                                                today = date[2] + "-" + day + "-" + month;
                                            }
                                            document.getElementById("postDate").value = today;
                                            document.getElementById("postDate1").value = today;
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
                                                var day;
                                                if (date[0].length != 2) {
                                                    day = "0" + date[0];
                                                } else {
                                                    day = date[0];
                                                }
                                                today = date[2] + "-" + day + "-" + month;
                                            }
                                            document.getElementById("othpdate").value = today;
                                            document.getElementById('<%=status.ClientID%>').value = data[0].status;
                                            document.getElementById('<%=status1.ClientID%>').value = data[0].status;
                                            document.getElementById('<%=passname.ClientID%>').value = data[0].passengername;
                                            document.getElementById('<%=passname1.ClientID%>').value = data[0].passengername;
                                            document.getElementById('<%=passenger.ClientID%>').value = data[0].passengername;
                                            document.getElementById('<%=sector.ClientID%>').value = data[0].sector;
                                            document.getElementById('<%=sector1.ClientID%>').value = data[0].sector;
                                            document.getElementById('<%=descriptionOth.ClientID%>').value = data[0].sector;
                                            document.getElementById('<%=fare.ClientID%>').value = data[0].fare;
                                            document.getElementById('<%=fare1.ClientID%>').value = data[0].fare;
                                            document.getElementById('<%=@class.ClientID%>').value = data[0].classification;
                                            document.getElementById('<%=class1.ClientID%>').value = data[0].classification;
                                            var now = data[0].deptdate.split(" ");
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
                                                var day;
                                                if (date[0].length != 2) {
                                                    day = "0" + date[0];
                                                } else {
                                                    day = date[0];
                                                }
                                                today = date[2] + "-" + day + "-" + month;
                                            }
                                            document.getElementById("deptDate").value = today;
                                            document.getElementById("deptDate1").value = today;
                                            document.getElementById('<%=pnr.ClientID%>').value = data[0].pnr;
                                            document.getElementById('<%=pnr1.ClientID%>').value = data[0].pnr;
                                            document.getElementById('<%=routeDropDown.ClientID%>').value = data[0].route;
                                            document.getElementById('<%=routeDropDown1.ClientID%>').value = data[0].route;
                                            document.getElementById('<%=cBalance.ClientID%>').value = data[0].balance;
                                            document.getElementById('<%=cLimit.ClientID%>').value = data[0].credit;
                                            document.getElementById('<%=passengerDropDown.ClientID%>').value = data[0].passengertype;
                                            document.getElementById('<%=passengerDropDown1.ClientID%>').value = data[0].passengertype;
                                            document.getElementById('<%=catDropdown.ClientID%>').value = data[0].category;
                                            document.getElementById('<%=catDropdown1.ClientID%>').value = data[0].category;
                                            document.getElementById('<%=DropDownList2.ClientID%>').value = data[0].mainseg;
                                            document.getElementById('<%=DropDownList21.ClientID%>').value = data[0].mainseg;
                                            document.getElementById('<%=DropDownList1.ClientID%>').value = data[0].subseg;
                                            document.getElementById('<%=DropDownList11.ClientID%>').value = data[0].subseg;
                                            document.getElementById('<%=DropDownList3.ClientID%>').value = data[0].mainseg;
                                            document.getElementById('<%=DropDownList4.ClientID%>').value = data[0].subseg;
                                            document.getElementById('<%=iata.ClientID%>').value = data[0].iata;
                                            document.getElementById('<%=iata1.ClientID%>').value = data[0].iata;
                                            document.getElementById('<%=mkt.ClientID%>').value = data[0].mkt;
                                            document.getElementById('<%=mkt1.ClientID%>').value = data[0].mkt;
                                            document.getElementById('<%=otherfare.ClientID%>').value = data[0].other;
                                            document.getElementById('<%=otherfare1.ClientID%>').value = data[0].other;
                                            document.getElementById('<%=soto.ClientID%>').value = data[0].soto;
                                            document.getElementById('<%=soto1.ClientID%>').value = data[0].soto;
                                            document.getElementById('<%=sp.ClientID%>').value = data[0].sp;
                                            document.getElementById('<%=sp1.ClientID%>').value = data[0].sp;
                                            document.getElementById('<%=yd.ClientID%>').value = data[0].yd;
                                            document.getElementById('<%=yd1.ClientID%>').value = data[0].yd;
                                            document.getElementById('<%=pk.ClientID%>').value = data[0].pk;
                                            document.getElementById('<%=pk1.ClientID%>').value = data[0].pk;
                                            document.getElementById('<%=fed.ClientID%>').value = data[0].fed;
                                            document.getElementById('<%=fed1.ClientID%>').value = data[0].fed;
                                            document.getElementById('<%=ced.ClientID%>').value = data[0].ced;
                                            document.getElementById('<%=ced1.ClientID%>').value = data[0].ced;
                                            document.getElementById('<%=xz.ClientID%>').value = data[0].xz;
                                            document.getElementById('<%=xz1.ClientID%>').value = data[0].xz;
                                            document.getElementById('<%=whairline.ClientID%>').value = data[0].whairline;
                                            document.getElementById('<%=whairline1.ClientID%>').value = data[0].whairline;
                                            document.getElementById('<%=whclient.ClientID%>').value = data[0].whclient;
                                            document.getElementById('<%=whclient1.ClientID%>').value = data[0].whclient;
                                            document.getElementById('<%=yq.ClientID%>').value = data[0].yq;
                                            document.getElementById('<%=yq1.ClientID%>').value = data[0].yq;
                                            document.getElementById('<%=pb.ClientID%>').value = data[0].pb;
                                            document.getElementById('<%=pb1.ClientID%>').value = data[0].pb;
                                            document.getElementById('<%=oth.ClientID%>').value = data[0].oth;
                                            document.getElementById('<%=oth1.ClientID%>').value = data[0].oth;
                                            document.getElementById('<%=tax.ClientID%>').value = data[0].tax;
                                            document.getElementById('<%=tax1.ClientID%>').value = data[0].tax;
                                            document.getElementById('<%=frtx.ClientID%>').value = data[0].frtx;
                                            document.getElementById('<%=frtx1.ClientID%>').value = data[0].frtx;
                                            document.getElementById('<%=fixDropDown.ClientID%>').value = data[0].whtfix;
                                            document.getElementById('<%=fixDropDown1.ClientID%>').value = data[0].whtfix;
                                            document.getElementById('<%=comm.ClientID%>').value = data[0].comm;
                                            document.getElementById('<%=comm1.ClientID%>').value = data[0].comm;
                                            document.getElementById('<%=comamt.ClientID%>').value = data[0].comamt;
                                            document.getElementById('<%=comamt1.ClientID%>').value = data[0].comamt;
                                            document.getElementById('<%=comadj.ClientID%>').value = data[0].comadj;
                                            document.getElementById('<%=comadj1.ClientID%>').value = data[0].comadj;
                                            document.getElementById('<%=tcom.ClientID%>').value = data[0].tcom;
                                            document.getElementById('<%=tcom1.ClientID%>').value = data[0].tcom;
                                            document.getElementById('<%=srvc.ClientID%>').value = data[0].servicech;
                                            document.getElementById('<%=srvc1.ClientID%>').value = data[0].servicech;
                                            document.getElementById('<%=srvcamt.ClientID%>').value = data[0].serviceamt;
                                            document.getElementById('<%=srvcamt1.ClientID%>').value = data[0].serviceamt;
                                            document.getElementById('<%=gstText.ClientID%>').value = data[0].gst;
                                            document.getElementById('<%=gstText1.ClientID%>').value = data[0].gst;
                                            document.getElementById('<%=gstpay.ClientID%>').value = data[0].gstpay;
                                            document.getElementById('<%=gstpay1.ClientID%>').value = data[0].gstpay;
                                            document.getElementById('<%=ins.ClientID%>').value = data[0].ins;
                                            document.getElementById('<%=ins1.ClientID%>').value = data[0].ins;
                                            document.getElementById('<%=transferDropDownList.ClientID%>').value = data[0].transferac;
                                            document.getElementById('<%=transferDropDownList1.ClientID%>').value = data[0].transferac;
                                            document.getElementById('<%=kbairline.ClientID%>').value = data[0].kbairline;
                                            document.getElementById('<%=kbairline1.ClientID%>').value = data[0].kbairline;
                                            document.getElementById('<%=kbcust.ClientID%>').value = data[0].kbcust;
                                            document.getElementById('<%=kbcust1.ClientID%>').value = data[0].kbcust;
                                            document.getElementById('<%=kbcomm.ClientID%>').value = data[0].commkb;
                                            document.getElementById('<%=kbcomm1.ClientID%>').value = data[0].commkb;
                                            document.getElementById('<%=disc.ClientID%>').value = data[0].disc;
                                            document.getElementById('<%=disc1.ClientID%>').value = data[0].disc;
                                            document.getElementById('<%=discamt.ClientID%>').value = data[0].discamt;
                                            document.getElementById('<%=discamt1.ClientID%>').value = data[0].discamt;
                                            document.getElementById('<%=discadj.ClientID%>').value = data[0].discadj;
                                            document.getElementById('<%=discadj1.ClientID%>').value = data[0].discadj;
                                            document.getElementById('<%=gds.ClientID%>').value = data[0].gds;
                                            document.getElementById('<%=gds1.ClientID%>').value = data[0].gds;
                                            document.getElementById('<%=fcDropDown.ClientID%>').value = data[0].fc;
                                            document.getElementById('<%=fcDropDown1.ClientID%>').value = data[0].fc;
                                            document.getElementById('<%=fcp.ClientID%>').value = data[0].fcpayable;
                                            document.getElementById('<%=fcp1.ClientID%>').value = data[0].fcpayable;
                                            document.getElementById('<%=fcr.ClientID%>').value = data[0].fcreceivable;
                                            document.getElementById('<%=fcr1.ClientID%>').value = data[0].fcreceivable;
                                            document.getElementById('<%=airlinepayable.ClientID%>').value = data[0].airlinepayable;
                                            document.getElementById('<%=airlinepayable1.ClientID%>').value = data[0].airlinepayable;
                                            document.getElementById('<%=clientreceivable.ClientID%>').value = data[0].receivableclient;
                                            document.getElementById('<%=clientreceivable1.ClientID%>').value = data[0].receivableclient;
                                            document.getElementById('<%=trcv.ClientID%>').value = data[0].receivableclient;
                                            document.getElementById('<%=otherpayable.ClientID%>').value = data[0].otherpayable;
                                            document.getElementById('<%=otherpayable1.ClientID%>').value = data[0].otherpayable;
                                            document.getElementById('<%=plothers.ClientID%>').value = data[0].profitlossamt;
                                            document.getElementById('<%=tpl.ClientID%>').value = data[0].profitlossamt;
                                            document.getElementById('<%=tktvalue.ClientID%>').value = data[0].ticketvalue;
                                            document.getElementById('<%=tktvalue1.ClientID%>').value = data[0].ticketvalue;
                                            document.getElementById('<%=passcnic.ClientID%>').value = data[0].PassengerCNIC;
                                            document.getElementById('<%=passcnic1.ClientID%>').value = data[0].PassengerCNIC;
                                            document.getElementById('<%=othpassportno.ClientID%>').value = data[0].PassengerCNIC;
                                            document.getElementById('<%=rcpt.ClientID%>').value = data[0].rcptno;
                                            document.getElementById('<%=rcpt1.ClientID%>').value = data[0].rcptno;
                                            document.getElementById('<%=visarcv.ClientID%>').value = data[0].visa;
                                            document.getElementById('<%=accomo1rcv.ClientID%>').value = data[0].accomodation1;
                                            document.getElementById('<%=accomo2rcv.ClientID%>').value = data[0].accomodation2;
                                            document.getElementById('<%=trnsrcv.ClientID%>').value = data[0].transport;
                                            document.getElementById('<%=foodrcv.ClientID%>').value = data[0].food;
                                            document.getElementById('<%=otherrcv.ClientID%>').value = data[0].other;
                                            document.getElementById('<%=zrtrcv.ClientID%>').value = data[0].ziarat;
                                            document.getElementById('<%=totalrcv.ClientID%>').value = data[0].receivableclient;
                                            document.getElementById('<%=tktno.ClientID%>').value = ticketno;
                                            document.getElementById('<%=tktno1.ClientID%>').value = ticketno.substr(0, 13);
                                            document.getElementById('<%=othtktno.ClientID%>').value = ticketno;
                                        },
                                        error: function (res) {
                                        }
                                    });
                            }
                        </script>
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

                    <asp:Panel ID="Panel3" runat="server">
                        <telerik:RadToolTip runat="server" ID="RadToolTip2" OffsetY="0" RenderInPageRoot="false"
                            HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                            ShowEvent="FromCode" Position="Center" Skin="Default">
                            <telerik:RadComboBox runat="server" EnableLoadOnDemand="true" OnItemsRequested="RadComboBox1_ItemsRequested">
                            </telerik:RadComboBox>
                        </telerik:RadToolTip>

                        <telerik:RadGrid ID="RadGrid3" runat="server" OnNeedDataSource="RadGrid1_NeedDataSource" Height="200px">
                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="false" Font-Size="10px">
                                <CommandItemSettings ShowAddNewRecordButton="false" ShowRefreshButton="false" ShowCancelChangesButton="false" ShowSaveChangesButton="false" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="ticketno" HeaderStyle-Width="13%" HeaderText="Ticket No"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="passengername" HeaderStyle-Width="20%" HeaderText="Passenger Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="sector" HeaderStyle-Width="20%" HeaderText="Sector"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="mkt" HeaderStyle-Width="8%" HeaderText="Basic Fare"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="tax" HeaderStyle-Width="8%" HeaderText="Tax All"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="oth" HeaderStyle-Width="8%" HeaderText="Other"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="discamt" HeaderStyle-Width="8%" HeaderText="S.P Total"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="receivableclient" HeaderStyle-Width="8%" HeaderText="Receivable"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="airlinepayable" HeaderStyle-Width="8%" HeaderText="Payable"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="status" HeaderStyle-Width="4%" HeaderText="Status"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings AllowKeyboardNavigation="True">
                                <KeyboardNavigationSettings AllowActiveRowCycle="true" />
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <ClientEvents OnUserAction="userAction" OnGridCreated="gridCreated" OnRowClick="rowSelected1" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </asp:Panel>
                </div>
            </div>


            <div class="row" style="margin-bottom: 2%">
                <div class="col-lg-5">
                    <div class="col-md-2">
                        <label>K.B</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="utkb" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label>Comm</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="utcomm" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label>WH.Airline</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="utwhair" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label>WH.Client</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="utwhclient" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label>Other Payable</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="utotherpay" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label>Profit/Loss</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="utpl" runat="server" />
                    </div>
                </div>
                <div class="col-lg-5 col-lg-offset-1" style="margin-left: 180px">
                    <div class="col-md-2">
                        <label>Total Fare</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="uttfare" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label>Total Taxes</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="utttax" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label>Total Other</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="uttother" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label>Total SP</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="uttsp" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label>Total Rcvable</label>
                        <input style="background-color: red; color: white" type="text" class="form-control" readonly clientidmode="Static" id="uttrcv" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label>Total Payable</label>
                        <input type="text" class="form-control" readonly clientidmode="Static" id="uttpay" runat="server" />
                    </div>
                </div>
            </div>
            <center>
                <div class="row" style="margin-bottom: 2%; display: inline; position: relative;">
                    <asp:Button ID="AddButton" OnClick="AddButton_Click" class="btn btn-primary" runat="server" Text="Save Record" />
                    <asp:Button ID="EditButton" OnClientClick="editBtn(); return false" class="btn btn-primary" runat="server" Text="Edit Record" />
                    <asp:Button ID="newButton" OnClick="newButton_Click1" class="btn btn-primary" runat="server" Text="Add New Invoice" />
                    <asp:Button ID="delButton" OnClientClick="delBtn()" OnClick="delButton_Click1" class="btn btn-primary" runat="server" Text="Delete" />
                    <asp:Button ID="delInvoiceButton" OnClientClick="delBtn()" OnClick="delButton_Click" class="btn btn-primary" runat="server" Text="Delete Invoice" />
                    <asp:Button ID="accountButton" OnClick="accountButton_Click" class="btn btn-primary" runat="server" Text="Change Account" />
                    <asp:Button ID="searchButton" OnClick="searchButton_Click" class="btn btn-primary" runat="server" Text="Search" />
                    <input name="printbtn" id="printbtn" value="Print" class="btn btn-primary" title="Print" type="button">
                    <input name="invbtn" id="invbtn" value="Inv. Status" class="btn btn-primary" title="Inv. Status" type="button">
                    <input name="remarkbtn" id="remarkbtn" value="Remarks" class="btn btn-primary" title="Detailed Remarks" type="button">
                    <input name="ledgerbtn" id="ledgerbtn" value="Ledger" class="btn btn-primary" title="Ledger" type="button">
                    <input name="selectbtn" id="selectbtn" value="Select" class="btn btn-primary" title="Select" type="button">
                    <asp:Button ID="prevbtn" OnClientClick="prevBtn();" OnClick="prevbtn_Click" class="btn btn-primary" runat="server" Text="Prev" />
                    <asp:Button ID="nextbtn" OnClientClick="nextBtn();" OnClick="nextbtn_Click" class="btn btn-primary" runat="server" Text="Next" />
                    <input name="recieptbtn" id="recieptbtn" value="Reciept" class="btn btn-primary" title="Reciept" type="button">
                </div>
            </center>
        </div>
    </div>
    <center>
            <div id="searchPopup" class="modal fade" role="dialog">
            <div class="modal-dialog" style="background-color: #f4f7f7">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; min-width: 600px">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <center>
                        <h4>Search Invoice
                        </h4>
                    </center>
                </div>
                    <div class="modal-body" style="width:600px">
                        <div class="panel-body">
                            <div class="row">
                                <label>Invoice No</label>
                                <input type="number" runat="server" id="invoiceSearch" clientidmode="Static" class="form-control" /><br />
                                <label>Ticket No</label>
                                <input type="text" runat="server" id="ticketSearch"  onchange="addDashesticketSearch(this)" clientidmode="Static" class="form-control" /><br />
                                <label>Manual Reference No</label><br />
                                <label>Ref. No</label>
                                <input type="text" runat="server" id="pnrSearch" clientidmode="Static" class="form-control" /><br />
                        <asp:Button ID="searchOK" OnClick="searchOk_Click" class="btn btn-primary" runat="server" Text="Search Invoice" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </center>
    <center>
            <div id="successpopup1" class="modal fade" role="dialog">
            <div class="modal-dialog" style="background-color: #f4f7f7">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body" style="width:600px">
                        <div class="panel-body">
                            <div class="row">
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/greencheck.png" Style="height: 100px; width: 100px;" /><br />
                                <label>Invoice # </label>
                                <label id="vno" runat="server"></label>
                                <label>Created Successfully!</label><br />
                                <label>Change Voucher #</label>
                                <input type="number" runat="server" id="Number1" clientidmode="Static" class="form-control" /><br />
                        <asp:Button ID="OkBtn" OnClick="OkBtn_Click" class="btn btn-primary" runat="server" Text="Change" />
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
        <div id="conflictPopup" class="modal fade" role="dialog">
            <div class="modal-dialog" style="background-color: #f4f7f7">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body" style="width: 600px">
                        <div class="panel-body">
                            <div class="row">
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/QuestionMark.png" Style="height: 100px; width: 100px;" /><br />
                                <label>Conflict in Invoice Number</label><br />
                                <label>Invoice Number Already Exists</label><br />
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
        <div id="otherPopupDescription" class="modal fade" role="dialog">
            <div class="modal-dialog" style="background-color: #f4f7f7">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body" style="width: 600px">
                        <div class="panel-body">
                            <div class="row">
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/greencheck.png" Style="height: 100px; width: 100px;" /><br />
                                <label>Invoice # </label>
                                <label id="othvno" runat="server"></label>
                                <label>Created Successfully!</label><br />
                                <label>For Editing Other Invoice. Click on the row containing the Other ticket number (starting with OTH) then click on the Other button a modal box will appear. After editing click on the save button located at the bottom of modal box it will save all the changes.</label>
                                <button type="button" class="btn btn-danger" data-dismiss="modal">
                                    Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>

    <div id="OthPopup" class="modal fade" role="dialog">
        <div class="modal-dialog" style="background-color: #f4f7f7; font-size: 10px; position: absolute">
            <!-- Modal content-->
            <div class="modal-content" style="width: max-content;">
                <div style="background-color: red" class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <center>
                        <h4 style="font-size: large; font-weight: bold">Umrah,Hajj,Recruiting,tours,Hotel,Visa,Service Charges,Holding,Protector,Medical & Other Income Voucher
                        </h4>
                    </center>
                </div>
                <div class="modal-body popupDialog">
                    <div class="content">
                        <div class="row">
                            <div class="col-md-2">
                                <label>Client Code</label>
                                <input type="text" class="form-control" clientidmode="Static" id="othccode" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>Client</label><br />
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="customerDropDownListOth" class="form-control dropdown-toggle">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-1">
                                <label>Entry Ref. No.</label>
                                <input type="text" style="font-size: 9px !important" class="form-control" clientidmode="Static" id="othtktno" runat="server" />
                            </div>
                            <div class="col-md-1">
                                <label>Posting Date</label>
                                <input type="date" runat="server" id="othpdate" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-md-1">
                                <label>Mofa No.</label>
                                <input type="text" class="form-control" clientidmode="Static" id="mofano" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>Passport No</label>
                                <input type="text" class="form-control" clientidmode="Static" id="othpassportno" runat="server" />
                            </div>
                            <div class="col-md-1">
                                <label>Category</label><br />
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="catDropdownOth" class="form-control dropdown-toggle">
                                    <asp:ListItem Value="Normal">Normal</asp:ListItem>
                                    <asp:ListItem Value="Umrah">Umrah</asp:ListItem>
                                    <asp:ListItem Value="Hajj">Hajj</asp:ListItem>
                                    <asp:ListItem Value="Insurance">Insurance</asp:ListItem>
                                    <asp:ListItem Value="Visa">Visa</asp:ListItem>
                                    <asp:ListItem Value="Protector">Protector</asp:ListItem>
                                    <asp:ListItem Value="Medical">Medical</asp:ListItem>
                                    <asp:ListItem Value="Seat Reserv.">Seat Reserv.</asp:ListItem>
                                    <asp:ListItem Value="Transit Visa">Transit Visa</asp:ListItem>
                                    <asp:ListItem Value="Visit Visa">Visit Visa</asp:ListItem>
                                    <asp:ListItem Value="Dubai Visa">Dubai Visa</asp:ListItem>
                                    <asp:ListItem Value="Kuwait Visa">Kuwait Visa</asp:ListItem>
                                    <asp:ListItem Value="Hotel Booking">Hotel Booking</asp:ListItem>
                                    <asp:ListItem Value="Tours Charges">Tours Charges</asp:ListItem>
                                    <asp:ListItem Value="Holding FC">Holding FC</asp:ListItem>
                                    <asp:ListItem Value="Holding PK">Holding PK</asp:ListItem>
                                    <asp:ListItem Value="Miscellaneous">Miscellaneous</asp:ListItem>
                                    <asp:ListItem Value="Others">Others</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-1 col-lg-offset-1">
                                <center>
                                    <asp:ImageButton runat="server" ImageUrl="~/Images/exit.png" Height="30px" data-dismiss="modal" /><br />
                                    <label style="font-size: large">Exit</label>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">
                                <label>Visa No.</label>
                                <input type="text" class="form-control" clientidmode="Static" id="visano" runat="server" />
                            </div>
                            <div class="col-md-1">
                                <label>Form Ref. No.</label>
                                <input type="text" class="form-control" clientidmode="Static" id="formno" runat="server" />
                            </div>
                            <div class="col-md-1">
                                <label>App.No.</label>
                                <input type="text" class="form-control" clientidmode="Static" id="appno" runat="server" />
                            </div>
                            <div class="col-md-1">
                                <label>Your XO No.</label>
                                <input type="text" class="form-control" clientidmode="Static" id="othxono" runat="server" />
                            </div>
                            <div class="col-md-1">
                                <label>Ins Hotel.#</label>
                                <input type="text" class="form-control" clientidmode="Static" id="hotelno" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>Passenger</label>
                                <input type="text" class="form-control" clientidmode="Static" id="passenger" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>Sales Person</label><br />
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="salesDropDownListOth" class="form-control dropdown-toggle">
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-1 col-lg-offset-1">
                                <center>
                                    <asp:ImageButton runat="server" OnClick="Unnamed_Click" ImageUrl="~/Images/attachmore.png" Height="40px" /><br />
                                    <label style="font-size: large">Attach More</label>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">
                                <label>Description</label>
                                <input type="text" class="form-control" clientidmode="Static" id="descriptionOth" runat="server" />
                            </div>
                            <div class="col-lg-2">
                                <label>Main Segregation</label>
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="DropDownList3" class="form-control dropdown-toggle">
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
                            <div class="col-lg-2">
                                <label>Sub Segregation</label>
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="DropDownList4" class="form-control dropdown-toggle">
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
                        <div class="row">
                            <div class="col-lg-5">
                                <center>
                                    <h3>Client Breakup</h3>
                                </center>
                                <div class="col-lg-3">
                                    <label>$ </label>
                                    <asp:TextBox ReadOnly="true" Width="30px" runat="server"></asp:TextBox><br />
                                    <label style="margin-top: 8px">Visa/Approval</label><br />
                                    <label style="margin-top: 5px">Accomodation-1</label><br />
                                    <label style="margin-top: 5px">Accomodation-2</label><br />
                                    <label style="margin-top: 5px">Transport</label><br />
                                    <label style="margin-top: 5px">Ziaraat</label><br />
                                    <label style="margin-top: 5px">Food</label><br />
                                    <label style="margin-top: 5px">Other</label><br />
                                    <label style="margin-top: 5px">Total:</label>
                                </div>
                                <div class="col-lg-3">
                                    <label>FC Amount</label>
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text1" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text2" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text3" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text4" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text5" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text6" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text7" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text8" runat="server" />
                                    <label style="margin-top: 5px">GST Payable %</label>
                                </div>
                                <div class="col-lg-3">
                                    <label>Conv.Rate</label>
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text10" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text11" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text12" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text13" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text14" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text15" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text16" runat="server" />
                                    <input type="text" class="form-control" disabled clientidmode="Static" id="Text17" runat="server" />
                                    <input type="text" class="form-control" onchange="calculatercvgst()" clientidmode="Static" id="gstpercent" runat="server" />
                                </div>
                                <div class="col-lg-3">
                                    <label>Receivable</label>
                                    <input type="text" class="form-control" clientidmode="Static" onchange="calculatercv()" id="visarcv" runat="server" />
                                    <input type="text" class="form-control" clientidmode="Static" onchange="calculatercv()" id="accomo1rcv" runat="server" />
                                    <input type="text" class="form-control" clientidmode="Static" onchange="calculatercv()" id="accomo2rcv" runat="server" />
                                    <input type="text" class="form-control" clientidmode="Static" onchange="calculatercv()" id="trnsrcv" runat="server" />
                                    <input type="text" class="form-control" clientidmode="Static" onchange="calculatercv()" id="zrtrcv" runat="server" />
                                    <input type="text" class="form-control" clientidmode="Static" onchange="calculatercv()" id="foodrcv" runat="server" />
                                    <input type="text" class="form-control" clientidmode="Static" onchange="calculatercv()" id="otherrcv" runat="server" />
                                    <input type="text" class="form-control" clientidmode="Static" readonly id="totalrcv" runat="server" />
                                    <input type="text" class="form-control" clientidmode="Static" id="gstrcv" runat="server" />
                                </div>
                            </div>
                            <div class="col-lg-7">
                                <center>
                                    <h3>Payable Breakup</h3>
                                </center>

                                <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                                    <script type="text/javascript">
                                        var maNV = null;
                                        function rowSelected(sender, args) {
                                            var grid = $find('<%= RadGrid1.ClientID %>');
                                            var masterTable = grid.get_masterTableView();
                                            var item = masterTable.get_dataItems()[args.get_itemIndexHierarchical()];
                                            var cell = masterTable.getCellByColumnUniqueName(item, "code");
                                            var value = $telerik.$(cell).text().trim();
                                            console.log(value);
                                            $.ajax({
                                                url: 'WebExpenses.asmx/getAccountName',
                                                method: 'POST',
                                                dataType: 'json',
                                                data: { value: value },
                                                success: function (data) {
                                                    accname = data[0].name;
                                                },
                                                error: function (res) {
                                                }
                                            });
                                        }
                                    </script>
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
                                    <script lang="javascript" type="text/javascript">  

                                        function OnClientSelectedIndexChanged(sender, eventArgs) {
                                            var newItem = eventArgs.get_item()._text;
                                        }
                                    </script>
                                </telerik:RadCodeBlock>

                                <asp:Panel ID="Panel1" runat="server">
                                    <telerik:RadToolTip runat="server" ID="RelatedComboBoxesToolTip" OffsetY="0" RenderInPageRoot="false"
                                        HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                                        ShowEvent="FromCode" Position="Center" Skin="Default">
                                        <telerik:RadComboBox runat="server" EnableLoadOnDemand="true" OnItemsRequested="RadComboBox1_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </telerik:RadToolTip>

                                    <telerik:RadGrid ID="RadGrid1" runat="server" OnNeedDataSource="RadGrid1_NeedDataSource" Height="190px"
                                        OnBatchEditCommand="RadGrid1_BatchEditCommand">
                                        <MasterTableView EditMode="Batch" CommandItemDisplay="Top" AutoGenerateColumns="false" ClientDataKeyNames="Code">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true"
                                                    ForceExtractValue="Always" Display="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="1" HeaderStyle-Width="5%" HeaderText="$" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="1" HeaderStyle-Width="12%" HeaderText="FC Amount" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="1" HeaderStyle-Width="12%" HeaderText="Conv.Rate" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="amount" HeaderStyle-Width="15%" HeaderText="Payables (CR)"></telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="code" HeaderText="Code" HeaderStyle-Width="20%" DataField="ID_Name" SortExpression="code">
                                                    <ItemTemplate>
                                                        <%# Eval("Code") %>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadComboBox ID="ddlName" runat="server" CssClass="HideArrow"
                                                            EnableLoadOnDemand="true"
                                                            Filter="Contains"
                                                            AllowCustomText="false"
                                                            DataTextField="Name"
                                                            DataValueField="ID_Name"
                                                            OnItemsRequested="ddlName_ItemsRequested">
                                                        </telerik:RadComboBox>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="head" HeaderStyle-Width="30%" ReadOnly="true" HeaderText="Account Title"></telerik:GridBoundColumn>
                                                <telerik:GridButtonColumn HeaderText="Del" HeaderStyle-Width="8%" ConfirmText="Delete this Row?" ConfirmDialogType="Classic"
                                                    ConfirmTitle="Delete" ButtonType="FontIconButton" CommandName="Delete">
                                                </telerik:GridButtonColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings AllowKeyboardNavigation="true">
                                            <Selecting AllowRowSelect="true" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                            <ClientEvents OnUserAction="userAction" OnGridCreated="gridCreated" OnRowClick="rowSelected" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </asp:Panel>
                                <div class="row">
                                    <div class="col-lg-1">
                                        <label>Description:</label>
                                    </div>
                                    <div class="col-lg-1 col-lg-offset-1">
                                        <label>Total:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="tpayable" runat="server" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <input type="text" class="form-control" clientidmode="Static" id="description" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2 col-lg-offset-1">
                                <label>Total Receivable:</label>
                                <input type="text" class="form-control" readonly clientidmode="Static" id="trcv" runat="server" />
                            </div>
                            <div class="col-lg-2">
                                <label>Total Payable:</label>
                                <input type="text" class="form-control" readonly clientidmode="Static" id="tpay" runat="server" />
                            </div>
                            <div class="col-lg-2">
                                <label>Profit/Loss (Dr/Cr):</label>
                                <input type="text" class="form-control" readonly clientidmode="Static" id="tpl" runat="server" />
                            </div>
                            <div class="col-lg-2">
                                <label>Income Code:</label>
                                <input type="text" class="form-control" clientidmode="Static" id="incacname" runat="server" />

                            </div>
                            <div class="col-lg-3">
                                <label>Income Account Name</label>
                                <asp:DropDownList runat="server" Style="-webkit-appearance: none;" ClientIDMode="Static" ID="IncomeDropDownList" class="form-control dropdown-toggle">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="content">
                                <div class="col-lg-12">
                                    <div class="panel panel-info" style="background-color: #f4f7f7">

                                        <telerik:RadCodeBlock ID="RadCodeBlock4" runat="server">

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

                                        <asp:Panel ID="Panel4" runat="server">
                                            <telerik:RadToolTip runat="server" ID="RadToolTip3" OffsetY="0" RenderInPageRoot="false"
                                                HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                                                ShowEvent="FromCode" Position="Center" Skin="Default">
                                                <telerik:RadComboBox runat="server" EnableLoadOnDemand="true" OnItemsRequested="RadComboBox1_ItemsRequested">
                                                </telerik:RadComboBox>
                                            </telerik:RadToolTip>

                                            <telerik:RadGrid ID="RadGrid4" runat="server" OnNeedDataSource="RadGrid1_NeedDataSource" Height="160px">
                                                <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="false" Font-Size="10px">
                                                    <CommandItemSettings ShowAddNewRecordButton="false" ShowRefreshButton="false" ShowCancelChangesButton="false" ShowSaveChangesButton="false" />
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="ticketno" HeaderStyle-Width="13%" HeaderText="Ticket No"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="passengername" HeaderStyle-Width="20%" HeaderText="Passenger Name"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="sector" HeaderStyle-Width="20%" HeaderText="Sector"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="mkt" HeaderStyle-Width="8%" HeaderText="Umrah/Other"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="mkt" HeaderStyle-Width="8%" HeaderText="Basic Fare"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="tax" HeaderStyle-Width="8%" HeaderText="Tax All"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="discamt" HeaderStyle-Width="8%" HeaderText="S.P Total"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="receivableclient" HeaderStyle-Width="8%" HeaderText="Receivable"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="airlinepayable" HeaderStyle-Width="8%" HeaderText="Payable"></telerik:GridBoundColumn>
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
                                </div>
                                <asp:Button ID="Button2" OnClick="Other_Click" class="btn btn-primary" runat="server" Text="Save" />
                                <button type="button" class="btn btn-danger" data-dismiss="modal">
                                    Discard</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="AttachPopup" class="modal fade" role="dialog">
        <div class="modal-dialog" style="background-color: #f4f7f7; font-size: 10px; position: absolute">
            <!-- Modal content-->
            <div class="modal-content" style="background-color: #f4f7f7; width: max-content;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <center>
                        <h3>Attachment In Invoice
                        </h3>
                    </center>
                </div>
                <div class="modal-body popupDialog">
                    <div class="panel-body">
                        <div class="row">
                            <div style="margin-top: 30px">
                                <div class="col-lg-1">
                                    <label>Attachment in INV.#</label>
                                    <input type="text" runat="server" id="invno1" style="background-color: red; color: yellow; font-size: 16px !important; font-weight: bold !important" readonly clientidmode="Static" class="form-control" />
                                </div>
                            </div>
                            <div style="margin-top: 30px">
                                <div class="col-lg-2">
                                    <label>Invoice Date</label>
                                    <input type="date" runat="server" id="invDate1" clientidmode="Static" class="form-control" />
                                </div>
                            </div>

                            <div style="margin-top: 30px">
                                <div class="col-lg-2">
                                    <label>Invoice Type</label><br />
                                    <asp:DropDownList runat="server" ClientIDMode="Static" ID="invType1" class="form-control dropdown-toggle">
                                        <asp:ListItem Value="Normal (Cash)">Normal (Cash)</asp:ListItem>
                                        <asp:ListItem Value="Credit/Debit Card (Merchant Machine Payment)">Credit/Debit Card (Merchant Machine Payment)</asp:ListItem>
                                        <asp:ListItem Value="Online Bank Transfer">Online Bank Transfer</asp:ListItem>
                                        <asp:ListItem Value="Cheque">Cheque</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div style="margin-top: 30px">
                                <div class="col-lg-2">
                                    <label>Receipt No.</label>
                                    <input type="text" runat="server" id="rcpt1" clientidmode="Static" class="form-control" />
                                </div>
                            </div>
                            <div style="margin-top: 30px">
                                <div class="col-lg-4">
                                    <label>Inv.Title C/O</label>
                                    <input type="text" runat="server" id="invt1" clientidmode="Static" class="form-control" />
                                </div>
                            </div>
                            <div class="col-lg-1">
                                <center>
                                    <asp:ImageButton runat="server" ImageUrl="~/Images/exit.png" Height="30px" data-dismiss="modal" /><br />
                                    <label style="font-size: large">Exit</label>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div style="margin-top: 30px">
                                <div class="col-lg-2">
                                    <label>Client Code</label>
                                    <input type="text" runat="server" id="ccode1" clientidmode="Static" class="form-control" />
                                </div>
                            </div>
                            <div style="margin-top: 30px">
                                <div class="col-lg-2">
                                    <label>Customer Name:</label><br />
                                    <asp:DropDownList runat="server" ClientIDMode="Static" ID="customerDropDownList1" class="form-control dropdown-toggle">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div style="margin-top: 30px">
                                <div class="col-lg-3">
                                    <label>Invoice Remarks</label>
                                    <input type="text" runat="server" id="invR1" clientidmode="Static" class="form-control" />
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <label>Carrier Name</label>
                                <asp:DropDownList runat="server" Style="-webkit-appearance: none;" ClientIDMode="Static" ID="airlineDropDownListTemp1" class="form-control dropdown-toggle">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 30px">
                            <div class="col-lg-1">
                                <label>Mode</label><br />
                                <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="modeDropDownList1" class="form-control dropdown-toggle">
                                    <asp:ListItem Value="normal">Ticket Sales</asp:ListItem>
                                    <asp:ListItem Value="pnr">PNR Ticket Only</asp:ListItem>
                                    <asp:ListItem Value="other">Other Services</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-3">
                                <div class="col-lg-3">
                                    <label>E.Tkt.</label>
                                    <input type="text" runat="server" id="etkt1" clientidmode="Static" class="form-control" />
                                </div>
                                <div class="col-lg-6">
                                    <label>Ticket No</label>
                                    <input type="text" required runat="server" onchange="addDashes1(this)" style="font-size: 9px !important" id="tktno1" clientidmode="Static" class="form-control" />
                                </div>
                                <div class="col-lg-3">
                                    <label>Conj.</label>
                                    <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="conjDropDownList1" class="form-control dropdown-toggle">
                                        <asp:ListItem Value="N">N</asp:ListItem>
                                        <asp:ListItem Value="Y">Y</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="col-lg-4">
                                    <label>Attach Last Ticket</label>
                                    <input type="text" runat="server" id="altn1" clientidmode="Static" class="form-control" />
                                </div>
                                <div class="col-lg-3">
                                    <label>Airline/Agent(CR)</label>
                                    <input type="text" runat="server" id="airlinecode1" clientidmode="Static" class="form-control" />
                                </div>
                                <div class="col-lg-5">
                                    <label>Ticket Purchase From</label>
                                    <asp:DropDownList runat="server" Style="-webkit-appearance: none;" ClientIDMode="Static" ID="airlineDropDownList1" class="form-control dropdown-toggle">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="col-lg-6">
                                    <label>Ticket Type</label><br />
                                    <asp:DropDownList Style="-webkit-appearance: none;" runat="server" ClientIDMode="Static" ID="tktt1" class="form-control dropdown-toggle">
                                        <asp:ListItem Value="International">International</asp:ListItem>
                                        <asp:ListItem Value="Domestic">Domestic</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-3">
                                    <label>BSP</label>
                                    <asp:DropDownList runat="server" Style="-webkit-appearance: none;" ClientIDMode="Static" ID="bspDropDown1" class="form-control dropdown-toggle">
                                        <asp:ListItem Value="N">N</asp:ListItem>
                                        <asp:ListItem Value="Y">Y</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-3">
                                    <label>XO</label>
                                    <input type="text" style="font-size: 10px" runat="server" id="xo1" clientidmode="Static" class="form-control" />
                                </div>
                            </div>
                            <div class="col-lg-1">
                                <label>Issue/Posting Dt</label>
                                <input type="date" runat="server" id="postDate1" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-1">
                                <label>Status</label>
                                <input type="text" runat="server" id="status1" clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 30px">
                            <div class="col-lg-2">
                                <label>Passenger Name</label>
                                <input type="text" runat="server" id="passname1" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-1">
                                <label>Passenger CNIC</label>
                                <input type="text" runat="server" id="passcnic1" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-2">
                                <label>Sector / Hotel / Service Description</label>
                                <input type="text" runat="server" id="sector1" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-1">
                                <label>Fare Basis</label>
                                <input type="text" runat="server" id="fare1" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-1">
                                <label>Class</label>
                                <input type="text" runat="server" id="class1" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-1">
                                <label>Dept. Date</label>
                                <input type="date" runat="server" id="deptDate1" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-1">
                                <label>PNR #</label>
                                <input type="text" runat="server" id="pnr1" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-1">
                                <label>Route Type</label><br />
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="routeDropDown1" class="form-control dropdown-toggle">
                                    <asp:ListItem Value="1">One Way</asp:ListItem>
                                    <asp:ListItem Value="2">Return</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-1">
                                <label>Passenger Type</label><br />
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="passengerDropDown1" class="form-control dropdown-toggle">
                                    <asp:ListItem Value="Child">Child</asp:ListItem>
                                    <asp:ListItem Value="Adult">Adult</asp:ListItem>
                                    <asp:ListItem Value="Infant">Infant</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-1">
                                <label>Category</label><br />
                                <asp:DropDownList runat="server" ClientIDMode="Static" ID="catDropdown1" class="form-control dropdown-toggle">
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
                        <div class="col-lg-12">
                            <div class="row" style="margin-top: 30px">
                                <div class="col-lg-1">
                                    <label>Main Segregation</label>
                                    <asp:DropDownList runat="server" ClientIDMode="Static" ID="DropDownList21" class="form-control dropdown-toggle">
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
                                <div class="col-lg-1">
                                    <label>Sub Segregation</label>
                                    <asp:DropDownList runat="server" ClientIDMode="Static" ID="DropDownList11" class="form-control dropdown-toggle">
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
                            <div class="row" style="margin-top: 30px">
                                <div class="col-lg-2">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <label>IATA Fare</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="iata1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>Basic Fare</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="mkt1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>Other Fare</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="otherfare1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>Soto Fare</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="soto1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>SP/YI</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="sp1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>YD/SF/FTT</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="yd1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>PK/YR</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="pk1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>FED/RG/CVT</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="fed1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>CED</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="ced1" readonly clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <label>XZ/JO</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="xz1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>W.H.Airline</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="whairline1" onchange="calculatewhairline1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>W.H.Client</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="whclient1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>YQ</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="yq1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>PB</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="pb1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>OTH</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="oth1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>Taxes</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="tax1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>FR + TX</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" readonly id="frtx1" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>WHT Fix</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="fixDropDown1" class="form-control dropdown-toggle">
                                                <asp:ListItem Value="No">No</asp:ListItem>
                                                <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <div class="row" style="margin-top: -30px">
                                        <center>
                                            <h4 style="background-color: darkgreen; color: white">----Airline---</h4>
                                        </center>
                                        <div class="col-lg-6">
                                            <label>Comm. %</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="comm1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>Com. Amt</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" readonly id="comamt1" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>Extra %</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="extra1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>Ext.Com.</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="extcom1" readonly clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>Com Adj.</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" runat="server" id="comadj1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-6">
                                            <label>Total Com.</label>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" style="background-color: limegreen; color: white" runat="server" id="tcom1" readonly clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="row" style="margin-top: -30px">
                                        <center>
                                            <h4 style="background-color: orange; color: white">***Client Service Charges & Client Discount***</h4>
                                        </center>
                                        <div class="col-lg-4">
                                            <label>PSF %</label>
                                            <input type="text" runat="server" id="srvc1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                        <div class="col-lg-2 col-lg-offset-2">
                                            <label>Disc.%</label>
                                        </div>
                                        <div class="col-lg-4">
                                            <input type="text" runat="server" id="disc1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-4">
                                            <label>PSF Amount</label>
                                            <input type="text" runat="server" id="srvcamt1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                        <div class="col-lg-2  col-lg-offset-2">
                                            <label>Disc.Amount</label>
                                        </div>
                                        <div class="col-lg-4">
                                            <input type="text" runat="server" id="discamt1" readonly clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-2">
                                            <label>GST%</label>
                                        </div>
                                        <div class="col-lg-2">
                                            <input type="text" runat="server" readonly id="gstText1" clientidmode="Static" class="form-control" />
                                        </div>
                                        <div class="col-lg-2 col-lg-offset-2">
                                            <label>Disc.Adj</label>
                                        </div>
                                        <div class="col-lg-4">
                                            <input type="text" runat="server" id="discadj1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 30px">
                                        <div class="col-lg-4">
                                            <label>GST Payable</label>
                                            <input type="text" runat="server" id="gstpay1" clientidmode="Static" class="form-control" />
                                        </div>
                                        <div class="col-lg-4" style="margin-top: -10px">
                                            <label>Comm. After KB</label>
                                        </div>
                                        <div class="col-lg-2" style="margin-top: -20px">
                                            <input type="text" runat="server" id="kbcomm1" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-4">
                                            <label>ins./SVC</label>
                                            <input type="text" runat="server" id="ins1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                        <div class="col-lg-4">
                                            <label>Transfer A/C</label>
                                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="transferDropDownList1" class="form-control dropdown-toggle">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-lg-4">
                                            <label>KB Airline</label>
                                            <input type="text" runat="server" id="kbairline1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-lg-3">
                                            <label>K.B Cust</label>
                                            <input type="text" runat="server" id="kbcust1" onchange="calculate1();" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2">

                                    <div class="row" style="margin-top: -30px">
                                        <div class="col-lg-8">
                                            <label>GDS</label>
                                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="gds1" class="form-control dropdown-toggle">
                                                <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                                <asp:ListItem Value="No">No</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: -30px">
                                        <div class="col-lg-8">
                                            <label>FC</label>
                                            <asp:DropDownList runat="server" ClientIDMode="Static" ID="fcDropDown1" class="form-control dropdown-toggle">
                                                <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                                <asp:ListItem Value="No">No</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: -30px">
                                        <div class="col-lg-8">
                                            <label>F/C Receivable</label>
                                            <input type="text" runat="server" id="fcr1" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: -30px">
                                        <div class="col-lg-8">
                                            <label>F/C Payable</label>
                                            <input type="text" runat="server" id="fcp1" clientidmode="Static" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <%--//---------------------------------------%>

                                <div class="col-lg-1 col-lg-offset-4">
                                    <label>Airline Payable</label>
                                    <input style="background-color: red; color: white" type="text" runat="server" readonly id="airlinepayable1" clientidmode="Static" class="form-control" />
                                </div>
                                <div class="col-lg-1">
                                    <label>Reveivable Client</label>
                                    <input style="background-color: red; color: white" type="text" runat="server" readonly id="clientreceivable1" clientidmode="Static" class="form-control" />
                                </div>
                                <div class="col-lg-1">
                                    <label>Other Payable</label>
                                    <input style="background-color: red; color: white" type="text" runat="server" readonly id="otherpayable1" clientidmode="Static" class="form-control" />
                                </div>
                                <div class="col-lg-1">
                                    <label>Profit/Loss</label>
                                    <input style="background-color: hotpink" type="text" runat="server" readonly id="plother1" clientidmode="Static" class="form-control" />
                                </div>
                                <div class="col-lg-1">
                                    <label>Ticket Value</label>
                                    <input style="background-color: yellow" type="text" runat="server" readonly id="tktvalue1" clientidmode="Static" class="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="content">
                            <div class="col-lg-12">
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
                                            <telerik:RadComboBox runat="server" EnableLoadOnDemand="true" OnItemsRequested="RadComboBox1_ItemsRequested">
                                            </telerik:RadComboBox>
                                        </telerik:RadToolTip>

                                        <telerik:RadGrid ID="RadGrid2" runat="server" OnNeedDataSource="RadGrid1_NeedDataSource" Height="200px">
                                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="false" Font-Size="10px">
                                                <CommandItemSettings ShowAddNewRecordButton="false" ShowRefreshButton="false" ShowCancelChangesButton="false" ShowSaveChangesButton="false" />
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="ticketno" HeaderStyle-Width="13%" HeaderText="Ticket No"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="passengerName" HeaderStyle-Width="20%" HeaderText="Passenger Name"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="sector" HeaderStyle-Width="20%" HeaderText="Sector"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="mkt" HeaderStyle-Width="8%" HeaderText="Basic Fare"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="tax" HeaderStyle-Width="8%" HeaderText="Tax All"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="oth" HeaderStyle-Width="8%" HeaderText="Other"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="discamt" HeaderStyle-Width="8%" HeaderText="S.P Total"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="receivableclient" HeaderStyle-Width="8%" HeaderText="Receivable"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="airlinepayable" HeaderStyle-Width="8%" HeaderText="Payable"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="status" HeaderStyle-Width="4%" HeaderText="Status"></telerik:GridBoundColumn>
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
                            </div>

                            <div class="row" style="margin-bottom: 2%">
                                <div class="col-lg-5">
                                    <div class="col-md-2">
                                        <label>K.B</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="utkb1" runat="server" />
                                    </div>
                                    <div class="col-md-2">
                                        <label>Comm</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="utcomm1" runat="server" />
                                    </div>
                                    <div class="col-md-2">
                                        <label>WH.Airline</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="utwhair1" runat="server" />
                                    </div>
                                    <div class="col-md-2">
                                        <label>WH.Client</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="utwhclient1" runat="server" />
                                    </div>
                                    <div class="col-md-2">
                                        <label>Other Payable</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="utotherpay1" runat="server" />
                                    </div>
                                    <div class="col-md-2">
                                        <label>Profit/Loss</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="utpl1" runat="server" />
                                    </div>
                                </div>
                                <div class="col-lg-5 col-lg-offset-1" style="margin-left: 180px">
                                    <div class="col-md-2">
                                        <label>Total Fare</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="uttfare1" runat="server" />
                                    </div>
                                    <div class="col-md-2">
                                        <label>Total Taxes</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="utttax1" runat="server" />
                                    </div>
                                    <div class="col-md-2">
                                        <label>Total Other</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="uttother1" runat="server" />
                                    </div>
                                    <div class="col-md-2">
                                        <label>Total SP</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="uttsp1" runat="server" />
                                    </div>
                                    <div class="col-md-2">
                                        <label>Total Rcvable</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="uttrcv1" runat="server" />
                                    </div>
                                    <div class="col-md-2">
                                        <label>Total Payable</label>
                                        <input type="text" class="form-control" readonly clientidmode="Static" id="uttpay1" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-1">
                                <asp:Button ID="Button1" OnClick="addmore_Click" class="btn btn-primary" runat="server" Text="Save Attachment" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    <center>
        <div id="deletepopupinv" class="modal fade" role="dialog">
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
                                <label>Are you sure you want to delete this Invoice?</label><br />
                                <asp:Button ID="Yesinv" OnClick="Yesinv_Click" class="btn btn-primary" runat="server" Text="Yes" />
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
        <div id="deletepopuptkt" class="modal fade" role="dialog">
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
                                <label>Are you sure you want to delete this Ticket?</label><br />
                                <asp:Button ID="Yestkt" OnClick="Yestkt_Click" class="btn btn-primary" runat="server" Text="Yes" />
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
        <div id="NoExistPopup" class="modal fade-in" role="dialog">
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
                                <label>The Invoice number/PNR/Ticket number you entered does not exists.</label><br />
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

            function showotherpopup1() {
                jQuery.noConflict();
                $('#OthPopup').modal('show');

            }
            function searchPopup() {
                jQuery.noConflict();
                $('#searchPopup').modal('show');

            }
            function otherPopupDescription1() {
                jQuery.noConflict();
                $('#otherPopupDescription').modal('show');

            }
            function showdeletepopupinv() {
                jQuery.noConflict();
                $('#deletepopupinv').modal('show');

            }
            function showdeletepopuptkt() {
                jQuery.noConflict();
                $('#deletepopuptkt').modal('show');

            }

            function addDashesticketSearch(f) {
                f.value = f.value.replace(/(\d{3})(\d{4})(\d{6})/, "$1-$2-$3").slice(0, 15);
            }

            function showotherpopup2() {
                var a = "OTH";
                const aa = 1000;
                const ab = 9999;
                const ba = 100000;
                const bb = 999999;
                const aaa = Math.random() * (ab - aa + 1);
                const bbb = Math.random() * (bb - ba + 1);
                const other = a + "-" + Math.ceil(aaa) + "-" + Math.ceil(bbb);
                document.getElementById('<%=tktno.ClientID%>').value = other;
                document.getElementById('<%=othtktno.ClientID%>').value = other;
                jQuery.noConflict();
                $('#OthPopup').modal('show');
            }

            function NoExistPopup1() {
                jQuery.noConflict();
                $('#NoExistPopup').modal('show');

            }

            $(document).ready(function () {
                var rcv = parseFloat(document.getElementById('<%=totalrcv.ClientID%>').value || 0);
                var pay = parseFloat(document.getElementById('<%=tpay.ClientID%>').value || 0);
                var total = rcv - pay;
                document.getElementById('<%=tpl.ClientID%>').value = parseFloat(total);
                document.getElementById('<%=trcv.ClientID%>').value = parseFloat(rcv);
                document.getElementById('<%=tpay.ClientID%>').value = parseFloat(pay);
            });

            function calculatercv() {
                var visa = parseFloat(document.getElementById('<%=visarcv.ClientID%>').value || 0);
                var food = parseFloat(document.getElementById('<%=foodrcv.ClientID%>').value || 0);
                var accomo1 = parseFloat(document.getElementById('<%=accomo1rcv.ClientID%>').value || 0);
                var accomo2 = parseFloat(document.getElementById('<%=accomo2rcv.ClientID%>').value || 0);
                var trns = parseFloat(document.getElementById('<%=trnsrcv.ClientID%>').value || 0);
                var zrt = parseFloat(document.getElementById('<%=zrtrcv.ClientID%>').value || 0);
                var other = parseFloat(document.getElementById('<%=otherrcv.ClientID%>').value || 0);
                var total = visa + food + accomo1 + accomo2 + trns + zrt + other;
                document.getElementById('<%=totalrcv.ClientID%>').value = parseFloat(total);
                document.getElementById('<%=trcv.ClientID%>').value = parseFloat(total);
                calculatercvgst();
                calculatePL();
            }
            function calculatercvgst() {
                var total = parseFloat(document.getElementById('<%=totalrcv.ClientID%>').value || 0);
                var gst = parseFloat(document.getElementById('<%=gstpercent.ClientID%>').value || 0);
                gstrcv = (gst * total) / 100;
                document.getElementById('<%=gstrcv.ClientID%>').value = parseFloat(gstrcv);
            }
            function calculatePL() {
                var rcv = parseFloat(document.getElementById('<%=trcv.ClientID%>').value || 0);
                var pay = parseFloat(document.getElementById('<%=tpay.ClientID%>').value || 0);
                total = rcv - pay;
                document.getElementById('<%=tpl.ClientID%>').value = parseFloat(total);
            }
        </script>
</asp:Content>
