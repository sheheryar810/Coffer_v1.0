<%@ Page Title="Ledger" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ledger.aspx.cs" Inherits="Coffer_Systems.Ledger" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Ledger</title>
        <link href="styles/loader.css" rel="stylesheet" />
        <link href="assets/css/StyleSheet1.css" rel="stylesheet" />

        <!-- Add defer to the script tags -->
        <script src="Scripts/jquery-3.4.1.min.js"></script>
        <script src="Scripts/bootstrap.min.js" defer></script>

        <script type="text/javascript" defer>

            $(document).ready(function () {

                $('#customerDropDownList').change(function () {
                    var vdd = $('#vTypeDropDownList').val();
                    var cdd = $('#customerDropDownList').val();
                    document.getElementById('<%=clientcode.ClientID%>').value = parseFloat(cdd);
                    var fromDate = $('#fromDate').val();
                    var toDate = $('#toDate').val();
                    var tkt = $('#ticketNumber').val();
                    var pnr = $('#pnrText').val();
                    var passport = $('#passportNumber').val();
                    var desc = $('#descriptionText').val();
                    var headCol = "head";
                    var tblCol = "tblname";
                    var tktCol = "ticketno";
                    var pnrCol = "pnr";
                    var passportCol = "passengerCNIC";
                    var descCol = "description";
                    customerLedger(cdd, vdd, fromDate, toDate, tkt, pnr, passport, desc, headCol, tblCol, tktCol, pnrCol, passportCol, descCol);

                });
                $('#vTypeDropDownList').change(function () {
                    var vdd = $('#vTypeDropDownList').val();
                    var cdd = $('#customerDropDownList').val();
                    var fromDate = $('#fromDate').val();
                    var toDate = $('#toDate').val();
                    var tkt = $('#ticketNumber').val();
                    var pnr = $('#pnrText').val();
                    var passport = $('#passportNumber').val();
                    var desc = $('#descriptionText').val();
                    var headCol = "head";
                    var tblCol = "tblname";
                    var tktCol = "ticketno";
                    var pnrCol = "pnr";
                    var passportCol = "passengerCNIC";
                    var descCol = "description";
                    customerLedger(cdd, vdd, fromDate, toDate, tkt, pnr, passport, desc, headCol, tblCol, tktCol, pnrCol, passportCol, descCol);

                });
                $('#toDate').change(function () {
                    var vdd = $('#vTypeDropDownList').val();
                    var cdd = $('#customerDropDownList').val();
                    var fromDate = $('#fromDate').val();
                    var toDate = $('#toDate').val();
                    var tkt = $('#ticketNumber').val();
                    var pnr = $('#pnrText').val();
                    var passport = $('#passportNumber').val();
                    var desc = $('#descriptionText').val();
                    var headCol = "head";
                    var tblCol = "tblname";
                    var tktCol = "ticketno";
                    var pnrCol = "pnr";
                    var passportCol = "passengerCNIC";
                    var descCol = "description";
                    customerLedger(cdd, vdd, fromDate, toDate, tkt, pnr, passport, desc, headCol, tblCol, tktCol, pnrCol, passportCol, descCol);

                });
                $('#ticketNumber').change(function () {
                    var vdd = $('#vTypeDropDownList').val();
                    var cdd = $('#customerDropDownList').val();
                    var fromDate = $('#fromDate').val();
                    var toDate = $('#toDate').val();
                    var tkt = $('#ticketNumber').val();
                    var pnr = $('#pnrText').val();
                    var passport = $('#passportNumber').val();
                    var desc = $('#descriptionText').val();
                    var headCol = "head";
                    var tblCol = "tblname";
                    var tktCol = "ticketno";
                    var pnrCol = "pnr";
                    var passportCol = "passengerCNIC";
                    var descCol = "description";
                    customerLedger(cdd, vdd, fromDate, toDate, tkt, pnr, passport, desc, headCol, tblCol, tktCol, pnrCol, passportCol, descCol);

                });
                $('#pnrText').change(function () {
                    var vdd = $('#vTypeDropDownList').val();
                    var cdd = $('#customerDropDownList').val();
                    var fromDate = $('#fromDate').val();
                    var toDate = $('#toDate').val();
                    var tkt = $('#ticketNumber').val();
                    var pnr = $('#pnrText').val();
                    var passport = $('#passportNumber').val();
                    var desc = $('#descriptionText').val();
                    var headCol = "head";
                    var tblCol = "tblname";
                    var tktCol = "ticketno";
                    var pnrCol = "pnr";
                    var passportCol = "passengerCNIC";
                    var descCol = "description";
                    customerLedger(cdd, vdd, fromDate, toDate, tkt, pnr, passport, desc, headCol, tblCol, tktCol, pnrCol, passportCol, descCol);

                });
                $('#passportNumber').change(function () {
                    var vdd = $('#vTypeDropDownList').val();
                    var cdd = $('#customerDropDownList').val();
                    var fromDate = $('#fromDate').val();
                    var toDate = $('#toDate').val();
                    var tkt = $('#ticketNumber').val();
                    var pnr = $('#pnrText').val();
                    var passport = $('#passportNumber').val();
                    var desc = $('#descriptionText').val();
                    var headCol = "head";
                    var tblCol = "tblname";
                    var tktCol = "ticketno";
                    var pnrCol = "pnr";
                    var passportCol = "passengerCNIC";
                    var descCol = "description";
                    customerLedger(cdd, vdd, fromDate, toDate, tkt, pnr, passport, desc, headCol, tblCol, tktCol, pnrCol, passportCol, descCol);

                });
                $('#descriptionText').change(function () {
                    var vdd = $('#vTypeDropDownList').val();
                    var cdd = $('#customerDropDownList').val();
                    var fromDate = $('#fromDate').val();
                    var toDate = $('#toDate').val();
                    var tkt = $('#ticketNumber').val();
                    var pnr = $('#pnrText').val();
                    var passport = $('#passportNumber').val();
                    var desc = $('#descriptionText').val();
                    var headCol = "head";
                    var tblCol = "tblname";
                    var tktCol = "ticketno";
                    var pnrCol = "pnr";
                    var passportCol = "passengerCNIC";
                    var descCol = "description";
                    customerLedger(cdd, vdd, fromDate, toDate, tkt, pnr, passport, desc, headCol, tblCol, tktCol, pnrCol, passportCol, descCol);
                });
            });
            function customerLedger(cdd, vdd, fromDate, toDate, tkt, pnr, passport, desc, headCol, tblCol, tktCol, pnrCol, passportCol, descCol) {

                jQuery.noConflict();
                $.ajax({
                    type: "POST",
                    url: "WebExpenses.asmx/GetCustomerLedger",
                    data: { cdd: cdd, vdd: vdd, fromDate: fromDate, toDate: toDate, tkt: tkt, pnr: pnr, passport: passport, desc: desc, headCol: headCol, tblCol: tblCol, tktCol: tktCol, pnrCol: pnrCol, passportCol: passportCol, descCol: descCol },
                    dataType: "json",
                    success: function (data) {
                        if (data.length > 0) {
                            console.log(data[0].date);

                            var tableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                            tableView.set_dataSource(data);
                            tableView.dataBind();
                            $.ajax({
                                type: "POST",
                                url: "WebExpenses.asmx/GetCustomerLedgerTotal",
                                data: { cdd: cdd, vdd: vdd, fromDate: fromDate, toDate: toDate, tkt: tkt, pnr: pnr, passport: passport, desc: desc, headCol: headCol, tblCol: tblCol, tktCol: tktCol, pnrCol: pnrCol, passportCol: passportCol, descCol: descCol },
                                dataType: "json",
                                success: function (data) {
                                    let last = data.pop();
                                    document.getElementById('<%=balancetotal.ClientID%>').value = parseInt(last.totalbalance).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=credittotal.ClientID%>').value = parseInt(last.totalcredit).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=debittotal.ClientID%>').value = parseInt(last.totaldebit).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=ttype.ClientID%>').value = last.type;

                                        if (last.type == "CREDIT") {
                                            document.getElementById('<%=ttype.ClientID%>').style.backgroundColor = 'Green';
                                        } else {
                                            document.getElementById('<%=ttype.ClientID%>').style.backgroundColor = 'Red';
                                        }
                                    },
                                    error: function (ex) {
                                        alert(JSON.stringify(ex));
                                    }
                                });
                        } else {
                            document.getElementById('<%=balancetotal.ClientID%>').value = "";
                            document.getElementById('<%=credittotal.ClientID%>').value = "";
                            document.getElementById('<%=debittotal.ClientID%>').value = "";
                            document.getElementById('<%=ttype.ClientID%>').value = "";
                            var tableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                            tableView.set_dataSource([]);
                            tableView.dataBind();
                            alert("No Data to Show!");
                        }
                    },
                    error: function () {
                        alert("Error");
                    }
                });
            }

            function customerLedgerSearch(variable) {

                jQuery.noConflict();
                $.ajax({
                    type: "POST",
                    url: "WebExpenses.asmx/GetCustomerLedgerSearch",
                    data: { variable: variable },
                    dataType: "json",
                    success: function (data) {
                        if (data.length > 0) {
                            console.log(data[0].date);

                            var tableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                            tableView.set_dataSource(data);
                            tableView.dataBind();
                            $.ajax({
                                type: "POST",
                                url: "WebExpenses.asmx/GetCustomerLedgerSearchTotal",
                                data: { variable: variable },
                                dataType: "json",
                                success: function (data) {
                                    let last = data.pop();
                                    document.getElementById('<%=balancetotal.ClientID%>').value = parseInt(last.totalbalance).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=credittotal.ClientID%>').value = parseInt(last.totalcredit).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=debittotal.ClientID%>').value = parseInt(last.totaldebit).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=ttype.ClientID%>').value = last.type;

                                        if (last.type == "CREDIT") {
                                            document.getElementById('<%=ttype.ClientID%>').style.backgroundColor = 'Green';
                                        } else {
                                            document.getElementById('<%=ttype.ClientID%>').style.backgroundColor = 'Red';
                                        }
                                    },
                                    error: function (ex) {
                                        alert(JSON.stringify(ex));
                                    }
                                });
                        } else {
                            document.getElementById('<%=balancetotal.ClientID%>').value = "";
                            document.getElementById('<%=credittotal.ClientID%>').value = "";
                            document.getElementById('<%=debittotal.ClientID%>').value = "";
                            document.getElementById('<%=ttype.ClientID%>').value = "";
                            var tableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                            tableView.set_dataSource([]);
                            tableView.dataBind();
                            alert("No Data to Show!");
                        }
                    },
                    error: function () {
                        alert("Error");
                    }
                });
            }

            function addDashes(f) {
                f.value = f.value.replace(/(\d{3})(\d{4})(\d{6})/, "$1-$2-$3").slice(0, 15);
            }

            function searchBtn() {
                var variable = $('#searchText').val();
                customerLedgerSearch(variable);
            }

            function ShowPopup() {

                var code = document.getElementById('<%=clientcode.ClientID%>').value;
                jQuery.noConflict();
                if (code != "") {
                    $.ajax({
                        type: "POST",
                        url: "WebExpenses.asmx/GetCustomerInvoiceData",
                        data: { code: code },
                        dataType: "json",
                        success: function (data) {
                            if (data.length > 0) {
                                var tableView = $find("<%= RadGrid2.ClientID %>").get_masterTableView();
                                tableView.set_dataSource(data);
                                tableView.dataBind();
                                $('#MyPopup1').modal('show');

                                $.ajax({
                                    type: "POST",
                                    url: "WebExpenses.asmx/GetCustomerInvoiceDataTotal",
                                    data: { code: code },
                                    dataType: "json",
                                    success: function (data) {
                                        debugger;
                                        document.getElementById('<%=invtkttotal.ClientID%>').value = parseInt(data[0].totalticket).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=invbalancetotal.ClientID%>').value = parseInt(data[0].totalbalance).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=customername.ClientID%>').value = data[0].name;
                                    },
                                    error: function () {
                                        alert("error");
                                    }
                                });
                            } else {
                                alert("No Data to Show!");
                            }
                        },
                        error: function (ex) {
                            alert(ex);
                        }
                    });
                }
                else {
                    alert("No record selected");
                }
            }

            function ShowPopup1() {

                var code = document.getElementById('<%=clientcode.ClientID%>').value;
                jQuery.noConflict();
                if (code != "") {
                    $.ajax({
                        type: "POST",
                        url: "WebExpenses.asmx/GetCustomerPendingInvoiceData",
                        data: { code: code },
                        dataType: "json",
                        success: function (data) {
                            if (data.length > 0) {
                                var tableView = $find("<%= RadGrid3.ClientID %>").get_masterTableView();
                                tableView.set_dataSource(data);
                                tableView.dataBind();
                                $('#MyPopup2').modal('show');

                                $.ajax({
                                    type: "POST",
                                    url: "WebExpenses.asmx/GetCustomerPendingInvoiceDataTotal",
                                    data: { code: code },
                                    dataType: "json",
                                    success: function (data) {
                                        let last = data.pop();
                                        console.log(last.name);
                                        document.getElementById('<%=Text1.ClientID%>').value = parseInt(last.totalamount).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=Text2.ClientID%>').value = parseInt(last.totaldebit).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=Text3.ClientID%>').value = parseInt(last.totalcredit).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=Text4.ClientID%>').value = parseInt(last.totalbalance).toLocaleString('en-US', { minimumFractionDigits: 2 });
                                        document.getElementById('<%=Text5.ClientID%>').value = last.type;
                                        document.getElementById('<%=customername1.ClientID%>').value = last.name;
                                        if (last.type == "CREDIT") {
                                            document.getElementById('<%=ttype.ClientID%>').style.backgroundColor = 'Green';
                                        } else {
                                            document.getElementById('<%=ttype.ClientID%>').style.backgroundColor = 'Red';
                                        }
                                    },
                                    error: function (ex) {
                                        console.log(ex);
                                    }
                                });
                            } else {
                                alert("No Data to Show!");
                            }
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

        <style type="text/css">
            .RadGrid_Telerik .rgSelectedRow td, .RadGrid_Telerik .rgSelectedRow td.rgSorted {
                cursor: pointer !important;
                background: url("WebResource.axd?d=ZwLO4cxF3YBmaUeZH4Re0D2vstkdCxMUTd1I5ZqpjOFEb62qgNE0sIAP8V5Be9tsEgXQ7wueGzIL-Eq7KLo6MlJ8cXjoQOua95OVMCrgojYcCC0fJNwbOZO3iwfC9Luk8RFLAY1dj3tGlu6-FUrckN2mcRgQBfBqlB_S4G05opM1&t=634648121040000000") repeat-x scroll 0 -3900px #63AC38 !important;
            }

            .rgAltRow, .rgRow {
                cursor: pointer !important;
            }

            .RadGrid_Default .rgRow td, .RadGrid_Default .rgAltRow td {
                cursor: pointer !important;
            }

            .RadGrid_Default .rgAltRow {
                cursor: pointer !important;
            }

            .UseHand {
                cursor: pointer !important;
            }
        </style>
    </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="loader-overlay" class="loader-overlay" style="display: none;">
        <div class="loader" style="justify-items: center">
            <img src="Images/Coffer.png" alt="Loading..." class="loader-logo" loading="lazy" />
            <div class="loader-spinner"></div>
        </div>
    </div>
    <div id="page-wrapper">
        <div class="row form-group">

            <div>
                <h1 class="col-lg-7 col-lg-offset-5">Ledger</h1>
            </div>
            <br />
        </div>
        <div class="panel panel-info" style="background-color: #f4f7f7">
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-2">
                        <label>Acc. Code</label>
                        <input type="text" class="form-control" clientidmode="Static" id="clientcode" readonly runat="server" />
                    </div>
                    <div class="col-lg-3">
                        <label>Account Head</label>
                        <asp:DropDownList runat="server" ClientIDMode="Static" ID="customerDropDownList" class="form-control dropdown-toggle">
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-1">
                        <label>From Date</label>
                        <input type="date" style="font-size: 11px" runat="server" id="fromDate" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>To Date</label>
                        <input type="date" style="font-size: 11px" runat="server" id="toDate" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2 col-lg-offset-1" style="margin-top: 1%">
                        <asp:Button ID="btnShowPopup" runat="server" OnClientClick="ShowPopup(); return false" Text="Individual Client Outstanding" class="btn btn-primary" />
                        <asp:Button ID="btnShowPopup1" runat="server" OnClientClick="ShowPopup1(); return false" Text="Only Pending Invoices" class="btn btn-primary" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-1">
                        <label>V.Type</label>
                        <asp:DropDownList runat="server" ClientIDMode="Static" ID="vTypeDropDownList" class="form-control dropdown-toggle">
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-2">
                        <label>Ticket Number</label>
                        <input type="text" style="font-size: 11px" onchange="addDashes(this)" runat="server" id="ticketNumber" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>PNR</label>
                        <input type="text" style="font-size: 11px" runat="server" id="pnrText" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-1">
                        <label>Passport No.</label>
                        <input type="text" style="font-size: 11px" runat="server" id="passportNumber" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Description</label>
                        <input type="text" style="font-size: 11px" runat="server" id="descriptionText" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Search</label>
                        <input type="text" style="font-size: 11px" runat="server" id="searchText" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2" style="margin-top: 22px">
                        <asp:Button ID="searchButton" OnClientClick="searchBtn(); return false" class="btn btn-primary" runat="server" Text="Search Ledger" />
                    </div>
                </div>



                <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
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


                        function OnRowDblClick(sender, args) {
                            var index = args._itemIndexHierarchical;

                            var grid = $find('<%= RadGrid1.ClientID %>');
                            var masterTable = grid.get_masterTableView();
                            var item = masterTable.get_dataItems()[args.get_itemIndexHierarchical()];
                            var cell = masterTable.getCellByColumnUniqueName(item, "vouchertype");
                            var vouchertype = $telerik.$(cell).text().trim();
                            var cell = masterTable.getCellByColumnUniqueName(item, "invno");
                            var invno = $telerik.$(cell).text().trim();
                            var url;

                            document.getElementById('<%= customerDropDownList.ClientID %>').value = "";
                            document.getElementById('<%= clientcode.ClientID %>').value = "";

                            if (vouchertype == "INV") {
                                url = "NormalInvoice.aspx?id=" + invno;
                            } else if (vouchertype == "BR" || vouchertype == "CR") {
                                url = "bankreceivable.aspx?id=" + invno;
                            } else if (vouchertype == "CP" || vouchertype == "BP") {
                                url = "cashpayment.aspx?id=" + invno;
                            } else if (vouchertype == "JV") {
                                url = "jourvalvoucher.aspx?id=" + invno;
                            } else if (vouchertype == "RFD") {
                                url = "refund.aspx?id=" + invno;
                            }
                            console.log("Voucher Type: ", vouchertype, " Invoice No: ", invno);
                            window.location.href = url;
                        }

                    </script>
                </telerik:RadCodeBlock>

                <center>
                    <!-- Modal content-->
                    <div class="row">
                        <div class="col-lg-4">
                            <input type="text" runat="server" id="customernameledger" visible="false" clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                    <div class="content">

                        <div class="panel panel-info" style="background-color: #f4f7f7">
                            <asp:Panel ID="Panel1" runat="server">
                                <telerik:RadToolTip runat="server" ID="RadToolTip1" OffsetY="0" RenderInPageRoot="false"
                                    HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                                    ShowEvent="FromCode" Position="Center" Skin="Default">
                                </telerik:RadToolTip>
                                <telerik:RadGrid CssClass="UseHand" ID="RadGrid1" OnNeedDataSource="RadGrid1_NeedDataSource" runat="server" Width="100%">
                                    <MasterTableView Width="100%" CommandItemDisplay="Top" AutoGenerateColumns="false" Font-Size="10px">
                                        <CommandItemSettings ShowAddNewRecordButton="false" ShowRefreshButton="false" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true"
                                                ForceExtractValue="Always" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="vouchertype" ItemStyle-Width="4%" HeaderStyle-Width="4%" HeaderText="V.TP"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="date" ItemStyle-Width="6%" HeaderStyle-Width="6%" HeaderText="DATE" DataFormatString="{0:dd/MM/yyyy}"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="invno" ItemStyle-Width="4%" HeaderStyle-Width="4%" HeaderText="NO."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ticket" ItemStyle-Width="11%" HeaderStyle-Width="11%" HeaderText="Tkt #/R.No."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="pnr" ItemStyle-Width="7%" HeaderStyle-Width="7%" HeaderText="PNR No."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="passport" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Passport No."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="description" HeaderText="DESCRIPTION" ItemStyle-Width="18%" HeaderStyle-Width="18%"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="debit" HeaderText="DEBIT" ItemStyle-Width="8%" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="credit" HeaderText="CREDIT" ItemStyle-Width="8%" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="balance" HeaderText="BALANCE" ItemStyle-Width="8%" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="type" HeaderText="TP" ItemStyle-Width="4%" HeaderStyle-Width="4%"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="age" HeaderText="AGEING" ItemStyle-Width="6%" HeaderStyle-Width="6%"></telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings EnableRowHoverStyle="true">
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                        <ClientEvents OnRowDblClick="OnRowDblClick" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </asp:Panel>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-1  col-lg-offset-6">
                            <label>Total:</label>
                        </div>
                        <div class="col-lg-5">
                            <div class="col-lg-3">
                                <input style="background-color: blue; color: yellow" type="text" runat="server" id="debittotal" disabled clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-3">
                                <input style="background-color: blue; color: yellow" type="text" runat="server" id="credittotal" disabled clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-3">
                                <input style="background-color: darkblue; color: yellow" type="text" runat="server" id="balancetotal" disabled clientidmode="Static" class="form-control" />
                            </div>
                            <div class="col-lg-3">
                                <input style="background-color: red; color: yellow" type="text" runat="server" id="ttype" disabled clientidmode="Static" class="form-control" />
                            </div>
                        </div>
                    </div>
            </div>

            <!-- Bootstrap -->
            <!-- Bootstrap -->
            <!-- Modal Popup -->
            <center>

                <div id="MyPopup1" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content" style="width: max-content; margin-left: -60%">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">
                                    &times;</button>
                                <h2>INDIVIDUAL CLIENT OUTSTANDING</h2>
                                <h4>(Pending Tickets Wise)
                                </h4>
                            </div>
                            <div class="modal-body" style="max-width: 1300px">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <label>Customer Name:</label>
                                        <input type="text" runat="server" id="customername" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                </div>
                                <div class="content">

                                    <div class="panel panel-info" style="background-color: #f4f7f7">

                                        <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                                            <script type="text/javascript">
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

                                                function clientClick(sender, args) {
                                                    var grid = $find('<%= RadGrid2.ClientID %>');
                                                    var masterTable = grid.get_masterTableView();
                                                    var selected = masterTable.get_selectedItems();
                                                    var rowIndex = selected[0]._itemIndex;
                                                    var item = masterTable.get_dataItems()[rowIndex];
                                                    var cell1 = masterTable.getCellByColumnUniqueName(item, "credit");
                                                    var cell2 = masterTable.getCellByColumnUniqueName(item, "balance");
                                                    var cell3 = masterTable.getCellByColumnUniqueName(item, "id");
                                                    credit = $telerik.$(cell1).text().trim();
                                                    balance = $telerik.$(cell2).text().trim();
                                                    id = $telerik.$(cell3).text().trim();
                                                    var tables = [];
                                                    tables.push(masterTable);
                                                    var batchManager = grid.get_batchEditingManager();
                                                    batchManager.saveTableChanges(tables);
                                                }
                                                function clientClickDel(sender, args) {
                                                    var grid = $find('<%= RadGrid2.ClientID %>');
                                                    var masterTable = grid.get_masterTableView();
                                                    var selected = masterTable.get_selectedItems();
                                                    var rowIndex = selected[0]._itemIndex;
                                                    var item = masterTable.get_dataItems()[rowIndex];
                                                    var cell1 = masterTable.getCellByColumnUniqueName(item, "credit");
                                                    var cell2 = masterTable.getCellByColumnUniqueName(item, "balance");
                                                    var cell3 = masterTable.getCellByColumnUniqueName(item, "id");
                                                    credit = $telerik.$(cell1).text().trim();
                                                    balance = $telerik.$(cell2).text().trim();
                                                    id = $telerik.$(cell3).text().trim();
                                                    var tbl = "JV";
                                                    $.ajax({
                                                        url: 'WebExpenses.asmx/deleteRecordLedger',
                                                        method: 'POST',
                                                        dataType: 'json',
                                                        data: { id: id, tbl: tbl },
                                                        success: function () {
                                                        },
                                                        error: function (res) {
                                                        }
                                                    });
                                                    window.location.reload(true);
                                                }

                                            </script>
                                        </telerik:RadCodeBlock>
                                        <asp:Panel ID="Panel2" runat="server">
                                            <telerik:RadToolTip runat="server" ID="RadToolTip2" OffsetY="0" RenderInPageRoot="false"
                                                HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                                                ShowEvent="FromCode" Position="Center" Skin="Default">
                                            </telerik:RadToolTip>

                                            <telerik:RadGrid ID="RadGrid2" runat="server" AllowAutomaticDeletes="true" OnNeedDataSource="RadGrid2_NeedDataSource"
                                                Width="100%">
                                                <MasterTableView Width="100%" CommandItemDisplay="Top" AutoGenerateColumns="false" Font-Size="10px">
                                                    <CommandItemSettings ShowAddNewRecordButton="false" ShowSaveChangesButton="false" ShowCancelChangesButton="false" ShowRefreshButton="false" />
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true"
                                                            ForceExtractValue="Always" Display="false">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="date" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Inv./Op. Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="invno" ItemStyle-Width="7%" HeaderStyle-Width="7%" HeaderText="INV/REF#" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="ticket" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderText="Ticket No." ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="amount" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Tkt Amount" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="balance" HeaderText="Balance" ReadOnly="true" ItemStyle-Width="8%" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="age" HeaderText="Ag.Days" ReadOnly="true" ItemStyle-Width="8%" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="name" HeaderText="Name" ItemStyle-Width="8%" HeaderStyle-Width="8%" ReadOnly="true"></telerik:GridBoundColumn>
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
                                        <div class="col-lg-1 col-lg-offset-4">
                                            <label style="font-size: larger">Total:</label>
                                        </div>
                                        <div class="col-lg-2">
                                            <input type="text" style="background-color: orange" runat="server" id="invtkttotal" disabled clientidmode="Static" class="form-control" />
                                        </div>
                                        <div class="col-lg-2">
                                            <input type="text" style="background-color: orange" runat="server" id="invbalancetotal" disabled clientidmode="Static" class="form-control" />
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

            <!-- Bootstrap -->
            <!-- Bootstrap -->
            <!-- Modal Popup -->
            <center>

                <div id="MyPopup2" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content" style="width: max-content; margin-left: -60%">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">
                                    &times;</button>
                                <h4>Only Pending Invoices
                                </h4>
                            </div>
                            <div class="modal-body" style="max-width: 1300px">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <label>Customer Name:</label>
                                        <input style="background-color: red; color: white" type="text" runat="server" id="customername1" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                </div>
                                <div class="content">

                                    <div class="panel panel-info" style="background-color: #f4f7f7">

                                        <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                                            <script type="text/javascript">
                                                var balance = "";
                                                var count = 0;
                                                function rowSelectedClearance(sender, args) {
                                                    count++;
                                                    var grid = $find('<%= RadGrid3.ClientID %>');
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

                                                function clientClick(sender, args) {
                                                    var grid = $find('<%= RadGrid3.ClientID %>');
                                                    var masterTable = grid.get_masterTableView();
                                                    var selected = masterTable.get_selectedItems();
                                                    var rowIndex = selected[0]._itemIndex;
                                                    var item = masterTable.get_dataItems()[rowIndex];
                                                    var cell1 = masterTable.getCellByColumnUniqueName(item, "credit");
                                                    var cell2 = masterTable.getCellByColumnUniqueName(item, "balance");
                                                    var cell3 = masterTable.getCellByColumnUniqueName(item, "id");
                                                    credit = $telerik.$(cell1).text().trim();
                                                    balance = $telerik.$(cell2).text().trim();
                                                    id = $telerik.$(cell3).text().trim();
                                                    var tables = [];
                                                    tables.push(masterTable);
                                                    var batchManager = grid.get_batchEditingManager();
                                                    batchManager.saveTableChanges(tables);
                                                }
                                                function clientClickDel(sender, args) {
                                                    var grid = $find('<%= RadGrid3.ClientID %>');
                                                    var masterTable = grid.get_masterTableView();
                                                    var selected = masterTable.get_selectedItems();
                                                    var rowIndex = selected[0]._itemIndex;
                                                    var item = masterTable.get_dataItems()[rowIndex];
                                                    var cell1 = masterTable.getCellByColumnUniqueName(item, "credit");
                                                    var cell2 = masterTable.getCellByColumnUniqueName(item, "balance");
                                                    var cell3 = masterTable.getCellByColumnUniqueName(item, "id");
                                                    credit = $telerik.$(cell1).text().trim();
                                                    balance = $telerik.$(cell2).text().trim();
                                                    id = $telerik.$(cell3).text().trim();
                                                    var tbl = "JV";
                                                    $.ajax({
                                                        url: 'WebExpenses.asmx/deleteRecordLedger',
                                                        method: 'POST',
                                                        dataType: 'json',
                                                        data: { id: id, tbl: tbl },
                                                        success: function () {
                                                        },
                                                        error: function (res) {
                                                        }
                                                    });
                                                    window.location.reload(true);
                                                }

                                            </script>
                                        </telerik:RadCodeBlock>
                                        <asp:Panel ID="Panel3" runat="server">
                                            <telerik:RadToolTip runat="server" ID="RadToolTip3" OffsetY="0" RenderInPageRoot="false"
                                                HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                                                ShowEvent="FromCode" Position="Center" Skin="Default">
                                            </telerik:RadToolTip>

                                            <telerik:RadGrid ID="RadGrid3" runat="server" AllowAutomaticDeletes="true" OnNeedDataSource="RadGrid3_NeedDataSource"
                                                Width="100%">
                                                <MasterTableView Width="100%" CommandItemDisplay="Top" AutoGenerateColumns="false" Font-Size="10px">
                                                    <CommandItemSettings ShowAddNewRecordButton="false" ShowSaveChangesButton="false" ShowCancelChangesButton="false" ShowRefreshButton="false" />
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true"
                                                            ForceExtractValue="Always" Display="false">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="vtp" HeaderStyle-Width="8%" HeaderText="V.Tp" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="date" HeaderStyle-Width="8%" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="invno" HeaderStyle-Width="7%" HeaderText="No." ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="ticket" HeaderStyle-Width="10%" HeaderText="Tkt. #/R.No." ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="pnr" HeaderStyle-Width="8%" HeaderText="PNR" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="passportno" HeaderStyle-Width="8%" HeaderText="Passport No." ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="description" HeaderStyle-Width="8%" HeaderText="Description" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="amount" HeaderStyle-Width="8%" HeaderText="Total Amount" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="debit" HeaderStyle-Width="8%" HeaderText="Debit" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="credit" HeaderStyle-Width="8%" HeaderText="Credit" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="balance" HeaderText="Balance" ReadOnly="true" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="type" HeaderText="Tp" ReadOnly="true" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="age" HeaderText="Ag." ItemStyle-Width="6%" HeaderStyle-Width="6%"></telerik:GridBoundColumn>
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
                                        <div class="col-lg-7 col-lg-offset-5">
                                            <div class="col-lg-2">
                                                <label>Total:</label>
                                            </div>
                                            <div class="col-lg-2">
                                                <input type="text" style="background-color: brown; color: lawngreen; font-size: 10px !important" runat="server" id="Text1" disabled clientidmode="Static" class="form-control" />
                                            </div>
                                            <div class="col-lg-2">
                                                <input type="text" style="background-color: red; color: yellow; font-size: 10px !important" runat="server" id="Text2" disabled clientidmode="Static" class="form-control" />
                                            </div>
                                            <div class="col-lg-2">
                                                <input type="text" style="background-color: green; color: yellow; font-size: 10px !important" runat="server" id="Text3" disabled clientidmode="Static" class="form-control" />
                                            </div>
                                            <div class="col-lg-2">
                                                <input type="text" style="background-color: darkblue; color: yellow; font-size: 10px !important" runat="server" id="Text4" disabled clientidmode="Static" class="form-control" />
                                            </div>
                                            <div class="col-lg-2">
                                                <input type="text" style="background-color: red; color: yellow; font-size: 10px !important" runat="server" id="Text5" disabled clientidmode="Static" class="form-control" />
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

        </div>
    </div>

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
</asp:Content>
