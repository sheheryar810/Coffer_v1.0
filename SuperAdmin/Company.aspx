<%@ Page Title="Super Admin Dashboard" Language="C#" AutoEventWireup="true" ValidateRequest="false" EnableEventValidation="false" CodeBehind="Company.aspx.cs" Inherits="Coffer_Systems.Company" %>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Super Admin Dashboard</title>
    <link href="../coffer_final_logo_png_Dxn_icon.ico" rel="shortcut icon" type="image/x-icon" />
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- JQVMap -->
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <!-- summernote -->
    <link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js" type="text/javascript"></script>

</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <form runat="server">
        <asp:ScriptManager runat="server">
            <Scripts>
                <%--To learn more about bundling scripts in ScriptManager see https://go.microsoft.com/fwlink/?LinkID=301884 --%>
                <%--Framework Scripts--%>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Name="bootstrap" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                <asp:ScriptReference Name="WebFormsBundle" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
                <asp:ScriptReference Path="../Batchextension/batchManagerExtentions.js" />
                <%--Site Scripts--%>
            </Scripts>
        </asp:ScriptManager>
        <div class="wrapper">
            <!-- Main Sidebar Container -->
            <aside class="main-sidebar sidebar-dark-primary elevation-4">
                <!-- Brand Logo -->
                <a class="brand-link">
                    <img src="dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
                    <span class="brand-text font-weight-light">Admin Panel</span>
                </a>

                <!-- Sidebar -->
                <div class="sidebar">
                    <!-- Sidebar user panel (optional) -->
                    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                        <div class="image">
                            <img src="../Images/account_avatar_human_male_man_men_people_person_profile_user_users_icon_512.png" class="img-circle elevation-2" alt="User Image">
                        </div>
                        <div class="info">
                            <a class="d-block">
                                <asp:Label runat="server" ID="user"></asp:Label></a>
                        </div>
                    </div>
                    <nav class="mt-2">
                        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                            <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
                            <li class="nav-item menu-open">
                                <a href="DashboardSA.aspx" class="nav-link active">
                                    <i class="nav-icon fas fa-tachometer-alt"></i>
                                    <p>
                                        Dashboard
             
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="Company.aspx" class="nav-link active">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Company</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="User.aspx" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Users</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../login.aspx" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Logout</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                    <!-- /.sidebar-menu -->
                </div>
                <!-- /.sidebar -->
            </aside>
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <div class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">Add Company</h1>
                            </div>
                            <!-- /.col -->
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <li class="breadcrumb-item"><a href="DashboardSA.aspx">Home</a></li>
                                    <li class="breadcrumb-item active">Company</li>
                                </ol>
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.container-fluid -->
                </div>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <!-- Small boxes (Stat box) -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel panel-info" style="background-color: #f4f7f7">

                                    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                                        <script type="text/javascript">
                                            function rowSelected(sender, args) {
                                            }
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

                                            function OnClientSelectedIndexChanged(sender, eventArgs) {
                                            }

                                            function OnClientSelectedIndexChanged1(sender, eventArgs) {
                                                

                                                const aa = 1;
                                                const ab = 9;
                                                const number1 = Math.random() * (ab - aa + 1);
                                                const number2 = Math.random() * (ab - aa + 1);
                                                const characters = "ABCDEFGHIJKLMNOPQRSTUVWXTZ";
                                                var char1 = "";
                                                var char2 = "";

                                                for (var i = 0; i < 1; i++) {
                                                    var rnum = Math.floor(Math.random() * characters.length);
                                                    char1 = characters.substring(rnum, rnum + 1);
                                                }
                                                for (var i = 0; i < 1; i++) {
                                                    var rnum = Math.floor(Math.random() * characters.length);
                                                    char2 = characters.substring(rnum, rnum + 1);
                                                }

                                                const officeID = Math.ceil(number1) + char1 + Math.ceil(number2) + char2;
                                                console.log(officeID);

                                                var grid = $find('<%= RadGrid1.ClientID %>');
                                                var masterTable = grid.get_masterTableView();
                                                var row = document.getElementById("row").value;
                                                if (row == undefined || row == "") {
                                                    row = 0;
                                                }
                                                var item = masterTable.get_dataItems()[row];
                                                var cell2 = masterTable.getCellByColumnUniqueName(item, "officeID");
                                                $telerik.$(cell2).text(officeID);
                                                document.getElementById("officeID").value = officeID;
                                            }
                                            function onRowSelected(sender, args) {
                                                var grid = $find('<%= RadGrid1.ClientID %>');
                                                 var masterTable = grid.get_masterTableView();
                                                var item = masterTable.get_dataItems()[args.get_itemIndexHierarchical()];
                                                document.getElementById('row').value = item.get_itemIndexHierarchical();
                                             }
                                        </script>
                                    </telerik:RadCodeBlock>
                                    <input type="text" id="country" hidden="hidden" class="form-group" />
                                    <input type="text" id="row" hidden="hidden" class="form-group" />
                                    <input type="text" id="officeID" runat="server" hidden="hidden" class="form-group" />

                                    <telerik:RadToolTip runat="server" ID="RadToolTip1" OffsetY="0" RenderInPageRoot="false"
                                        HideEvent="FromCode" AutoCloseDelay="0" RelativeTo="Element" CssClass="RelatedCombosToolTip"
                                        ShowEvent="FromCode" Position="Center" Skin="Default">
                                        <telerik:RadComboBox runat="server" EnableLoadOnDemand="true" OnItemsRequested="RadComboBox1_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </telerik:RadToolTip>

                                    <asp:Panel ID="Panel1" runat="server">
                                        <telerik:RadGrid ID="RadGrid1" runat="server" OnNeedDataSource="RadGrid1_NeedDataSource"
                                            OnBatchEditCommand="RadGrid1_BatchEditCommand">
                                            <MasterTableView EditMode="Batch" CommandItemDisplay="Top" AutoGenerateColumns="false" ClientDataKeyNames="name" Font-Size="10px">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="id" HeaderText="ID" ReadOnly="true"
                                                        ForceExtractValue="Always" Display="false">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="name" ItemStyle-Width="15%" HeaderStyle-Width="15%" HeaderText="Name"></telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="country" HeaderText="Country" ItemStyle-Width="10%" HeaderStyle-Width="10%" DataField="ID_Country" SortExpression="country">
                                                        <ItemTemplate>
                                                            <%# Eval("Country") %>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="ddlCountry" runat="server" CssClass="HideArrow"
                                                                EnableLoadOnDemand="true"
                                                                Filter="Contains"
                                                                AllowCustomText="false"
                                                                DataTextField="Country"
                                                                DataValueField="ID_Country"
                                                                OnItemsRequested="ddlCountry_ItemsRequested">
                                                            </telerik:RadComboBox>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn AutoPostBackOnFilter="true" UniqueName="city" HeaderText="City" ItemStyle-Width="10%" HeaderStyle-Width="10%" DataField="ID_City" SortExpression="city">
                                                        <ItemTemplate>
                                                            <%# Eval("City") %>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="ddlCity" runat="server" CssClass="HideArrow" OnClientSelectedIndexChanged="OnClientSelectedIndexChanged1"
                                                                EnableLoadOnDemand="true"
                                                                Filter="Contains"
                                                                AllowCustomText="false"
                                                                DataTextField="City"
                                                                DataValueField="ID_City"
                                                                OnItemsRequested="ddlCity_ItemsRequested">
                                                            </telerik:RadComboBox>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="officeID" UniqueName="officeID" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderText="Coffer ID">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="gst" ItemStyle-Width="5%" HeaderStyle-Width="5%" HeaderText="GST%"></telerik:GridBoundColumn>
                                                    <telerik:GridDateTimeColumn PickerType="DatePicker" DataField="fromdate" ItemStyle-Width="10%" HeaderStyle-Width="10%" DataFormatString="{0:MM/dd/yy}" HeaderText="Date From"></telerik:GridDateTimeColumn>
                                                    <telerik:GridDateTimeColumn PickerType="DatePicker" DataField="todate" ItemStyle-Width="10%" HeaderStyle-Width="10%" DataFormatString="{0:MM/dd/yy}" HeaderText="Date To"></telerik:GridDateTimeColumn>
                                                    <telerik:GridButtonColumn HeaderText="Del" ItemStyle-Width="5%" HeaderStyle-Width="5%" ConfirmText="Delete this Row?" ConfirmDialogType="Classic"
                                                        ConfirmTitle="Delete" ButtonType="FontIconButton" CommandName="Delete">
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                            </MasterTableView>
                                            <ClientSettings AllowKeyboardNavigation="true">
                                                <Selecting AllowRowSelect="true" />
                                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                                <ClientEvents OnUserAction="userAction" OnGridCreated="gridCreated" OnRowSelected="onRowSelected"/>
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                    </asp:Panel>
                                </div>
                            </div>
                            <!-- ./col -->

                        </div>
                    </div>
                </section>
            </div>
            <footer class="main-footer">
                <center>
                    <p>Coffer Systems (Pvt) Ltd - Copyright &copy; <%: DateTime.Now.Year %></p>
                </center>
            </footer>
        </div>
    </form>
</body>
</html>
