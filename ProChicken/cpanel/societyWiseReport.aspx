<%@ Page Title="Society wise Report" Language="C#" MasterPageFile="CPMaster.Master" AutoEventWireup="true" Async="true" CodeBehind="societyWiseReport.aspx.cs" Inherits="ProChicken.cpanel.societyWiseReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function menueActive() {
            sDate = document.getElementById('<%=txtFromDate.ClientID%>').value.split("-");
            tDate = document.getElementById('<%=txtToDate.ClientID%>').value.split("-");

            document.getElementById("menuReport").classList.add("pcoded-hasmenu");
            document.getElementById("menuReport").classList.add("active");
            document.getElementById("menuReport").classList.add("pcoded-trigger");
            document.getElementById("menuSocietyOrderReport").classList.add("active");


            document.getElementById("sDate").innerHTML = sDate[2] + "/" + sDate[1] + "/" + sDate[0];
            document.getElementById("tDate").innerHTML = tDate[2] + "/" + tDate[1] + "/" + tDate[0];
        }

        function printDiv() {

            var printContents = document.getElementById("printTable").innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }

        //function createColumn() {                            
        //    var headerRow = document.getElementById('basic-btn').getElementsByTagName('thead')[0].rows[0];
        //    var x = headerRow.cells.length;
        //    var i;
        //    for (i = 4; i <= x ; i++)
        //    {
        //         var y = document.getElementById("tblRow").insertCell(i);
        //        y.innerHTML = headerRow.cells[i].innerHTML;
        //    }
        //}

        var tableToExcel = (function () {
            var uri = 'data:application/vnd.ms-excel;base64,'
                , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><style>table td,th{text-align:left} .pro-count{text-align:center !important;}</style><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
                , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
                , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
            return function (table, name, filename) {
                if (!table.nodeType) table = document.getElementById(table)
                var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }

                document.getElementById("dlink").href = uri + base64(format(template, ctx));
                document.getElementById("dlink").download = document.getElementById('<%=lblBuildingName.ClientID%>').innerHTML + "_" + document.getElementById('<%=txtFromDate.ClientID%>').value + "_to_" + document.getElementById('<%=txtToDate.ClientID%>').value;
                document.getElementById("dlink").click();

            }
        })()

        // When the user clicks the button, open the modal 
        function mailOnclick() {
            document.getElementById("myModal").style.display = "block";
            return false;
        }

        // When the user clicks on <span> (x), close the modal
        function closeOnclick() {
            document.getElementById("myModal").style.display = "none";
        }

        function sendclick() {         
            var atLeast = 1;
            var CHK = document.getElementById("<%=ddlEMailID.ClientID%>");
            var checkbox = CHK.getElementsByTagName("input");
            var counter = 0;
            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {
                    counter++;
                }
            }

            if (document.getElementById('<%=FileUpload1.ClientID%>').value == "") {
                document.getElementById("lblFileUpload").style.display = "block";
                document.getElementById('<%=FileUpload1.ClientID%>').focus();
                return false;
            }
            else if (atLeast > counter) {
                document.getElementById("lblEMail").style.display = "block";
                document.getElementById('<%=ddlEMailID.ClientID%>').focus();
                return false;
            }
            else {
                document.getElementById("loader").style.display = "block";
            }
        }

        function hidUploadlbl() {
            document.getElementById("lblFileUpload").style.display = "none";
        }
        function hidEmaillbl() {
            document.getElementById("lblEMail").style.display = "none";
        }

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
        table tfoot{
            border-top: 4px double #c0c0c0;
        }
        table tfoot th{
            vertical-align:middle !important;
        }
        table tfoot td {
            line-height:25px;
            font-weight:600;
        }
        #mCSB_1_container {
            top:0 !important;
        }
        #mCSB_1 {
            position:unset !important;
        }
        input[type=checkbox], input[type=radio] {
            box-sizing: border-box;
            margin-right: 10px;
            width: 13px;
        }
        .btnSend {
            color:#01a9ac !important;
        }
        .btnSend:hover {
            color:#007a7c !important;
        }
        .close {
            font-weight:600;
            font-size:20px;
            color:#666666
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
                    <!-- The Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div id="loader" class="loader2">
                                <img class="loader-image2" src="../assets/images/small_loader.gif" width="60" />
                            </div>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Send Report via E-Mail</h5>
                                    <button type="button" class="close m-0" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <asp:Label ID="lblRegisterAlert" runat="server" Font-Size="12px" ForeColor="#cc5965" CssClass="col-12"></asp:Label>
                                        <div class="col-lg-12 col-md-12 col-sm-4 col-xs-12">
                                            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control mb-2" AllowMultiple="true" onclick="hidUploadlbl()" accept=".xls, .xlsx, .pdf"/>  
                                            <label id="lblFileUpload" class="error">Please select report.</label>
                                        </div>
                                        <div class="col-lg-12 col-md-12 col-sm-4 col-xs-12 mt-3">
                                            <asp:CheckBoxList ID="ddlEMailID" runat="server" CssClass="form=control" onclick="hidEmaillbl()">                                                
                                                <asp:ListItem Text="shricorporate@gmail.com"></asp:ListItem>                                                
                                                <asp:ListItem Text="swapy96k@gmail.com"></asp:ListItem>
                                                <asp:ListItem Text="dhomseshubham@gmail.com"></asp:ListItem>
                                            </asp:CheckBoxList>
                                            <label id="lblEMail" class="error">Please select email-id.</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <a id="btnSend" class="btnSend" runat="server" onclick="return sendclick();" onserverclick="btnSnedMail_Click" style="color:#01a9ac;" title="Send"><i class="icofont icofont-paper-plane f-40"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row align-items-end">
                        <div class="col-lg-4">
                            <div class="page-header-title">
                                <div class="d-inline">
                                    <h4>Society Wise Order</h4>
                                    List of placed order
                                    <asp:Label ID="lblColumnString" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="row filter">
                                <div class="col-lg-4 col-sm-12 filter-btn">
                                    <asp:DropDownList ID="ddlDay" runat="server" class="form-control m" ForeColor="#888888" AutoPostBack="true" Width="100%" OnSelectedIndexChanged="ddlAll_SelectedIndexChanged">
                                        <asp:ListItem Text="Today" Value="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Yesterday" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="This Week" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Previous Week" Value="7"></asp:ListItem>
                                        <asp:ListItem Text="This Month" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="Previous Month" Value="5"></asp:ListItem>
                                        <asp:ListItem Text="Randome Date" Value="6"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-4 col-sm-12 filter-btn">
                                    <asp:TextBox ID="txtFromDate" class="form-control m" TextMode="Date" runat="server" ForeColor="#888888" onkeydown="return false;" OnTextChanged="txtFromDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                </div>
                                <div class="col-lg-4 col-sm-12 filter-btn">
                                    <asp:TextBox ID="txtToDate" class="form-control m" TextMode="Date" runat="server" ForeColor="#888888" onkeydown="return false;" OnTextChanged="txtToDate_TextChanged" AutoPostBack="true"></asp:TextBox>
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
                                    <li class="breadcrumb-item"><a href="#">Society Wise Order </a>
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
                                <div class="col-lg-2 col-sm-4">
                                    <a class="dt-button" onclick="tableToExcel('printTable', 'Society Report');">Excel</a>
                                    <%--<a class="dt-button" data-toggle="modal" data-target="#exampleModal">E-Mail</a>--%>
                                </div>
                                <div class="col-lg-4 col-sm-8">
                                    <asp:DropDownList ID="ddlBuilding" runat="server" CssClass="js-example-basic-single" OnSelectedIndexChanged="ddlBuilding_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <div class="col-lg-6 col-sm-12 m-auto">
                                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="dt-responsive table-responsive">
                                <table id="dom-jqry" class="table table-striped table-bordered nowrap">
                                    <thead>
                                        <tr>
                                            <th>Sr.</th>
                                            <th>Date</th>
                                            <th style="text-align: left">Customer Name</th>
                                            <th>Flat</th>
                                            <%--<th>Bill Amount</th>--%>
                                            <asp:Repeater ID="rptProduct" runat="server">
                                                <ItemTemplate>
                                                    <th>
                                                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("productName").ToString() %>'></asp:Label>
                                                    </th>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <th>Pay Mode</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptrOrder" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Container.ItemIndex+1 %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label6" runat="server" Text='<%# Convert.ToDateTime(Eval("orderDate")).ToString("dd/MM/yyyy")+ "<br />" + Convert.ToDateTime(Eval("orderDate")).ToString("hh:mm tt") %>'></asp:Label>
                                                    </td>
                                                    <td style="text-align: left">
                                                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("name").ToString() + "</br> Mo : " + Eval("mobile").ToString() %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Text='<%#Eval("flatNo").ToString() %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label10" runat="server" Text='<%#Eval("Boneless Chicken 500 gm") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label13" runat="server" Text='<%#Eval("Chicken Curry Cut 500 gm") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label11" runat="server" Text='<%#Eval("Chicken Curry Cut 1 kg") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label12" runat="server" Text='<%#Eval("Chicken Drumstick 500 gm") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label14" runat="server" Text='<%#Eval("Chicken Lollipop 500 gm") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label15" runat="server" Text='<%#Eval("Farm Fresh Eggs 6 Pieces") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label16" runat="server" Text='<%#Eval("Farm Fresh Eggs Tray 30 Pieces") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label9" runat="server" Text='<%#Eval("totalAmount") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label17" runat="server" Text='<%#Eval("paymentMode") %>'></asp:Label>
                                                    </td>

                                                    <%--<asp:Repeater ID="rptrOrderRow" runat="server">
                                                        <ItemTemplate>
                                                            <td>
                                                                <asp:Label ID="Label9" runat="server" Text='<%#Eval("row") %>'></asp:Label>
                                                            </td>
                                                        </ItemTemplate>
                                                    </asp:Repeater>--%>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                    <tfoot>                                        
                                        <tr role="row">                                                                                        
                                            <th colspan="4">Total</th>                                            
                                            <asp:Repeater ID="rptrTableFooter" runat="server">
                                                <ItemTemplate>
                                                    <td>
                                                        <asp:Label ID="lblFooterTotal" runat="server" Text='<%# Eval("productName").ToString() %>'></asp:Label>
                                                    </td>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tr>
                                    </tfoot>
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
                    <td align="center" colspan="3">
                        <h4>Order Details</h4>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3">
                        <asp:Label ID="lblBuildingName" runat="server" Font-Size="18px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="30%"></td>
                    <td width="40%" align="center" style="font-size: 18px; margin-bottom: 10px">
                        <asp:Label ID="lblAddress1" runat="server" Font-Size="16px"></asp:Label>
                    </td>
                    <td width="30%" align="right" style="font-size: 16px; margin-bottom: 10px">
                        <label id="sDate"></label>
                        To
                        <label id="tDate"></label>
                    </td>
                </tr>
            </table>
            <table class="table table-striped table-bordered nowrap">
                <thead>                    
                    <tr>
                        <th>Sr.</th>
                        <th>Date</th>
                        <th style="text-align: left">Customer Name</th>
                        <th>Flat</th>
                        <%--<th>Bill Amount</th>--%>
                        <asp:Repeater ID="rptProduct1" runat="server">
                            <ItemTemplate>
                                <th>
                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("productName").ToString() %>'></asp:Label>
                                </th>
                            </ItemTemplate>
                        </asp:Repeater>
                        <th>Pay Mode</th>
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
                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("name").ToString() + " Mo : " + Eval("mobile").ToString() %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text='<%#Eval("flatNo").ToString() %>'></asp:Label>
                                </td>
                                <td class="pro-count">
                                    <asp:Label ID="Label10" runat="server" Text='<%#Eval("Boneless Chicken 500 gm") %>'></asp:Label>
                                </td>
                                <td class="pro-count">
                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Chicken Curry Cut 500 gm") %>'></asp:Label>
                                </td>
                                <td class="pro-count">
                                    <asp:Label ID="Label11" runat="server" Text='<%#Eval("Chicken Curry Cut 1 kg") %>'></asp:Label>
                                </td>
                                <td class="pro-count">
                                    <asp:Label ID="Label12" runat="server" Text='<%#Eval("Chicken Drumstick 500 gm") %>'></asp:Label>
                                </td>
                                <td class="pro-count">
                                    <asp:Label ID="Label14" runat="server" Text='<%#Eval("Chicken Lollipop 500 gm") %>'></asp:Label>
                                </td>
                                <td class="pro-count">
                                    <asp:Label ID="Label15" runat="server" Text='<%#Eval("Farm Fresh Eggs 6 Pieces") %>'></asp:Label>
                                </td>
                                <td class="pro-count">
                                    <asp:Label ID="Label16" runat="server" Text='<%#Eval("Farm Fresh Eggs Tray 30 Pieces") %>'></asp:Label>
                                </td>
                                <td class="pro-count">
                                    <asp:Label ID="Label9" runat="server" Text='<%#Eval("totalAmount") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label17" runat="server" Text='<%#Eval("paymentMode") %>'></asp:Label>
                                </td>

                                <%--<asp:Repeater ID="rptrOrderRow" runat="server">
                                    <ItemTemplate>
                                        <td>
                                            <asp:Label ID="Label9" runat="server" Text='<%#Eval("row") %>'></asp:Label>
                                        </td>
                                    </ItemTemplate>
                                </asp:Repeater>--%>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
                <tfoot>
                    <tr>
                        <th class="pro-count" colspan="4">Total</th>
                        <asp:Repeater ID="rptrTableFooter2" runat="server">
                            <ItemTemplate>
                                <td class="pro-count">
                                    <asp:Label ID="lblFooterTotal" runat="server" Text='<%# Eval("productName").ToString() %>'></asp:Label>
                                </td>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
    <%--<a onclick="createColumn()"> click</a>--%>
    <a id="dlink"  style="display:none;"></a>

</asp:Content>