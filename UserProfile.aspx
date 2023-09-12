<%@ Page Language="C#" Title="Profile" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" ValidateRequest="false" EnableEventValidation="false" MasterPageFile="~/Site.Master" Inherits="Coffer_Systems.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>Profile</title>
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css"/>
                <link href="styles/loader.css" rel="stylesheet" />
    
    <link href="assets/css/StyleSheet1.css" rel="stylesheet" />
    <!-- GOOGLE FONTS-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js" type="text/javascript"></script>
    <script src = "https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" defer ></script>
    <script src="assets/js/datatables.js"></script>
    
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
        <div class="row form-group">

            <div>
                <h1 class="col-lg-7 col-lg-offset-5">User Profile</h1>
            </div>
            <br />
        </div>
        <div class="panel panel-info"  style="background-color: #f4f7f7">
            <div class="panel-body">
                <div class="row" style="margin-top: 30px">
                    <div class="col-lg-2">
                        <label>User Name</label>
                        <input type="text" runat="server" id="user" readonly="readonly" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Email Address</label>
                        <input type="email" runat="server" id="email" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Profile Picture</label>
                        <asp:FileUpload ID="fileUpload" runat="server" />
                        </div>
                    <div class="col-lg-2">
                        <asp:Button ID="txtGetImage" runat="server" Text="Upload" OnClick="txtGetImage_Click" /><br />
                        <asp:label ID="lblMessage" runat="server"></asp:label>
                    </div>
                    <div class="col-lg-2">
                        <asp:Image ID="Image1" runat="server" Width="100px" /> 
                    </div>
                </div>
                
                <div style="margin-top: 30px">
                <h1 class="col-lg-7 col-lg-offset-5">Change Password</h1>
                    
                    <div class="col-lg-2">
                        <label>Old Password</label>
                        <input type="password" runat="server" id="oldpass" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>New Password</label>
                        <input type="password" runat="server" id="pass1" clientidmode="Static" class="form-control" />
                    </div>
                    <div class="col-lg-2">
                        <label>Confirm Password</label>
                        <input type="password" runat="server" id="pass2" clientidmode="Static" class="form-control" />
                    </div>
                    <div style="padding:90px">
                        <asp:Button ID="Save" runat="server" CssClass="default" Text="Save" OnClick="AddButton_Click" />
                    </div>
            </div>
    </div>
            </div>
        </div>
</asp:Content>
