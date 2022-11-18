<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="UploadDocument.aspx.cs" Inherits="UploadDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpTitle" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="Server">
    <div class="container">

        <div class="row">
            <h3>Document Upload</h3>
            <hr />
        </div>
        <div class="row">



            <div class="col-sm-6 inline">Please Enter text to create
                <asp:TextBox ID="txtFolderName" runat="server"></asp:TextBox>
            </div>
            <div class="col-sm-6 inline">
                <asp:Button ID="btnCreateFolder" Text="Create sub Folder" runat="server" OnClick="btnCreateFolder_Click" />
            </div>
        </div>
        <br />

        <div class="row">



            <div class="col-sm-6 inline">Folder List
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                   <%-- <asp:ListItem Selected="True" Value="1"></asp:ListItem>--%>
                </asp:DropDownList>
            </div>
            <div class="col-sm-6 inline">
                <asp:TextBox ID="txtBindFolderName" runat="server"></asp:TextBox>
                <asp:Button ID="btnRename" runat="server" CssClass="btn btn-primary" Text="Rename" OnClick="btnRename_Click" />
                <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary" Text="Delete" OnClick="btnDelete_Click" />
            </div>
        </div>
        <br />
        <div class="row">



            <div class="col-sm-6 inline">
                <label class="lblstyle">Select Documents</label>
            </div>
            <div class="col-sm-6 inline">
                <asp:FileUpload runat="server" ID="fup" AllowMultiple="true" />
                <i>(Max. file size 5MB.)</i>
            </div>
             <div class="col-sm-6 inline">
            <asp:Label ID="Label1" runat="server"></asp:Label> 
                 </div>
        </div>
        <div class="col-xs-12">
            <div class="row">

                <div class="col-sm-2">
                    <label class="lblstyle">&nbsp;</label>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSave_Click" />

                    </div>
                </div>

            </div>


        </div>
    </div>
    <br />



    <div class="row">
        <div class="col-12">
            <asp:HiddenField ID="pageHDN" runat="server" />
            <div class="container">
                <div class="row">

                    <asp:GridView ID="gvDocument" BorderStyle="None" CssClass="table table-bordered" Width="100%" runat="server" AutoGenerateColumns="false"
                        OnRowCommand="gvDocument_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Text" HeaderText="FileName" />
                            <asp:TemplateField>
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" Text="Download" runat="server" CommandName="Download" CommandArgument='<%# Eval("Text") %>'></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
                 <asp:TemplateField HeaderText="View">  
                    <ItemTemplate>  
                        <asp:LinkButton ID="btnView" runat="server" Text="View" CommandName="Preview" 
                        CommandArgument='<%# Eval("Text") %>' />  
                     
                    </ItemTemplate>  
                </asp:TemplateField>            
               
                            <%--<asp:TemplateField HeaderText="Download">  
                    <ItemTemplate>  
                        <asp:Button ID="btnDownload" runat="server" Text="Download" OnClick="btnDownload_Click" />  
                    </ItemTemplate>  
                </asp:TemplateField> 
                           --%>

                        </Columns>
                         <EmptyDataTemplate>No Record Available</EmptyDataTemplate>  
                    </asp:GridView>


                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="PreviewPopup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none; max-height: 750px;" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" style="background: white">
            <div class="modal-content">
                <div class="modal-header" style="display: inline-block; width: 100%;">
                    Document Preview
                                       
                    <button type="button" class="close" style="float: right" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <iframe width="960px" height="750px" runat="server" id="iframeDocument"></iframe>
                </div>
            </div>
        </div>
    </div>
    <script src="Scripts/jquery-ui-1.8.24.js"></script>
    <link href="Style/jquery-ui.css" rel="stylesheet" />
    <script>
        $.noConflict();
        function openPopup() {
            $('#PreviewPopup').modal('show');
        }

        function closeModelPopup() {
            //jQuery.noConflict();
            //(function ($) {

            $('#PreviewPopup').modal('hide');

            //})(jQuery);
        }
    </script>
</asp:Content>

