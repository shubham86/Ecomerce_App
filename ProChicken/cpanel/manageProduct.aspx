<%@ Page Title="Manage Products" Language="C#" MasterPageFile="CPMaster.Master" AutoEventWireup="true" CodeBehind="manageProduct.aspx.cs" Inherits="ProChicken.cpanel.manageProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script>
        window.onload = function menueActive(){
            document.getElementById("menuMaster").classList.add("pcoded-hasmenu");
            document.getElementById("menuMaster").classList.add("active");
            document.getElementById("menuMaster").classList.add("pcoded-trigger");
            document.getElementById("menuManageProduct").classList.add("active");
        }
    </script>
    <style>
       .card-block table td, th {
            text-align:center;
            vertical-align:middle;
        }
       .card-block table td, th{
           padding:5px 0px;
       }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content">
        <!-- Main-body start -->
        <div class="main-body">
            <div class="page-wrapper">
                <!-- Page-header start -->
                <div class="page-header">
                    <div>
                        <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Visible="false">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <asp:Label ID="lblAlert" runat="server" Text="" Font-Bold="true"></asp:Label>
                        </asp:Panel>
                    </div>
                    <div class="row align-items-end">
                        <div class="col-lg-4">
                            <div class="page-header-title">
                                <div class="d-inline">
                                    <h4>Manage Products</h4>
                                    <span>Products which are display on wesite</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <table width="100%">
                                <tr>
                                    <td align="right">
                                        <asp:DropDownList ID="ddlAll" runat="server" class="col-md-8 form-control m" ForeColor="#888888" OnSelectedIndexChanged="ddl_SelectedIndexChange" AutoPostBack="true" Width="170px">
                                            <asp:ListItem Text="Active Products" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Inactive Products" Value="2"></asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td align="left">
                                        &nbsp;<asp:Button ID="Button1" runat="server" CssClass="btn btn-secondary" Text="Add New Product"  OnClick="imgbtnadd_Click"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-lg-3">
                            <div class="page-header-breadcrumb">
                                <ul class="breadcrumb-title">
                                    <li class="breadcrumb-item">
                                        <a href="dashboard.aspx"><i class="feather icon-home"></i></a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="#">Master</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="#">Manage Product</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Page-header end -->

                <!-- Page-body start -->
                <div class="page-body">
                    <!-- DOM/Jquery table start -->
                    <div class="card">
                        <div class="card-header">
                            
                            <div>
                                
                                <div class="col-md-2 right-align pt-10">
                                    
                                </div>
                            </div>
                        </div>

                        <div class="card-block">
                            <div class="table-responsive dt-responsive">
                                <table id="dom-jqry" class="table table-striped table-bordered nowrap">
                                    <thead>
                                        <tr>
                                            <th>Sr.No.</th>
                                            <th>Photo</th>
                                            <th>Name</th>
                                            <th>Qty</th>
                                            <th>Price</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptrProduct" runat="server" OnItemCommand="rptrProduct_RowCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Container.ItemIndex+1 %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%#Eval("photo").ToString() == "../cpanel/Product_Photos/empty" ? "../cpanel/Product_Photos/NoImage.jpg" : Eval("photo")%>' Width="90" Height="80" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Text='<%#Eval("productName") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("packageQuantity") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label4" runat="server" Text='<%#Eval("price") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgbtnStatus" runat="server" ImageUrl='<%# Convert.ToBoolean(Eval("isActive")) ? "files/assets/images/tickIcon.png" :"files/assets/images/crossIcon.png" %>' Width="15px" Height="15px" CommandArgument='<%#Eval("productID") %>' CommandName="status" ToolTip="Change Status" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgbtnUpdate" runat="server" ImageUrl="files/assets/images/edit.png" AlternateText="Edit" Width="20px" Height="20px" CommandArgument='<%#Eval("productID") %>' CommandName="edit" ToolTip="Edite" />&nbsp&nbsp
                                                        <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="files/assets/images/delete.png" AlternateText="Delete" Width="20px" Height="20px" CommandArgument='<%#Eval("productID") %>' CommandName="delete" ToolTip="Delete" CausesValidation="false" OnClientClick="return confirm('Are You Sure You Want To Delete it..?')" />
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- DOM/Jquery table end -->
                </div>
                <!-- Page-body start -->
            </div>
        </div>
        <!-- Main-body end -->

    </div>
</asp:Content>
