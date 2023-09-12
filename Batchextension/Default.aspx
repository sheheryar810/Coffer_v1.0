<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
		
	</style>
    <link href="batchManagerExtensions.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
                <asp:ScriptReference Path="batchManagerExtentions.js" />
            </Scripts>
        </telerik:RadScriptManager>

        

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

            </script>
        </telerik:RadCodeBlock>

        <asp:Panel ID="Panel1" runat="server">
            <telerik:RadToolTip runat="server" ID="RelatedComboBoxesToolTip" OffsetY="0" RenderInPageRoot="false"
                HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                ShowEvent="FromCode" Position="Center" Skin="Default">
                <telerik:RadComboBox runat="server"  EnableLoadOnDemand="true" OnItemsRequested="RadComboBox1_ItemsRequested">
                </telerik:RadComboBox>
            </telerik:RadToolTip>

            <telerik:RadGrid ID="RadGrid1" runat="server" OnNeedDataSource="RadGrid1_NeedDataSource"
                OnBatchEditCommand="RadGrid1_BatchEditCommand">
                <MasterTableView EditMode="Batch" CommandItemDisplay="Top" AutoGenerateColumns="false">
                    <Columns>
                                        <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true"
                                            ForceExtractValue="Always" Display="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="code" HeaderText="Code" ReadOnly="true"></telerik:GridBoundColumn>
                        
                        <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="Name" HeaderText="Name" DataField="ID_Name" SortExpression="Name">
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="ddlName" runat="server"
                                EnableLoadOnDemand="true"
                                Filter="Contains"
                                AllowCustomText="false"
                                DataTextField="Name"
                                DataValueField="ID_Name"
                                OnItemsRequested="ddlName_ItemsRequested">
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="transactiontype" HeaderText="transactiontype" DataField="ID_transactiontype" SortExpression="transactiontype">
                        <ItemTemplate>
                            <%# Eval("transactiontype") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="ddltransactiontype" runat="server"
                                EnableLoadOnDemand="true"
                                Filter="Contains"
                                AllowCustomText="false"
                                DataTextField="transactiontype"
                                DataValueField="ID_transactiontype"
                                OnItemsRequested="ddltransactiontype_ItemsRequested">
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="description" HeaderText="Description"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="seggregation" HeaderText="Seggregation"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="receipt" HeaderText="Receipt#"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cheque" HeaderText="Cheque#"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="amount" HeaderText="Amount"></telerik:GridBoundColumn>
                                        <telerik:GridDateTimeColumn PickerType="DatePicker" DataField="date" DataFormatString="{0:MM/dd/yy}" HeaderText="Posting Date"></telerik:GridDateTimeColumn>
                                        <telerik:GridDropDownColumn DropDownControlType="RadComboBox" UniqueName="salereport" ReadOnly="true" DataField="salereport" HeaderText="Sale Report"></telerik:GridDropDownColumn>
                                        <telerik:GridBoundColumn DataField="crno" HeaderText="CR.No" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridButtonColumn HeaderText="Delete" ConfirmText="Delete this Row?" ConfirmDialogType="Classic"
                                            ConfirmTitle="Delete" ButtonType="FontIconButton" CommandName="Delete">
                                        </telerik:GridButtonColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings AllowKeyboardNavigation="true">
                    <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    <ClientEvents OnUserAction="userAction" OnGridCreated="gridCreated" />
                </ClientSettings>
            </telerik:RadGrid>
        </asp:Panel>
    </form>
</body>
</html>
