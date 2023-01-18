<%@ Page Title="Ass Products" Language="C#" MasterPageFile="CPMaster.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="ProChicken.cpanel.AddProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script language="JavaScript"  src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.0/jquery.min.js"></script>
     <script type="text/javascript">
         function validation() {
            if (document.getElementById('<%=txtProductName.ClientID%>').value == "") {
                document.getElementById("lblProductName").style.display = "block";
                document.getElementById('<%=txtProductName.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtQuantity.ClientID%>').value == "") {
                document.getElementById("lblQuantity").style.display = "block";
                document.getElementById('<%=txtQuantity.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtPrice.ClientID%>').value == "") {
                document.getElementById("lblPrice").style.display = "block";
                document.getElementById('<%=txtPrice.ClientID%>').focus();
                return false;
            }
         }

         
         function hideProductName() {
             document.getElementById("lblProductName").style.display = "none";
         }
         function hideQuantity() {
             document.getElementById("lblQuantity").style.display = "none";
         }

        function previewFile1() {
            var preview1 = document.querySelector('#<%=Image1.ClientID %>');
            var file1 = document.querySelector('#<%=FileUpload1.ClientID %>').files[0];
            var reader1 = new FileReader();

            reader1.onloadend = function () {
                preview1.src = reader1.result;
            }

            if (file1) {
                reader1.readAsDataURL(file1);
                document.querySelector('#<%=lblImg1.ClientID %>').innerHTML = document.querySelector('#<%=FileUpload1.ClientID %>').value.split(/(\\|\/)/g).pop()
            }
            else {
                preview1.src = "";
            }
        }

        function delete1click() {
            document.getElementById('<%=lblImg1.ClientID%>').innerHTML = "empty.jpg";
            document.getElementById('<%=Image1.ClientID %>').src = "";
        }

        $(function () {
            $('input[type=file]').change(function () {
                var val = $(this).val().toLowerCase(),
                    regex = new RegExp("(.*?)\.(jpg|jpeg|png|gif)$");

                if (!(regex.test(val))) {
                    $(this).val('');
                    alert('Please select correct file format');
                }
            });
        });
        
        function isDecimalNumber(evt, c) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            var dot1 = c.value.indexOf('.');
            var dot2 = c.value.lastIndexOf('.');

            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else if (charCode == 46 && (dot1 == dot2) && dot1 != -1 && dot2 != -1)
                return false;
            
             document.getElementById("lblPrice").style.display = "none";
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content">
        <!-- Main-body start -->
        <div class="main-body">
            <div class="page-wrapper">
                <!-- Page-header start -->
                <div class="page-header">
                    <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Visible="false">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <asp:Label ID="lblAlert" runat="server" Text="" Font-Bold="true"></asp:Label>
                    </asp:Panel>

                    <div class="row align-items-end">
                        <div class="col-lg-8">
                            <div class="page-header-title">
                                <div class="d-inline">
                                    <h4>Add Product</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="page-header-breadcrumb">
                                <ul class="breadcrumb-title">
                                    <li class="breadcrumb-item">
                                        <a href="dashboard.aspx"><i class="feather icon-home"></i></a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="manageProduct.aspx">Manage Product</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="#">Add Product</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Page-header end -->

                <!-- Page body start -->
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-block mt-2">
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Product Name</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtProductName" CssClass="form-control" runat="server" type="text" MaxLength="100" onkeypress="hideProductName()"></asp:TextBox>
                                            <label id="lblProductName" class="error">Please enter product name</label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Quantity</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" type="text" MaxLength="15" onkeypress="hideQuantity()"></asp:TextBox>
                                            <label id="lblQuantity" class="error">Please enter product quantity</label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Price ( ₹ )</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtPrice" runat="server" type="text" CssClass="form-control" MaxLength="10" onkeypress='javascript:return isDecimalNumber(event,this);'></asp:TextBox>
                                            <label id="lblPrice" class="error">Please enter product price</label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Product Photo</label>
                                        <div class="col-sm-10">
                                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <div class="col-md-4 col-xs-12" style="text-align:center">
                                                        <asp:Image ID="Image1" runat="server" CssClass="form-control" Height="200px" Width="100%" />
                                                        <asp:FileUpload ID="FileUpload1" runat="server" class="form-control" onchange="previewFile1()" />          
                                                        <asp:Label ID="lblImg1" runat="server" ForeColor="White"></asp:Label>
                                                        <asp:Label ID="lblOldName1" runat="server" ForeColor="White" Font-Size="1px"></asp:Label>
                                                        <asp:ImageButton ID="btnDelet1" runat="server" ImageUrl="files/assets/images/delete.png" OnClick="btnDelete1_Click"/>
                                                    </div>                                              
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-2"></div> 
                                        <div class="col-sm-10">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-primary m-b-0" Style="margin-right: 1%" OnClientClick="return validation()" OnClick="btnSave_Click" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-secondary m-b-0" CausesValidation="false" OnClick="btnCancel_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Page body end -->
            </div>
        </div>
    </div>
</asp:Content>
