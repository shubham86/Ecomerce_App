 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index3.aspx.cs" Inherits="ProChicken.index3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pro Chicken</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <meta name="description" content="Company Has Started Its Business In Pune (Maharashtra)In 2006 . All Production Parameters Are For Export Quality Only , Growing Of Broiler Birds Under Standard Feeding , Good Management &Healthy Environment We Have Our Own Production Farms For Broiler ( Chicken ) And Layers ( Eggs ) Which Is Monitored Under Technical Staff & It Is Leading By Experienced Veterinary Doctors Having 20 To 25 Years Experience In India As Well As International Market." />
    <meta name="keywords" content="Chiken Shop, Egg Shop, buy chicken online, buy eggs online, pro chiken, profeed, premix" />
    <meta name="author" content="Jerico Technologies" />
    <link rel="icon" href="assets/images/logo-small.png" type="image/x-icon" />
    <link rel="shortcut icon" href="assets/images/logo-small.png" type="image/x-icon" />
    <!--Google font-->
    <link href="https://fonts.googleapis.com/css?family=PT+Sans:400,700&amp;display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Raleway&amp;display=swap" rel="stylesheet" />
    <!--icon css-->
    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="assets/css/themify.css" />
    <!--Slick slider css-->
    <link rel="stylesheet" type="text/css" href="assets/css/slick.css" />
    <%--<link rel="stylesheet" type="text/css" href="assets/css/slick-theme.css" />--%>
    <!--Animate css-->
    <link rel="stylesheet" type="text/css" href="assets/css/animate.css" />
    <!-- Bootstrap css -->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.css" />
    <!-- Theme css -->
    <link rel="stylesheet" type="text/css" href="assets/css/color6.css" media="screen" id="color" />
    <!-- Select 2 css -->
    <link rel="stylesheet" href="cpanel\files\bower_components\select2\css\select2.min.css" />
    <style>
        .select2-container {
            width:100% !important;
        }
        .select2-results__option[aria-selected] {
            width:100%;
        }
        .select2-container--default .select2-results__option[aria-selected=true] {
            width:100%;
        }
        .select2-container--default .select2-selection--single{
            border:1px solid #ccc;
        }
        .select2-container--default .select2-selection--single {
            height:37px;
        }
            .select2-container--default .select2-selection--single .select2-selection__arrow {
                height:35px;
            }
        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height:35px;
        }

    </style>
    <script>
        window.onload = function load() {
            if (document.getElementById('<%=ddlPayMode.ClientID%>').value == "1") {
                document.getElementById("transaction").style.display = "block";
            }
        }

        function validation() {
            if (document.getElementById('<%=lblBillTotal.ClientID%>').innerHTML == "0.00" || document.getElementById('<%=lblBillTotal.ClientID%>').innerHTML == "0") {
                document.getElementById("lblEmptyCart").style.display = "block";
                document.getElementById('<%=btnCheckOut.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtMobile.ClientID%>').value == "") {
                document.getElementById("lblMobile").style.display = "block";
                document.getElementById('<%=txtMobile.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtMobile.ClientID%>').value.length < 10) {
                document.getElementById("lblMobile1").style.display = "block";
                document.getElementById('<%=txtMobile.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtName.ClientID%>').value == "") {
                document.getElementById("lblName").style.display = "block";
                document.getElementById('<%=txtName.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtFlat.ClientID%>').value == "") {
                document.getElementById("lblFlat").style.display = "block";
                document.getElementById('<%=txtFlat.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlBuilding.ClientID%>').value == "0") {
                document.getElementById("lblBuilding").style.display = "block";
                document.getElementById('<%=ddlBuilding.ClientID%>').focus();
                return false;
            }
            <%--if (document.getElementById('<%=txtStreet.ClientID%>').value == "") {
                document.getElementById("lblStreet").style.display = "block";
                document.getElementById('<%=txtStreet.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtCity.ClientID%>').value == "") {
                document.getElementById("lblCity").style.display = "block";
                document.getElementById('<%=txtCity.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtPincode.ClientID%>').value == "") {
                document.getElementById("lblPincode").style.display = "block";
                document.getElementById('<%=txtPincode.ClientID%>').focus();
                return false;
            }--%>
            if (document.getElementById('<%=ddlPayMode.ClientID%>').value == "0") {
                document.getElementById("lblPayMode").style.display = "block";
                document.getElementById('<%=ddlPayMode.ClientID%>').focus();
                return false;
            }
            <%--if (document.getElementById('<%=ddlPayMode.ClientID%>').value == "1" && document.getElementById('<%=txtTransactionID.ClientID%>').value == "") {
                document.getElementById("lblTransactionID").style.display = "block";
                document.getElementById('<%=txtTransactionID.ClientID%>').focus();
                return false;
            }--%>
        }

        function hideNamelbl() {
            document.getElementById("lblName").style.display = "none";
        }
        function hideFlatlbl() {
            document.getElementById("lblFlat").style.display = "none";
        }
        function hideBuildinglbl() {
            document.getElementById("lblBuilding").style.display = "none";
        }
        function hideStreetlbl() {
            document.getElementById("lblStreet").style.display = "none";
        }
        function hideCitylbl() {
            document.getElementById("lblCity").style.display = "none";
        }
        function hidePincodelbl() {
            document.getElementById("lblPincode").style.display = "none";
        }
        function hidePayModelbl() {
            document.getElementById("lblPayMode").style.display = "none";
        }
        function hideTransactionIDlbl() {
            document.getElementById("lblTransactionID").style.display = "none";
        }

        function paymodeChange() {            
            if (document.getElementById('<%=ddlPayMode.ClientID%>').value == "1") {
                document.getElementById("transaction").style.display = "block";
            }
            else {
                document.getElementById("transaction").style.display = "none";
            document.getElementById("lblTransactionID").style.display = "none";
            }
        }
        
        function isNumberKey(evt, obj) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            var value = obj.value;
            var dotcontains = value.indexOf(".") != -1;
            if (dotcontains)
                if (charCode == 46) return false;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;
                        
                document.getElementById("lblMobile").style.display = "none";
                document.getElementById("lblMobile1").style.display = "none";
                document.getElementById("lblPincode").style.display = "none ";

            return true;
        }

        
        function getDetails()
        {  
            if (document.getElementById('<%=txtMobile.ClientID%>').value.length == 10) {
                PageMethods.getCustomerDetails(document.getElementById('<%=txtMobile.ClientID%>').value, onSetailSuccess);
            }
        }

        function onSetailSuccess(response) {
            if (response != "") {
                var arry = new Array();
                arry = response.split("$");
                document.getElementById('<%=lblCustomerID.ClientID%>').innerHTML = arry[0];
                document.getElementById('<%=txtName.ClientID%>').value = arry[1];
                document.getElementById('<%=txtFlat.ClientID%>').value = arry[2];
                document.getElementById('<%=lblOldFlat.ClientID%>').innerHTML = arry[2];
                document.getElementById('<%=ddlBuilding.ClientID%>').value = arry[3];
                document.getElementById('<%=lblOldBuilding.ClientID%>').innerHTML = arry[3];
                document.getElementById("select2-ddlBuilding-container").title = arry[4];
                document.getElementById("select2-ddlBuilding-container").textContent = arry[4];
            }
            else {                
                document.getElementById('<%=lblCustomerID.ClientID%>').innerHTML = "";
                document.getElementById('<%=txtName.ClientID%>').value = "";
                document.getElementById('<%=txtFlat.ClientID%>').value = "";
                document.getElementById('<%=lblOldFlat.ClientID%>').innerHTML = "";
                document.getElementById('<%=ddlBuilding.ClientID%>').value = "0";
                document.getElementById('<%=lblOldBuilding.ClientID%>').innerHTML = "0";
            }
        } 

        function ShowPopup() {
            $("#MyPopup").modal("show");
        }
        function ShowCheckoutPopup() {
            $("#CheckoutPopup").modal("show");
        }

        function orderclick() {
            document.getElementById("loader").style.display = "block";
        }
    </script>
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <!-- loader start -->
        <div class="loader-wrapper">
            <div>
                <img src="assets/images/vagitable-loader.gif" alt="loader" class="img-fluid" />
            </div>
        </div>
        <!-- Modal Popup -->
        <div id="MyPopup" class="modal fade" role="dialog" style="padding-right: 0">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" runat="server" class="close" data-dismiss="modal" onserverclick="btnRedirect_Click">
                            &times;</button>
                    </div>
                    <div class="modal-body" style="text-align:center">
                        <h2 class="color-yellow">Order Successfully Placed.</h2>
                    </div>
                    <div class="modal-footer">
                        <button runat="server" type="button" class="btn btn-orange" data-dismiss="modal" onserverclick="btnRedirect_Click">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Popup -->
        <!-- loader end -->
        <!--header start-->
        <header>
            <div class="mobile-fix-option">
                <div class="row mobile-cart">
                    <div class="col-6 center-align">
                        <i class="icon-shopping-cart"></i>
                        <!--<span class="cart-title">&nbsp; Total</span>-->
                    </div>
                    <div class="col-6 cart-total">
                        <h2><span class="rupee">₹</span>
                            <asp:Label ID="lblBillTotal2" runat="server" Text="0.00"></asp:Label></h2>
                    </div>
                </div>
            </div>
            <div class="layout-header1 fixed-top">
                <div class="max-width container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="main-menu-block">
                                <div class="menu-left">
                                    <div class="brand-logo">
                                        <a href="#">
                                            <span class="color-gray">Powered By :</span>
                                            <h2 class="font-weight-bold" style="font-size: 22px"><span class="color-yellow">Profeed</span><span class="color-brown"> & </span><span class="color-orange">Premix</span></h2>
                                        </a>
                                    </div>
                                </div>
                                <div class="menu-center">
                                    <div class="brand-logo">
                                        <a href="#">
                                            <img src="assets/images/logo.png" class="img-fluid logo" alt="logo-header">
                                        </a>
                                    </div>
                                </div>
                                <div class="menu-right">
                                    <a class="btn btn-rounded btnMenu mr-3" href="#catlog">Order Now</a>
                                    <div class="cart-top">
                                        <table>
                                            <tr>
                                                <td>
                                                    <i class="icon-shopping-cart"></i>
                                                </td>
                                                <td>&nbsp;</td>
                                                <td>
                                                    <h2><span class="rupee">₹</span>
                                                        <asp:Label ID="lblBillTotal" runat="server" Text="0.00"></asp:Label></h2>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!--header end-->
        <!-- masonary-banner start -->
        <section class="masonory-banner o-hidden pt-8">
            <div class="container-fluid">
                <div class="row masonary-banner-block1 gutter-15">
                    <div class="col-xl-6 col-lg-12">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="row masonary-banner-block">
                                    <div class="col-md-12 col-sm-6">
                                        <div class="masonary-banner-main">
                                            <div class="masonory-banner-img">
                                                <img src="assets/images/layout-6/masonory-banner/chicken-curry-cut.jpg" class="img-fluid bg-img" alt="masonory-banner">
                                            </div>
                                            <div class="masonary-banner-contant p-center">
                                                <h5>Chicken Curry Cut</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="masonary-banner-main">
                                            <div class="masonory-banner-img">
                                                <img src="assets/images/layout-6/masonory-banner/chicken-lollipop.jpg" class="img-fluid bg-img" alt="masonory-banner">
                                            </div>
                                            <div class="masonary-banner-contant p-center">
                                                <h5>Chicken Lollipop</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 pl-3">
                                <div class="masonary-banner-main">
                                    <div class="masonory-banner-img masonory-img1">
                                        <img src="assets/images/layout-6/masonory-banner/eggs.jpg" class="img-fluid bg-img" alt="masonory-banner">
                                    </div>
                                    <div class="masonary-banner-contant p-center">
                                        <div>
                                            <h5>Eggs</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-12 ">
                        <div class="row masonary-banner-block masonary-inner1">
                            <div class="col-md-12">
                                <div class="row masonary-banner-block2">
                                    <div class="col-sm-6 pr-0">
                                        <div class="masonary-banner-main">
                                            <div class="masonory-banner-img">
                                                <img src="assets/images/layout-6/masonory-banner/4.jpg" class="img-fluid bg-img" alt="masonory-banner">
                                            </div>
                                            <div class="masonary-banner-contant p-center">
                                                <h5>Chicken Drumstick</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="masonary-banner-main">
                                            <div class="masonory-banner-img">
                                                <img src="assets/images/layout-6/masonory-banner/5.jpg" class="img-fluid bg-img" alt="masonory-banner">
                                            </div>
                                            <div class="masonary-banner-contant p-center">
                                                <h5>Eggs</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 pr-0">
                                <div class="masonary-banner-main">
                                    <div class="masonory-banner-img">
                                        <img src="assets/images/layout-6/masonory-banner/6.jpg" alt="masonary-banner" class="img-fluid bg-img">
                                    </div>
                                    <div class="masonary-banner-contant p-right">
                                        <div class="masonary-banner-subcontant">
                                            <div>
                                                <h5>Boneless</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- masonory-banner end -->
        <!-- Parallax banner -->
        <section class="section-big-pt-space">
            <div class="full-banner parallax text-left p-left">
                <img src="assets/images/layout-6/parallax-banner/parelex.jpg" alt="" class="bg-img" />
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="banner-contain">
                                <%--<img src="assets/images/technical details.jpg" width="330px"/>--%>
                                <h2>More than 2 decades</h2>
                                <h3>of experience in India</h3>
                                <h4>as well as International market</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Parallax banner end -->
        <!--slider start-->
        <section class="theme-slider" id="catlog">
            <div class="custom-container">
                <div class="row">
                    <div class="col-xl-2 col-sm-3 p-0 offer-banner">
                        <div class="offer-banner-img">
                            <img src="assets/images/layout-6/collection-banner/6.jpg" alt="offer-banner" class="img-fluid" />
                        </div>
                    </div>
                    <div class="col-xl-8 col-md-12 col-sm-12">
                        <asp:Repeater ID="rptProducts" runat="server">
                            <ItemTemplate>
                                <div class="row catlog">
                                    <div class="col-lg-3 col-md-3 col-sm-12 catlog-img p-3">
                                        <img src='<%# Eval("photo") %>' alt='<%# Eval("productName") %>'>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-12 p-0 catlog-details-box">
                                        <div class="catlog-details">
                                            <h3>
                                                <asp:Label ID="lblNAme" runat="server" Text='<%# Eval("productName").ToString()%>'></asp:Label>
                                            </h3>
                                            <h4 class="color-yellow">
                                                <asp:Label ID="lblQty" runat="server" Text='<%# Eval("packageQuantity") %>'></asp:Label>
                                                <asp:Label ID="lblProductID" runat="server" Text='<%# Eval("productID") %>' Font-Size="1px" ForeColor="Transparent"></asp:Label>
                                            </h4>
                                            <h2 class="color-orange"><span class="rupee">₹</span>
                                                <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price") %>'></asp:Label></h2>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-12 qty-btn-box">
                                        <div class="input-group w-75">
                                            <asp:Button ID="btnMin" runat="server" CssClass="btn quantity-left-minus btn-qty" Text="-" data-type="minus" OnClick="calculatePrice" OnClientClick="showLoader()" />
                                            <!--&#xf068;-->
                                            <asp:TextBox ID="txtQuantity" TextMode="Phone" runat="server" class="form-control input-number qty-input" Text="0" MaxLength="3"></asp:TextBox>
                                            <asp:Button ID="btnMax" runat="server" CssClass="btn quantity-right-plus btn-qty" Text="+" data-type="plus" OnClick="calculatePrice" OnClientClick="showLoader()" />
                                            <!--&#xf067;-->
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-12 product-total-price">
                                        <h2><span class="rupee">₹</span>
                                            <asp:Label ID="lblProductPrice" runat="server" Text="0.00"></asp:Label>
                                        </h2>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
                        <div class="row catlog contact">
                            <div class="check-out">
                                <h3>Total Bill Amount : <span class="color-orange">&nbsp;<span class="rupee"> ₹ </span>
                                    <asp:Label ID="lblBillTotal1" runat="server" Text="0.00"></asp:Label></span></h3>
                            </div>
                            <div class="col-lg-12 heading mt-3">
                                <h3>Customer Details
                                    <asp:Label ID="lblCustomerID" runat="server" Text="0" Font-Size="1px" ForeColor="Transparent"></asp:Label>
                                    <asp:Label ID="lblOldFlat" runat="server" Text="" Font-Size="1px" ForeColor="Transparent"></asp:Label>
                                    <asp:Label ID="lblOldBuilding" runat="server" Text="0" Font-Size="1px" ForeColor="Transparent"></asp:Label>
                                </h3>
                            </div>

                            <div class="col-lg-12 col-sm-12 field">
                                <asp:TextBox ID="txtMobile" TextMode="Phone" runat="server" CssClass="form-control" placeholder="&#xf10b; Mobile Number" MaxLength="10" onkeypress='javascript:return isNumberKey(event,this);' onfocusout="getDetails()"></asp:TextBox>
                                <label id="lblMobile" class="error">Please enter your mobile number</label>
                                <label id="lblMobile1" class="error">Please enter valid mobile number</label>
                            </div>

                            <div class="col-lg-12 col-sm-12 field">
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="&#xf2be;  Full Name" MaxLength="100" onkeypress="hideNamelbl()"></asp:TextBox>
                                <label id="lblName" class="error">Please enter your naame</label>
                            </div>

                            <div class="col-lg-6 col-sm-12 field">
                                <asp:TextBox ID="txtFlat" runat="server" CssClass="form-control" placeholder="&#xf015;  Flat / Shop No" MaxLength="10" onkeypress="hideFlatlbl()"></asp:TextBox>
                                <label id="lblFlat" class="error">Enter flat / shop number</label>
                            </div>

                            <div class="col-lg-6 col-sm-12 field">
                                <asp:DropDownList ID="ddlBuilding" runat="server" CssClass="js-example-basic-single" ForeColor="Gray" onclick="hideBuildinglbl()"></asp:DropDownList>
                                <label id="lblBuilding" class="error">Select building / complex name</label>
                            </div>

                            <%--<div class="col-lg-6 col-sm-12 field">
                                <asp:TextBox ID="txtBuilding" runat="server" CssClass="form-control" placeholder="&#xf0f7;  Building / Complex" MaxLength="100" onkeypress="hideBuildinglbl()"></asp:TextBox>
                                <label id="lblBuilding" class="error">Enter building / complex name</label>
                            </div>

                            <div class="col-lg-3 col-sm-12 field">
                                <asp:TextBox ID="txtBuildingcode" runat="server" CssClass="form-control" placeholder="&#xf0f7;  Building Code" onkeypress="return false;"></asp:TextBox>
                            </div>

                            <div class="col-lg-8 col-sm-12 field">
                                <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control" placeholder="&#xf277; Street / Lane" MaxLength="200" onkeypress="hideStreetlbl()"></asp:TextBox>
                                <label id="lblStreet" class="error">Enter street / lane</label>
                            </div>

                            <div class="col-lg-4 col-sm-12 field">
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="&#xf041; City" MaxLength="50" onkeypress="hideCitylbl()"></asp:TextBox>
                                <label id="lblCity" class="error">Enter city name</label>
                            </div>

                            <div class="col-lg-4 col-sm-12 field">
                                <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control" placeholder="&#xf276; Pincode" MaxLength="6" onkeypress='javascript:return isNumberKey(event,this);'></asp:TextBox>
                                <label id="lblPincode" class="error">Enter pincode</label>
                            </div>--%>

                            <div class="col-lg-6 col-sm-12 field">
                                <asp:DropDownList ID="ddlPayMode" runat="server" CssClass="form-control" ForeColor="Gray" onchange="paymodeChange()" onclick="hidePayModelbl()">
                                    <%--<asp:ListItem Text="--- Payment Mode ---" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Pre Paid" Value="1"></asp:ListItem>--%>
                                    <asp:ListItem Text="Cash on Delivery" Value="2" Selected="True"></asp:ListItem>
                                    <%--<asp:ListItem Text="Digital Payment on Delivery" Value="3"></asp:ListItem>--%>
                                </asp:DropDownList>
                                <label id="lblPayMode" class="error">Select payment mode</label>
                            </div>

                            <%--<div id="transaction" class="col-lg-6 col-sm-12 field">
                                <asp:TextBox ID="txtTransactionID" runat="server" CssClass="form-control" placeholder="&#xf0d6; Transaction ID" onkeypress="hideTransactionIDlbl()"></asp:TextBox>
                                <label id="lblTransactionID" class="error">Enter transaction id</label>
                            </div>--%>
                            <div class="col-lg-12 col-sm-12 field mt-3" style="text-align: center">
                                <label id="lblEmptyCart" class="error" style="margin-bottom: 15px; font-size: 16px">Cart is empty...</label>
                                <asp:Button ID="btnCheckOut" runat="server" Text="Check Out" CssClass="btn btn-rounded" OnClientClick="return validation()" OnClick="btnCheckOut_Click" />

                                 <!-- Modal Popup -->
                                <div id="CheckoutPopup" class="modal fade" role="dialog" style="padding-right: 0">
                                    <div class="modal-dialog">
                                    <div id="loader">
                                        <img id="loader-image" src="assets/images/small_loader.gif" width="60" />
                                    </div>
                                        <!-- Modal content-->
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h3 class="color-yellow">Checkout</h3>
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            </div>
                                            <div class="modal-body">
                                                <table class="chkout-tbl" width="80%" align="center">
                                                    <asp:Repeater ID="rptrCheckOut" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td align="left" width="60%">
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("ProductName") + " - " + Eval("packageQty").ToString()  %>'></asp:Label>
                                                                </td>
                                                                <td align="left" width="10%">
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("qty") %>'></asp:Label>
                                                                </td>
                                                                <td align="left" width="30%">
                                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("amt") %>'></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </table>
                                                <table class="chkout-tbl" width="80%" align="center" style="border-top: 1px dashed #ccc; margin-top: 5px">
                                                    <tr>
                                                        <td colspan="3"></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="60%" align="left"><b>Total</b></td>
                                                        <td width="10%" align="left">
                                                            <asp:Label ID="lblProductCount" runat="server" Text="0" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td width="30%" align="left">
                                                            <asp:Label ID="lblBillTotal3" runat="server" Text="0.00" Font-Bold="true"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="modal-footer">
                                                <button id="btnBack" type="button" class="btn btn-rounded-gray" data-dismiss="modal">Back</button>
                                                <asp:Button ID="btnOrder" runat="server" Text="Place Order" CssClass="btn btn-rounded" OnClientClick="orderclick()" OnClick="btnOrder_Click"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Modal Popup -->
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-2 col-sm-3 p-0 offer-banner">
                        <div class="offer-banner-img">
                            <img src="assets/images/layout-6/collection-banner/3.jpg" alt="offer-banner" class="img-fluid  ">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--slider end-->
        <!--services start-->
        <section class="services p-3 mt-5">
            <div class="container">
                <div class="row service-block">
                    <div class="col-lg-4 col-md-6  col-sm-12">
                        <div class="media">
                            <svg height="679pt" viewBox="0 -117 679.99892 679" width="679pt" xmlns="http://www.w3.org/2000/svg">
                                <path d="m12.347656 378.382812h37.390625c4.371094 37.714844 36.316407 66.164063 74.277344 66.164063 37.96875 0 69.90625-28.449219 74.28125-66.164063h241.789063c4.382812 37.714844 36.316406 66.164063 74.277343 66.164063 37.96875 0 69.902344-28.449219 74.285157-66.164063h78.890624c6.882813 0 12.460938-5.578124 12.460938-12.460937v-352.957031c0-6.882813-5.578125-12.464844-12.460938-12.464844h-432.476562c-6.875 0-12.457031 5.582031-12.457031 12.464844v69.914062h-105.570313c-4.074218.011719-7.890625 2.007813-10.21875 5.363282l-68.171875 97.582031-26.667969 37.390625-9.722656 13.835937c-1.457031 2.082031-2.2421872 4.558594-2.24999975 7.101563v121.398437c-.09765625 3.34375 1.15624975 6.589844 3.47656275 9.003907 2.320312 2.417968 5.519531 3.796874 8.867187 3.828124zm111.417969 37.386719c-27.527344 0-49.851563-22.320312-49.851563-49.847656 0-27.535156 22.324219-49.855469 49.851563-49.855469 27.535156 0 49.855469 22.320313 49.855469 49.855469 0 27.632813-22.21875 50.132813-49.855469 50.472656zm390.347656 0c-27.53125 0-49.855469-22.320312-49.855469-49.847656 0-27.535156 22.324219-49.855469 49.855469-49.855469 27.539063 0 49.855469 22.320313 49.855469 49.855469.003906 27.632813-22.21875 50.132813-49.855469 50.472656zm140.710938-390.34375v223.34375h-338.375c-6.882813 0-12.464844 5.578125-12.464844 12.460938 0 6.882812 5.582031 12.464843 12.464844 12.464843h338.375v79.761719h-66.421875c-4.382813-37.710937-36.320313-66.15625-74.289063-66.15625-37.960937 0-69.898437 28.445313-74.277343 66.15625h-192.308594v-271.324219h89.980468c6.882813 0 12.464844-5.582031 12.464844-12.464843 0-6.882813-5.582031-12.464844-12.464844-12.464844h-89.980468v-31.777344zm-531.304688 82.382813h99.703125v245.648437h-24.925781c-4.375-37.710937-36.3125-66.15625-74.28125-66.15625-37.960937 0-69.90625 28.445313-74.277344 66.15625h-24.929687v-105.316406l3.738281-5.359375h152.054687c6.882813 0 12.460938-5.574219 12.460938-12.457031v-92.226563c0-6.882812-5.578125-12.464844-12.460938-12.464844h-69.796874zm-30.160156 43h74.777344v67.296875h-122.265625zm0 0" />
                            </svg>
                            <div class="media-body">
                                <h5>free shipping</h5>
                            </div>
                        </div>
                    </div>
                    <%--<div class="col-lg-3 col-md-6  col-sm-12">
                        <div class="media">
                            <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                viewBox="0 0 417.12 417.12" style="enable-background: new 0 0 417.12 417.12;" xml:space="preserve">
                                <g>
                                    <g>
                                        <path d="M409.12,200.741c-4.418,0-8,3.582-8,8c-0.06,106.525-86.464,192.831-192.988,192.772C101.607,401.453,15.3,315.049,15.36,208.524C15.42,102,101.824,15.693,208.348,15.753c51.36,0.029,100.587,20.54,136.772,56.988l-17.84-0.72c-4.418,0-8,3.582-8,8s3.582,8,8,8l36.72,1.52c1.013,0.003,2.018-0.188,2.96-0.56l0.88-0.56c1.381-0.859,2.534-2.039,3.36-3.44c0.034-0.426,0.034-0.854,0-1.28c0.183-0.492,0.317-1.001,0.4-1.52l3.2-36.72c0.376-4.418-2.902-8.304-7.32-8.68s-8.304,2.902-8.68,7.32l-1.6,18.16c-80.799-82.092-212.848-83.14-294.939-2.341s-83.14,212.848-2.341,294.939s212.848,83.14,294.939,2.341c39.786-39.159,62.212-92.635,62.261-148.459C417.12,204.323,413.538,200.741,409.12,200.741z" />
                                    </g>
                                </g>
                                <g>
                                    <g>
                                        <path d="M200.4,256.341c-3.716-2.516-8.162-3.726-12.64-3.44h-56c1.564-2.442,3.302-4.768,5.2-6.96c6.727-7.402,14.088-14.201,22-20.32c10.667-8.747,18.293-15.147,22.88-19.2c5.252-4.976,9.752-10.689,13.36-16.96c4.377-7.234,6.649-15.545,6.56-24c-0.009-11.177-4.27-21.931-11.92-30.08c-3.725-3.941-8.181-7.12-13.12-9.36c-8.709-3.645-18.08-5.443-27.52-5.28c-8.048-0.163-16.055,1.194-23.6,4c-6.2,2.328-11.862,5.894-16.64,10.48c-4.219,4.117-7.565,9.042-9.84,14.48c-2.098,4.853-3.213,10.074-3.28,15.36c-0.192,3.547,1.081,7.018,3.52,9.6c2.345,2.352,5.56,3.626,8.88,3.52c3.499,0.231,6.903-1.19,9.2-3.84c2.503-3.303,4.424-7.01,5.68-10.96c0.939-3.008,2.144-5.926,3.6-8.72c4.562-7.738,12.94-12.416,21.92-12.24c4.114,0.077,8.149,1.147,11.76,3.12c3.625,1.82,6.693,4.583,8.88,8c2.194,3.673,3.329,7.882,3.28,12.16c-0.067,4.437-1.105,8.806-3.04,12.8c-2.129,4.829-5.019,9.286-8.56,13.2c-4.419,4.617-9.298,8.772-14.56,12.4c-5.616,4.247-10.96,8.843-16,13.76c-7.787,7.04-16.453,15.467-26,25.28c-2.638,2.966-4.773,6.344-6.32,10c-1.632,3.159-2.612,6.614-2.88,10.16c-0.018,3.939,1.605,7.707,4.48,10.4c3.393,3.096,7.896,4.684,12.48,4.4h78.4c3.842,0.312,7.641-0.993,10.48-3.6c2.291-2.379,3.53-5.579,3.44-8.88C204.691,262.051,203.173,258.598,200.4,256.341z" />
                                    </g>
                                </g>
                                <g>
                                    <g>
                                        <path d="M333.76,222.901c-4.254-1.637-8.809-2.346-13.36-2.08h-4.56v-82.48c0-12.373-5.333-18.56-16-18.56c-3.185-0.052-6.261,1.155-8.56,3.36c-3.331,3.343-6.382,6.956-9.12,10.8l-56.48,75.6l-3.92,5.2c-1.067,1.44-2.107,2.907-3.12,4.4c-0.916,1.374-1.668,2.851-2.24,4.4c-0.475,1.308-0.718,2.689-0.72,4.08c-0.237,4.699,1.607,9.263,5.04,12.48c4.323,3.358,9.742,4.984,15.2,4.56h53.52v20.08c-0.273,4.252,1.006,8.459,3.6,11.84c5.276,5.346,13.887,5.403,19.233,0.127c0.043-0.042,0.085-0.084,0.127-0.127c2.587-3.384,3.866-7.589,3.6-11.84v-20h6.48c4.242,0.298,8.476-0.677,12.16-2.8c2.877-2.141,4.425-5.63,4.08-9.2C339.301,228.744,337.319,224.811,333.76,222.901z M289.36,220.581h-45.84l45.84-61.92V220.581z" />
                                    </g>
                                </g>
                            </svg>
                            <div class="media-body">
                                <h5>24X7 SERVICE</h5>
                            </div>
                        </div>
                    </div>--%>
                    <div class="col-lg-4 col-md-6  col-sm-12 ">
                        <div class="media">
                            <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 295.82 295.82" xmlns:xlink="http://www.w3.org/1999/xlink" enable-background="new 0 0 295.82 295.82">
                                <g>
                                    <g>
                                        <path d="m269.719,43.503h-243.617c-13.921,0-26.102,12.181-26.102,26.102v156.611c0,13.921 12.181,26.102 26.102,26.102h243.617c13.921,0 26.102-12.181 26.102-26.102v-156.611c-0.001-13.921-12.182-26.102-26.102-26.102zm-243.617,17.401h243.617c5.22,0 8.701,3.48 8.701,8.701v13.921h-261.019v-13.921c-1.06581e-14-5.22 3.481-8.701 8.701-8.701zm252.317,40.023v13.921h-261.018v-13.921h261.018zm-8.7,133.989h-243.617c-5.22,0-8.701-3.48-8.701-8.701v-93.966h261.018v93.966c0,5.221-3.48,8.701-8.7,8.701z" />
                                        <path d="m45.243,172.272h45.243c5.22,0 8.701-3.48 8.701-8.701 0-5.22-3.48-8.701-8.701-8.701h-45.243c-5.22,0-8.701,3.48-8.701,8.701 0.001,5.221 3.481,8.701 8.701,8.701z" />
                                        <path d="m151.391,191.413h-106.148c-5.22,0-8.701,3.48-8.701,8.701s3.48,8.701 8.701,8.701h106.147c3.48,0 8.701-3.48 8.701-8.701s-3.48-8.701-8.7-8.701z" />
                                    </g>
                                </g>
                            </svg>
                            <div class="media-body">
                                <h5>CASH ON DELIVERY</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6  col-sm-12 ">
                        <div class="media">
                            <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                viewBox="0 0 448 448" style="enable-background: new 0 0 448 448;" xml:space="preserve">
                                <g>
                                    <g>
                                        <g>
                                            <path d="M384,172.4C384,83.6,312.4,12,224,12S64,83.6,64,172c0,0,0,0,0,0.4C28.4,174.4,0,204,0,240v8c0,37.6,30.4,68,68,68h3.6l28.4,45.2c20,32,54,50.8,91.6,50.8h5.6c3.6,13.6,16,24,30.8,24c17.6,0,32-14.4,32-32c0-17.6-14.4-32-32-32c-14.8,0-27.2,10.4-30.8,24h-5.6c-32,0-61.2-16.4-78-43.6L90.4,316H96c8.8,0,16-7.2,16-16V188c0-8.8-7.2-16-16-16H80c0-79.6,64.4-144,144-144s144,64.4,144,144h-16c-8.8,0-16,7.2-16,16v112c0,8.8,7.2,16,16,16h28c37.6,0,68-30.4,68-68v-8C448,204,419.6,174.4,384,172.4z M228,388c8.8,0,16,7.2,16,16s-7.2,16-16,16s-16-7.2-16-16S219.2,388,228,388z M96,188v112H68c-28.8,0-52-23.2-52-52v-8c0-28.8,23.2-52,52-52H96z M432,248c0,28.8-23.2,52-52,52h-28V188h28c28.8,0,52,23.2,52,52V248z" />
                                            <path d="M290.4,72.4c-0.8-0.4-2-1.2-3.2-2c-1.2-0.8-2.4-1.6-3.2-2c-3.6-2.4-8.8-1.2-10.8,2.8S272,79.6,276,82c0.8,0.4,2,1.2,3.2,2s2.4,1.6,3.6,2c1.2,0.8,2.8,1.2,4,1.2c2.8,0,5.2-1.2,6.8-4C295.6,79.6,294.4,74.8,290.4,72.4z" />
                                            <path d="M224,52c-34,0-66,14.8-88,40.4c-2.8,3.2-2.4,8.4,0.8,11.2c1.6,1.2,3.2,2,5.2,2c2.4,0,4.4-0.8,6-2.8c19.2-22,46.8-34.8,76-34.8c7.2,0,14.4,0.8,21.6,2.4c4.4,0.8,8.4-2,9.6-6s-2-8.4-6-9.6C240.8,52.8,232.4,52,224,52z" />
                                        </g>
                                    </g>
                                </g>
                            </svg>
                            <div class="media-body">
                                <h5>G-Pay / Paytm / UPI</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--services end-->
        <!--contact banner start-->
        <section class="contact-banner">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="contact-banner-contain">
                            <div class="contact-banner-img">
                                <img src="assets/images/call-img.png" class="img-fluid" alt="call-banner">
                            </div>
                            <div>
                                <h3>if you have any question please call us</h3>
                            </div>
                            <div>
                                <h2><a href="tel:+917350013696" class="text-white">7350-01-3696</a></h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--contact banner end-->
        <!--footer start-->
        <footer class="footer-2">
            <div class="container ">
                <div class="row">
                    <div class="col-12">
                        <div class="footer-main-contian">
                            <div class="row ">
                                <div class="col-lg-6 col-md-12 ">
                                    <div class="footer-left">
                                        <div class="footer-logo">
                                            <h2 class="font-weight-bold text-uppercase" style="font-size: 36px"><span class="color-brown">Pro</span><span class="color-orange">-</span><span class="color-yellow">Chicken</span></h2>
                                            <h4>PROFEED  AND  PREMIX PVT LTD.</h4>
                                        </div>
                                        <div class="footer-detail">
                                            <p>
                                                Company Has Started Its Business In Pune (Maharashtra)In 2006 . All Production Parameters Are For Export Quality Only , Growing Of Broiler Birds Under Standard Feeding , Good Management &Healthy Environment We Have Our Own Production Farms For Broiler ( Chicken ) And Layers ( Eggs ) Which Is Monitored Under Technical Staff & It Is Leading By Experienced Veterinary Doctors Having 20 To 25 Years Experience In India As Well As International Market.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-12 ">
                                    <div class="footer-right">
                                        <div class="row">
                                            <div class="col-lg-12 col-sm-12 col-md-12">
                                                <h3 class="font-weight-light">Contact Us</h3>
                                                <br />
                                                <div class="contact-details">
                                                    <div class="contact-text"><i class="fa fa-phone"></i>&nbsp <a href="tel:+917350013696">+91 7350 01 3696</a> / <a href="tel:+919689148246">+ 91 9689 14 8246</a></div>
                                                    <div class="contact-text"><i class="fa fa-envelope-o"></i>&nbsp <a href="mailto:drraut@profeed.co.in">drraut@profeed.co.in</a></div>
                                                    <div class="contact-text"><i class="fa fa-map-marker"></i>&nbsp; KPCT Mall, Office No.207, 2nd Floor, <br />&nbsp;&nbsp;&nbsp; Near Vishal Megamart, Fatima Nagar,<br />&nbsp;&nbsp;&nbsp; Pune, 411040.</div>
                                                </div>
                                            </div>
                                        <div class="col-lg-12 col-sm-12 col-md-12 certificate">
                                            <img src="assets/images/fssi.png" width="80px"/>
                                            <img src="assets/images/APEDA.png" width="90px" />
                                            <img src="assets/images/make-in-india.jpg" width="100px" />
                                        </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="app-link-block  bg-transparent">
                <div class="container">
                    <div class="row">
                        <div class="app-link-bloc-contain app-link-bloc-contain-1">
                            <div class="app-item-group ">
                                <div class="sosiyal-block">
                                    <ul class="sosiyal">
                                        <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                                        <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                        <li><a id="whatsapp" href="https://api.whatsapp.com/send?phone=+919689148246&amp;text=Hi, I contacted you Through your website." target="_blank"><i class="fa fa-whatsapp"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sub-footer">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="sub-footer-contain">
                                <p><span>2020 - 21 </span>copy right by Pro-Chicken design & developed by <a href="http://www.jericotechnologies.in" target="_blank" style="color: #00b6cc;">Jerico technologies</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!--footer end-->
        <!-- tap to top -->
        <div class="tap-top bg-white">
            <div>
                <img src="assets/images/icon/tap-top.png" class="img-fluid" alt="tap top" />
            </div>
        </div>
        <!-- tap to top End -->
        <!-- Add to cart bar -->

        <!-- notification product -->
        <!-- latest jquery-->
        <script src="assets/js/jquery-3.3.1.min.js"></script>
        <!-- popper js-->
        <script src="assets/js/popper.min.js"></script>
        <!-- Bootstrap js-->
        <script src="assets/js/bootstrap.js"></script>
        <!-- Bootstrap js-->
        <script src="assets/js/bootstrap-notify.min.js"></script>
        <!-- Timer js-->
        <script src="assets/js/menu.js"></script>
        <!-- slick js-->
        <script src="assets/js/slick.js"></script>
        <!-- Theme js-->
        <script src="assets/js/modal.js"></script>
        <script src="assets/js/script.js"></script>
        <!-- Select 2 js -->
        <script type="text/javascript" src="cpanel\files\bower_components\select2\js\select2.full.min.js"></script>
        <!-- Custom js -->
        <script type="text/javascript" src="cpanel\files\assets\pages\advance-elements\select2-custom.js"></script>
    </form>
</body>
</html>
