<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="pdfPrepare.aspx.cs" Inherits="pdfPrepare" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpTitle" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" Runat="Server">
    <script>
        function handlechange() {
         //   alert($("#<%=chkMandatory.ClientID%>").prop('checked'))
            if ($("#<%=chkMandatory.ClientID%>").prop('checked')) {
                 $("#<%=chkAddName.ClientID%>").removeAttr("disabled");
              } else {
                    $("#<%=chkAddName.ClientID%>").attr("disabled", true);
            }
        
    }
</script>
    <div class="container">
        <h3>Add Textbox For</h3>
        <asp:FileUpload ID="FilePdf" runat="server" Width="400px" CssClass="form-control" />
        <br />
        <asp:CheckBox ID="chkMandatory" runat="server" onchange="handlechange()"  Checked="true" /> Add Mandatory Textbox [txtFile and txtTable] 
        <br />
        <br />
        <asp:CheckBox ID="chkAddName" runat="server"  /> Add Default Value to Mandatory Textbox [FileName and View_Pdf] 
        <br />
        <br />
        <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-primary" OnClick="btnUpload_Click" />
        <br />
        <br />
        <asp:Label ID="lblPdf" runat="server" Text="" ></asp:Label>
        <br />
        <br />
        <br />
        <br />
        <asp:DropDownList ID="ddlPdf" runat="server" Width="400px" CssClass="form-control"></asp:DropDownList>
        <br />
        <br />
        <asp:Button ID="btnAddText" runat="server" Text="Add Mandatory Textbox" CssClass="btn btn-primary" OnClick="btnAddText_Click"  />

    </div>
</asp:Content>

