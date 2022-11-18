﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AddFollowUpMaster.master" AutoEventWireup="true" CodeFile="FuWrist.aspx.cs" Inherits="FuWrist" %>
<%@ Register Assembly="EditableDropDownList" Namespace="EditableControls" TagPrefix="editable" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        /*.table{
    display:table;
    width:100%;
    table-layout:fixed;
}*/
        .table_cell {
            /*display:table-cell;*/
            width: 100px;
            /*border:solid black 1px;*/
        }
    </style>
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
    <div id="mymodelmessage" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Message</h4>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ID="upMessage" UpdateMode="Conditional">
                        <ContentTemplate>
                            <label runat="server" id="lblMessage"></label>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
        <!-- start: Header -->
        <%--    <asp:UpdatePanel runat="server" ID="upMain">
            <ContentTemplate>--%>
    <div class="container">
        <div class="row">
            <div class="col-lg-10" id="content">
                    <%--    <ul class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a href="Page1.aspx"><span class="label">Page1</span></a>
                                </li>
                                <li id="lipage2">
                                    <i class="icon-edit"></i>
                                    <a href="Page2.aspx"><span class="label label-success">Page2</span></a>
                                </li>
                                <li id="li1" runat="server" enable="false">
                                    <i class="icon-edit"></i>
                                    <a href="Page3.aspx"><span class="label">Page3</span></a>
                                </li>
                                <li id="li2" runat="server" enable="false">
                                    <i class="icon-edit"></i>
                                    <a href="Page4.aspx"><span class="label">Page4</span></a>
                                </li>
                            </ul>--%>
                    <div class="row">
                    <div class="col-md-3">
                        <label class="control-label"><b><u>CHIEF COMPLAINT</u></b></label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                        <div id="WrapLeft" runat="server">
                                <label class=control-label> The patient complains of </label>
                                <label class=control-label> &nbsp; left wrist  pain that is &nbsp;</label>
                                <asp:TextBox runat="server" ID="txtPainScaleLeft" Width="40px"></asp:TextBox>
                                <label class=control-label> &nbsp;/10 and &nbsp;</Label>
                                <asp:CheckBox ID="chkContentLeft" runat="server" Text="constant" />
                                <asp:CheckBox ID="chkIntermittentLeft" runat="server" Text="intermittent." />
                                <asp:CheckBox ID="chkSharpLeft" runat="server" Text="sharp  " Checked="true" />
                                <asp:CheckBox ID="chkElectricLeft" runat="server" Text="electric,  " />
                                <asp:CheckBox ID="chkShootingLeft" runat="server" Text="shooting,  " Checked="true" />
                                <asp:CheckBox ID="chkThrobblingLeft" runat="server" Text="throbbing,  " />
                                <asp:CheckBox ID="chkPulsatingLeft" runat="server" Text="pulsating,  " />
                                <asp:CheckBox ID="chkDullLeft" runat="server" Text="dull,  " />
                                <asp:CheckBox ID="chkAchyLeft" runat="server" Text="achy in nature.  " />
                                <label class=control-label> The patient complains of pain specifically at the </Label>
                                <asp:CheckBox ID="chkulnarLeft" runat="server" Text="ulna  " />
                                <asp:CheckBox ID="chkradiusLeft" runat="server" Text="radius  " Checked="true" />
                                <asp:CheckBox ID="chkDorsalLeft" runat="server" Text="dorsum of the wrist  " Checked="true" />
                                <asp:CheckBox ID="chkPalmarLeft" runat="server" Text="palmar side of the wrist.  " Checked="true" />
                                <label class=control-label> &nbsp;The elbow  pain is worsened with &nbsp;</Label>
                                <asp:CheckBox ID="chkLiftingObjectLeft"  runat="server" Text="lifting objects, " />
                                <asp:CheckBox ID="chkRotationLeft"  runat="server" Text="rotation, " />
                                <asp:CheckBox ID="chkMovementLeft"  runat="server" Text="movement " />
                                <asp:CheckBox ID="chkWorkingLeft"  runat="server" Text="working activities." />
                        </div><br />
                        <div id="wrpRight" runat="server">
                                <label class=control-label> The patient complains of </Label>
                                <label class=control-label> &nbsp; right wrist  pain that is </Label>
                                <asp:TextBox runat="server" ID="txtPainScaleRight"  Width="40px"></asp:TextBox>
                                <label class=control-label>&nbsp;/10 and &nbsp;</Label>
                                <asp:CheckBox ID="chkContentRight" runat="server" Text="constant" />
                                <asp:CheckBox ID="chkIntermittentRight" runat="server" Text="intermittent." />
                                <asp:CheckBox ID="chkSharpRight" runat="server" Text="sharp  " Checked="true" />
                                <asp:CheckBox ID="chkElectricRight" runat="server" Text="electric,  " />
                                <asp:CheckBox ID="chkShootingRight" runat="server" Text="shooting,  " Checked="true" />
                                <asp:CheckBox ID="chkThrobblingRight" runat="server" Text="throbbing,  " />
                                <asp:CheckBox ID="chkPulsatingRight" runat="server" Text="pulsating,  " />
                                <asp:CheckBox ID="chkDullRight" runat="server" Text="dull,  " />
                                <asp:CheckBox ID="chkAchyRight" runat="server" Text="achy in nature.  " />
                                <label class=control-label>The patient complains of pain specifically at the &nbsp;</Label>
                                <asp:CheckBox ID="chkulnarRight" runat="server" Text="ulna  " />
                                <asp:CheckBox ID="chkradiusRight" runat="server" Text="radius  " Checked="true" />
                                <asp:CheckBox ID="chkDorsalRight" runat="server" Text="dorsum of the wrist  " Checked="true" />
                                <asp:CheckBox ID="chkPalmarRight" runat="server" Text="palmar side of the wrist.  " Checked="true" />
                                <label class=control-label>The elbow  pain is worsened with &nbsp; </Label>
                                <asp:CheckBox ID="chkLiftingObjectRight"  runat="server" Text="lifting objects, " />
                                <asp:CheckBox ID="chkRotationRight"  runat="server" Text="rotation, " />
                                <asp:CheckBox ID="chkMovementRight"  runat="server" Text="movement " />
                                <asp:CheckBox ID="chkWorkingRight"  runat="server" Text="working activities." />
                        </div></div></div>
                        <div class="row">
                    <div class="col-md-3">
                        <label class="control-label">Notes:</label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                        <asp:TextBox ID="txtFreeFormCC" runat="server" TextMode="MultiLine" Width="700px" Height="100px"></asp:TextBox>
                        <button type="button" id="start_button1" onclick="startButton1(event)">
                                <img src="images/mic.gif" alt="start" /></button>
                            <div style="display: none"><span class="final" id="final_span1"></span><span class="interim" id="interim_span1"></span></div>
                        </div></div>
                        <%--<tr>
                            <th style="width: 10%;">
                                <label class="control-label">PHYSICAL EXAM:</label></th>
                            <th style="width: 90%;">--%>
                <div class="row">
                    <div class="col-md-3">
                        <label class="control-label"><b><u>PHYSICAL EXAM:</u></b></label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                                <table style="width: 40%;display:none;">
                                    <thead>
                                        <tr>
                                            <td style="text-align: left;" colspan="2">Upper Extremities</td>
                                            <td colspan="3">ROM</td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td>Left</td>
                                            <td>Right</td>
                                            <td>Normal</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Wrist</td>
                                            <td style="text-align: left;">Flexion</td>
                                            <td>
                                                <asp:TextBox ID="txtFlexionLeft" runat="server" Width="50px"></asp:TextBox></td>
                                            <td>
                                                <asp:TextBox ID="txtFlexionRight" Width="50px" runat="server"></asp:TextBox></td>
                                            <td>
                                                <asp:TextBox ID="txtFlexionRange" ReadOnly="true" Width="50px" runat="server"  Text="0-80"></asp:TextBox></td>
                                        </tr>

                                        <tr>
                                            <td></td>
                                            <td style="text-align: left;"">Extension</td>
                                            <td>
                                                <asp:TextBox ID="txtExtensionLeft" runat="server" Width="50px" ></asp:TextBox></td>
                                            <td>
                                                <asp:TextBox ID="txtExtensionRight" Width="50px" runat="server"></asp:TextBox></td>
                                            <td>
                                                <asp:TextBox ID="txtExtensionRange" ReadOnly="true" Width="50px" runat="server" Text="0-70"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="text-align: left;">Radial deviation</td>
                                            <td>
                                                <asp:TextBox ID="txtRadialdeviationLeft" runat="server" Width="50px" ></asp:TextBox></td>
                                            <td>
                                                <asp:TextBox ID="txtRadialdeviationRight" Width="50px" runat="server"></asp:TextBox></td>
                                            <td>
                                                <asp:TextBox ID="txtRadialdeviationRange" ReadOnly="true" Width="50px" runat="server" Text="0-20"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="text-align: left;">Ulnar deviation</td>
                                            <td>
                                                <asp:TextBox ID="txtUlnarDeviationLeft" runat="server" Width="50px"></asp:TextBox></td>
                                            <td>
                                                <asp:TextBox ID="txtUlnarDeviationRight" Width="50px" runat="server"></asp:TextBox></td>
                                            <td>
                                                <asp:TextBox ID="txtUlnarDeviationRange" ReadOnly="true" Width="50px" runat="server" Text="0-30"></asp:TextBox></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                    <div class="col-md-3">
                        <label class="control-label"></label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                                <div id="wrpPELeft" runat="server">
                                    <asp:Label runat="server" Text="The wrist  exam reveals tenderness upon palpation of the left" Font-Bold="False"></asp:Label>
                                    <asp:CheckBox ID="chkPalpationUlnarLeft" runat="server" Text="ulna  " Checked="true" />
                                    <asp:CheckBox ID="chkPalpationRadialLeft" runat="server" Text="radius " />
                                    <asp:CheckBox ID="chkPalpationDorsalLeft" runat="server" Text="dorsum  " Checked="true" />
                                    <asp:CheckBox ID="chkPalpationPalmarLeft" runat="server" Text="palmar" /> <span>&nbsp;<label class="control-label">of the wrist.</label></span> 
                                    <br />
                                </div>
                                <br />
                                <div id="wrpPERight" runat="server">
                                    <asp:Label runat="server" Text="The wrist  exam reveals tenderness upon palpation of the Right" Font-Bold="False"></asp:Label>
                                    <asp:CheckBox ID="chkPalpationUlnarRight" runat="server" Text="ulna  " Checked="true" />
                                    <asp:CheckBox ID="chkPalpationRadialRight" runat="server" Text="radius " />
                                    <asp:CheckBox ID="chkPalpationDorsalRight" runat="server" Text="dorsum  " Checked="true" />
                                    <asp:CheckBox ID="chkPalpationPalmarRight" runat="server" Text="palmar" /> <span>&nbsp;<label class="control-label">of the wrist.</label></span> 
                                    <br />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                    <div class="col-md-3">
                        <label class="control-label"></label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                                <br />
                                <table  class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <td style="text-align: left"></td>
                                            <td>Tinnels</td>
                                            <td>Phalens</td>
                                            <td>Finkelsteins</td>
                                            <td>Pain upon ulnar deviation</td>
                                            <td>Pain upon radial deviation</td>
                                            <td>Pain upon dorsi flexion</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="text-align: left;">Right</td>
                                            <td>
                                                <asp:CheckBox ID="chkTinelRight"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPhalenRight"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkFinkelsteinRight"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPainUponUlnarDeviationRight"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPainUponRadialRight"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPainUponDorsiFlexionRight"  runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left;">Left</td>
                                            <td>
                                                <asp:CheckBox ID="chkTinelLeft"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPhalenLeft"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkFinkelsteinleft"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPainUponUlnarDeviationLeft"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPainUponRadialLeft"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPainUponDorsiFlexionLeft"  runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left;">Bilaterally</td>
                                            <td>
                                                <asp:CheckBox ID="chkTinelBilaterally"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPhalenBilaterally"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkFinkelsteinBilaterally"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPainUponUlnarDeviationBilaterally"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPainUponRadialBilaterally"  runat="server" /></td>
                                            <td>
                                                <asp:CheckBox ID="chkPainUponDorsiFlexionBilaterally"  runat="server" /></td>
                                        </tr>
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                         <div class="row">
                    <div class="col-md-3">
                        <label class="control-label">Notes</label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                                <asp:TextBox runat="server" ID="txtFreeForm" TextMode="MultiLine" Width="700px" Height="100px"></asp:TextBox>
                         <button type="button" id="start_button" onclick="startButton(event)">
                            <img src="images/mic.gif" alt="start" /></button>
                        <div style="display: none"><span class="final" id="final_span"></span><span class="interim" id="interim_span"></span></div>
                            </div>
                        </div>
                        <%--<tr>
                            <th style="width: 10%;"><label class="control-label">ASSESSMENT/DIAGNOSIS</label></th>
                            <th style="width: 90%; margin-left: 40px;">--%>
                <div class="row">
                    <div class="col-md-3">
                       <label class="control-label"><b><u>ASSESSMENT/DIAGNOSIS:</u></b></label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                                <%--<asp:CheckBox ID="chkSprainStrain" Style=";" runat="server" Text="Cervical muscle sprain/strain." Checked="true" /><br />
                                <asp:CheckBox ID="chkHerniation" Style="; margin-left: -18.5%" runat="server" Text="Possible cervical disc herniation." Checked="true" /><br />--%>
                                <%-- <asp:CheckBox ID="chkSyndrome" runat="server" Text="Possible cervical radiculopathy vs. plexopathy vs. entrapment syndrome." Checked="true" />
                                --%>
                            </div>
                        </div>

                        <div class="row">
                    <div class="col-md-3">
                        <label class="control-label">Notes</label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                                <asp:TextBox runat="server"  ID="txtFreeFormA" TextMode="MultiLine" Width="700px" Height="100px"></asp:TextBox>
                                <asp:ImageButton ID="AddDiag" Style="text-align: left;" ImageUrl="~/img/a1.png" Height="50px" Width="50px" runat="server" OnClientClick="basicPopup();" OnClick="AddDiag_Click" />
                            </div>
                        </div>


                       <div class="row">
                    <div class="col-md-3">
                        <label class="control-label"></label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                                 <asp:GridView ID="dgvDiagCodes" runat="server" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:TemplateField HeaderText="DiagCode" ItemStyle-Width="100">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtcc" ReadOnly="true" runat="server" Text='<%# Eval("DiagCode") %>'></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description" ItemStyle-Width="450">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtpe" ReadOnly="true" runat="server" Width="400" Text='<%# Eval("Description") %>'></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>


                        <div class="row">
                    <div class="col-md-3">
                        <label class="control-label"><b><u>PLAN:</u></b></label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                                <%--  <asp:CheckBox ID="chkCervicalSpine" Style=";" Text="MRI" runat="server" />
                                <asp:ListBox ID="cboScanType" Style="; height: 25px;" runat="server"></asp:ListBox>
                                <asp:Label ID="Label7" Style=";" Text=" of the cervical spine " runat="server"></asp:Label>
                                <asp:TextBox ID="txtToRuleOut" runat="server" Style="; " Text="to rule out herniated nucleus pulposus/soft tissue injury " Width="299px"></asp:TextBox>--%>
                                <%--OnClick="AddStd_Click"--%>
                            </div>
                        </div>
                        <div class="row">
                    <div class="col-md-3">
                        <label class="control-label">Notes</label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                                <asp:TextBox runat="server" ID="txtFreeFormP" Style=";" TextMode="MultiLine" Width="700px" Height="100px"></asp:TextBox>
                                <asp:ImageButton ID="AddStd" Style="display:none" runat="server" Height="50px" Width="50px" ImageUrl="~/img/a1.png" PostBackUrl="~/AddStandards.aspx" OnClientClick="basicPopup();return false;" />
                            </div>
                        </div>

                <div class="row">
                    <div class="col-md-3">
                        <label class="control-label"></label>
                    </div>
                    <div class="col-md-9" style="margin-top: 5px">
                                <asp:GridView ID="dgvStandards" runat="server" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hfFname" runat="server" Value='<%# Eval("ID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Heading" ItemStyle-Width="450">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtHeading" runat="server" CssClass="form-control" Width="400px" TextMode="MultiLine" Text='<%# Eval("Heading") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PDesc" ItemStyle-Width="600">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPDesc" runat="server" CssClass="form-control" Width="600px" TextMode="MultiLine" Text='<%# Eval("PDesc") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:TemplateField HeaderText="IsChkd">

                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox2" runat="server" value='<%# Convert.ToBoolean(Eval("IsChkd")) %>' AutoPostBack="true" />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                <%-- <asp:TemplateField HeaderText="MCODE" ItemStyle-Width="150">
                                            <ItemTemplate>
                                                <asp:Label ID="mcode" runat="server" Text='<%# Eval("MCODE") %>'></asp:Label>
                                                
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                 <%--<asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="hfFname" runat="server" Value='<%# Eval("ProcedureDetail_ID") %>' />
                    </ItemTemplate>
                                      </asp:TemplateField>--%>
                                <%--<asp:TemplateField HeaderText="BodyPart" ItemStyle-Width="150">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("BodyPart") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                               <%--<asp:TemplateField HeaderText="Heading" ItemStyle-Width="450">
                                    <ItemTemplate>--%>
                                        <%--<asp:Label ID="lblheading" runat="server" Text='<%# Eval("Heading") %>'></asp:Label>--%>
                                       <%-- <asp:TextBox ID="txtHeading" runat="server" CssClass="form-control" Width="400px"  TextMode="MultiLine" Text='<%# Eval("Heading") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                               <%-- <asp:TemplateField HeaderText="CC" ItemStyle-Width="50">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtcc" Width="48" ReadOnly="true" runat="server" Text='<%# Eval("CCDesc") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PE" ItemStyle-Width="50">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtpe" Width="48" ReadOnly="true" runat="server" Text='<%# Eval("PEDesc") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="AD" ItemStyle-Width="50">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtadesc" Width="48" ReadOnly="true" runat="server" Text='<%# Eval("ADesc") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PD" ItemStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtpdesc" Width="95" ReadOnly="true" runat="server" Text='<%# Eval("PDesc") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                                <%-- <asp:TemplateField HeaderText="PN" ItemStyle-Width="20">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox3" Enabled="false" runat="server" value='<%# Eval("PN") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>

                                <%--<asp:TemplateField HeaderText="IsChkd">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox4" Enabled="false" runat="server" value='<%# Eval("PN") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                            </Columns>
                        </asp:GridView>
                            </div>
                        </div>
                                        <div class="row"></div>
                <div class="row" style="margin-top: 15px">
                    <div class="col-md-3"></div>
                    <div class="col-md-9" style="margin-top: 5px">

                                <%--<asp:ImageButton ID="LoadDV" Style=";" runat="server" OnClick="LoadDV_Click" ImageUrl="~/img/edit.gif" />--%>
                                <div style="display:none"><asp:Button ID="btnSave"  runat="server" Text="Save"  CssClass="btn blue" OnClick="btnSave_Click"/></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
         <%--   </ContentTemplate>
        </asp:UpdatePanel>--%>
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
    </script>
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <script type="text/javascript">
        function OnSuccess(response) {
            //debugger;
            popupWindow = window.open("AddStandards.aspx", 'popUpWindow', 'height=500,width=1200,left=100,top=30,resizable=No,scrollbars=Yes,toolbar=no,menubar=no,location=no,directories=no, status=No');
        }
        function OnSuccess_q(response) {
            popupWindow = window.open("AddDiagnosis.aspx", 'popUpWindow', 'height=500,width=1200,left=100,top=30,resizable=No,scrollbars=Yes,toolbar=no,menubar=no,location=no,directories=no, status=No');

        }
        function basicPopup() {
            document.forms[0].target = "_blank";
        };
    </script>
    <script>
        $(document).ready(function () {
            $('#rbl_in_past input').change(function () {
                if ($(this).val() == '0') {
                    $("#txt_injur_past_bp").prop('disabled', true);
                    $("#txt_injur_past_how").prop('disabled', true);
                }
                else {
                    $("#txt_injur_past_bp").prop('disabled', false);
                    $("#txt_injur_past_how").prop('disabled', false);
                }
            });
        });

        $(document).ready(function () {
            $('#rbl_seen_injury input').change(function () {
                if ($(this).val() == 'False') {
                    $("#txt_docname").prop('disabled', true);
                }
                else {
                    $("#txt_docname").prop('disabled', false);
                }
            });
        });

        $(document).ready(function () {
            $('#rep_wenttohospital input').change(function () {
                if ($(this).val() == '0') {
                    $("#txt_day").prop('disabled', true);
                    $("#txt_day").prop('value', "0");
                }
                else {
                    $("#txt_day").prop('disabled', false);
                    $("#txt_day").select();
                    $("#txt_day").focus();
                }
            });
        });

        $(document).ready(function () {
            $('#rep_hospitalized input').change(function () {
                if ($(this).val() == '0') {
                    $("#txt_hospital").prop('disabled', true);
                    $("#txt_day").prop('disabled', true);
                    $("#chk_mri").prop('disabled', true);
                    $("#txt_mri").prop('disabled', true);
                    $("#chk_CT").prop('disabled', true);
                    $("#txt_CT").prop('disabled', true);
                    $("#chk_xray").prop('disabled', true);
                    $("#txt_x_ray").prop('disabled', true);
                    $("#txt_prescription").prop('disabled', true);
                    $("#txt_which_what").prop('disabled', true);
                }
                else {
                    $("#txt_hospital").prop('disabled', false);
                    $("#ddl_via").prop('disabled', false);
                    $("#txt_day").prop('disabled', false);
                    $("#chk_mri").prop('disabled', false);
                    $("#txt_mri").prop('disabled', false);
                    $("#chk_CT").prop('disabled', false);
                    $("#txt_CT").prop('disabled', false);
                    $("#chk_xray").prop('disabled', false);
                    $("#txt_x_ray").prop('disabled', false);
                    $("#txt_prescription").prop('disabled', false);
                    $("#txt_which_what").prop('disabled', false);
                }
            });
        });
    </script>
     <script>
         var controlname = null;
         var final_transcript = '';
         var recognizing = false;
         var ignore_onend;
         var start_timestamp;

         if (!('webkitSpeechRecognition' in window)) {
             // upgrade();
         } else {
             start_button.style.display = 'inline-block';
             var recognition = new webkitSpeechRecognition();
             recognition.continuous = true;
             recognition.interimResults = true;

             recognition.onstart = function () {
                 recognizing = true;
             };

             recognition.onerror = function (event) {
                 if (event.error == 'no-speech') {
                     ignore_onend = true;
                 }
                 if (event.error == 'audio-capture') {
                     //showInfo('info_no_microphone');
                     ignore_onend = true;
                 }
                 if (event.error == 'not-allowed') {
                     if (event.timeStamp - start_timestamp < 100) {
                         //showInfo('info_blocked');
                     } else {
                         //showInfo('info_denied');
                     }
                     ignore_onend = true;
                 }
             };

             recognition.onend = function () {
                 recognizing = false;
                 if (ignore_onend) {
                     return;
                 }
                 if (!final_transcript) {
                     //showInfo('info_start');
                     return;
                 }
                 if (!final_transcript1) {
                     //showInfo('info_start');
                     return;
                 }

             };

             recognition.onresult = function (event) {
                 var interim_transcript = '';
                 if (typeof (event.results) == 'undefined') {
                     recognition.onend = null;
                     recognition.stop();
                     //upgrade();
                     return;
                 }
                 for (var i = event.resultIndex; i < event.results.length; ++i) {
                     if (event.results[i].isFinal) {
                         final_transcript += event.results[i][0].transcript;
                     } else {
                         interim_transcript += event.results[i][0].transcript;
                     }
                 }
                 final_transcript = capitalize(final_transcript);
                 //finalrecord = linebreak(final_transcript);
                 //$('#ctl00_ContentPlaceHolder1_txtFreeForm').text(linebreak(final_transcript));
                 $(controlname).text(linebreak(final_transcript));
                 interim_span.innerHTML = linebreak(interim_transcript);
             };
         }



         var two_line = /\n\n/g;
         var one_line = /\n/g;
         function linebreak(s) {
             return s.replace(two_line, '<p></p>').replace(one_line, '<br>');
         }

         var first_char = /\S/;
         function capitalize(s) {
             return s.replace(first_char, function (m) { return m.toUpperCase(); });
         }

         function startButton(event) {
             controlname = "#ctl00_ContentPlaceHolder1_txtFreeForm";
             if (recognizing) {
                 recognition.stop();
                 return;
             }
             final_transcript = '';
             recognition.lang = 'en';
             recognition.start();
             ignore_onend = false;
             final_span.innerHTML = '';
             interim_span.innerHTML = '';
             //showInfo('info_allow');
             //showButtons('none');
             start_timestamp = event.timeStamp;
         }

         function startButton1(event) {
             controlname = "#ctl00_ContentPlaceHolder1_txtFreeFormCC";
             if (recognizing) {
                 recognition.stop();
                 return;
             }
             final_transcript = '';
             recognition.lang = 'en';
             recognition.start();
             ignore_onend = false;
             final_span1.innerHTML = '';
             interim_span1.innerHTML = '';
             //showInfo('info_allow');
             //showButtons('none');
             start_timestamp = event.timeStamp;
         }
    </script>
</asp:Content>