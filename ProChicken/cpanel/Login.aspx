<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="JericoTransportManagment.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Admin Login</title>    
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="description" content="#"/>
    <meta name="keywords" content="#"/>
    <meta name="author" content="#"/>
    <!-- Favicon icon -->
    <link rel="icon" href="../assets/images/logo.jpeg" type="image/x-icon"/>
    <!-- Google font--><link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,800" rel="stylesheet">
    <!-- Required Fremwork -->
    <link rel="stylesheet" type="text/css" href="files\bower_components\bootstrap\css\bootstrap.min.css"/>
    <!-- themify-icons line icon -->
    <link rel="stylesheet" type="text/css" href="files\assets\icon\themify-icons\themify-icons.css"/>
    <!-- ico font -->
    <link rel="stylesheet" type="text/css" href="files\assets\icon\icofont\css\icofont.css"/>
    <!-- Style.css -->
    <link rel="stylesheet" type="text/css" href="files\assets\css\style.css"/>
    
    <style>
        .error {
            color:red;
            font-size:12px;
            display:none;
            margin:10px 3px;
        }
    </style>

    <script>
        window.setTimeout(function () {
            $(".alert").fadeTo(500, 0).slideUp(500, function () {
                $(this).remove();
            });
        }, 4000);

        
        function validation() {
            if (document.getElementById('<%=txtUserName.ClientID%>').value == "") {
                document.getElementById("lblUName").style.display = "block";
                document.getElementById('<%=txtUserName.ClientID%>').focus();
                window.setTimeout(function () { $("#lblUName").attr("style", "display:none"); }, 3000);
                return false;
            }
            if (document.getElementById('<%=txtPassword.ClientID%>').value == "") {
                document.getElementById("lblPassword").style.display = "block";
                document.getElementById('<%=txtPassword.ClientID%>').focus();
                window.setTimeout(function () { $("#lblPassword").attr("style", "display:none"); }, 3000);
                return false;
             }
        }
    </script>
</head>

<body class="fix-menu">
    <!-- Pre-loader start -->
    <div class="theme-loader">
        <div class="ball-scale">
            <div class='contain'>
                <div class="ring"><div class="frame"></div></div>
                <div class="ring"><div class="frame"></div></div>
                <div class="ring"><div class="frame"></div></div>
                <div class="ring"><div class="frame"></div></div>
                <div class="ring"><div class="frame"></div></div>
                <div class="ring"><div class="frame"></div></div>
                <div class="ring"><div class="frame"></div></div>
                <div class="ring"><div class="frame"></div></div>
                <div class="ring"><div class="frame"></div></div>
                <div class="ring"><div class="frame"></div></div>
            </div>
        </div>
    </div>
    <!-- Pre-loader end -->

    <section class="login-block">
        <!-- Container-fluid starts -->
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <!-- Authentication card start -->
                    
                        <form runat="server" class="md-float-material form-material">
                            <div class="text-center">
                                <span class="font-weight-bold f-26" style="text-shadow: 0px 0px 13px #fff;"><span style="color:#401212">Pro</span><span style="color:#f97c2d">-</span><span style="color:#ffb92e">Chicken</span></span>
                            </div>
                            <div class="auth-box card">
                                <div class="card-block">
                                    <div class="row m-b-20">
                                        <div class="col-md-12">
                                            <h3 class="text-center">Sign In</h3>
                                        </div>
                                    </div>
                                    <div class="form-group form-primary">
                                        <input runat="server" id="txtUserName" type="text" name="email" class="form-control" required="" placeholder="Your Email ID / Mobile" />
                                        <label id="lblUName" class="error">Please enter username</label>
                                        <span class="form-bar"></span>
                                    </div>
                                    <div class="form-group form-primary">
                                        <input  runat="server" id="txtPassword" type="password" name="password" class="form-control" required="" placeholder="Password"/>
                                        <label id="lblPassword" class="error">Please enter password</label>
                                        <span class="form-bar"></span>
                                    </div>
                                    <div class="row m-t-25 text-left">
                                        <div class="col-12">
                                            <div class="checkbox-fade fade-in-primary d-">
                                                <label>                                                    
                                                    <asp:CheckBox ID="chbxRemember" runat="server" />
                                                    <span class="cr"><i class="cr-icon icofont icofont-ui-check txt-primary"></i></span>
                                                    <span class="text-inverse">Remember me</span>
                                                </label>
                                            </div>
                                            <%--<div class="forgot-phone text-right f-right">
                                                <a href="auth-reset-password.htm" class="text-right f-w-600"> Forgot Password?</a>
                                            </div>--%>
                                        </div>
                                    </div>
                                    <div class="row m-t-30">
                                        <div class="col-md-12">
                                            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary btn-md btn-block waves-effect waves-light text-center m-b-20" Text="Sign in" OnClick="btnSubmit_Click" OnClientClick="return validation()" />
                                        </div>
                                    </div>
                                    <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Visible="false">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="color:indianred"><span aria-hidden="true">&times;</span></button>
                                        <asp:Label ID="lblalert" runat="server" Text="" Font-Size="12px" Font-Bold="true"></asp:Label>
                                    </asp:Panel>
                                    <hr/>
                                    <div class="row">
                                        <div class="col-9">
                                            <p class="text-inverse text-left m-b-0">Thank you.</p>
                                            <p class="text-inverse text-left"><a href="../index.aspx"><b class="f-w-600">Back to website</b></a></p>
                                        </div>
                                        <div class="col-3">
                                                <a href="../index.aspx"><img src="../assets/images/logo.png" width="70"/></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!-- end of form -->
                </div>
                <!-- end of col-sm-12 -->
            </div>
            <!-- end of row -->
        </div>
        <!-- end of container-fluid -->
    </section>
    <!-- Warning Section Starts -->
   
    <!-- Warning Section Ends -->
    <!-- Required Jquery -->
    <script type="text/javascript" src="files\bower_components\jquery\js\jquery.min.js"></script>
    <script type="text/javascript" src="files\bower_components\jquery-ui\js\jquery-ui.min.js"></script>
    <script type="text/javascript" src="files\bower_components\popper.js\js\popper.min.js"></script>
    <script type="text/javascript" src="files\bower_components\bootstrap\js\bootstrap.min.js"></script>
    <!-- jquery slimscroll js -->
    <script type="text/javascript" src="files\bower_components\jquery-slimscroll\js\jquery.slimscroll.js"></script>
    <!-- modernizr js -->
    <script type="text/javascript" src="files\bower_components\modernizr\js\modernizr.js"></script>
    <script type="text/javascript" src="files\bower_components\modernizr\js\css-scrollbars.js"></script>
    <!-- i18next.min.js -->
    <script type="text/javascript" src="files\bower_components\i18next\js\i18next.min.js"></script>
    <script type="text/javascript" src="files\bower_components\i18next-xhr-backend\js\i18nextXHRBackend.min.js"></script>
    <script type="text/javascript" src="files\bower_components\i18next-browser-languagedetector\js\i18nextBrowserLanguageDetector.min.js"></script>
    <script type="text/javascript" src="files\bower_components\jquery-i18next\js\jquery-i18next.min.js"></script>
    <script type="text/javascript" src="files\assets\js\common-pages.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async="" src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-23581568-13');
</script>
</body>

</html>
