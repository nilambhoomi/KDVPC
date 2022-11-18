<%@ Page Title="" Language="C#" MasterPageFile="~/PageMainMaster.master" AutoEventWireup="true" CodeFile="Page3.aspx.cs" Inherits="Page3" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="EditableDropDownList" Namespace="EditableControls" TagPrefix="editable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
    <script type="text/javascript" src="https://cdn.rawgit.com/bassjobsen/Bootstrap-3-Typeahead/master/bootstrap3-typeahead.min.js"></script>



    <script language="javascript">
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler(sender, args) {
            MenuHighlight();
        }
        var postbackElement = null;
        function RestoreFocus(source, args) {
            document.getElementById(postbackElement.id).focus();
            enableMenu();
        }
        function SavePostbackElement(source, args) {
            postbackElement = args.get_postBackElement();
            enableMenu();
        }
        function AddRequestHandler() {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_endRequest(RestoreFocus);
            prm.add_beginRequest(SavePostbackElement);
            enableMenu();


        }
        function enableMenu() {

            //debugger;
            var current = location.pathname;
            var curpage = current.substr(current.lastIndexOf('/') + 1);

            $('#nav li a').each(function () {
                var $this = $(this);
                //alert(curpage);

                // if the current path is like this link, make it active
                if ($this.attr('href').indexOf(curpage) !== -1) {
                    $(this).parent('li').addClass('active');
                    //$this.addClass('active');
                }

            })

        }
    </script>

    <script type="text/javascript">
        function openPopup(divid) {

            $('#' + divid + '').modal('show');

        }
        function Confirmbox(e, page) {
            e.preventDefault();
            var answer = confirm('Do you want to save the data?');
            if (answer) {
                //alert();
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
    <script type="text/javascript">

        function RefreshUpdatePanelL3() {
            <%= Page.ClientScript.GetPostBackEventReference(txtDMTL3, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel4() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox4, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel5() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox5, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel6() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox6, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel7() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox7, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel8() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox8, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel10() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox10, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel21() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox21, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel24() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox24, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel25() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox25, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel9() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox9, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanelC5Right() {
            <%= Page.ClientScript.GetPostBackEventReference(txtUEC5Right, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel11() {
            <%= Page.ClientScript.GetPostBackEventReference(txtDMTL3, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel12() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox12, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel13() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox13, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel14() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox14, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel15() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox15, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel16() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox16, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel17() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox17, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel18() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox18, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel19() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox19, String.Empty) %>;
            MenuHighlight();
        }
        function RefreshUpdatePanel20() {
            <%= Page.ClientScript.GetPostBackEventReference(TextBox20, String.Empty) %>;
            MenuHighlight();
        };
    </script>

    <%--</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpTitle" runat="Server">--%>
    <div>
        <%--<ul class="breadcrumb">
            <li>
                <i class="icon-home"></i>
                <a href="Page1.aspx"><span class="label">Page1</span></a>
            </li>
            <li id="lipage2">
                <i class="icon-edit"></i>
                <a href="Page2.aspx"><span class="label">Page2</span></a>
            </li>
            <li id="li1" runat="server" enable="false">
                <i class="icon-edit"></i>
                <a href="Page3.aspx"><span class="label label-success">Page3</span></a>
            </li>
            <li id="li2" runat="server" enable="false">
                <i class="icon-edit"></i>
                <a href="Page4.aspx"><span class="label">Page4</span></a>
            </li>
        </ul>--%>
    </div>
    <%--</asp:Content>--%>
    <%--<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="Server">--%>
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

    <asp:UpdatePanel runat="server" ID="up_complains">
        <ContentTemplate>
            <h4>ROS</h4>
            <hr/>
            <div class="form-horizontal">
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="1" ID="chk_abdominal_pain" Text="Abdominal Pain" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="2" ID="chk_blurred" Text="Blurred Vision" />
                    &nbsp;/ Double Vision
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="3" ID="chk_bowel_bladder" Text="Bowel/Bladder Incontinence" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="4" ID="chk_chest_pain" Text="Chest Pain" />
                </div>
                <div style="clear: both"></div>
            </div>
            <div class="form-horizontal">
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="5" ID="chk_diarrhea" Text="Diarrhea" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="6" ID="chk_episodic_ligth" Text="Episodic Light Headedness" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="7" ID="chk_fever" Text="Fever" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="8" ID="chk_hearing_loss" Text="Hearing Loss" />
                </div>

                <div style="clear: both"></div>
            </div>
            <div class="form-horizontal">
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="9" ID="chk_recent_wt" Text="Recent wt.loss" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="10" ID="chk_seizures" Text="Seizures" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="11" ID="chk_shortness_of_breath" Text="Shortness of Breath" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="12" ID="chk_sleep_disturbance" Text="Sleep Disturbance / Night Sweats" />
                </div>
                <div style="clear: both"></div>
            </div>
            <h4>Complaints</h4>
            <hr/>

            <div class="form-horizontal">
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="13" ID="chk_depression" Text="Depression " />
                </div>

                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="14" ID="chk_dizziness" Text="Dizziness" />
                </div>

                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="15" ID="chk_headaches" Text="Headaches" />
                </div>

                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="16" ID="chk_jaw_pain" Text="Jaw Pain/Clicking" />
                </div>
                <div style="clear: both"></div>
            </div>
            <div class="form-horizontal">
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="17" ID="chk_nausea" Text="Nausea" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="18" ID="chk_numbness_in_arm" Text="Numbness in Arm / Hand" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="19" ID="chk_numbess_in_leg" Text="Numbness in Leg" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="20" ID="chk_pain_radiating_leg" Text="Pain Radiating Down Leg" />
                </div>
                <div style="clear: both"></div>
            </div>

            <div class="form-horizontal">
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="21" ID="chk_pain_radiating_shoulder" Text="Pain Radiating Down Shoulder" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="22" ID="chk_rashes" Text="Rashes" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="23" ID="chk_anxiety" Text="Anxiety" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="24" ID="chk_tingling_in_arms" Text="Tingling in Arms" />
                </div>
                <div style="clear: both"></div>
            </div>
            <div class="form-horizontal">
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="25" ID="chk_tingling_in_legs" Text="Tingling in Legs" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="26" ID="chk_vomiting" Text="Vomiting" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="27" ID="chk_weakness_in_arm" Text="Weakness in Arm / Hand" />
                </div>
                <div class="span3">
                    <asp:CheckBox runat="server" TabIndex="28" ID="chk_weakness_in_leg" Text="Weakness in Leg" />
                </div>
                <div style="clear: both"></div>
            </div>
            <br />
            <div class="form-horizontal">
                <strong>Degree of Disability:</strong>
                <asp:RadioButtonList ID="rblDOD" TabIndex="29" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="partial">Partial</asp:ListItem>
                    <asp:ListItem Value="25%">25%</asp:ListItem>
                    <asp:ListItem Value="50%">50%</asp:ListItem>
                    <asp:ListItem Value="75%">75%</asp:ListItem>
                    <asp:ListItem Value="100%">100%</asp:ListItem>
                    <asp:ListItem Value="none">None</asp:ListItem>
                </asp:RadioButtonList><br />
                <strong>Restrictions:</strong>
                <asp:CheckBoxList ID="cblRestictions" runat="server" TabIndex="30" RepeatColumns="4">
                    <asp:ListItem Value="Bending / Twisting">Bending / Twisting</asp:ListItem>
                    <asp:ListItem Value="Climbing stairs/ladders">Climbing stairs/ladders</asp:ListItem>
                    <asp:ListItem Value="Environmental conditions">Environmental conditions</asp:ListItem>
                    <asp:ListItem Value="Kneeling">Kneeling</asp:ListItem>
                    <asp:ListItem Value="Lifting">Lifting</asp:ListItem>
                    <asp:ListItem Value="Operating heavy equipment">Operating heavy equipment</asp:ListItem>
                    <asp:ListItem Value="Operation of motor vehicles">Operation of motor vehicles</asp:ListItem>
                    <asp:ListItem Value="Personal protective equipment">Personal protective equipment</asp:ListItem>
                    <asp:ListItem Value="Sitting">Sitting</asp:ListItem>
                    <asp:ListItem Value="Standing">Standing</asp:ListItem>
                    <asp:ListItem Value="Use of public transportation">Use of public transportation</asp:ListItem>
                    <asp:ListItem Value="Use of upper extremities">Use of upper extremities</asp:ListItem>
                </asp:CheckBoxList>
                <strong>Others:</strong>
                <asp:TextBox ID="txtOtherRestrictions" TabIndex="31" Width="782px" runat="server"></asp:TextBox>
                <br />
                <br />
                <strong>Work Status:</strong>
                <%--  <asp:CheckBoxList ID="cblWorkStatus" runat="server" RepeatColumns="2">
                            <asp:ListItem Value="Able to go back to work">Able to go back to work                              
                         
                                 </asp:ListItem>
                            <asp:ListItem Value="Working">Working</asp:ListItem>
                            <asp:ListItem Value="Not Working">Not Working</asp:ListItem>
                            <asp:ListItem Value="Partially Working">Partially Working</asp:ListItem>
                        </asp:CheckBoxList>--%>

                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <table border="0" cellpadding="0" cellspacing="0">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:CheckBox ID="cblWorkStatus" Text='<%# Eval("WorkStatus") %>' runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtCollageName" runat="server" />
                            </td>

                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <br />
                <strong>Neurological Exam:</strong>
                <p>
                    The patient is alert and cooperative and responding appropriately. Cranial nerves - II-XII are grossly intact except
                    <asp:TextBox ID="txtIntactExcept" TabIndex="32" runat="server"></asp:TextBox>
                </p>
                <p>
                    Deep Tendon Reflexes: 
                   <table>
                       <tr>
                           <td>
                               <table style="margin-right: 50px">
                                   <thead>
                                       <tr>
                                           <td>
                                               <asp:CheckBox ID="UExchk" TabIndex="33" runat="server" Text=" Upper Extremity    " /></td>
                                           <td>Left</td>
                                           <td>Right</td>
                                       </tr>
                                   </thead>
                                   <tbody>
                                       <tr>
                                           <td>Triceps</td>
                                           <td>
                                               <asp:TextBox ID="LTricepstxt" TabIndex="34" Width="50" runat="server"></asp:TextBox></td>
                                           <td>
                                               <asp:TextBox ID="RTricepstxt" TabIndex="35" Width="50" runat="server"></asp:TextBox></td>


                                       </tr>
                                       <tr>
                                           <td>Biceps</td>
                                           <td>
                                               <asp:TextBox ID="LBicepstxt" TabIndex="36" Width="50" runat="server"></asp:TextBox></td>
                                           <td>
                                               <asp:TextBox ID="RBicepstxt" TabIndex="37" Width="50" runat="server"></asp:TextBox></td>
                                       </tr>
                                       <tr>
                                           <td>Brachioradialis</td>
                                           <td>
                                               <asp:TextBox Width="50" TabIndex="38" ID="RBrachioradialis" runat="server"></asp:TextBox></td>
                                           <td>
                                               <asp:TextBox ID="LBrachioradialis" TabIndex="39" Width="50" runat="server"></asp:TextBox></td>

                                       </tr>
                                   </tbody>
                               </table>
                           </td>
                           <td></td>
                           <td>
                               <table style="margin-top: -40px">
                                   <thead>
                                       <tr>
                                           <td>
                                               <asp:CheckBox ID="LEdtr" TabIndex="40" runat="server" Text=" Lower Extremity    " /></td>
                                           <td>Left</td>
                                           <td>Right</td>
                                       </tr>
                                   </thead>
                                   <tbody>
                                       <tr>
                                           <td>Knee</td>
                                           <td>
                                               <asp:TextBox ID="LKnee" TabIndex="41" Width="50" runat="server"></asp:TextBox></td>
                                           <td>
                                               <asp:TextBox ID="RKnee" TabIndex="42" Width="50" runat="server"></asp:TextBox></td>


                                       </tr>
                                       <tr>
                                           <td>Ankle</td>
                                           <td>
                                               <asp:TextBox ID="LAnkle" TabIndex="43" Width="50" runat="server"></asp:TextBox></td>
                                           <td>
                                               <asp:TextBox ID="RAnkle" TabIndex="44" Width="50" runat="server"></asp:TextBox></td>
                                       </tr>
                                       <tr>
                                           <td></td>
                                           <td>
                                               <asp:TextBox ID="TextBox1" TabIndex="45" Visible="false" Width="50" runat="server"></asp:TextBox></td>
                                           <td>
                                               <asp:TextBox ID="TextBox2" TabIndex="46" Visible="false" Width="50" runat="server"></asp:TextBox></td>
                                       </tr>
                                   </tbody>
                               </table>
                           </td>
                       </tr>
                   </table>
                </p>
                <hr />
                Sensory:  Is checked by 
                    <asp:CheckBox ID="chkPinPrick" TabIndex="47" runat="server" /> Pinprick
                    <asp:CheckBox Text="" runat="server" ID="chkLighttouch" /> light touch. It is
                <asp:TextBox runat="server" TabIndex="48" ID="txtSensory"></asp:TextBox>
                <table>
                    <tr>
                        <td>
                            <table style="margin-right: 50px; margin-top: 5px;">
                                <thead>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="UESen_Click" runat="server" TabIndex="59" Text=" Upper Extremity    " /></td>
                                        <td>Left</td>
                                        <td>Right</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Lateral arm (C5)</td>
                                        <td>
                                            <asp:TextBox ID="TextBox9" onkeyup="RefreshUpdatePanel9();" TabIndex="60" AutoPostBack="false" OnTextChanged="TextBox9_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="txtUEC5Right" onkeyup="RefreshUpdatePanelC5Right();MenuHighlight();" TabIndex="61" OnTextChanged="txtUEC5Right_TextChanged" Width="100" runat="server"></asp:TextBox></td>


                                    </tr>
                                    <tr>
                                        <td>Lateral forearm, thumb, index (C6)</td>
                                        <td>
                                            <asp:TextBox ID="TextBox11" onkeyup="RefreshUpdatePanel11();MenuHighlight();" TabIndex="62" OnTextChanged="TextBox11_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="TextBox12" onkeyup="RefreshUpdatePanel12();MenuHighlight();" TabIndex="63" OnTextChanged="TextBox12_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>Middle finger (C7)</td>
                                        <td>
                                            <asp:TextBox ID="TextBox13" onkeyup="RefreshUpdatePanel13();MenuHighlight();" TabIndex="64" OnTextChanged="TextBox13_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="TextBox14" onkeyup="RefreshUpdatePanel14();MenuHighlight();" TabIndex="65" OnTextChanged="TextBox14_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>Medial forearm, ring, little finger (C8)</td>
                                        <td>
                                            <asp:TextBox ID="TextBox15" onkeyup="RefreshUpdatePanel15();MenuHighlight();" TabIndex="66" OnTextChanged="TextBox15_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="TextBox16" onkeyup="RefreshUpdatePanel16();MenuHighlight();" TabIndex="67" OnTextChanged="TextBox16_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>Medial arm (T1)</td>
                                        <td>
                                            <asp:TextBox ID="TextBox17" onkeyup="RefreshUpdatePanel17();MenuHighlight();" TabIndex="68" OnTextChanged="TextBox17_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="TextBox18" onkeyup="RefreshUpdatePanel18();MenuHighlight();" TabIndex="69" OnTextChanged="TextBox18_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>Cervical paraspinals</td>
                                        <td>
                                            <asp:TextBox ID="TextBox19" onkeyup="RefreshUpdatePanel19();MenuHighlight();" TabIndex="70" OnTextChanged="TextBox19_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="TextBox20" onkeyup="RefreshUpdatePanel20();MenuHighlight();" TabIndex="71" OnTextChanged="TextBox20_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                    </tr>
                                </tbody>
                            </table>

                        </td>
                        <td></td>
                        <td>
                            <table style="margin-top: -20px">
                                <thead>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="LESen_Click" TabIndex="49" runat="server" Text=" Lower Extremity    " /></td>
                                        <td>Left</td>
                                        <td>Right</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Distal medial thigh (L3)</td>
                                        <td>
                                            <asp:TextBox ID="txtDMTL3" Width="100" TabIndex="50" onkeyup="RefreshUpdatePanelL3();MenuHighlight();" OnTextChanged="txtDMTL3_TextChanged" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="TextBox4" Width="100" TabIndex="51" onkeyup="RefreshUpdatePanel4();MenuHighlight();" OnTextChanged="TextBox4_TextChanged" runat="server"></asp:TextBox></td>

                                    </tr>
                                    <tr>
                                        <td>Medial left foot (L4)</td>
                                        <td>
                                            <asp:TextBox ID="TextBox5" onkeyup="RefreshUpdatePanel5();MenuHighlight();" TabIndex="52" OnTextChanged="TextBox5_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="TextBox6" onkeyup="RefreshUpdatePanel6();MenuHighlight();" TabIndex="53" OnTextChanged="TextBox6_TextChanged" Width="100" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>Dorsum of the foot (L5)</td>
                                        <td>
                                            <asp:TextBox Width="100" onkeyup="RefreshUpdatePanel7();MenuHighlight();" TabIndex="53" OnTextChanged="TextBox7_TextChanged" ID="TextBox7" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="TextBox8" onkeyup="RefreshUpdatePanel8();MenuHighlight();" TabIndex="54" OnTextChanged="TextBox8_TextChanged" Width="100" runat="server"></asp:TextBox></td>

                                    </tr>
                                    <tr>
                                        <td>Lateral foot (S1)</td>
                                        <td>
                                            <asp:TextBox Width="100" onkeyup="RefreshUpdatePanel10();MenuHighlight();" TabIndex="55" OnTextChanged="TextBox10_TextChanged" ID="TextBox10" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="TextBox21" onkeyup="RefreshUpdatePanel21();MenuHighlight();" TabIndex="56" OnTextChanged="TextBox21_TextChanged" Width="100" runat="server"></asp:TextBox></td>

                                    </tr>
                                    <%--   <tr><td>Brachioradialis</td><td><asp:TextBox Width="25" ID="TextBox22" runat="server"></asp:TextBox></td>
                               <td><asp:TextBox ID="TextBox23" Width="25" runat="server"></asp:TextBox></td>

                           </tr>--%>
                                    <tr>
                                        <td>Lumbar paraspinals</td>
                                        <td>
                                            <asp:TextBox Width="100" onkeyup="RefreshUpdatePanel24();MenuHighlight();" TabIndex="57" OnTextChanged="TextBox24_TextChanged" ID="TextBox24" runat="server"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox ID="TextBox25" onkeyup="RefreshUpdatePanel25();MenuHighlight();" TabIndex="58" OnTextChanged="TextBox25_TextChanged" Width="100" runat="server"></asp:TextBox></td>

                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </table>
                <hr />
                <p>
                    Hoffman's exam:
                    <asp:DropDownList ID="cboHoffmanexam" TabIndex="72" runat="server">
                        <asp:ListItem> </asp:ListItem>
                        <asp:ListItem Value="Positive">Positive</asp:ListItem>
                        <asp:ListItem Value="Negative">Negative</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CheckBox ID="chkStocking" TabIndex="73" runat="server" Text=" stocking pattern  " />
                    <asp:CheckBox ID="chkGlove" TabIndex="74" runat="server" Text=" glove pattern." />
                </p>
                <p>
                    Manual Muscle Strength Testing: 
                      <table>
                          <tr>
                              <td>
                                  <table style="margin-right: 50px;">
                                      <thead>
                                          <tr>
                                              <td>
                                                  <asp:CheckBox ID="UEmmst" TabIndex="90" runat="server" Text=" Upper Extremity    " /></td>
                                              <td></td>
                                              <td>Left</td>
                                              <td>Right</td>
                                          </tr>
                                      </thead>
                                      <tbody>
                                          <tr>
                                              <td>Shoulder</td>
                                              <td>Abduction</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox30" TabIndex="91" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox31" TabIndex="92" Width="50" runat="server"></asp:TextBox></td>


                                          </tr>
                                          <tr>
                                              <td></td>
                                              <td>Flexion</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox48" TabIndex="93" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox49" TabIndex="94" Width="50" runat="server"></asp:TextBox></td>


                                          </tr>
                                          <tr>
                                              <td>Elbow</td>
                                              <td>Extension</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox32" TabIndex="95" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox33" TabIndex="96" Width="50" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td></td>
                                              <td>Flexion</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox50" TabIndex="97" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox51" TabIndex="98" Width="50" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td></td>
                                              <td>Supination</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox52" TabIndex="99" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox53" TabIndex="100" Width="50" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td></td>
                                              <td>Pronation</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox54" TabIndex="101" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox55" Width="50" TabIndex="102" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td>Wrist</td>
                                              <td>Flexion</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox36" TabIndex="103" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox37" TabIndex="104" Width="50" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td></td>
                                              <td>Extension</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox56" TabIndex="105" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox57" Width="50" TabIndex="106" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td>Hand</td>
                                              <td>Grip strength</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox38" TabIndex="107" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox39" TabIndex="108" Width="50" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td>Hand</td>
                                              <td>Finger abduction</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox58" TabIndex="109" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox59" TabIndex="110" Width="50" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox34" TabIndex="111" Visible="false" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox35" TabIndex="112" Visible="false" Width="50" runat="server"></asp:TextBox></td>
                                          </tr>
                                      </tbody>
                                  </table>

                              </td>
                              <td></td>
                              <td>
                                  <table style="margin-top: -100px">
                                      <thead>
                                          <tr>
                                              <td>
                                                  <asp:CheckBox ID="LEmmst" TabIndex="75" runat="server" Text=" Lower Extremity    " /></td>
                                              <td></td>
                                              <td>Left</td>
                                              <td>Right</td>
                                          </tr>
                                      </thead>
                                      <tbody style="padding: 5px">
                                          <tr>
                                              <td>Hip</td>
                                              <td>Flexion</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox22" TabIndex="76" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox23" TabIndex="77" Width="50" runat="server"></asp:TextBox></td>


                                          </tr>
                                          <tr>
                                              <td></td>
                                              <td>Abduction</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox40" TabIndex="78" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox41" Width="50" TabIndex="79" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td>Knee</td>
                                              <td>Extension</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox26" TabIndex="80" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox27" TabIndex="81" Width="50" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td></td>
                                              <td>Flexion</td>
                                              <td>
                                                  <asp:TextBox ID="TextBox42" TabIndex="82" Width="50" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox43" TabIndex="83" Width="50" runat="server"></asp:TextBox></td>
                                          </tr>
                                          <tr>
                                              <td>Ankle</td>
                                              <td>Dorsiflexion</td>
                                              <td>
                                                  <asp:TextBox Width="50" TabIndex="84" ID="TextBox28" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox29" TabIndex="85" Width="50" runat="server"></asp:TextBox></td>

                                          </tr>
                                          <tr>
                                              <td></td>
                                              <td>Plantar flexion</td>
                                              <td>
                                                  <asp:TextBox Width="50" TabIndex="86" ID="TextBox44" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox45" TabIndex="87" Width="50" runat="server"></asp:TextBox></td>

                                          </tr>
                                          <tr>
                                              <td></td>
                                              <td>Extensor hallucis longus</td>
                                              <td>
                                                  <asp:TextBox Width="50" TabIndex="88" ID="TextBox46" runat="server"></asp:TextBox></td>
                                              <td>
                                                  <asp:TextBox ID="TextBox47" TabIndex="89" Width="50" runat="server"></asp:TextBox></td>

                                          </tr>
                                      </tbody>
                                  </table>
                              </td>
                          </tr>
                      </table>

                </p>
                <%-- <strong>Work Status Comments:</strong>
               <asp:TextBox ID="workStatusCmnts" TextMode="multiline" Columns="500" Rows="5"  runat="server"></asp:TextBox>--%>
                <div style="clear: both"></div>
            </div>
            <br />
            <div style="display: none">
                <asp:Button runat="server" Text="Save" CssClass="btn btn-primary" TabIndex="113" OnClick="btnSave_Click" ID="btnSave" UseSubmitBehavior="False" />
            </div>
            <asp:Button runat="server" ID="Button1" PostBackUrl="~/PatientIntakeList.aspx" TabIndex="114" Text="Back to List" CssClass="btn btn-default" UseSubmitBehavior="False" />
            </div>
            
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

