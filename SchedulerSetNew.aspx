<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SchedulerSetNew.aspx.cs" Inherits="SchedulerSetNew" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    
    <title></title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css" />
    <link rel="stylesheet" href="assets/css/font-awesome.css" />

      <%--<link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.css" rel="stylesheet" />--%>
        <link href="css/jquery-ui-1.8.21.custom.css" rel="stylesheet" />


    <link href="css/jquery-ui-timepicker-addon.css" rel="stylesheet" />
    <style>
        .ui-datepicker td > a.ui-state-active {
            color: indianred !important;
            font-weight: 800;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="alert-danger" style="padding:5px">
        <asp:Label ID="lblFollowupDetail" runat="server" Text="Label"  ></asp:Label>
            </div>
     
        <div>
                Location :
            <asp:DropDownList ID="ddlLocation" CssClass="form-control" runat="server"></asp:DropDownList>
                </div>
            <br />
    <div>
        <br />
        <br />
      <asp:TextBox ID="txtFollowedUpOn" CssClass="fudate form-control"  runat="server" style="width:50%;float:right"></asp:TextBox>
        <br />
        <br />
        <br />

                                <br />
                                <asp:Button ID="btnSet" CssClass="btn btn-primary" style="float:right" runat="server" Text="Set" OnClick="btnSet_Click" />
                  <br />
        <br />
    </div>
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <script src="Scripts/jquery-ui.min.js"></script>
    <script src="js/jquery-ui-timepicker-addon.js"></script>
        <script>
     
       
          var $j = jQuery.noConflict();

        //$j(document).ready(function () {           
           $j(".fudate").datetimepicker({
               controlType: 'select',
                oneLine: true,
                timeFormat: 'hh:mm tt',
                showPeriod: true,
                stepMinute: 30,
              //  defaultTime: '08:00 am',
                formatTime: 'hh:mm tt',
               // defaultValue: new Date()
            });           
        //});


   
   </script>

    </form>

</body>
</html>
