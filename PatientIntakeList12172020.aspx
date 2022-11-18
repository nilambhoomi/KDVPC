<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="PatientIntakeList.aspx.cs" Inherits="PatientIntakeList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /*a.btn {
            text-decoration: none;
        }

        table {
            text-align: center;
        }

        .main-container {
            min-height: 900px;
        }*/

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpTitle" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="Server">
    <div class="main-content-inner">
        <div class="page-content">
            <div class="page-header">
                <h1>
                    <small>Patient Details								
									<i class="ace-icon fa fa-angle-double-right"></i>

                    </small>
                </h1>
            </div>


            <div class="">

                <div class="row">
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <asp:TextBox ID="txtSearch" CssClass="form-control" placeholder="Search" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:DropDownList runat="server" ID="ddl_location" Style="width: 200px">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-3">
                                        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Text="Search" OnClick="btnSearch_Click" />
                                        <asp:Button ID="btnRefresh" runat="server" CssClass="btn btn-success" Text="Refresh" OnClick="btnRefresh_Click" />
                                        <asp:HiddenField ID="hfPatientId" runat="server"></asp:HiddenField>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="space"></div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="table-responsive">
                                    <asp:GridView ID="gvPatientDetails" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" DataKeyNames="PatientIE_ID" OnRowDataBound="OnRowDataBound" AllowPaging="True" OnPageIndexChanging="gvPatientDetails_PageIndexChanging1" PagerStyle-CssClass="pager">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <img alt="" title='<%# Eval("PatientIE_ID") %>' style="cursor: pointer" src="img/plus.png" />
                                                    <asp:Panel ID="pnlOrders" runat="server" Style="display: none">
                                                        <asp:GridView ID="gvPatientFUDetails" BorderStyle="None" CssClass="table table-bordered" Width="100%" runat="server" AllowPaging="True" OnPageIndexChanging="gvPatientFUDetails_PageIndexChanging" AutoGenerateColumns="False" EmptyDataText="No Records Found" PagerStyle-CssClass="pager">
                                                            <Columns>
                                                                <asp:BoundField DataField="DOE" HeaderText="DOE" DataFormatString="{0:d}" />
                                                                <asp:BoundField DataField="Location" HeaderText="Location" />
                                                                <asp:BoundField DataField="MAProviders" HeaderText="MA & Providers" />
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <%--<asp:HyperLink runat="server" CssClass="btn btn-info" ID="hlAddFU" NavigateUrl='<%# "~/TimeSheet.aspx?PId="+Eval("PatientIEId")+"&FID="+Eval("PatientFUId")  %>' Text="Procedure Details"></asp:HyperLink>--%>
                                                                        <asp:HyperLink runat="server" CssClass="btn btn-info" ID="HyperLink1" NavigateUrl='<%# "~/EditFU.aspx?FUID="+Eval("PatientFUId") %>' Text="Edit"></asp:HyperLink>

                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>

                                                            <EmptyDataRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />

                                                            <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />

                                                        </asp:GridView>
                                                        <%--<asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass = "ChildGrid">
                        <Columns>
                            <asp:BoundField ItemStyle-Width="150px" DataField="OrderId" HeaderText="Order Id" />
                            <asp:BoundField ItemStyle-Width="150px" DataField="OrderDate" HeaderText="Date" />
                        </Columns>
                    </asp:GridView>--%>
                                                    </asp:Panel>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="Sex" HeaderText="Title" />
                                            <asp:BoundField DataField="lastname" HeaderText="LastName" />
                                            <asp:BoundField DataField="firstname" HeaderText="FirstName" />
                                            <asp:BoundField DataField="DOB" HeaderText="DOB" DataFormatString="{0:d}" />
                                            <asp:BoundField DataField="DOA" HeaderText="DOA" DataFormatString="{0:d}" />
                                            <asp:BoundField DataField="DOE" HeaderText="DOE" DataFormatString="{0:d}" />
                                            <asp:BoundField DataField="Compensation" HeaderText="Case Type" />
                                            <asp:BoundField DataField="location" HeaderText="Location" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:HyperLink runat="server" CssClass="btn btn-link" ID="hlEdit" NavigateUrl='<%# "~/Page1.aspx?id="+Eval("PatientIE_ID") %>' Text="Edit IE">
                                      
                                                    </asp:HyperLink>
                                                    | 
              <asp:HyperLink runat="server" CssClass="btn btn-link" ID="hlAddFU" NavigateUrl='<%# "~/AddFU.aspx?PID="+Eval("PatientIE_ID") %>' Text="AddFU"></asp:HyperLink>
                                                    <asp:HyperLink runat="server" ID="lnkhyper" CssClass="btn btn-link" NavigateUrl='<%# "~/patientdocuments.aspx?PID="+Eval("PatientId") %>'>| Documents</asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <%-- <asp:BoundField ItemStyle-Width="150px" DataField="ContactName" HeaderText="Contact Name" />
            <asp:BoundField ItemStyle-Width="150px" DataField="City" HeaderText="City" />--%>
                                        </Columns>
                                        <PagerSettings PageButtonCount="5" />

                                        <PagerStyle CssClass="pager"></PagerStyle>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                        <asp:HiddenField ID="hfCurrentlyOpened" runat="server"></asp:HiddenField>
                        <%-- <asp:GridView ID="gvPatientDetails" Width="80%" runat="server" AllowPaging="True" OnPageIndexChanging="gvPatientDetails_PageIndexChanging" AutoGenerateColumns="False" EmptyDataText="No Records Found" ShowHeaderWhenEmpty="True">
            <Columns>
                <asp:BoundField DataField="Sex" HeaderText="Title" />
                <asp:BoundField DataField="lastname" HeaderText="LastName" />
                <asp:BoundField DataField="firstname" HeaderText="FirstName" />
                <asp:BoundField DataField="DOB" HeaderText="DOB" DataFormatString="{0:d}" />
                <asp:BoundField DataField="DOA" HeaderText="DOA" DataFormatString="{0:d}" />
                <asp:BoundField DataField="DOE" HeaderText="DOE" DataFormatString="{0:d}"/>
                <asp:BoundField DataField="location" HeaderText="Location" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HyperLink runat="server" CssClass="btn" ID="hlAddFU" NavigateUrl='<%# "~/AddFU.aspx?PID="+Eval("PatientIE_ID") %>' Text="AddFU"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>               
            </Columns>
          
            <EmptyDataRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
          
            <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
          
        </asp:GridView>--%>
                    </div>
                </div>
               <script src="Scripts/jquery-1.8.2.js"></script>
                <%--<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js" ></script>--%>
                 <script src="Scripts/jquery-ui.js"></script>
                
                <link href="Style/jquery-ui.css" rel="stylesheet" />
                <script type="text/javascript">

                    function funfordefautenterkey1(btn, event) {

                        if (event.keyCode == 13) {
                            event.returnValue = false;
                            event.cancel = true;
                            btn.click();

                        }
                    }

                    $(document).ready(function () {
                        if ($('[title="' + $("#<%=hfCurrentlyOpened.ClientID %>").val() + '"]')) {
                    $('[title="' + $("#<%=hfCurrentlyOpened.ClientID %>").val() + '"]').closest("tr").after("<tr><td></td><td colspan = '999'>" + $('[title="' + $("#<%=hfCurrentlyOpened.ClientID %>").val() + '"]').next().html() + "</td></tr>");
                    $('[title="' + $("#<%=hfCurrentlyOpened.ClientID %>").val() + '"]').attr("src", "img/minus.png");
                }
                $("[src*=plus]").live("click", function () {
                    $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>");
                    $(this).attr("src", "img/minus.png");
                });

                $("[src*=minus]").live("click", function () {
                    $(this).attr("src", "img/plus.png");
                    $(this).closest("tr").next().remove();
                });

                $("#<%=txtSearch.ClientID %>").autocomplete({
                    appendTo: "#container",
                    source: function (request, response) {

                        var str = request.term;

                        if (str.length < 3) {
                            return;
                        }
                        $.ajax({
                            url: 'Search.aspx/GetPatients',
                            data: "{ 'prefix': '" + str + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('_')[0],
                                        val: item.split('_')[1]
                                    }
                                }))
                            },
                            error: function (response) {
                                alert(response.responseText);
                            },
                            failure: function (response) {
                                alert(response.responseText);
                            }
                        });
                    },
                    select: function (e, i) {
                        $("#<%=hfPatientId.ClientID %>").val(i.item.val);
                                $('#<%= txtSearch.ClientID %>').val(i.item.label);
                                $('#<%= btnSearch.ClientID %>').click();
                            },
                    minLength: 1
                });
            });
                </script>
            </div>
        </div>
    </div>
</asp:Content>

