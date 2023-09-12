<%@ Page Title="Bank Payment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" ValidateRequest="false" EnableEventValidation="false" CodeBehind="CashPayment.aspx.cs" Inherits="Coffer_Systems.CashPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title></title>
        <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css" />

        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
                        <link href="styles/loader.css" rel="stylesheet" />

        <%--    <script type="text/javascript" src="/js/DataTablesEditor.js"></script>--%>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.css" />
        <link href="assets/css/StyleSheet1.css" rel="stylesheet" />
        <link href="styles/grid.css" rel="stylesheet" />
        <!-- GOOGLE FONTS-->
        <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js" type="text/javascript"></script>
        <script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" defer></script>
        <script src="assets/js/datatables.js"></script>


    </head>


    <script type="text/javascript">

        function showsuccesspopup() {
            jQuery.noConflict();
            $('#successpopup').modal('show');
        }
        function showupdatepopup() {
            jQuery.noConflict();
            $('#updatepopup').modal('show');
        }
        function searchPopup() {
            jQuery.noConflict();
            $('#searchPopup').modal('show');
        }
        function showdeletepopup() {
            jQuery.noConflict();
            $('#deletepopup').modal('show');
        }
        function showdeletepopup1() {
            jQuery.noConflict();
            $('#deletepopup1').modal('show');
        }
        function showfailurepopup() {
            jQuery.noConflict();
            $('#failurepopup').modal('show');
        }
        function alertPopup() {
            jQuery.noConflict();
            $('#alertPopup').modal('show');
        }
        function NoExistPopup() {
            jQuery.noConflict();
            $('#NoExistPopup').modal('show');
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
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <div id="loader-overlay" class="loader-overlay" style="display: none;">
    <div class="loader" style="justify-items:center">
        <img src="Images/Coffer.png" alt="Loading..." class="loader-logo"  loading="lazy"/>
        <div class="loader-spinner"></div>
    </div>
</div>
    <div id="page-wrapper">
        <div class="row form-group">

            <div>
                <h1 class="col-lg-7 col-lg-offset-4">Bank Payment Voucher</h1>
            </div>
            <br />
            <input type="text" runat="server" id="Text1" visible="false" clientidmode="Static" class="form-control" />
        </div>
        <div class="panel panel-info" style="background-color: #f4f7f7">
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-1">
                        <label>Voucher #</label>
                        <input type="text" runat="server" id="invno" style="font-size: 16px !important; font-weight: bold !important" readonly clientidmode="Static" class="form-control" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <label>Account Name</label>
                        <input type="text" runat="server" id="accname" disabled clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Total Debit</label>
                        <input type="text" runat="server" id="debit" disabled clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Total Credit</label>
                        <input type="text" runat="server" id="credit" disabled clientidmode="Static" class="form-control" />
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
                                <MasterTableView EditMode="Batch" OnDataBinding="Unnamed_DataBinding" CommandItemDisplay="Top" AutoGenerateColumns="false" ClientDataKeyNames="Code" Font-Size="10px">
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
                                        <telerik:GridDateTimeColumn PickerType="DatePicker" DataField="date" ItemStyle-Width="8%" HeaderStyle-Width="8%" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Posting Date"></telerik:GridDateTimeColumn>
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
                        <asp:Button ID="NewBtn" OnClick="NewBtn_Click" class="btn btn-primary" runat="server" Text="Add New Voucher" />
                        <asp:Button ID="DelBtn" OnClick="DelBtn_Click" class="btn btn-primary" runat="server" Text="Delete" />
                        <asp:Button ID="PrevBtn" OnClick="PrevBtn_Click" class="btn btn-primary" runat="server" Text="Prev" />
                        <asp:Button ID="NextBtn" OnClick="NextBtn_Click" class="btn btn-primary" runat="server" Text="Next" />
                        <asp:Button ID="searchButton" OnClick="searchButton_Click" class="btn btn-primary" runat="server" Text="Search" />

                        <%--<label>For Cash Payment Voucher</label>
                        <p>
                           Enter the Account Code By selecting the drop-down list. When you save the voucher the cash account code (10001) will be automatically credit. Cash A/C Code 10001 is not allow in this voucher.</p>
                        --%>
                    </div>
                </center>
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
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/greencheck.png" Style="height: 100px; width: 100px;" /><br />
                                <label>Voucher # </label>
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
        <div id="failurepopup" class="modal fade" role="dialog">
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
                                <label>Debit and Credit values are not equal. Please Re-Enter.</label><br />
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
                                <label>No Record Exists. Please click on ‘Add New Voucher’ to start posting.</label><br />
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
        <div id="updatepopup" class="modal fade" role="dialog">
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
                                <label id="Label1" runat="server"></label>
                                <label>Updated Successfully!</label><br />
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
        <div id="deletepopup" class="modal fade" role="dialog">
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
                                <label id="Label2" runat="server"></label>
                                <label>Deleted Successfully!</label><br />
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
        <div id="searchPopup" class="modal fade" role="dialog">
            <div class="modal-dialog" style="background-color: #f4f7f7">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; min-width: 600px">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <center>
                        <h4>Search Voucher
                        </h4>
                    </center>
                </div>
                    <div class="modal-body" style="width: 600px">
                        <div class="panel-body">
                            <div class="row">
                                <label>Voucher No</label>
                                <input type="number" runat="server" id="invoiceSearch" clientidmode="Static" class="form-control" /><br />
                                <asp:Button ID="searchOK" OnClick="searchOk_Click" class="btn btn-primary" runat="server" Text="Search Voucher" />
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
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/warning.png" Style="height: 100px; width: 100px;" /><br />
                                <label>Are you sure you want to delete this Voucher?</label><br />
                                <asp:Button ID="Yes" OnClick="Yes_Click" class="btn btn-primary" runat="server" Text="Yes" />
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
                                <label>The Voucher number you entered does not exists.</label><br />
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

