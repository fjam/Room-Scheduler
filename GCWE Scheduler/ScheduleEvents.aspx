﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScheduleEvents.aspx.cs" Inherits="GCWE_Scheduler.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style type="text/css">
        body {
            background-color: ActiveCaption;
        }

        .inline {
            display: inline;
        }

        .auto-style1 {
            width: 100%;
        }

        .auto-style4{
            text-align: center;
        }
        .auto-style2 {
            width: 265px;
            text-align: right;
            font-weight: 700;
        }

        #Reset1 {
            width: 62px;
        }

        .auto-style3 {
            width: 327px;
        }
    </style>
    <title>Register Event</title>
</head>
<body>

<h2 class="auto-style4"><strong>Schedule Event</strong></h2>


    <form id="form1" runat="server">
        <div>

            <asp:Label ID="Label2" runat="server" Font-Bold="False" Font-Size="Large"></asp:Label>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Logout" OnClick="Button1_Click" ValidationGroup="group2"/>
            <br />

            <br />
            <div id="links">
            <a href="AllEvents.aspx">Edit all events</a>
                        <br />
                <a href="Employees.aspx">Edit Staff Schedule</a>
                    </div>


            </div>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Text], [EventStart], [EventEnd], [Room] FROM [Events]"></asp:SqlDataSource>

            <br />
            <div id="calendar">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="#FFFFCC" BorderColor="#FFCC66" Font-Names="Verdana" Font-Size="8pt"
                    ForeColor="#663399" Height="211px" Width="239px" OnSelectionChanged="Calendar1_SelectionChanged" Format="mm/dd/yyyy" DayNameFormat="Shortest" BorderWidth="1px" ShowGridLines="True">
                    <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                    <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                    <OtherMonthDayStyle ForeColor="#CC9966" />
                    <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                    <SelectorStyle BackColor="#FFCC66" />
                    <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" BorderColor="Yellow" />
                    <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                </asp:Calendar>
            </div>

            <div class='my-legend'>
                <div class='legend-title'>Legned</div>
                <div class='legend-scale'>
                    <ul class='legend-labels'>
                        <li><span style='background: #ff0000;'></span>Class</li>
                        <li><span style='background: #ffd800;'></span>Meeting</li>
                        <li><span style='background: #00ff21;'></span>Free</li>
                        <li><span style='background: #00ffff'></span>Other</li>
                    </ul>
                </div>
            </div>

            <style type='text/css'>
                .my-legend .legend-title {
                    text-align: left;
                    margin-bottom: 8px;
                    font-weight: bold;
                    font-size: 90%;
                }

                .my-legend .legend-scale ul {
                    margin: 0;
                    padding: 0;
                    float: left;
                    list-style: none;
                    width: 253px;
                    height: 35px;
                }

                    .my-legend .legend-scale ul li {
                        display: block;
                        float: left;
                        width: 50px;
                        margin-bottom: 6px;
                        text-align: center;
                        font-size: 80%;
                        list-style: none;
                    }

                .my-legend ul.legend-labels li span {
                    display: block;
                    float: left;
                    height: 15px;
                    width: 50px;
                }

                .my-legend .legend-source {
                    font-size: 70%;
                    color: #999;
                    clear: both;
                }

                .my-legend a {
                    color: #777;
                }

                .my-legend {
                    margin-left: 250px;
                    clear: both;
                }

                #calendar {
                    position: absolute;
                }

                #table1 {
                    clear: both;
                    margin-left: 250px;
                    margin-top: 20px;
                }

                #table2 {
                    margin-right: 50px;
                    margin-top: 20px;
                }

                #addEvent{
                    clear:both;
                    margin-top:234px;
                }

                #links{
                    float:right;
                }
            </style>

            <div id="tables">
                
                <div id="table1">
                        <table align="left" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                        <tr align="left" style="background-color: #990000; color: White;">
                            <td>Room</td>
                            <td>Section</td>
                            <td>Title</td>
                            <td>Event Start</td>
                            <td>Event End</td>
                            <td>Instructor</td>
                            <td>Notes</td>
                        </tr>

                        <div id="eventTable" runat="server">
                        </div>
                    </table>
                </div>

                
                <div id="table2">
                    <table align="right" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                        <tr align="left" style="background-color: #990000; color: White;">
                            <td>Room</td>
                            <td>Free From</td>
                            <td>Free To</td>
                        </tr>

                        <div id="freeTable" runat="server">
                        </div>
                    </table>
                </div>

            </div>

            <div id="addEvent">
                <h3><strong><u>REGISTER EVENT:</u></strong></h3>
                <br />
                <table class="auto-style1">
                    <tr>
                        <td class="auto-style2">Section <strong>Name</strong>:</td>
                        <td class="auto-style3">
                            <asp:TextBox ID="SectionTextBox" runat="server"></asp:TextBox></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="auto-style2"><strong>Title</strong>:</td>
                        <td class="auto-style3">
                            <asp:TextBox ID="EventNameTextBox" runat="server"></asp:TextBox></td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="EventNameTextBox" ErrorMessage="Enter an Event Name" ForeColor="Red" ValidationGroup="group1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2"><strong>Event Start Time: </strong> </td>
                        <td class="auto-style3">
                            <asp:TextBox ID="StartTimeTextBox" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="StartTimeTextBox" ErrorMessage="Enter Start Time" ForeColor="Red" ValidationGroup="group1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2"><strong>Event End Time:</strong></td>
                        <td class="auto-style3">
                            <asp:TextBox ID="EndTimeTextBox" runat="server"></asp:TextBox></td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="EndTimeTextBox" ErrorMessage="Enter End Time" ForeColor="Red" ValidationGroup="group1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2"><strong>Instructor Name:</strong></td>
                        <td class="auto-style3">
                            <asp:TextBox ID="InstructorTextBox" runat="server"></asp:TextBox></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="auto-style2"><strong>Room:</strong></td>
                        <td class="auto-style3">
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="RoomDataSource" DataTextField="Title" DataValueField="Title" Height="19px" Width="128px">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="RoomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Title] FROM [Room] ORDER BY [Title]"></asp:SqlDataSource>



                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DropDownList1" ErrorMessage="Select One" ForeColor="Red" ValidationGroup="group1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2"><strong>Starting Date of Event:</strong></td>
                        <td class="auto-style3">
                            <asp:Calendar ID="Calendar2" runat="server" Height="109px" OnSelectionChanged="Calendar2_SelectionChanged" Width="190px" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399">
                                <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                <TitleStyle BackColor="#990000" BorderColor="#FFCC00" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                                <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                <WeekendDayStyle BackColor="#CCCCFF" />
                            </asp:Calendar>
                            <br />
                            <asp:TextBox ID="StartDateTextBox" runat="server" Enabled="False"></asp:TextBox>
                        </td>
                        <td>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="StartDateTextBox" ErrorMessage="Enter the starting date of the Event" ForeColor="Red" ValidationGroup="group1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2"><strong>Ending Date of Event:</strong></td>
                        <td class="auto-style3">
                            <br />
                            <asp:Calendar ID="Calendar3" runat="server" Height="109px" OnSelectionChanged="Calendar3_SelectionChanged" Width="190px" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399">
                                <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                <TitleStyle BackColor="#990000" BorderColor="#FFCC00" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                                <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                <WeekendDayStyle BackColor="#CCCCFF" />
                            </asp:Calendar>
                            <br />
                            <asp:TextBox ID="EndDateTextBox" runat="server" Enabled="False"></asp:TextBox>
                        </td>
                        <td>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="StartDateTextBox" ErrorMessage="Enter the ending date of the Event" ForeColor="Red" ValidationGroup="group1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style2"><strong>Repeat</strong></td>
                        <td class="auto-style3">
                            <asp:RadioButton ID="YesRepeat" runat="server" GroupName="Repeat" Text="Yes" OnCheckedChanged="YesRepeat_CheckedChanged" />
                            <asp:RadioButton ID="NoRepeat" runat="server" GroupName="Repeat" Text="No" />
                            <br />
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2"><strong>Days to repeat: 
                        <br />
                            (Ex. Monday:Wednesday)</strong></td>
                        <td class="auto-style3">
                            
                            <asp:TextBox ID="DaysRepeatTextBox" runat="server"></asp:TextBox></td>
                        <td>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="DaysRepeatTextBox" ErrorMessage="Enter Days to repeat" ForeColor="Red" ValidationGroup="group1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style2"><strong>Type of event: </strong> </td>
                        <td class="auto-style3">
                            
                            <asp:DropDownList ID="typeDropDownList" runat="server">
                                <asp:ListItem>Class</asp:ListItem>
                                <asp:ListItem>Meeting</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>
                            
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>


                    <tr>
                        <td class="auto-style2">Notes:</td>
                        <td class="auto-style3">
                            <asp:TextBox ID="NotesTextBox" runat="server" Height="87px" TextMode="MultiLine" Width="215px"></asp:TextBox></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2">&nbsp;</td>
                        <td class="auto-style3">
                            <asp:Button ID="Submit" runat="server" Text="Submit" OnClick="Submit_Click" ValidationGroup="group1"/>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="Reset1" type="reset" value="Reset" />
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                
    </form>
</body>
</html>
