<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="GCWE_Scheduler.Employees" %>

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
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 172px;
        }
    </style>  
    <title>Employees</title>
</head>
<body>

    <h2 class="auto-style1"><strong>All Employees</strong></h2>

    <form id="form1" runat="server">
    <div>
    
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id" DataSourceID="SqlDataSource1" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
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
            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#0000A9" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#000065" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [StaffHours]" DeleteCommand="DELETE FROM [StaffHours] WHERE [Id] = @original_Id AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([XT] = @original_XT) OR ([XT] IS NULL AND @original_XT IS NULL)) AND (([Room] = @original_Room) OR ([Room] IS NULL AND @original_Room IS NULL)) AND (([Monday] = @original_Monday) OR ([Monday] IS NULL AND @original_Monday IS NULL)) AND (([Tuesday] = @original_Tuesday) OR ([Tuesday] IS NULL AND @original_Tuesday IS NULL)) AND (([Wednesday] = @original_Wednesday) OR ([Wednesday] IS NULL AND @original_Wednesday IS NULL)) AND (([Thursday] = @original_Thursday) OR ([Thursday] IS NULL AND @original_Thursday IS NULL)) AND (([Friday] = @original_Friday) OR ([Friday] IS NULL AND @original_Friday IS NULL))" ConflictDetection="CompareAllValues" InsertCommand="INSERT INTO [StaffHours] ([FirstName], [LastName], [XT], [Room], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday]) VALUES (@FirstName, @LastName, @XT, @Room, @Monday, @Tuesday, @Wednesday, @Thursday, @Friday)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [StaffHours] SET [FirstName] = @FirstName, [LastName] = @LastName, [XT] = @XT, [Room] = @Room, [Monday] = @Monday, [Tuesday] = @Tuesday, [Wednesday] = @Wednesday, [Thursday] = @Thursday, [Friday] = @Friday WHERE [Id] = @original_Id AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([XT] = @original_XT) OR ([XT] IS NULL AND @original_XT IS NULL)) AND (([Room] = @original_Room) OR ([Room] IS NULL AND @original_Room IS NULL)) AND (([Monday] = @original_Monday) OR ([Monday] IS NULL AND @original_Monday IS NULL)) AND (([Tuesday] = @original_Tuesday) OR ([Tuesday] IS NULL AND @original_Tuesday IS NULL)) AND (([Wednesday] = @original_Wednesday) OR ([Wednesday] IS NULL AND @original_Wednesday IS NULL)) AND (([Thursday] = @original_Thursday) OR ([Thursday] IS NULL AND @original_Thursday IS NULL)) AND (([Friday] = @original_Friday) OR ([Friday] IS NULL AND @original_Friday IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_Id" Type="Int32" />
                <asp:Parameter Name="original_FirstName" Type="String" />
                <asp:Parameter Name="original_LastName" Type="String" />
                <asp:Parameter Name="original_XT" Type="String" />
                <asp:Parameter Name="original_Room" Type="String" />
                <asp:Parameter Name="original_Monday" Type="String" />
                <asp:Parameter Name="original_Tuesday" Type="String" />
                <asp:Parameter Name="original_Wednesday" Type="String" />
                <asp:Parameter Name="original_Thursday" Type="String" />
                <asp:Parameter Name="original_Friday" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="XT" Type="String" />
                <asp:Parameter Name="Room" Type="String" />
                <asp:Parameter Name="Monday" Type="String" />
                <asp:Parameter Name="Tuesday" Type="String" />
                <asp:Parameter Name="Wednesday" Type="String" />
                <asp:Parameter Name="Thursday" Type="String" />
                <asp:Parameter Name="Friday" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="XT" Type="String" />
                <asp:Parameter Name="Room" Type="String" />
                <asp:Parameter Name="Monday" Type="String" />
                <asp:Parameter Name="Tuesday" Type="String" />
                <asp:Parameter Name="Wednesday" Type="String" />
                <asp:Parameter Name="Thursday" Type="String" />
                <asp:Parameter Name="Friday" Type="String" />
                <asp:Parameter Name="original_Id" Type="Int32" />
                <asp:Parameter Name="original_FirstName" Type="String" />
                <asp:Parameter Name="original_LastName" Type="String" />
                <asp:Parameter Name="original_XT" Type="String" />
                <asp:Parameter Name="original_Room" Type="String" />
                <asp:Parameter Name="original_Monday" Type="String" />
                <asp:Parameter Name="original_Tuesday" Type="String" />
                <asp:Parameter Name="original_Wednesday" Type="String" />
                <asp:Parameter Name="original_Thursday" Type="String" />
                <asp:Parameter Name="original_Friday" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
        <br />
        <br />
        <strong>Add Employee:</strong><br />
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">FirstName:</td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">LastName:</td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">XT:</td>
                <td>
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Room:</td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Monday:</td>
                <td>
                    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Tuesday:</td>
                <td>
                    <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Wednesday:</td>
                <td>
                    <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Thursday:</td>
                <td>
                    <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Friday:</td>
                <td>
                    <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td>
                   
                    <asp:Button ID="Button1" runat="server" style="text-align: right" Text="Submit" OnClick="Button1_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input id="Reset1" type="reset" value="reset" /></td>
            </tr>
        </table>
    </form>
    <br />
    <br />
    <a href="ScheduleEvents.aspx">Back</a>

</body>
</html>
