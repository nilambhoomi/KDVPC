<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImportMedicines.aspx.cs" MasterPageFile="~/site.master" Inherits="ImportMedicines" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="Server">

    <div class="main-content-inner">
        <div class="page-content">
            <div class="page-header">
                <h1>
                    <small>Utility								
									<i class="ace-icon fa fa-angle-double-right"></i>

                    </small>
                </h1>
            </div>


            <div class="span12">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Label ID="Label1" runat="server"></asp:Label>
                                <div class="row">
                                    <asp:Label ID="lblConfirm" runat="server"></asp:Label>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        Select a file to upload: 
                                    <asp:FileUpload ID="FileUpload" Width="450px" runat="server" CssClass="form-control" />
                                    </div>
                                    <div class="col-lg-4">
                                        <asp:Button ID="btnImport" runat="server" Text="Import Data" CssClass="btn btn-default" OnClick="ImportFromExcel" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
