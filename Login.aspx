<%@ Page Language="C#" Title="Login" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Coffer_Systems.Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>Login</title>

            <link href="styles/loader.css" rel="stylesheet" />
    <!-- Font Icon -->
    <link rel="stylesheet" href="loginfonts/material-icon/css/material-design-iconic-font.min.css" />

    <!-- Main css -->
    <link href="coffer_final_logo_png_Dxn_icon.ico" rel="shortcut icon" type="image/x-icon" />
    <link rel="stylesheet" href="css/style.css" />
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="assets/css/StyleSheet1.css" rel="stylesheet" />
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <script src="assets/js/bootstrap.js"></script>

        
        <script type="text/javascript">

            function alertPopup() {
                jQuery.noConflict();
                jQuery('#alertPopup').modal('show');
            }

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
    <body>
        <div id="loader-overlay" class="loader-overlay" style="display: none;">
    <div class="loader" style="justify-items:center">
        <img src="Images/Coffer.png" alt="Loading..." class="loader-logo"  loading="lazy"/>
        <div class="loader-spinner"></div>
    </div>
</div>
    <div class="main">
        <form runat="server" id="form1">
        <!-- Sign in form -->
            <section class="sign-in" >
            <div class="container">
                <div class="signup-content" style="background-color:#f4f7f7; border-radius:10px">
                    <div class="signup-image">
                    <br />
                        <figure>
                            <img src="images/coffer.png" style="height:15vw; width:15vw" alt="sign in image"  loading="lazy"/>
                        </figure>
                    </div>

                    <div class="signin-form" style="text-align:center; margin-top:3%">
                        <h2 class="form-title">LOGIN</h2>
                        <div method="POST" runat="server">
                            <div class="form-group">
                                <label for="officeID"><i class="zmdi zmdi-account widget-user"></i></label>
                                <input type="text" id="officeID" required placeholder="Coffer ID" runat="server"/>
                            </div>
                            <div class="form-group">
                                <label for="your_name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="text" id="userName" required placeholder="User Name" runat="server"/>
                            </div>
                            <div class="form-group">
                                <label for="your_pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" id="password" required placeholder="Password" runat="server"/>
                            </div>
                            <div>
                                <asp:Button ID="signin" CssClass="btn-hover" runat="server" onclick="LoginButton_Click" type="submit" Text="Login" />
                            </div>
                            <br />
                            <br />
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </section>
            
            <center>
            <div id="alertPopup" class="modal fade" role="dialog">
            <div class="modal-dialog" style="background-color: #f4f7f7">
                <!-- Modal content-->
                <div class="modal-content" style="width: max-content; min-width: 600px">
                    <div class="modal-header">
                        <h4>The Username entered is being used by another session</h4>
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                    </div>
                    <div class="modal-body" style="width:600px">
                        <div class="panel-body">
                            <div class="row">
                                <asp:ImageButton runat="server" CssClass="icon" ImageUrl="~/images/warning.png" Style="height: 8vw; width: 10vw;" /><br />
                               <p>The Username entered is being used by another session:</p>
                                <ul>
                                <li><p>To go back to the sign in page and login with another username, Click on Close</p></li> 
                                <li><p>To disconnect the opened session and continue with the login, click on Force Sign In</p></li> 
                                </ul>
                        <asp:Button ID="forceSignIn" OnClick="forceSignIn_Click1" class="btn btn-primary" runat="server" Text="Force Sign In" /> 
                                <button type="button" class="btn btn-danger" data-dismiss="modal">
                                    Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </center>

        </form>

    </div>

</body>
</html>