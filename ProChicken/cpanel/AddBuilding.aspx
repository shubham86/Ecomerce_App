<%@ Page Title="Add Society" Language="C#" MasterPageFile="../cpanel/CPMaster.Master" AutoEventWireup="true" CodeBehind="AddBuilding.aspx.cs" Inherits="ProChicken.cpanel.AddBuilding" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">    
         function validation() {
            if (document.getElementById('<%=txtBuildingName.ClientID%>').value == "") {
                document.getElementById("lblBuildingName").style.display = "block";
                document.getElementById('<%=txtBuildingName.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtStreet.ClientID%>').value == "") {
                document.getElementById("lblStreet").style.display = "block";
                document.getElementById('<%=txtStreet.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtCity.ClientID%>').value == "") {
                document.getElementById("lblCity").style.display = "block";
                document.getElementById('<%=txtCity.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtPincode.ClientID%>').value == "0") {
                document.getElementById("lblPincode").style.display = "block";
                document.getElementById('<%=txtPincode.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtPincode.ClientID%>').value.length < 6) {
                document.getElementById("lblPincode1").style.display = "block";
                document.getElementById('<%=txtPincode.ClientID%>').focus();
                return false;
            }
         }

         function hideBuildingName() {
             document.getElementById("lblBuildingName").style.display = "none";
         }
         function hideStreet() {
             document.getElementById("lblStreet").style.display = "none";
         }
         function hideCity() {
             document.getElementById("lblCity").style.display = "none";
         }

        function isNumberKey(evt, obj) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            var value = obj.value;
            var dotcontains = value.indexOf(".") != -1;
            if (dotcontains)
                if (charCode == 46) return false;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;
                        
             document.getElementById("lblPincode").style.display = "none";
             document.getElementById("lblPincode1").style.display = "none";

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
                                    <h4>Add Society</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="page-header-breadcrumb">
                                <ul class="breadcrumb-title">
                                    <li class="breadcrumb-item">
                                        <a href="dashboard.aspx"><i class="feather icon-home"></i></a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="manageBuildings.aspx">Manage Society</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="#">Add Society</a>
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
                                        <label class="col-sm-2 col-form-label">Society Name</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtBuildingName" CssClass="form-control" runat="server" type="text" MaxLength="100" onkeypress="hideBuildingName()"></asp:TextBox>
                                            <label id="lblBuildingName" class="error">Please enter society name</label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Location</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control" type="text" MaxLength="250" onkeypress="hideStreet()"></asp:TextBox>
                                            <label id="lblStreet" class="error">Please enter location</label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">City</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtCity" runat="server" type="text" CssClass="form-control" MaxLength="100" onkeypress="hideCity()"></asp:TextBox>
                                            <label id="lblCity" class="error">Please enter city</label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Pincode</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtPincode" runat="server" type="text" CssClass="form-control" MaxLength="6" onkeypress='javascript:return isNumberKey(event,this);'></asp:TextBox>
                                            <label id="lblPincode" class="error">Please enter pincode</label>
                                            <label id="lblPincode1" class="error">Please enter valid pincode</label>
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
