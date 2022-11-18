﻿<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="PNS.aspx.cs" Inherits="PNS" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.css" rel="stylesheet" />
    <script src="https://cdn.rawgit.com/igorescobar/jQuery-Mask-Plugin/master/src/jquery.mask.js"></script>
    <script src="js/jquery-mask-1.14.8.min.js"></script>
    <script src="js/jquery.maskedinput.js"></script>
    <script src="https://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
    <link href="CSS/CSS.css" rel="stylesheet" type="text/css" />
    <style>
        .pager::before {
            display: none;
        }

        .pager table {
            margin: 0 auto;
        }

            .pager table tbody tr td a,
            .pager table tbody tr td span {
                position: relative;
                float: left;
                padding: 6px 12px;
                margin-left: -1px;
                line-height: 1.42857143;
                color: #337ab7;
                text-decoration: none;
                background-color: #fff;
                border: 1px solid #ddd;
            }

            .pager table > tbody > tr > td > span {
                z-index: 3;
                color: #fff;
                cursor: default;
                background-color: #337ab7;
                border-color: #337ab7;
            }

            .pager table > tbody > tr > td:first-child > a,
            .pager table > tbody > tr > td:first-child > span {
                margin-left: 0;
                border-top-left-radius: 4px;
                border-bottom-left-radius: 4px;
            }

            .pager table > tbody > tr > td:last-child > a,
            .pager table > tbody > tr > td:last-child > span {
                border-top-right-radius: 4px;
                border-bottom-right-radius: 4px;
            }

            .pager table > tbody > tr > td > a:hover,
            .pager table > tbody > tr > td > span:hover,
            .pager table > tbody > tr > td > a:focus,
            .pager table > tbody > tr > td > span:focus {
                z-index: 2;
                color: #23527c;
                background-color: #eee;
                border-color: #ddd;
            }

        label {
            padding: 10px;
        }
    </style>
    <script>
        $(document).ready(function ($) {

            $('#<%=txtSearchFromdate.ClientID%>').mask("99/99/9999");
            $('#<%=txtSearchTodate.ClientID%>').mask("99/99/9999");

            $('#<%=txtSearchFromdate.ClientID%>').datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: "-100:+0",
                onSelect: function (dateText, inst) {
                    $(this).focus();
                }
            });

            $('#<%=txtSearchTodate.ClientID%>').datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: "-100:+0",
                onSelect: function (dateText, inst) {
                    $(this).focus();
                }
            });
            $('#<%=txtMaxDate.ClientID%>').datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: "-100:+0",
                onSelect: function (dateText, inst) {
                    $(this).focus();
                }
            });

        })
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpTitle" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" Runat="Server">
    <asp:HiddenField ID="hdn_ID" runat="server" />
    <div class="main-content-inner">
        <div class="page-content">
            <div class="page-header">
                <h1>
                    <small>Generate Report							
									<i class="ace-icon fa fa-angle-double-right"></i>
                    </small>
                    
                </h1>
            </div>
            <asp:Panel ID="p" runat="server" DefaultButton="btnSearch">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 col-md-4 col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon">Max Date</span>
                                <asp:TextBox ID="txtMaxDate" runat="server" OnServerValidate="CustomValidator3_ServerValidate"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon">From Date</span>
                                <asp:TextBox ID="txtSearchFromdate" runat="server" OnServerValidate="CustomValidator1_ServerValidate"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon">To date</span>
                                <asp:TextBox ID="txtSearchTodate" runat="server" OnServerValidate="CustomValidator2_ServerValidate"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon">Location</span>
                                <asp:DropDownList runat="server" ID="ddl_location" Style="width: 200px">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                   <br />
                    <div class="row">
                        <div class="clearfix"></div>
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="input-group">
                                <asp:LinkButton ID="btnSearch" CssClass="btn success" runat="server" OnClick="btnSearch_Click" Text="Search"></asp:LinkButton>
                                <asp:LinkButton ID="btnReset" CssClass="btn btn-danger " Style="margin-left: 2px" runat="server" OnClick="btnReset_Click" Text="Reset"></asp:LinkButton>
                                <asp:LinkButton ID="lkExportToexcel" CssClass="btn btn-danger " Style="margin-left: 2px" runat="server" OnClick="lkExportToexcel_Click" Text="ExportExcel"></asp:LinkButton>
                                
                            </div>
                        </div>
                    </div>
                    <br />
                </div>
            </asp:Panel>
            <div class="clearfix"></div>



            <asp:GridView ID="gvProcedureTbl" AllowSorting="true" OnSorting="gridView_Sorting" runat="server"  Width="100%" AutoGenerateColumns="false" PageSize="100" CssClass="table table-striped table-bordered table-hover" AllowPaging="True" PagerStyle-CssClass="pager" OnRowDataBound="gvProcedureTbl_RowDataBound">
                <Columns>
                   
                    
                    <asp:BoundField DataField="Patient" HeaderText="Patient"  SortExpression="Patient"/>
                   <asp:BoundField DataField="Mobile Number" HeaderText="Mobile Number" SortExpression="Mobile Number" />
                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                    <asp:BoundField DataField="LastDOV" HeaderText="Last DOV" SortExpression="LastDOV"/>        


                   
                </Columns>
                <AlternatingRowStyle BackColor="#C2D69B" />

            </asp:GridView>


        </div>
    </div>
</asp:Content>


