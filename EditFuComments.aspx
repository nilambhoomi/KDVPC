<%@ Page Title="" Language="C#" MasterPageFile="~/FollowUpMaster.master" AutoEventWireup="true" CodeFile="EditFuComments.aspx.cs" Inherits="EditFuComments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <script type="text/javascript">
         function Confirmbox(e, page) {
             e.preventDefault();
             var answer = confirm('Do you want to save the data?');
             if (answer) {
                 //var currentURL = window.location.href;
                 document.getElementById('<%=pageHDN.ClientID%>').value = $('#ctl00_' + page).attr('href');
                  document.getElementById('<%= btnSave.ClientID %>').click();
              }
              else {
                  window.location.href = $('#ctl00_' + page).attr('href');
              }
          }
         function saveall() {
             document.getElementById('<%= btnSave.ClientID %>').click();
         }
    </script>
    <asp:HiddenField ID="pageHDN" runat="server" />
    <div class="container">
            <div class="row">

                <div class="col-md-10">
                    <label class="control-label">Comments: </label>
                    <div class="controls">
                        <asp:TextBox TextMode="MultiLine" Width="650px" Height="200px"  runat="server" ID="txtComment"></asp:TextBox>
                    </div>
                </div>
                </div>
     
                       <div class="row">

                <div class="col-md-10">
   <asp:Button runat="server" ID="btnSave" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-primary" UseSubmitBehavior="False" /></div>
                     
                </div>
     </div>
                                
</asp:Content>

