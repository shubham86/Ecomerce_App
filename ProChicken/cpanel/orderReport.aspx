<%@ Page Title="Order Report" Language="C#" MasterPageFile="../cpanel/CPMaster.Master" AutoEventWireup="true" CodeBehind="orderReport.aspx.cs" Inherits="ProChicken.cpanel.orderReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script>
        window.onload = function menueActive(){
            document.getElementById("menuReport").classList.add("pcoded-hasmenu");
            document.getElementById("menuReport").classList.add("active");
            document.getElementById("menuReport").classList.add("pcoded-trigger");
            document.getElementById("menuOrderReport").classList.add("active");
         }
         
        function printDiv() {

            sDate = document.getElementById('<%=txtFromDate.ClientID%>').value.split("-");  
            tDate = document.getElementById('<%=txtToDate.ClientID%>').value.split("-"); 
            
            document.getElementById("sDate").innerHTML =  sDate[2] + "/" + sDate[1] + "/" + sDate[0];
            document.getElementById("tDate").innerHTML = tDate[2] + "/" + tDate[1] + "/" + tDate[0];

            var printContents = document.getElementById("printTable").innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }

        var tableToExcel = (function () {
        var uri = 'data:application/vnd.ms-excel;base64,'
            , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><style>table td,th{text-align:left} .pro-count{text-align:center !important;}</style><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
            , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
            , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
            return function (table, name) {
                if (!table.nodeType) table = document.getElementById(table)
                var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }

                document.getElementById("dlink").href = uri + base64(format(template, ctx));
                document.getElementById("dlink").download = "Orders_" + document.getElementById('<%=txtFromDate.ClientID%>').value + "_to_" + document.getElementById('<%=txtToDate.ClientID%>').value;
                document.getElementById("dlink").click();

            }
        })()
    </script>
    <style>        
        .dt-button {
            color:white !important;
        }
       .card-block table td, th {
            text-align:center;
            vertical-align:middle;
        }
        table td b {
            font-weight:600;
        }
        #mCSB_1_container {
            top:0 !important;
        }
        #mCSB_1 {
            position:unset !important;
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
                                    <h4>Order Report</h4>
                                    List of placed order
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="row filter">
                                <div class="col-lg-4 col-sm-12 filter-btn">
                                    <asp:dropdownlist id="ddlDay" runat="server" class="form-control m" forecolor="#888888" autopostback="true" width="100%" onselectedindexchanged="ddlAll_SelectedIndexChanged">
                                        <asp:ListItem Text="Today" Value="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Yesterday" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="This Week" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Previous Week" Value="7"></asp:ListItem>
                                        <asp:ListItem Text="This Month" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="Previous Month" Value="5"></asp:ListItem>
                                        <asp:ListItem Text="Randome Date" Value="6"></asp:ListItem>
                                    </asp:dropdownlist>
                                </div>
                                <div class="col-lg-4 col-sm-12 filter-btn">
                                    <asp:textbox id="txtFromDate" class="form-control m" textmode="Date" runat="server" forecolor="#888888" onkeydown="return false;" ontextchanged="txtFromDate_TextChanged" autopostback="true"></asp:textbox>
                                </div>
                                <div class="col-lg-4 col-sm-12 filter-btn">
                                    <asp:textbox id="txtToDate" class="form-control m" textmode="Date" runat="server" forecolor="#888888" onkeydown="return false;" ontextchanged="txtToDate_TextChanged" autopostback="true"></asp:textbox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="page-header-breadcrumb">                                
                                <ul class="breadcrumb-title">
                                    <li class="breadcrumb-item">
                                        <a href="dashboard.aspx"><i class="feather icon-home"></i></a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="#">Report</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="#">Order Report</a>
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
                        <div class="card-block">
                            <div class="row mb-2">
                                <div class="col-lg-4 col-sm-4">                                    
                                    <a class="dt-button" runat="server" onclick="tableToExcel('printTable', 'Order Report');">Excel</a>
                                    <a class="dt-button" onclick="printDiv();">Print</a>
                                </div>
                            </div>
                            <div class="dt-responsive table-responsive">
                                <table id="dom-jqry" class="table table-striped table-bordered nowrap">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Date</th>
                                            <th style="text-align:left">Customer Name</th>
                                            <th>Mobile</th>
                                            <th>Flat No</th>
                                            <th>Bill Amount</th>
                                            <th>Pay Mode</th>
                                            <%--<th>Payment</th>--%>
                                            <th>Delivery</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptrOrder" runat="server" OnItemCommand="rptrOrder_RowCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Container.ItemIndex+1 %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label6" runat="server" Text='<%# Convert.ToDateTime(Eval("orderDate")).ToString("dd/MM/yyyy")+ "<br /> " + Convert.ToDateTime(Eval("orderDate")).ToString("hh:mm tt") %>'></asp:Label>
                                                    </td>
                                                    <td style="text-align: left">
                                                        <asp:Label ID="Label7" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label8" runat="server" Text='<%#Eval("mobile") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Text='<%# "<b>" + Eval("flatNo") + "</b>,</br>" + (Eval("buildingName").ToString() == "" ? "-" : Eval("buildingName").ToString())%>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("totalAmount") %>'></asp:Label>
                                                    </td>
                                                   <td>
                                                        <asp:Label ID="Label4" runat="server" Text='<%#Eval("paymentMode") %>'></asp:Label>
                                                    </td>
                                                     <%--<td>
                                                        <asp:Label ID="Label5" runat="server" Text='<%# Convert.ToBoolean(Eval("paymentStatus")) ? "Paid" :"Pending" %>' CssClass='<%# Convert.ToBoolean(Eval("paymentStatus")) ? "link-success" :"link-danger" %>'></asp:Label>
                                                    </td>--%>
                                                    <td>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Convert.ToBoolean(Eval("deliveryStatus")) ? "Delivered" :"Pending" %>' CssClass='<%# Convert.ToBoolean(Eval("paymentStatus")) ? "link-success" :"link-danger" %>' CommandName="status" CommandArgument='<%#Eval("orderID") %>'></asp:LinkButton>
                                                    </td>                                                    
                                                    <td>
                                                        <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="files/assets/images/delete.png" AlternateText="Delete" Width="20px" Height="20px" CommandArgument='<%#Eval("orderID") %>' CommandName="delete" ToolTip="Delete" CausesValidation="false" OnClientClick="return confirm('Are You Sure You Want To Delete it..?')" />
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
        <!-- Print Area -->
        <div id="printTable" style="display: none">
            <table width="100%">
                <tr>
                    <td align="center">
                        <h4>Order Details</h4>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="font-size: 16px; margin-bottom: 10px">
                        <label id="sDate"></label>
                        To
                        <label id="tDate"></label>
                    </td>
                </tr>
            </table>
            <table class="table table-striped table-bordered nowrap">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Date</th>
                        <th style="text-align: left">Customer Name</th>
                        <th>Mobile</th>
                        <th>Flat No</th>
                        <th>Bill Amount</th>
                       <th>Pay Mode</th>
                         <%--<th>Payment</th>--%>
                        <th>Delivery</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptrOrder1" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Container.ItemIndex+1 %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Convert.ToDateTime(Eval("orderDate")).ToString("dd/MM/yyyy")+ " " + Convert.ToDateTime(Eval("orderDate")).ToString("hh:mm tt") %>'></asp:Label>
                                </td>
                                <td style="text-align: left">
                                    <asp:Label ID="Label7" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label8" runat="server" Text='<%#Eval("mobile") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("flatNo") + ", " + Eval("buildingName") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text='<%#Eval("totalAmount") %>'></asp:Label>
                                </td>
                               <td>
                                    <asp:Label ID="Label4" runat="server" Text='<%#Eval("paymentMode") %>'></asp:Label>
                                </td>
                                <%-- <td>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Convert.ToBoolean(Eval("paymentStatus")) ? "Paid" :"Pending" %>' CssClass='<%# Convert.ToBoolean(Eval("paymentStatus")) ? "link-success" :"link-danger" %>'></asp:Label>mmandArgument='<%#Eval("orderID") %>' CommandName="status" ToolTip="Change Status" />
                                </td>--%>
                                <td>
                                    <asp:Label ID="Label9" runat="server" Text= ></asp:Label>
                                    <asp:LinkButton ID="btnDelivery" runat="server" Text='<%# Convert.ToBoolean(Eval("deliveryStatus")) ? "Delivered" :"Pending" %>' CssClass='<%# Convert.ToBoolean(Eval("paymentStatus")) ? "link-success" :"link-danger" %>' CommandArgument='<%#Eval("orderID") %>' CommandName="deliveryStatus" ToolTip="Change delivery Status"></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
    <a id="dlink"  style="display:none;"></a>
</asp:Content>