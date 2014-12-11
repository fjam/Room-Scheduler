<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GCWE_Scheduler.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Events Taking Place</title>
    <style type="text/css">
        body {
            background-color: ActiveCaption;
        }

        .auto-style1 {
            text-align: center;
        }

        .auto-style2 {
            width: 147px;
        }

        .auto-style3 {
            width: 147px;
            text-align: right;
        }

        .auto-style4 {
            width: 180px;
        }

        .auto-style5 {
            width: 147px;
            text-align: right;
            height: 26px;
        }

        .auto-style6 {
            width: 180px;
            height: 26px;
        }

        .auto-style7 {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h2 class="auto-style1"><strong>Brooklyn College - GCWE Events Calendar</strong></h2>

        </div>
        <table style="width: 100%;">
            <tr>
                <td class="auto-style5">UserName</td>
                <td class="auto-style6">
                    <asp:TextBox ID="TextBoxUn" runat="server" Width="144px" OnTextChanged="TextBoxUn_TextChanged"></asp:TextBox>
                </td>
                <td class="auto-style7">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxUn" ErrorMessage="Please enter Username" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">Password</td>
                <td class="auto-style4">
                    <asp:TextBox ID="TextBoxP" runat="server" TextMode="Password" Width="144px" OnTextChanged="TextBoxP_TextChanged"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxP" ErrorMessage="Please enter password" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td class="auto-style4">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                    <br />
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Login" Height="23px" Width="87px" />
                    <br />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <br />
        <div id="calendar">
            <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" BackColor="#FFFFCC" BorderColor="#FFCC66" BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#663399" ShowGridLines="True">
                <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="1px" />
                <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                <OtherMonthDayStyle ForeColor="#CC9966" />
                <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                <SelectorStyle BackColor="#FFCC66" />
                <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                <WeekendDayStyle Font-Overline="False" Font-Strikeout="False" />
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

            #Calendar1 {
                position: absolute;
                top: 181px;
                left: 10px;
                height: 211px;
                width: 239px;
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

            #staffhourtable {
                margin-top: 150px;
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

        <p>
            &nbsp;
        </p>
        <p>
            &nbsp;
        </p>
        <p>
            <div id="staffhourtable">
                &nbsp;<asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Large" Text="Staff Hours:"></asp:Label>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" AllowSorting="True" BorderColor="White" Font-Bold="False">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                        <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                        <asp:BoundField DataField="XT" HeaderText="XT" SortExpression="XT" />
                        <asp:BoundField DataField="Room" HeaderText="Room" SortExpression="Room" />
                        <asp:BoundField DataField="Monday" HeaderText="Monday" SortExpression="Monday" />
                        <asp:BoundField DataField="Tuesday" HeaderText="Tuesday" SortExpression="Tuesday" />
                        <asp:BoundField DataField="Wednesday" HeaderText="Wednesday" SortExpression="Wednesday" />
                        <asp:BoundField DataField="Thursday" HeaderText="Thursday" SortExpression="Thursday" />
                        <asp:BoundField DataField="Friday" HeaderText="Friday" SortExpression="Friday" />
                    </Columns>
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <SortedAscendingCellStyle BackColor="#FDF5AC" />
                    <SortedAscendingHeaderStyle BackColor="#4D0000" />
                    <SortedDescendingCellStyle BackColor="#FCF6C0" />
                    <SortedDescendingHeaderStyle BackColor="#820000" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [FirstName], [LastName], [XT], [Room], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday] FROM [StaffHours]"></asp:SqlDataSource>
            </div>
        </p>
    </form>
    <p>
        &nbsp;
    </p>
    <p>
        &nbsp;
    </p>
</body>
</html>
