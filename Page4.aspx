<%@ Page Title="" Language="C#" MasterPageFile="~/PageMainMaster.master" AutoEventWireup="true" CodeFile="Page4.aspx.cs" Inherits="Page4" %>

   
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">  

<script type="text/javascript">
    function openPopup(divid) {

        $('#' + divid + '').modal('show');

    }
     </script>
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


    <asp:UpdatePanel runat="server" ID="up_complains">
        <ContentTemplate>
            <h4>Additional Complaints</h4>
            <hr />
            <asp:Panel runat="server" ID="pnlCheckbox">
                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server"  ID="A_Fall_History" OnCheckedChanged="A_Fall_History_CheckedChanged" AutoPostBack="true" Text=" A Fall History" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Answering_The_Door" OnCheckedChanged="Answering_The_Door_CheckedChanged" AutoPostBack="true" Text=" Answering The Door" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Appliances_Laundry_Appliances" OnCheckedChanged="Appliances_Laundry_Appliances_CheckedChanged" AutoPostBack="true" Text=" Appliances And Laundry Appliances" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Bending" OnCheckedChanged="Bending_CheckedChanged" AutoPostBack="true" Text=" Bending" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Carrying_Large_Objects" OnCheckedChanged="Carrying_Large_Objects_CheckedChanged" AutoPostBack="true" Text=" Carrying Large Objects" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Carrying" OnCheckedChanged="Carrying_CheckedChanged" AutoPostBack="true" Text=" Carrying" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Cleaning" OnCheckedChanged="Cleaning_CheckedChanged" AutoPostBack="true" Text=" Cleaning" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Cognitive_Impairment" OnCheckedChanged="Cognitive_Impairment_CheckedChanged" AutoPostBack="true" Text=" Cognitive Impairment" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Decrease_In_Sensitivity_To_Heat_Pain_Pressure" OnCheckedChanged="Decrease_In_Sensitivity_To_Heat_Pain_Pressure_CheckedChanged" AutoPostBack="true" Text=" Decrease In Sensitivity To Heat Or Pain Or Pressure" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Diminished_Sense_Of_Touch" OnCheckedChanged="Diminished_Sense_Of_Touch_CheckedChanged" AutoPostBack="true" Text=" Diminished Sense Of Touch" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Doing_Laundry" OnCheckedChanged="Doing_Laundry_CheckedChanged" AutoPostBack="true" Text=" Doing Laundry" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Driving" OnCheckedChanged="Driving_CheckedChanged" AutoPostBack="true" Text=" Driving" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Emptying_The_Mailbox" OnCheckedChanged="Emptying_The_Mailbox_CheckedChanged" AutoPostBack="true" Text=" Emptying The Mailbox" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Getting_Dressed" OnCheckedChanged="Getting_Dressed_CheckedChanged" AutoPostBack="true" Text=" Getting Dressed" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Getting_In_And_Out_Of_The_Home" OnCheckedChanged="Getting_In_And_Out_Of_The_Home_CheckedChanged" AutoPostBack="true" Text=" Getting In And Out Of The Home" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Getting_In_And_Out_Of_Bed_Chairs_Sofas" OnCheckedChanged="Getting_In_And_Out_Of_Bed_Chairs_Sofas_CheckedChanged" AutoPostBack="true" Text=" Getting In And Out Of Bed Or Chairs Or Sofas" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Hearing_Problems" OnCheckedChanged="Hearing_Problems_CheckedChanged" AutoPostBack="true" Text=" Hearing Problems" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Holding" OnCheckedChanged="Holding_CheckedChanged" AutoPostBack="true" Text=" Holding" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Household_Chores" OnCheckedChanged="Household_Chores_CheckedChanged" AutoPostBack="true" Text=" Household Chores" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Incontinence" OnCheckedChanged="Incontinence_CheckedChanged" AutoPostBack="true" Text=" Incontinence" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Kneeling" OnCheckedChanged="Kneeling_CheckedChanged" AutoPostBack="true" Text=" Kneeling" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Lack_Of_Coordination" OnCheckedChanged="Lack_Of_Coordination_CheckedChanged" AutoPostBack="true" Text=" Lack Of Coordination" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Lifting" OnCheckedChanged="Lifting_CheckedChanged" AutoPostBack="true" Text=" Lifting" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Lifting_Heavy_Or_Bulky_Objects_" OnCheckedChanged="Lifting_Heavy_Or_Bulky_Objects__CheckedChanged" AutoPostBack="true" Text=" Lifting Heavy Or Bulky Objects" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Limited_Reach" OnCheckedChanged="Limited_Reach_CheckedChanged" AutoPostBack="true" Text=" Limited Reach" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Moving_About_In_Individual_Rooms" OnCheckedChanged="Moving_About_In_Individual_Rooms_CheckedChanged" AutoPostBack="true" Text=" Moving About In Individual Rooms" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Moving_From_One_Room_To_Another" OnCheckedChanged="Moving_From_One_Room_To_Another_CheckedChanged" AutoPostBack="true" Text=" Moving From One Room To Another" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Opening_Closing_Or_Locking_Windows_And_Doors" OnCheckedChanged="Opening_Closing_Or_Locking_Windows_And_Doors_CheckedChanged" AutoPostBack="true" Text=" Opening Or Closing Or Locking Windows And Doors" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Operating_Light_Switches_Faucets_Kitchen" OnCheckedChanged="Operating_Light_Switches_Faucets_Kitchen_CheckedChanged" AutoPostBack="true" Text=" Operating Light Switches Or Faucets Or Kitchen" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Physical_Weakness" OnCheckedChanged="Physical_Weakness_CheckedChanged" AutoPostBack="true" Text=" Physical Weakness" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Playing_With_Children" OnCheckedChanged="Playing_With_Children_CheckedChanged" AutoPostBack="true" Text=" Playing With Children" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Poor_Grip" OnCheckedChanged="Poor_Grip_CheckedChanged" AutoPostBack="true" Text=" Poor Grip" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Poor_Vision" OnCheckedChanged="Poor_Vision_CheckedChanged" AutoPostBack="true" Text=" Poor Vision" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Poor_Balance_Gait" OnCheckedChanged="Poor_Balance_Gait_CheckedChanged" AutoPostBack="true" Text=" Poor Balance Or Gait" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Preparing_Meals" OnCheckedChanged="Preparing_Meals_CheckedChanged" AutoPostBack="true" Text=" Preparing Meals" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Pulling" OnCheckedChanged="Pulling_CheckedChanged" AutoPostBack="true" Text=" Pulling" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Pushing" OnCheckedChanged="Pushing_CheckedChanged" AutoPostBack="true" Text=" Pushing" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Reaching_Items_In_Closets_And_Cabinets" OnCheckedChanged="Reaching_Items_In_Closets_And_Cabinets_CheckedChanged" AutoPostBack="true" Text=" Reaching Items In Closets And Cabinets" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Reduced_Mobility" OnCheckedChanged="Reduced_Mobility_CheckedChanged" AutoPostBack="true" Text=" Reduced Mobility" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Sex_Sexual_Dysfunction" OnCheckedChanged="Sex_Sexual_Dysfunction_CheckedChanged" AutoPostBack="true" Text=" Sex (Sexual Dysfunction)" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Sitting" OnCheckedChanged="Sitting_CheckedChanged" AutoPostBack="true" Text=" Sitting" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Socializing" OnCheckedChanged="Socializing_CheckedChanged" AutoPostBack="true" Text=" Socializing" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Sports_Activities" OnCheckedChanged="Sports_Activities_CheckedChanged" AutoPostBack="true" Text=" Sports Activities" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Standing" OnCheckedChanged="Standing_CheckedChanged" AutoPostBack="true" Text=" Standing" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Stooping" OnCheckedChanged="Stooping_CheckedChanged" AutoPostBack="true" Text=" Stooping" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Twisting" OnCheckedChanged="Twisting_CheckedChanged" AutoPostBack="true" Text=" Twisting" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Use_Of_Cane_Walker_Wheelchair" OnCheckedChanged="Use_Of_Cane_Walker_Wheelchair_CheckedChanged" AutoPostBack="true" Text=" Use Of Cane Or Walker Or Wheelchair" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Using_The_Stairs" OnCheckedChanged="Using_The_Stairs_CheckedChanged" AutoPostBack="true" Text=" Using The Stairs" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Using_The_Bathtub_Or_Shower" OnCheckedChanged="Using_The_Bathtub_Or_Shower_CheckedChanged" AutoPostBack="true" Text=" Using The Bathtub Or Shower" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Using_The_Kitchen" OnCheckedChanged="Using_The_Kitchen_CheckedChanged" AutoPostBack="true" Text=" Using The Kitchen" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Using_The_Toilet" OnCheckedChanged="Using_The_Toilet_CheckedChanged" AutoPostBack="true" Text=" Using The Toilet" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Using_The_Telephone" OnCheckedChanged="Using_The_Telephone_CheckedChanged" AutoPostBack="true" Text=" Using The Telephone" />
                    </div>
                    <div style="clear: both"></div>
                </div>

                <div class="form-horizontal">
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Walking" OnCheckedChanged="Walking_CheckedChanged" AutoPostBack="true" Text=" Walking" />
                    </div>
                    <div class="span3">
                        <asp:CheckBox runat="server" ID="Working" OnCheckedChanged="Working_CheckedChanged" AutoPostBack="true" Text=" Working" />
                    </div>
                    <div style="clear: both"></div>
                </div>
                <asp:TextBox runat="server" ID="txt_FreeForm" TextMode="MultiLine" Width="100%" ReadOnly="True"></asp:TextBox>
                <br />
                .<br />
               <div style="display:none"> <asp:Button runat="server" Text="Save"  CssClass="btn btn-primary" OnClick="btnSave_Click" ID="btnSave" /> </div>
                <asp:Button runat="server" ID="Button1" PostBackUrl="~/PatientIntakeList.aspx" Text="Back to List" CssClass="btn btn-default" UseSubmitBehavior="False" />
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

