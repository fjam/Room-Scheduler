<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GCWE_Scheduler.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Events Taking Place</title>
    <link rel="stylesheet" type="text/css" href="Styles/style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h2 class="Title"><strong>Brooklyn College - GCWE Events Calendar</strong></h2>

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
                <td class="passText">Password</td>
                <td class="login">
                    <asp:TextBox ID="TextBoxP" runat="server" TextMode="Password" Width="144px" OnTextChanged="TextBoxP_TextChanged"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxP" ErrorMessage="Please enter password" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="empty">&nbsp;</td>
                <td class="login">
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
            <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" Height="211px" Width="239px" BackColor="#FFFFCC" BorderColor="#FFCC66" BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#663399" ShowGridLines="True">
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
