<%@ Page Language="C#" Title="Coding Menu" AutoEventWireup="true" CodeBehind="CodingMenu.aspx.cs" ValidateRequest="false" EnableEventValidation="false" MasterPageFile="~/Site.Master" Inherits="Coffer_Systems.Coding.CodingMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head>
        <meta charset="UTF-8">
        <title>Coding Menu</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">

        <!-- Stylesheets -->
        <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="styles/loader.css">
        <link rel="stylesheet" href="assets/css/StyleSheet1.css">
        <link rel="stylesheet" href="Content/fontawesome.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans">

        <!-- Include jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
        <section class="content">

            <div class="row">
                <div class="panel panel-info" style="background-color: #f4f7f7;">
                    <div class="panel-body">
                        <center>
                            <div class="col-lg-3">
                                <h1 style="color: black; text-align: center">1-2-3-4 All Accounts</h1>
                                <br />
                                <asp:Button ID="allAccBtn" class="btn btn-primary" runat="server" OnClientClick="managerpopup();  return false" Text="All Accounts Chart" />
                                <asp:Button ID="clientpsfBtn" class="btn btn-primary" runat="server" Text="Client Comm-PSF-WHT" />
                            </div>
                            <div class="col-lg-3">
                                <h1 style="color: black; text-align: center">1 Assets</h1>
                                <br />
                                <asp:Button ID="assetbtn" class="btn btn-primary" OnClientClick="FixedAsset1(); return false" runat="server" Text="Fixed & Other Assets" /><br />
                                <asp:Button ID="bankbtn" class="btn btn-primary" OnClientClick="Bank1(); return false" runat="server" Text="New Bank Account" /><br />
                                <asp:Button ID="newcustbtn" class="btn btn-primary" OnClientClick="AccReceivable1(); return false" runat="server" Text="New Customer" /><br />
                                <asp:Button ID="newclientbtn" class="btn btn-primary" OnClientClick="Client1(); return false" runat="server" Text="Umrah/Hajj Client" /><br />
                                <asp:Button ID="rfdbtn" class="btn btn-primary" OnClientClick="Refund1(); return false" runat="server" Text="RFD Receivable Airline" /><br />
                                <asp:Button ID="staffbtn" class="btn btn-primary" OnClientClick="Advance1(); return false" runat="server" Text="Staff Advances" /><br />
                                <asp:Button ID="bankgsbtn" class="btn btn-primary" OnClientClick="Security1(); return false" runat="server" Text="Bank Guarantee & Security Deposit" /><br />
                                <asp:Button ID="advbtn" class="btn btn-primary" OnClientClick="Tax1(); return false" runat="server" Text="Adv. Tax & Other Deposits" /><br />
                                <input type="text" hidden id="assetcode" runat="server" />
                            </div>
                            <div class="col-lg-3">
                                <h1 style="color: black; text-align: center">2 Liabilites</h1>
                                <br />
                                <asp:Button ID="capitalbtn" class="btn btn-primary" OnClientClick="Capital1(); return false" runat="server" Text="Equity & Capital" /><br />
                                <asp:Button ID="plbtn" class="btn btn-primary" OnClientClick="ProfitLoss1(); return false" runat="server" Text="Profit & Loss A/C" /><br />
                                <asp:Button ID="airlinebtn" class="btn btn-primary" OnClientClick="AccPayable1(); return false" runat="server" Text="New Airline, Visa, Ins." /><br />
                                <asp:Button ID="rfdcustbtn" class="btn btn-primary" OnClientClick="OtherPayable1(); return false" runat="server" Text="RFD Payable Customer" /><br />
                                <asp:Button ID="payablebtn" class="btn btn-primary" OnClientClick="Payables1(); return false" runat="server" Text="Other Payables (Ticket, Visa, Supplier, Ins.)" /><br />
                                <asp:Button ID="taxbtn" class="btn btn-primary" OnClientClick="TaxPayables1(); return false" runat="server" Text="Taxes Payables & Others" /><br />
                                <asp:Button ID="prepaidBtn" class="btn btn-primary" OnClientClick="Prepaid1(); return false" runat="server" Text="Prepaid Account" /><br />
                            </div>
                            <div class="col-lg-3">
                                <div class="row">
                                    <h1 style="color: black; text-align: center">3 Expenses</h1>
                                    <br />
                                    <asp:Button ID="revbtn" class="btn btn-primary" OnClientClick="Expense1(); return false" runat="server" Text="Cost of Sale/Revenue" /><br />
                                    <asp:Button ID="expbtn" class="btn btn-primary" OnClientClick="GenExpense1(); return false" runat="server" Text="New Expense" /><br />
                                    <asp:Button ID="finbtn" class="btn btn-primary" OnClientClick="Financial1(); return false" runat="server" Text="New Financial Charges" /><br />
                                </div>
                                <div class="row">
                                    <h1 style="color: black; text-align: center">4 Revenue</h1>
                                    <br />
                                    <asp:Button ID="incbtn" class="btn btn-primary" OnClientClick="Revenue1(); return false" runat="server" Text="New Income" /><br />
                                    <asp:Button ID="otherincbtn" class="btn btn-primary" OnClientClick="Income1(); return false" runat="server" Text="Other Income" /><br />
                                </div>
                            </div>
                        </center>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="col-lg-2">
                                <label>New Code</label>
                                <input type="text" class="form-control" clientidmode="Static" id="code" runat="server" />
                            </div>
                            <div class="col-lg-2">
                                <label>Title Of Account</label>
                                <input type="text" class="form-control" clientidmode="Static" id="title" runat="server" />
                            </div>
                            <div class="col-lg-2">
                                <br />
                                <asp:Button ID="saveAccountButton" OnClick="saveBtn_Click" class="btn btn-primary" runat="server" Text="Create Account" />
                            </div>

                        </div>
                    </div>
                    <br />
                    <br />
                    <div class="row">
                        <div class="col-lg-5 col-lg-offset-2">
                            <label>Detail</label>
                            <p>
                                Assets: All Account Codes that starts from digit 1 are Assets Accounts
                            Liabilities: All Account Codes that starts from digit 2 are Liabilities Accounts
                            Expenses: All Account Codes that starts from digit 3 are Expenses Accounts
                            Revenue: All Account Codes that starts from digit 4 are Income Accounts
                            </p>
                        </div>
                        <center>
                            <br />
                            <div class="col-lg-2">
                                <asp:Button ID="aircombtn" OnClientClick="showairdiv(); return false" class="btn btn-primary" runat="server" Text="Set Airline Comm. Percentage" />
                                <br />
                                <asp:Button ID="clientperbtn" OnClientClick="showclientdiv(); return false" class="btn btn-primary" runat="server" Text="Set Client Percentage %" />
                            </div>
                        </center>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <center>
        <div id="commAirlinePopup" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; margin-left: -60%">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body" style="max-width: 1300px">
                        <div class="panel panel-info" style="background-color: #f4f7f7">
                            <h3>Set Commission Airline</h3>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>Code</label>
                                        <input type="text" class="form-control" clientidmode="Static" id="aircode" runat="server" />
                                    </div>
                                    <div class="col-lg-3">
                                        <label>Account Title</label>
                                        <asp:DropDownList runat="server" ClientIDMode="Static" ID="customerDropDownList1" class="form-control dropdown-toggle">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>Domestic</label>
                                        <input type="text" class="form-control" clientidmode="Static" id="airdom" runat="server" />
                                        <label>Dom.Extra</label>
                                        <input type="text" class="form-control" clientidmode="Static" id="airdomextra" runat="server" />
                                    </div>
                                    <div class="col-lg-2">
                                        <label>International</label>
                                        <input type="text" class="form-control" clientidmode="Static" id="airintl" runat="server" />
                                        <label>Intl.Extra</label>
                                        <input type="text" class="form-control" clientidmode="Static" id="airintlextra" runat="server" />
                                    </div>
                                    <div class="col-lg-2">
                                        <label>Comm. After KB</label>
                                        <asp:DropDownList runat="server" ClientIDMode="Static" ID="commkbDropDownList" class="form-control dropdown-toggle">
                                            <asp:ListItem></asp:ListItem>
                                            <asp:ListItem Value="N">N</asp:ListItem>
                                            <asp:ListItem Value="Y">Y</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-2">
                                        <br />
                                        <asp:Button ID="saveAirCom" class="btn btn-primary" runat="server" Text="Update" OnClick="saveAirCom_Click" />
                                        <asp:Button ID="cancelAirCom" class="btn btn-primary" runat="server" Text="Cancel" OnClientClick="cancelAirCom(); return false" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>

        <div id="commClientPopup" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; margin-left: -30%">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body" style="max-width: 1300px">
                        <div class="panel panel-info" style="background-color: #f4f7f7">
                            <h3>Set Commission Client</h3>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>Code</label>
                                        <input type="text" class="form-control" clientidmode="Static" id="clientcode" runat="server" />
                                    </div>
                                    <div class="col-lg-3">
                                        <label>Account Title</label>
                                        <asp:DropDownList runat="server" ClientIDMode="Static" ID="customerDropDownList2" class="form-control dropdown-toggle">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>Domestic</label>
                                        <input type="text" class="form-control" clientidmode="Static" id="clientdom" runat="server" />
                                    </div>
                                    <div class="col-lg-2">
                                        <label>International</label>
                                        <input type="text" class="form-control" clientidmode="Static" id="clientintl" runat="server" />
                                    </div>
                                    <br />
                                    <div class="col-lg-2">
                                        <asp:Button ID="saveClientCom" class="btn btn-primary" runat="server" Text="Update" OnClick="saveClientCom_Click" />
                                        <asp:Button ID="cancelClientCom" class="btn btn-primary" runat="server" Text="Cancel" OnClientClick="cancelClientCom(); return false" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>

    <div id="accchartPopup" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content" style="width: max-content; margin-left: -60%">
                <center>
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <h2>All Accounts Chart</h2>
                    </div>
                </center>
                <div class="modal-body" style="max-width: 1300px">
                    <div class="panel panel-info" style="background-color: #f4f7f7">
                        <div class="panel-body">
                            <div class="row">
                                <label>Opening Date</label>
                                <input type="date" runat="server" id="openingDate" placeholder="YYYY-MM-DD" min="1997-01-01" max="2030-12-31" clientidmode="Static" class="form-control" />
                            </div>
                            <div class="row">
                                <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                                    <script type="text/javascript">
                                        var balance = "";
                                        var count = 0;
                                        function rowSelected(sender, args) {
                                            var grid = $find('<%= RadGrid1.ClientID %>');
                                            var masterTable = grid.get_masterTableView();
                                            var item = masterTable.get_dataItems()[args.get_itemIndexHierarchical()];
                                            var cell = masterTable.getCellByColumnUniqueName(item, "code");
                                            var value = $telerik.$(cell).text().trim();
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

                                    <style type="text/css">
                                        .HideArrow .rcbArrowCell {
                                            display: none !important;
                                        }
                                    </style>
                                </telerik:RadCodeBlock>

                                <asp:Panel ID="Panel1" runat="server">
                                    <telerik:RadToolTip runat="server" ID="RelatedComboBoxesToolTip" OffsetY="0" RenderInPageRoot="false"
                                        HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                                        ShowEvent="FromCode" Position="Center" Skin="Default">
                                        <telerik:RadComboBox runat="server" EnableLoadOnDemand="true" OnItemsRequested="RadComboBox1_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </telerik:RadToolTip>

                                    <telerik:RadGrid ID="RadGrid1" runat="server" OnNeedDataSource="RadGrid1_NeedDataSource"
                                        OnBatchEditCommand="RadGrid1_BatchEditCommand">
                                        <MasterTableView EditMode="Batch" CommandItemDisplay="Top" AutoGenerateColumns="false" ClientDataKeyNames="Code" Font-Size="10px">
                                            <CommandItemSettings ShowAddNewRecordButton="false" />
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true" ForceExtractValue="Always" Display="false"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="seq" HeaderStyle-Width="4%" ReadOnly="true" HeaderText="Seq"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="branch" HeaderStyle-Width="6%" HeaderText="Branch"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="code" HeaderStyle-Width="8%" HeaderText="Code"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="sub_head" HeaderStyle-Width="20%" HeaderText="Title of Account"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="scode" HeaderStyle-Width="6%" HeaderText="S.Code"></telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="idtype" HeaderText="ID" HeaderStyle-Width="6%" DataField="ID_idtype" SortExpression="idtype">
                                                    <ItemTemplate>
                                                        <%# Eval("idtype") %>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadComboBox ID="ddlidtype" runat="server" CssClass="HideArrow"
                                                            EnableLoadOnDemand="true"
                                                            Filter="Contains"
                                                            AllowCustomText="false"
                                                            DataTextField="idtype"
                                                            DataValueField="ID_idtype"
                                                            OnItemsRequested="ddlidtype_ItemsRequested">
                                                        </telerik:RadComboBox>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="city" HeaderStyle-Width="8%" HeaderText="City"></telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="level" HeaderText="Level" HeaderStyle-Width="6%" DataField="ID_level" SortExpression="level">
                                                    <ItemTemplate>
                                                        <%# Eval("level") %>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadComboBox ID="ddllevel" runat="server" CssClass="HideArrow"
                                                            EnableLoadOnDemand="true"
                                                            Filter="Contains"
                                                            AllowCustomText="false"
                                                            DataTextField="level"
                                                            DataValueField="ID_level"
                                                            OnItemsRequested="ddllevel_ItemsRequested">
                                                        </telerik:RadComboBox>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="type" HeaderText="Type" HeaderStyle-Width="10%" DataField="ID_type" SortExpression="type">
                                                    <ItemTemplate>
                                                        <%# Eval("type") %>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadComboBox ID="ddltype" runat="server" CssClass="HideArrow"
                                                            EnableLoadOnDemand="true"
                                                            Filter="Contains"
                                                            AllowCustomText="false"
                                                            DataTextField="type"
                                                            DataValueField="ID_type"
                                                            OnItemsRequested="ddltype_ItemsRequested">
                                                        </telerik:RadComboBox>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="class" HeaderText="Class" HeaderStyle-Width="15%" DataField="ID_class" SortExpression="class">
                                                    <ItemTemplate>
                                                        <%# Eval("class") %>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadComboBox ID="ddlclass" runat="server" CssClass="HideArrow"
                                                            EnableLoadOnDemand="true"
                                                            Filter="Contains"
                                                            AllowCustomText="false"
                                                            DataTextField="class"
                                                            DataValueField="ID_class"
                                                            OnItemsRequested="ddlclass_ItemsRequested">
                                                        </telerik:RadComboBox>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="transaction" HeaderText="DB/CR" HeaderStyle-Width="8%" DataField="ID_transaction" SortExpression="transaction">
                                                    <ItemTemplate>
                                                        <%# Eval("transaction") %>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadComboBox ID="ddltransaction" runat="server" CssClass="HideArrow"
                                                            EnableLoadOnDemand="true"
                                                            Filter="Contains"
                                                            AllowCustomText="false"
                                                            DataTextField="transaction"
                                                            DataValueField="ID_transaction"
                                                            OnItemsRequested="ddltransaction_ItemsRequested">
                                                        </telerik:RadComboBox>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="opening" HeaderStyle-Width="10%" HeaderText="Opening"></telerik:GridBoundColumn>
                                                <telerik:GridButtonColumn HeaderText="Del" HeaderStyle-Width="5%" ConfirmText="Delete this Row?" ConfirmDialogType="RadWindow"
                                                    ConfirmTitle="Delete" ButtonType="FontIconButton" CommandName="Delete">
                                                </telerik:GridButtonColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings AllowKeyboardNavigation="True">
                                            <KeyboardNavigationSettings AllowActiveRowCycle="true" />
                                            <Selecting AllowRowSelect="true" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                            <ClientEvents OnUserAction="userAction" OnGridCreated="gridCreated" OnRowClick="rowSelected" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </asp:Panel>
                            </div>

                            <div class="row">

                                <div class="col-lg-9">
                                    <br />
                                    <asp:Button ID="removeOpening" OnClick="removeOpening_Click" class="btn btn-primary" runat="server" Text="Remove Opening" />
                                    <asp:Button ID="refreshBtn" OnClick="Page_Load" class="btn btn-primary" runat="server" Text="Refresh" />
                                    <asp:Button ID="Button2" class="btn btn-primary" runat="server" Text="Lock Code" />
                                    <asp:Button ID="Button3" class="btn btn-primary" runat="server" Text="Properties" />
                                    <asp:Button ID="Button4" class="btn btn-primary" runat="server" Text="Remarks" />
                                    <asp:Button ID="Button5" class="btn btn-primary" runat="server" Text="Print Detail" />
                                    <asp:Button ID="Button6" class="btn btn-primary" runat="server" Text="Print Opening" />
                                </div>
                                <div class="col-lg-3">
                                    <div style="float: right" class="col-lg-6">
                                        <label>Op.Credit Total</label>
                                        <input type="text" class="form-control" disabled clientidmode="Static" id="optotalCredit" runat="server" />
                                    </div>
                                    <div style="float: right" class="col-lg-6">
                                        <label>Op.Debit Total</label>
                                        <input type="text" class="form-control" disabled clientidmode="Static" id="optotalDebit" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <center>
        <div id="successpopup" class="modal fade" role="dialog">
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
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/greencheck.png" Style="height: 80px; width: 80px;" />
                                <h4>Account Created Successfully!</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="successpopup1" class="modal fade" role="dialog">
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
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/greencheck.png" Style="height: 80px; width: 80px;" />
                                <h4>Accounts Updated Successfully!</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="deletepopup1" class="modal fade" role="dialog">
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
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/greencheck.png" Style="height: 80px; width: 80px;" />
                                <h4>Accounts Deleted Successfully!</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="updatepopup1" class="modal fade" role="dialog">
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
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/greencheck.png" Style="height: 80px; width: 80px;" />
                                <h4>OP Balances Date Changed Successfully!</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="managerpopup" class="modal fade" role="dialog">
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
                                <h4>Enter Manager Password</h4>
                                <input type="password" runat="server" id="managerPassword" clientidmode="Static" class="form-control" /><br />
                                <asp:Button ID="passOk" OnClick="passOk_Click" class="btn btn-primary" runat="server" Text="Ok" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="managerpopuptrue" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <center>
                            <h4>Authentication Successful</h4>
                        </center>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body">
                            <div class="row">
                                <p>Your account password has been authenticated successfully!</p>
                                <br />
                                <p>You may proceed with changing the date of opening balances.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="managerpopupfalse" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="min-width: 600px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <center>
                            <h4>Authentication Failed</h4>
                        </center>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body">
                            <div class="row">
                                <p>The password you entered is incorrect.</p>
                                <br />
                                <p>Please try again or contact you system administrator or assistance.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <script type="text/javascript">

        FixedAsset = <%= Application["FixedAsset"] %>;
        CurrentAsset = <%= Application["CurrentAsset"] %>;
        Bank = <%= Application["Bank"] %>;
        AccReceivable = <%= Application["AccReceivable"] %>;
        Client = <%= Application["Client"] %>;
        Refund = <%= Application["Refund"] %>;
        Advance = <%= Application["Advance"] %>;
        Security = <%= Application["Security"] %>;
        Tax = <%= Application["Tax"] %>;
        Capital = <%= Application["Capital"] %>;
        ProfitLoss = <%= Application["ProfitLoss"] %>;
        AccPayable = <%= Application["AccPayable"] %>;
        OtherPayable = <%= Application["OtherPayable"] %>;
        Payables = <%= Application["Payables"] %>;
        TaxPayables = <%= Application["TaxPayables"] %>;
        Expense = <%= Application["Expense"] %>;
        GenExpense = <%= Application["GenExpense"] %>;
        Financial = <%= Application["Financial"] %>;
        Revenue = <%= Application["Revenue"] %>;
        Income = <%= Application["Income"] %>;
        Prepaid = <%= Application["Prepaid"] %>;

        $(document).ready(function () {

            $('#acccode').prop('readonly', true);
            $('#customerDropDownList').prop('readonly', true);
            $('#levelDropDownList').prop('readonly', true);
            $('#classDropDownList').prop('readonly', true);
            $('#accDropDownList').prop('readonly', true);

            $('#customerDropDownList1').change(function () {
                var cdd = $('#customerDropDownList1').val();
                document.getElementById('<%=aircode.ClientID%>').value = parseFloat(cdd);
            });
            $('#customerDropDownList2').change(function () {
                var cdd = $('#customerDropDownList2').val();
                document.getElementById('<%=clientcode.ClientID%>').value = parseFloat(cdd);
        });

        });

        function showclientdiv() {
            jQuery.noConflict();
            $('#commClientPopup').modal('show');
        }
        function managerpopuptrue() {
            jQuery.noConflict();
            $('#managerpopuptrue').modal('show');
        }
        function managerpopupfalse() {
            jQuery.noConflict();
            $('#managerpopupfalse').modal('show');
        }
        function managerpopup() {
            jQuery.noConflict();
            $('#managerpopup').modal('show');
        }
        function updatepopup1() {
            jQuery.noConflict();
            $('#updatepopup1').modal('show');
        }
        function showairdiv() {
            jQuery.noConflict();
            $('#commAirlinePopup').modal('show');
        }
        function show() {
            jQuery.noConflict();
            $('#accchartPopup').modal('show');
        }
        function showsuccesspopup() {
            jQuery.noConflict();
            $('#successpopup').modal('show');
        }
        function showsuccesspopup1() {
            jQuery.noConflict();
            $('#successpopup1').modal('show');
        }
        function showdeletepopup1() {
            jQuery.noConflict();
            $('#deletepopup1').modal('show');
        }

        function FixedAsset1() {
            document.getElementById('<%=title.ClientID%>').value = "";
            FixedAsset++;
            document.getElementById('<%=code.ClientID%>').value = FixedAsset;
        }
        function CurrentAsset1() {
            document.getElementById('<%=title.ClientID%>').value = "";
            CurrentAsset++;
            document.getElementById('<%=code.ClientID%>').value = CurrentAsset;
        }
        function Bank1() {
            document.getElementById('<%=title.ClientID%>').value = "";
            Bank++;
            document.getElementById('<%=code.ClientID%>').value = Bank;
        }
        function AccReceivable1() {
            document.getElementById('<%=title.ClientID%>').value = "";
            AccReceivable++;
            document.getElementById('<%=code.ClientID%>').value = AccReceivable;
        }
        function Client1() {
            document.getElementById('<%=title.ClientID%>').value = "";
            Client++;
            document.getElementById('<%=code.ClientID%>').value = Client;
        }
        function Refund1() {
            document.getElementById('<%=title.ClientID%>').value = "";
            Refund++;
            document.getElementById('<%=code.ClientID%>').value = Refund;
        }
        function Advance1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        Advance++;
        document.getElementById('<%=code.ClientID%>').value = Advance;
        }
        function Security1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        Security++;
        document.getElementById('<%=code.ClientID%>').value = Security;
        }
        function Tax1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        Tax++;
        document.getElementById('<%=code.ClientID%>').value = Tax;
        }
        function Capital1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        Capital++;
        document.getElementById('<%=code.ClientID%>').value = Capital;
        }
        function ProfitLoss1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        ProfitLoss++;
        document.getElementById('<%=code.ClientID%>').value = ProfitLoss;
        }
        function AccPayable1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        AccPayable++;
        document.getElementById('<%=code.ClientID%>').value = AccPayable;
        }
        function OtherPayable1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        liability++;
        document.getElementById('<%=code.ClientID%>').value = OtherPayable;
        }
        function Payables1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        Payables++;
        document.getElementById('<%=code.ClientID%>').value = Payables;
        }
        function TaxPayables1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        TaxPayables++;
        document.getElementById('<%=code.ClientID%>').value = TaxPayables;
        }
        function OtherPayable1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        OtherPayable++;
        document.getElementById('<%=code.ClientID%>').value = OtherPayable;
        }
        function Expense1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        Expense++;
        document.getElementById('<%=code.ClientID%>').value = Expense;
        }
        function GenExpense1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        GenExpense++;
        document.getElementById('<%=code.ClientID%>').value = GenExpense;
        }
        function Financial1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        Financial++;
        document.getElementById('<%=code.ClientID%>').value = Financial;
        }
        function Revenue1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        Revenue++;
        document.getElementById('<%=code.ClientID%>').value = Revenue;
        }
        function Income1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        Income++;
        document.getElementById('<%=code.ClientID%>').value = Income;
        }
        function Prepaid1() {
            document.getElementById('<%=title.ClientID%>').value = "";
        Prepaid++;
        document.getElementById('<%=code.ClientID%>').value = Prepaid;
        }

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
</asp:Content>
