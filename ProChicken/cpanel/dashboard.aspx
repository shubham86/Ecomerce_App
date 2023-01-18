<%@ Page Title="Dashboard" Language="C#" MasterPageFile="../cpanel/CPMaster.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="ProChicken.cpanel.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function menueActive(){
            var element = document.getElementById("menuDashboard");
            element.classList.add("active");
        }
    </script>
    <style>
        table td, th {
            vertical-align:middle !important;
            text-align:center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content">
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Visible="false">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <asp:Label ID="lblAlert" runat="server" Text="" Font-Bold="true"></asp:Label>
                    </asp:Panel>

                    <div class="row">
                        <!-- task, page, download counter  start -->
                        <div class="col-xl-3 col-md-6">
                            <div class="card">
                                <div class="card-block">
                                    <div class="row align-items-end">
                                        <div class="col-12">
                                            <h4 class="text-c-yellow f-w-600">
                                                <asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label>
                                            </h4>
                                            <h6 class="text-muted m-b-0">Total Orders</h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer bg-c-yellow">
                                    <p class="text-white m-b-0"><i class="feather icon-clock text-white f-14 m-r-10"></i>Today's</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="card">
                                <div class="card-block">
                                    <div class="row align-items-end">
                                        <div class="col-12">
                                            <h4 class="text-c-green f-w-600">
                                                <asp:Label ID="lblDeliveredOrder" runat="server" Text="0"></asp:Label>
                                                /
                                                <asp:Label ID="lblPendingOrder" runat="server" Text="0"></asp:Label>
                                            </h4>
                                            <h6 class="text-muted m-b-0">Delivered Order / Pending Order</h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer bg-c-green">
                                    <p class="text-white m-b-0"><i class="feather icon-clock text-white f-14 m-r-10"></i>Yesterday's</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="card">
                                <div class="card-block">
                                    <div class="row align-items-end">
                                        <div class="col-12">
                                            <h4 class="text-c-pink f-w-600">
                                                <asp:Label ID="lblTotalBuilding" runat="server" Text="0"></asp:Label>
                                            </h4>
                                            <h6 class="text-muted m-b-0">Total Buildings</h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer bg-c-pink">
                                    <p class="text-white m-b-0"><i class="feather icon-clock text-white f-14 m-r-10"></i>update :
                                    <asp:Label ID="lblTime" runat="server"></asp:Label></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="card">
                                <div class="card-block">
                                    <div class="row align-items-end">
                                        <div class="col-12">
                                            <h4 class="text-c-blue f-w-600">
                                                <asp:Label ID="lblTotalProduct" runat="server" Text="0"></asp:Label>
                                            </h4>
                                            <h6 class="text-muted m-b-0">Total Products</h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer bg-c-blue">
                                    <p class="text-white m-b-0"><i class="feather icon-clock text-white f-14 m-r-10"></i>update :
                                        <asp:Label ID="lblTime1" runat="server"></asp:Label></p>
                                </div>
                            </div>
                        </div>
                        <!-- task, page, download counter  end -->

                        <!--  sale analytics start -->
                        <div class="col-xl-9 col-md-12">
                            <div class="card table-card">
                                <div class="card-header">
                                    <h5>Today's Required Product Count</h5>
                                </div>
                                <div class="card-block">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-borderless">
                                            <thead>
                                                <tr>
                                                    <th>Sr. No.</th>
                                                    <th>Photo</th>
                                                    <th class="text-left">Product Name</th>
                                                    <th>Count</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptrOrder" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label2" runat="server" Text='<%# Container.ItemIndex + 1 %>'></asp:Label>
                                                            </td>
                                                            <td>
                                                                <img src='<%#Eval("photo") %>' alt="" height="50" width="50" style="border-radius:10px">
                                                            </td>
                                                            <td class="text-left">
                                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("productName") + " " + Eval("packageQuantity") %>'></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label3" runat="server" Text='<%#Eval("productCount") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="text-right  m-r-20">
                                        <a href="orderDetailReport.aspx" class="b-b-primary text-primary">View all Orders </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--  sale analytics end -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
