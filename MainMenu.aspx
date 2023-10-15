<%@ Page Language="C#" Title="Main Menu" AutoEventWireup="true" CodeBehind="MainMenu.aspx.cs" Inherits="Coffer_Systems.MainMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Main Menu</title>
    <link rel="stylesheet" type="text/css" href="css/metro.css" />
    <link rel="stylesheet" type="text/css" href="css/metro_mobile.css" media="screen and (max-height: 600px), screen and (orientation:portrait)" />
    <link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="assets/css/StyleSheet1.css" />
    <link rel="stylesheet" type="text/css" href="styles/loader.css" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link href="coffer_final_logo_png_Dxn_icon.ico" rel="shortcut icon" type="image/x-icon" />
</head>

<body style="background-color: #f4f7f7">

    <form runat="server">
        <div id="loader-overlay" class="loader-overlay" style="display: none;">
            <div class="loader" style="justify-items: center">
                <img loading="lazy" src="Images/Coffer.png" alt="Loading..." class="loader-logo" />
                <div class="loader-spinner"></div>
            </div>
        </div>
        <div id="page-wrapper" style="font-size: large">
            <section class="content">

                <div class="row">
                    <div style="margin-top: 2%; float: right" class="col-lg-2">
                        <a href="Logout.aspx">
                            <img loading="lazy" src="images/signout.png" style="height: 60px; width: 60px" alt="Sign Out" /></a>
                        <span>
                            <br />
                            <label style="text-align: center; color: black;">Logout</label>
                        </span>
                    </div>
                </div>
                <div class="row" style="margin-top: 5%">
                    <center>
                        <div id="codingDiv" class="col-lg-2 col-lg-offset-1" style="margin-top: 1%">
                            <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/core.png" ID="coding" OnClick="coding_Click" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Coding</label>
                            </span>
                        </div>
                        <div id="salesDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" CssClass="icon" ImageUrl="~/images/48-512.png" ID="sale" OnClick="sale_Click" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Invoicing</label>
                            </span>
                        </div>
                        <div id="refundDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" CssClass="icon" ImageUrl="~/images/refund.png" ID="refund" OnClick="refund_Click" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Refund</label>
                            </span>
                        </div>
                        <div id="reportsDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" OnClick="ReportBtn_Click" runat="server" ImageUrl="~/images/reports.png" CssClass="icon" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Reports</label>
                            </span>
                        </div>
                        <div id="hotelVoucherDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" ImageUrl="~/images/voucher.png" OnClick="hv_Click" Style="height: 60px; width: 60px;" CssClass="icon" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Hotel Voucher</label>
                            </span>
                        </div>
                        <div id="jvDiv" class="col-lg-2 col-lg-offset-1" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" ImageUrl="~/images/journalvoucher.png" OnClick="jv_Click" CssClass="icon" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Journal Voucher</label>
                            </span>
                        </div>
                        <div id="dayBookDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" ImageUrl="~/images/daybook.png" CssClass="icon" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Day Book</label>
                            </span>
                        </div>
                        <div id="ledgerDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" ImageUrl="~/images/ledger.png" CssClass="icon" OnClick="ledger_Click" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Ledger</label>
                            </span>
                        </div>
                        <div id="accountsDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" ImageUrl="~/images/account_avatar_human_male_man_men_people_person_profile_user_users_icon_512.png" CssClass="icon" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Accounts</label>
                            </span>
                        </div>
                        <div id="clientProfileDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" ImageUrl="~/images/elevator-user-man-ui-round-login-512.png" CssClass="icon" OnClick="Unnamed_Click5" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Client Profile</label>
                            </span>
                        </div>
                        <div id="inquiryDiv" class="col-lg-2 col-lg-offset-1" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" ImageUrl="~/images/salee.png" CssClass="icon" OnClick="Unnamed_Click4" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Inquiry</label>
                            </span>
                        </div>
                        <div id="bankrecDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" CssClass="icon" ImageUrl="~/images/cashpayvoucher.png" OnClick="Unnamed_Click2" class="icon" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Bank/Cash Reciept Voucher</label>
                            </span>
                        </div>
                        <div id="cashpayDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" CssClass="icon" ImageUrl="~/images/cashpa.png" OnClick="Unnamed_Click1" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Bank/Cash Payment Voucher</label>
                            </span>
                        </div>
                        <div id="financialDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" ImageUrl="~/images/genralvoi.png" CssClass="icon" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Financial</label>
                            </span>
                        </div>
                        <div id="packagesDiv" class="col-lg-2" style="margin-top: 1%">
                            <asp:ImageButton loading="lazy" runat="server" ImageUrl="~/images/packages.png" CssClass="icon" Style="height: 60px; width: 60px;" />
                            <span>
                                <br />
                                <label style="text-align: center; color: black; letter-spacing: 1px;">Packages</label>
                            </span>
                        </div>
                    </center>
                </div>

            </section>
        </div>
    </form>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js" async></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js" async></script>
    <script src="javascript/metro.js" async></script>
    <script src="javascript/demo.js" async></script>

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
</body>
</html>
