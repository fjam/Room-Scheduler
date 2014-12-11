<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AllEvents.aspx.cs" Inherits="GCWE_Scheduler.AllEvents" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <style>
     body{
            background-color:ActiveCaption;
        }
     .gridview {
        width: 100%; 
        word-wrap:break-word;
        table-layout: fixed;
     }
</style>   
    <title>All Events</title>
</head>
<body>
    <h2 class="auto-style1"><strong>All Events</strong></h2>

    <form id="form1" runat="server">
    <div class="gridview">
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="event_id" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="event_id" HeaderText="event_id" InsertVisible="False" ReadOnly="True" SortExpression="event_id" />
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="EventStart" HeaderText="EventStart" SortExpression="EventStart" />
                <asp:BoundField DataField="EventEnd" HeaderText="EventEnd" SortExpression="EventEnd" />
                <asp:BoundField DataField="Repeat" HeaderText="Repeat" SortExpression="Repeat" />
                <asp:BoundField DataField="Days" HeaderText="Days" SortExpression="Days" />
                <asp:BoundField DataField="Room" HeaderText="Room" SortExpression="Room" />
                <asp:BoundField DataField="StartDate" HeaderText="StartDate" SortExpression="StartDate" />
                <asp:BoundField DataField="User" HeaderText="User" SortExpression="User" />
                <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
                <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                <asp:BoundField DataField="Instructor" HeaderText="Instructor" SortExpression="Instructor" />
                <asp:BoundField DataField="Section" HeaderText="Section" SortExpression="Section" />
                <asp:BoundField DataField="EndDate" HeaderText="EndDate" SortExpression="EndDate" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="Black" HorizontalAlign="Center" BackColor="#999999" />
            <PagerTemplate>
                <br />
            </PagerTemplate>
            <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#0000A9" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#000065" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Events]" 
            DeleteCommand="DELETE FROM [Events] WHERE [event_id] = @original_event_id AND (([Title] = @original_Title) OR ([Title] IS NULL AND @original_Title IS NULL)) AND [EventStart] = @original_EventStart AND [EventEnd] = @original_EventEnd AND [Repeat] = @original_Repeat AND [Days] = @original_Days AND [Room] = @original_Room AND [StartDate] = @original_StartDate AND (([User] = @original_User) OR ([User] IS NULL AND @original_User IS NULL)) AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL)) AND (([Type] = @original_Type) OR ([Type] IS NULL AND @original_Type IS NULL)) AND (([Instructor] = @original_Instructor) OR ([Instructor] IS NULL AND @original_Instructor IS NULL)) AND (([Section] = @original_Section) OR ([Section] IS NULL AND @original_Section IS NULL)) AND (([EndDate] = @original_EndDate) OR ([EndDate] IS NULL AND @original_EndDate IS NULL))"
            ConflictDetection="CompareAllValues" InsertCommand="INSERT INTO [Events] ([Title], [EventStart], [EventEnd], [Repeat], [Days], [Room], [StartDate], [User], [Notes], [Type], [Instructor], [Section], [EndDate]) VALUES (@Title, @EventStart, @EventEnd, @Repeat, @Days, @Room, @StartDate, @User, @Notes, @Type, @Instructor, @Section, @EndDate)" 
            OldValuesParameterFormatString="original_{0}" 
            UpdateCommand="UPDATE [Events] SET [Title] = @Title, [EventStart] = @EventStart, [EventEnd] = @EventEnd, [Repeat] = @Repeat, [Days] = @Days, [Room] = @Room, [StartDate] = @StartDate, [User] = @User, [Notes] = @Notes, [Type] = @Type, [Instructor] = @Instructor, [Section] = @Section, [EndDate] = @EndDate WHERE [event_id] = @original_event_id AND (([Title] = @original_Title) OR ([Title] IS NULL AND @original_Title IS NULL)) AND [EventStart] = @original_EventStart AND [EventEnd] = @original_EventEnd AND [Repeat] = @original_Repeat AND [Days] = @original_Days AND [Room] = @original_Room AND [StartDate] = @original_StartDate AND (([User] = @original_User) OR ([User] IS NULL AND @original_User IS NULL)) AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL)) AND (([Type] = @original_Type) OR ([Type] IS NULL AND @original_Type IS NULL)) AND (([Instructor] = @original_Instructor) OR ([Instructor] IS NULL AND @original_Instructor IS NULL)) AND (([Section] = @original_Section) OR ([Section] IS NULL AND @original_Section IS NULL)) AND (([EndDate] = @original_EndDate) OR ([EndDate] IS NULL AND @original_EndDate IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_event_id" Type="Int32" />
                <asp:Parameter Name="original_Title" Type="String" />
                <asp:Parameter DbType="Time" Name="original_EventStart" />
                <asp:Parameter DbType="Time" Name="original_EventEnd" />
                <asp:Parameter Name="original_Repeat" Type="Int32" />
                <asp:Parameter Name="original_Days" Type="String" />
                <asp:Parameter Name="original_Room" Type="String" />
                <asp:Parameter DbType="Date" Name="original_StartDate" />
                <asp:Parameter Name="original_User" Type="String" />
                <asp:Parameter Name="original_Notes" Type="String" />
                <asp:Parameter Name="original_Type" Type="String" />
                <asp:Parameter Name="original_Instructor" Type="String" />
                <asp:Parameter Name="original_Section" Type="String" />
                <asp:Parameter DbType="Date" Name="original_EndDate" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter DbType="Time" Name="EventStart" />
                <asp:Parameter DbType="Time" Name="EventEnd" />
                <asp:Parameter Name="Repeat" Type="Int32" />
                <asp:Parameter Name="Days" Type="String" />
                <asp:Parameter Name="Room" Type="String" />
                <asp:Parameter DbType="Date" Name="StartDate" />
                <asp:Parameter Name="User" Type="String" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Type" Type="String" />
                <asp:Parameter Name="Instructor" Type="String" />
                <asp:Parameter Name="Section" Type="String" />
                <asp:Parameter DbType="Date" Name="EndDate" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter DbType="Time" Name="EventStart" />
                <asp:Parameter DbType="Time" Name="EventEnd" />
                <asp:Parameter Name="Repeat" Type="Int32" />
                <asp:Parameter Name="Days" Type="String" />
                <asp:Parameter Name="Room" Type="String" />
                <asp:Parameter DbType="Date" Name="StartDate" />
                <asp:Parameter Name="User" Type="String" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Type" Type="String" />
                <asp:Parameter Name="Instructor" Type="String" />
                <asp:Parameter Name="Section" Type="String" />
                <asp:Parameter DbType="Date" Name="EndDate" />
                <asp:Parameter Name="original_event_id" Type="Int32" />
                <asp:Parameter Name="original_Title" Type="String" />
                <asp:Parameter DbType="Time" Name="original_EventStart" />
                <asp:Parameter DbType="Time" Name="original_EventEnd" />
                <asp:Parameter Name="original_Repeat" Type="Int32" />
                <asp:Parameter Name="original_Days" Type="String" />
                <asp:Parameter Name="original_Room" Type="String" />
                <asp:Parameter DbType="Date" Name="original_StartDate" />
                <asp:Parameter Name="original_User" Type="String" />
                <asp:Parameter Name="original_Notes" Type="String" />
                <asp:Parameter Name="original_Type" Type="String" />
                <asp:Parameter Name="original_Instructor" Type="String" />
                <asp:Parameter Name="original_Section" Type="String" />
                <asp:Parameter DbType="Date" Name="original_EndDate" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    </form>
    <br />
    <a href="ScheduleEvents.aspx">Back</a>
</body>
</html>
