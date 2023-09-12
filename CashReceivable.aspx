<%@ Page Title="Cash Receivable" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" ValidateRequest="false" EnableEventValidation="false" CodeBehind="CashReceivable.aspx.cs" Inherits="Coffer_Systems.CashReceivable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title></title>
        <link href="assets/css/StyleSheet1.css" rel="stylesheet" />
        <script src="Scripts/jquery-3.4.1.min.js"></script>
        <script src="Scripts/bootstrap.min.js"></script>
        <script type="text/javascript">

            function openModal() {
                jQuery.noConflict();
                $('#MyPopup').modal('show');
            };
            function ShowPopup() {
                jQuery.noConflict();
                $('#MyPopup').modal('show');
            }
            function ShowPopup1() {
                jQuery.noConflict();
                $('#MyPopup1').modal('show');
            }
        </script>

    <script type="text/javascript">

        function showsuccesspopup() {
            jQuery.noConflict();
            $('#successpopup').modal('show');
        }
            function showdecisionpopup() {
                jQuery.noConflict();
                $('#decisionpopup').modal('show');
            }
    </script>
    </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        <div class="row form-group">

            <div>
                <h1 class="col-lg-7 col-lg-offset-4">Cash Receipts Voucher</h1>
            </div>
            <br />
        </div>
                    <input type="text" hidden runat="server" id="acccode" clientidmode="Static" />
                    <input type="text" hidden runat="server" id="creditrd" clientidmode="Static" />
                    <input type="text" hidden runat="server" id="balancerd" clientidmode="Static" />
                    <input type="text" hidden runat="server" id="idrd" clientidmode="Static" />
            <input type="text" runat="server" id="Text1" visible="false" clientidmode="Static" class="form-control" />
        <div class="panel panel-info"  style="background-color: #f4f7f7">
            <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-1">
                            <label>Reciept #</label>
                            <input type="text" runat="server" id="invno" style="font-size:16px !important; font-weight:bold !important " readonly clientidmode="Static" class="form-control" />
                        </div>
                    </div>
                <div class="row">
                    <div class="col-lg-4">
                        <label>Account Name</label>
                        <input type="text" runat="server" id="accname" readonly clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Total Debit</label>
                        <input type="text" runat="server" id="debit" disabled clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Total Credit</label>
                        <input type="text" runat="server" id="credit" disabled clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Voucher Status</label>
                        <input type="text" runat="server" readonly id="voucherstatus" value="Not Cleared" clientidmode="Static" class="form-control" />
                    </div>
                </div>
            </div>


            <div class="content">
                <div class="col-lg-12">
                    <div class="panel panel-info" style="background-color: #f4f7f7">



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
                                            document.getElementById('<%=accname.ClientID%>').value = accname;
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
                                    document.getElementById('<%=accname.ClientID%>').value = newItem;
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

            <telerik:RadGrid ID="RadGrid1" runat="server" OnNeedDataSource="RadGrid1_NeedDataSource"
                OnBatchEditCommand="RadGrid1_BatchEditCommand">
                             <MasterTableView EditMode="Batch" CommandItemDisplay="Top" AutoGenerateColumns="false" ClientDataKeyNames="Code" Font-Size="10px">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true"
                                            ForceExtractValue="Always" Display="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="code" HeaderText="Code" ItemStyle-Width="12%" HeaderStyle-Width="12%" DataField="ID_Name" SortExpression="code">
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
                                        <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="transactiontype" HeaderText="DB/CR" ItemStyle-Width="10%" HeaderStyle-Width="10%" DataField="ID_transactiontype" SortExpression="transactiontype">

                                            <ItemTemplate>
                                                <%# Eval("transactiontype") %>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddltransactiontype" runat="server" CssClass="HideArrow"
                                                    EnableLoadOnDemand="true"
                                                    Filter="Contains"
                                                    AllowCustomText="false"
                                                    DataTextField="transactiontype"
                                                    DataValueField="ID_transactiontype"
                                                    OnItemsRequested="ddltransactiontype_ItemsRequested">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="description" ItemStyle-Width="20%" HeaderStyle-Width="20%" HeaderText="Description"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="seggregation" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderText="Seggregation"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="receipt" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Receipt#"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cheque" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Cheque#"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="amount" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Amount"></telerik:GridBoundColumn>
                                        <telerik:GridDateTimeColumn PickerType="DatePicker" DataField="date" ItemStyle-Width="8%" HeaderStyle-Width="8%"  DataFormatString="{0:dd/MM/yyyy}" HeaderText="Posting Date"></telerik:GridDateTimeColumn>
                                        <telerik:GridDropDownColumn DropDownControlType="RadComboBox" ItemStyle-Width="6%" HeaderStyle-Width="6%" UniqueName="salereport" ReadOnly="true" DataField="salereport" HeaderText="Sale Report"></telerik:GridDropDownColumn>
                                        <telerik:GridBoundColumn DataField="crno" HeaderText="CR.No" ItemStyle-Width="6%" HeaderStyle-Width="6%" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridButtonColumn HeaderText="Del" ItemStyle-Width="5%" HeaderStyle-Width="5%" ConfirmText="Delete this Row?" ConfirmDialogType="Classic"
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
                    </div>
                </div>
                <center>
                <div class="row">
                    <asp:Button ID="NewBtn" OnClick="NewBtn_Click" class="btn btn-primary" runat="server" Text="Add New Reciept"/>
                    <asp:Button ID="DelBtn" OnClick="DelBtn_Click" class="btn btn-primary" runat="server" Text="Delete"/>
                    <asp:Button ID="NextBtn" OnClick="NextBtn_Click" class="btn btn-primary" runat="server" Text="Next"/>
                    <asp:Button ID="PrevBtn" OnClick="PrevBtn_Click" class="btn btn-primary" runat="server" Text="Prev"/>
                        <asp:Button ID="btnShowPopup" runat="server" OnClick="btnShowPopup_Click" Text="Invoice Clearance" class="btn btn-primary" />
                    </div>
                </center>
            </div>
            <!-- Bootstrap -->
            <!-- Bootstrap -->
            <!-- Modal Popup -->
            <center>    

                <div id="MyPopup" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content" style="width: max-content; margin-left: -60%">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">
                                    &times;</button>
                                <h4>Select Invoices to Clear
                                </h4>
                            </div>
                            <div class="modal-body" style="max-width: 1300px">
                            <div class="row">
                                <div class="col-lg-4">
                                    <label>Customer Name:</label>
                                    <input style="background-color:green; color:white" type="text" runat="server" id="customername" disabled clientidmode="Static" class="form-control" />
                                </div>
                                <div class="col-lg-4">
                                    <label>Voucher Amount:</label>
                                    <input style="background-color:red; color:white" type="text" runat="server" id="voucheramt" disabled clientidmode="Static" class="form-control" />
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
                                                <MasterTableView Width="100%" EditMode="Batch" CommandItemDisplay="Top" AutoGenerateColumns="false">
                                                    <CommandItemSettings ShowAddNewRecordButton="false" ShowSaveChangesButton="false" ShowCancelChangesButton="false" ShowRefreshButton="false" />
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true"
                                                            ForceExtractValue="Always" Display="false">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="invdate" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Inv. Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="invno" ItemStyle-Width="6%" HeaderStyle-Width="6%" HeaderText="Inv/Ref.#" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="ticketno" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderText="Ticket No." ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="ticketvalue" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Amount" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="credit" ItemStyle-Width="8%" HeaderStyle-Width="8%" ReadOnly="true" HeaderText="Recv Amount"></telerik:GridBoundColumn>
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
                    <asp:Button ID="DelInvBtn" OnClick="DelInvBtn_Click" class="btn btn-primary" runat="server" Text="Delete"/>
                                </div>
                                <div class="col-lg-1 col-lg-offset-2">
                                    <label style="font-size: larger">Total:</label>
                                </div>
                                <div class="col-lg-4">
                                    <div class="col-lg-4">
                                        <input style="background-color:orange" type="text" runat="server" id="invtkttotal" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                    <div class="col-lg-4">
                                        <input style="background-color:orange" type="text" runat="server" id="invrcvtotal" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                    <div class="col-lg-4">
                                        <input style="background-color:saddlebrown; color:white" type="text" runat="server" id="invbalancetotal" disabled clientidmode="Static" class="form-control" />
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
                                    <input style="background-color:green; color:white" type="text" runat="server" id="customername1" disabled clientidmode="Static" class="form-control" />
                                </div>
                                <div class="col-lg-4">
                                    <label>Voucher Clearable Amount:</label>
                                    <input style="background-color:red; color:white" type="text" runat="server" id="voucheramt1" disabled clientidmode="Static" class="form-control" />
                                </div>
                            </div>
                                <div class="content">
                                    <div class="panel panel-info" style="background-color: #f4f7f7">

                                        <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
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
                                                    document.getElementById('<%=creditrd.ClientID%>').value = credit;
                                                    document.getElementById('<%=balancerd.ClientID%>').value = balance;
                                                    document.getElementById('<%=idrd.ClientID%>').value = id;
                                                    var tables = [];
                                                    tables.push(masterTable);
                                                    var batchManager = grid.get_batchEditingManager();
                                                    batchManager.saveTableChanges(tables);
                                                }

                                            </script>
                                        </telerik:RadCodeBlock>
                                        <asp:Panel ID="Panel3" runat="server">
                                            <telerik:RadToolTip runat="server" ID="RadToolTip3" OffsetY="0" RenderInPageRoot="false"
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
                                                        <telerik:GridBoundColumn DataField="ticketvalue" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Amount" ReadOnly="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="amount" ItemStyle-Width="8%" HeaderStyle-Width="8%" HeaderText="Recv Amount"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="balance" HeaderText="Balance" ItemStyle-Width="8%" HeaderStyle-Width="8%"></telerik:GridBoundColumn>
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
                                <div class="col-lg-1 col-lg-offset-3">
                                    <label style="font-size: larger">Total:</label>
                                </div>
                                <div class="col-lg-4">
                                    <div class="col-lg-4">
                                        <input style="background-color:orange" type="text" runat="server" id="Text3" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                    <div class="col-lg-4">
                                        <input style="background-color:orange" type="text" runat="server" id="Text4" disabled clientidmode="Static" class="form-control" />
                                    </div>
                                    <div class="col-lg-4">
                                        <input style="background-color:saddlebrown; color:white" type="text" runat="server" id="Text5" disabled clientidmode="Static" class="form-control" />
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
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/greencheck.png" Style="height: 100px; width: 100px;" /><br />
                                <label>Reciept # </label>
                                <label id="vno" runat="server"></label>
                                <label>Created Successfully!</label><br />
                                <label>Change Voucher #</label>
                                <input type="number" runat="server" id="Text2" clientidmode="Static" class="form-control" /><br />
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
</asp:Content>