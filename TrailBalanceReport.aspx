<%@ Page Title="Reports" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrailBalanceReport.aspx.cs" Inherits="Coffer_Systems.TrailBalanceReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title></title>

        <link href="assets/css/StyleSheet1.css" rel="stylesheet" />
        <script src="Scripts/jquery-3.4.1.min.js"></script>
        <script src="Scripts/bootstrap.min.js"></script>
        
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
        <div class="row form-group" style="text-align: center">
            <h1>Reports</h1>
        </div>
        <div class="panel panel-info" style="background-color: #f4f7f7">
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-2">
                        <label>
                            Select Report
                        </label>
                        <asp:DropDownList runat="server" ClientIDMode="Static" ID="ReportType" class="form-control dropdown-toggle">
                            <asp:ListItem Text="Trial Balance" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Balance Sheet" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Profit & Loss" Value="3"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <div class="col-lg-6">
                            <label>From Date</label>
                            <input type="date" style="font-size: 11px" runat="server" id="fromDate" clientidmode="Static" class="form-control" value="2022-11-01" />
                        </div>

                        <div class="col-lg-6">
                            <label>To Date</label>
                            <input type="date" style="font-size: 11px" runat="server" id="toDate" clientidmode="Static" class="form-control" value="2023-08-31" />
                        </div>
                    </div>
                    <div class="col-2" style="margin-top: 23px">
                        <asp:Button ID="generateBtn" runat="server" Text="Generate" OnClick="generateBtn_Click" class="btn btn-primary" />
                    </div>
                </div>
                <br />
                <br />
                <div class="row">
                    <center>
                        <div class="col-lg-9 col-lg-offset-3" style="text-align: center;">
                            <rsweb:ReportViewer ID="ReportViewer" Height="500px" ProcessingMode="Local" runat="server"></rsweb:ReportViewer>
                        </div>
                    </center>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
