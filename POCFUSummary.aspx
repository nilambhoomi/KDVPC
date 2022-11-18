<%@ Page Language="C#" MasterPageFile="~/AddFollowUpMaster.master" AutoEventWireup="true" CodeFile="POCFUSummary.aspx.cs" Inherits="POCFUSummary" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="EditableDropDownList" Namespace="EditableControls" TagPrefix="editable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.css" rel="stylesheet" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/Multiselect.css" rel="stylesheet" />
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>--%>
    <script src="js/images/bootstrap.min.js"></script>
    <%--<script type="text/javascript" src='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>--%>

    <script src="js/multiselect.js"></script>
    <style>
        .panel-default > .panel-heading {
            color: #333;
            background-color: #f5f5f5;
            border-color: #ddd;
        }

        .panel-body {
            padding: 15px;
            overflow-x: auto;
            white-space: nowrap;
        }

        .panel-default > .panel-heading + .panel-collapse > .panel-body {
            border-top-color: #ddd;
        }

        .panel-group .panel-heading + .panel-collapse > .list-group, .panel-group .panel-heading + .panel-collapse > .panel-body {
            border-top: 1px solid #ddd;
        }

        .panel-title > .small, .panel-title > .small > a, .panel-title > a, .panel-title > small, .panel-title > small > a {
            color: inherit;
        }


        a {
            color: #337ab7;
            text-decoration: none;
        }

        a {
            background-color: transparent;
        }

        .radio input[type="radio"], .checkbox input[type="checkbox"] {
            float: left;
            margin-left: 13px;
        }

        .ProcText {
            width: 70px;
        }

        input[type=checkbox] {
            -ms-transform: scale(1.5); /* IE */
            -moz-transform: scale(1.5); /* FF */
            -webkit-transform: scale(1.5); /* Safari and Chrome */
            -o-transform: scale(1.5); /* Opera */
            margin-left: 13px;
            /*padding: 10px;*/
        }

        .Proctable {
            table-layout: fixed;
            min-width: 1300px;
            word-wrap: break-word;
        }
    </style>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title"><a class="collapse" style="cursor: pointer;" id="#Summarytable">Summary</a></h4>
              <asp:DropDownList ID="ddlInhouse" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlInhouse_SelectedIndexChanged">
                <asp:ListItem Text="All" Value="-1" ></asp:ListItem>
                <asp:ListItem Text="Inhouse" Value="1" ></asp:ListItem>
                <asp:ListItem Text="SC" Value="0" Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div id="Summarytablediv" class="panel-collapse collapse" style="display: none">
            <div class="panel-body">
                <div class="table-responsive">
                    <asp:Repeater runat="server" ID="repSummery">
                        <HeaderTemplate>
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Body Part</th>
                                        <th>Mcode</th>
                                        <th>In-House/S C</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("PDate","{0:MM/dd/yyyy}") %></td>
                                <td><%# Eval("BodyPart") %></td>
                                <td><%# Eval("Mcode") %></td>
                                 <td><%# Convert.ToBoolean(Eval("INhouse"))?"In-House":"SC" %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate></table></FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
    <script>
        function tableTransform(objTable) {
            objTable.each(function () {
                var $this = $(this);
                var newrows = [];
                $this.find("tbody tr, thead tr").each(function () {
                    var i = 0;
                    $(this).find("td, th").each(function () {
                        i++;
                        if (newrows[i] === undefined) {
                            newrows[i] = $("<tr></tr>");
                        }
                        newrows[i].append($(this));
                    });
                });
                $this.find("tr").remove();
                $.each(newrows, function () {
                    $this.append(this);
                });
            });
            return false;
        }

    </script>
    <script type="text/javascript">
        function toggleDiv(divId) {
            $("#" + divId).toggle();
        }

        $(document).ready(function () {
            
            $(window).load(function () {
                $('.collapse')[0].click();
                $("#" + localStorage.getItem("lastdisplayGridvalue")).prop("style", "height:auto;display:block");
                if (localStorage.getItem("lastdisplayGridconsider") == "none")
                { $("#Considertablediv").prop("style", "height:0px;display:none"); }
            });

            $(window).bind('beforeunload', function () {
                //debugger;
                $('#accordion').find("div[id*='div']").each(function (e) {
                    if ($("#" + this.id).css("display") == "block")
                    { localStorage.setItem("lastdisplayGridvalue", this.id); }
                });
                if ($("#Considertablediv").css("display") == "none")
                { localStorage.setItem("lastdisplayGridconsider", "none"); }
                else { localStorage.setItem("lastdisplayGridconsider", "block"); }
            });

            $('.collapse').click(function () {
                var test = this.id;
                if ($(test + "div").css("display") == "none") {
                    $(test + "div").prop("style", "height:auto;display:block");
                }
                else {
                    $(test + "div").prop("style", "height:0px;display:none")
                }
            });
            $('#date').val($('#ctl00_ContentPlaceHolder1_dov').val());
            $('#date').text($('#ctl00_ContentPlaceHolder1_dov').val());
            $('#date').html($('#ctl00_ContentPlaceHolder1_dov').val());
            $('#date').datepicker();
            // $('#Medication').multiselect({ includeSelectAllOption: true});
            setdatepicker();
            loadPanel();
            if ($('#lblName').val() != "") {
                $('#New').css("visiblity", "visible");
            }
            else {
                $('#New').css("visiblity", "hidden");
            }

            $('#txtDate').text($('#DOEhdn').val());
        });
        function setdatepicker() {
            $('.dateonly').datepicker({
                dateFormat: "mm/dd/yy"
            });
            $('.date').datepicker({
                dateFormat: "mm/dd/yy",

            });
        }
        function loadPanel() {
        }
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {
                    setdatepicker();
                    loadPanel();
                }
            });
        }
    </script>
    <style>
        .panel {
            margin-bottom: 20px;
            background-color: #fff;
            border: 1px solid transparent;
            border-radius: 4px;
            -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
            box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
        }

        .panel-body {
            padding: 15px;
        }

        .panel-heading {
            padding: 10px 15px;
            border-bottom: 1px solid transparent;
            border-top-left-radius: 3px;
            border-top-right-radius: 3px;
        }

            .panel-heading > .dropdown .dropdown-toggle {
                color: inherit;
            }

        .panel-title {
            margin-top: 0;
            margin-bottom: 0;
            font-size: 16px;
            color: inherit;
        }

            .panel-title > .small,
            .panel-title > .small > a,
            .panel-title > a,
            .panel-title > small,
            .panel-title > small > a {
                color: inherit;
            }

        .panel-footer {
            padding: 10px 15px;
            background-color: #f5f5f5;
            border-top: 1px solid #ddd;
            border-bottom-right-radius: 3px;
            border-bottom-left-radius: 3px;
        }

        .panel > .list-group,
        .panel > .panel-collapse > .list-group {
            margin-bottom: 0;
        }

            .panel > .list-group .list-group-item,
            .panel > .panel-collapse > .list-group .list-group-item {
                border-width: 1px 0;
                border-radius: 0;
            }

            .panel > .list-group:first-child .list-group-item:first-child,
            .panel > .panel-collapse > .list-group:first-child .list-group-item:first-child {
                border-top: 0;
                border-top-left-radius: 3px;
                border-top-right-radius: 3px;
            }

            .panel > .list-group:last-child .list-group-item:last-child,
            .panel > .panel-collapse > .list-group:last-child .list-group-item:last-child {
                border-bottom: 0;
                border-bottom-right-radius: 3px;
                border-bottom-left-radius: 3px;
            }

        .panel-heading + .list-group .list-group-item:first-child {
            border-top-width: 0;
        }

        .list-group + .panel-footer {
            border-top-width: 0;
        }

        .panel > .panel-collapse > .table,
        .panel > .table,
        .panel > .table-responsive > .table {
            margin-bottom: 0;
        }

            .panel > .panel-collapse > .table caption,
            .panel > .table caption,
            .panel > .table-responsive > .table caption {
                padding-right: 15px;
                padding-left: 15px;
            }

            .panel > .table-responsive:first-child > .table:first-child,
            .panel > .table:first-child {
                border-top-left-radius: 3px;
                border-top-right-radius: 3px;
            }

                .panel > .table-responsive:first-child > .table:first-child > tbody:first-child > tr:first-child,
                .panel > .table-responsive:first-child > .table:first-child > thead:first-child > tr:first-child,
                .panel > .table:first-child > tbody:first-child > tr:first-child,
                .panel > .table:first-child > thead:first-child > tr:first-child {
                    border-top-left-radius: 3px;
                    border-top-right-radius: 3px;
                }

                    .panel > .table-responsive:first-child > .table:first-child > tbody:first-child > tr:first-child td:first-child,
                    .panel > .table-responsive:first-child > .table:first-child > tbody:first-child > tr:first-child th:first-child,
                    .panel > .table-responsive:first-child > .table:first-child > thead:first-child > tr:first-child td:first-child,
                    .panel > .table-responsive:first-child > .table:first-child > thead:first-child > tr:first-child th:first-child,
                    .panel > .table:first-child > tbody:first-child > tr:first-child td:first-child,
                    .panel > .table:first-child > tbody:first-child > tr:first-child th:first-child,
                    .panel > .table:first-child > thead:first-child > tr:first-child td:first-child,
                    .panel > .table:first-child > thead:first-child > tr:first-child th:first-child {
                        border-top-left-radius: 3px;
                    }

                    .panel > .table-responsive:first-child > .table:first-child > tbody:first-child > tr:first-child td:last-child,
                    .panel > .table-responsive:first-child > .table:first-child > tbody:first-child > tr:first-child th:last-child,
                    .panel > .table-responsive:first-child > .table:first-child > thead:first-child > tr:first-child td:last-child,
                    .panel > .table-responsive:first-child > .table:first-child > thead:first-child > tr:first-child th:last-child,
                    .panel > .table:first-child > tbody:first-child > tr:first-child td:last-child,
                    .panel > .table:first-child > tbody:first-child > tr:first-child th:last-child,
                    .panel > .table:first-child > thead:first-child > tr:first-child td:last-child,
                    .panel > .table:first-child > thead:first-child > tr:first-child th:last-child {
                        border-top-right-radius: 3px;
                    }

            .panel > .table-responsive:last-child > .table:last-child,
            .panel > .table:last-child {
                border-bottom-right-radius: 3px;
                border-bottom-left-radius: 3px;
            }

                .panel > .table-responsive:last-child > .table:last-child > tbody:last-child > tr:last-child,
                .panel > .table-responsive:last-child > .table:last-child > tfoot:last-child > tr:last-child,
                .panel > .table:last-child > tbody:last-child > tr:last-child,
                .panel > .table:last-child > tfoot:last-child > tr:last-child {
                    border-bottom-right-radius: 3px;
                    border-bottom-left-radius: 3px;
                }

                    .panel > .table-responsive:last-child > .table:last-child > tbody:last-child > tr:last-child td:first-child,
                    .panel > .table-responsive:last-child > .table:last-child > tbody:last-child > tr:last-child th:first-child,
                    .panel > .table-responsive:last-child > .table:last-child > tfoot:last-child > tr:last-child td:first-child,
                    .panel > .table-responsive:last-child > .table:last-child > tfoot:last-child > tr:last-child th:first-child,
                    .panel > .table:last-child > tbody:last-child > tr:last-child td:first-child,
                    .panel > .table:last-child > tbody:last-child > tr:last-child th:first-child,
                    .panel > .table:last-child > tfoot:last-child > tr:last-child td:first-child,
                    .panel > .table:last-child > tfoot:last-child > tr:last-child th:first-child {
                        border-bottom-left-radius: 3px;
                    }

                    .panel > .table-responsive:last-child > .table:last-child > tbody:last-child > tr:last-child td:last-child,
                    .panel > .table-responsive:last-child > .table:last-child > tbody:last-child > tr:last-child th:last-child,
                    .panel > .table-responsive:last-child > .table:last-child > tfoot:last-child > tr:last-child td:last-child,
                    .panel > .table-responsive:last-child > .table:last-child > tfoot:last-child > tr:last-child th:last-child,
                    .panel > .table:last-child > tbody:last-child > tr:last-child td:last-child,
                    .panel > .table:last-child > tbody:last-child > tr:last-child th:last-child,
                    .panel > .table:last-child > tfoot:last-child > tr:last-child td:last-child,
                    .panel > .table:last-child > tfoot:last-child > tr:last-child th:last-child {
                        border-bottom-right-radius: 3px;
                    }

            .panel > .panel-body + .table,
            .panel > .panel-body + .table-responsive,
            .panel > .table + .panel-body,
            .panel > .table-responsive + .panel-body {
                border-top: 1px solid #ddd;
            }

            .panel > .table > tbody:first-child > tr:first-child td,
            .panel > .table > tbody:first-child > tr:first-child th {
                border-top: 0;
            }

        .panel > .table-bordered,
        .panel > .table-responsive > .table-bordered {
            border: 0;
        }

            .panel > .table-bordered > tbody > tr > td:first-child,
            .panel > .table-bordered > tbody > tr > th:first-child,
            .panel > .table-bordered > tfoot > tr > td:first-child,
            .panel > .table-bordered > tfoot > tr > th:first-child,
            .panel > .table-bordered > thead > tr > td:first-child,
            .panel > .table-bordered > thead > tr > th:first-child,
            .panel > .table-responsive > .table-bordered > tbody > tr > td:first-child,
            .panel > .table-responsive > .table-bordered > tbody > tr > th:first-child,
            .panel > .table-responsive > .table-bordered > tfoot > tr > td:first-child,
            .panel > .table-responsive > .table-bordered > tfoot > tr > th:first-child,
            .panel > .table-responsive > .table-bordered > thead > tr > td:first-child,
            .panel > .table-responsive > .table-bordered > thead > tr > th:first-child {
                border-left: 0;
            }

            .panel > .table-bordered > tbody > tr > td:last-child,
            .panel > .table-bordered > tbody > tr > th:last-child,
            .panel > .table-bordered > tfoot > tr > td:last-child,
            .panel > .table-bordered > tfoot > tr > th:last-child,
            .panel > .table-bordered > thead > tr > td:last-child,
            .panel > .table-bordered > thead > tr > th:last-child,
            .panel > .table-responsive > .table-bordered > tbody > tr > td:last-child,
            .panel > .table-responsive > .table-bordered > tbody > tr > th:last-child,
            .panel > .table-responsive > .table-bordered > tfoot > tr > td:last-child,
            .panel > .table-responsive > .table-bordered > tfoot > tr > th:last-child,
            .panel > .table-responsive > .table-bordered > thead > tr > td:last-child,
            .panel > .table-responsive > .table-bordered > thead > tr > th:last-child {
                border-right: 0;
            }

            .panel > .table-bordered > tbody > tr:first-child > td,
            .panel > .table-bordered > tbody > tr:first-child > th,
            .panel > .table-bordered > thead > tr:first-child > td,
            .panel > .table-bordered > thead > tr:first-child > th,
            .panel > .table-responsive > .table-bordered > tbody > tr:first-child > td,
            .panel > .table-responsive > .table-bordered > tbody > tr:first-child > th,
            .panel > .table-responsive > .table-bordered > thead > tr:first-child > td,
            .panel > .table-responsive > .table-bordered > thead > tr:first-child > th {
                border-bottom: 0;
            }

            .panel > .table-bordered > tbody > tr:last-child > td,
            .panel > .table-bordered > tbody > tr:last-child > th,
            .panel > .table-bordered > tfoot > tr:last-child > td,
            .panel > .table-bordered > tfoot > tr:last-child > th,
            .panel > .table-responsive > .table-bordered > tbody > tr:last-child > td,
            .panel > .table-responsive > .table-bordered > tbody > tr:last-child > th,
            .panel > .table-responsive > .table-bordered > tfoot > tr:last-child > td,
            .panel > .table-responsive > .table-bordered > tfoot > tr:last-child > th {
                border-bottom: 0;
            }

        .panel > .table-responsive {
            margin-bottom: 0;
            border: 0;
        }

        .panel-group {
            margin-bottom: 20px;
        }

            .panel-group .panel {
                margin-bottom: 0;
                border-radius: 4px;
            }

                .panel-group .panel + .panel {
                    margin-top: 5px;
                }

            .panel-group .panel-heading {
                border-bottom: 0;
            }

                .panel-group .panel-heading + .panel-collapse > .list-group,
                .panel-group .panel-heading + .panel-collapse > .panel-body {
                    border-top: 1px solid #ddd;
                }

            .panel-group .panel-footer {
                border-top: 0;
            }

                .panel-group .panel-footer + .panel-collapse .panel-body {
                    border-bottom: 1px solid #ddd;
                }

        .panel-default {
            border-color: #ddd;
        }

            .panel-default > .panel-heading {
                color: #333;
                background-color: #f5f5f5;
                border-color: #ddd;
            }

                .panel-default > .panel-heading + .panel-collapse > .panel-body {
                    border-top-color: #ddd;
                }

                .panel-default > .panel-heading .badge {
                    color: #f5f5f5;
                    background-color: #333;
                }

            .panel-default > .panel-footer + .panel-collapse > .panel-body {
                border-bottom-color: #ddd;
            }

        .panel-primary {
            border-color: #337ab7;
        }

            .panel-primary > .panel-heading {
                color: #fff;
                background-color: #337ab7;
                border-color: #337ab7;
            }

                .panel-primary > .panel-heading + .panel-collapse > .panel-body {
                    border-top-color: #337ab7;
                }

                .panel-primary > .panel-heading .badge {
                    color: #337ab7;
                    background-color: #fff;
                }
    </style>
</asp:Content>
