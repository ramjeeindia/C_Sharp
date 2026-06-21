<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataGrid.aspx.cs" Inherits="DataGrid._1_DataGrid.DataGrid" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SBODemoINConnectionString %>" SelectCommand="SELECT [ItmsGrpCod], [ItmsGrpNam], [Locked] FROM [OITB]"></asp:SqlDataSource>
        </div>
        <asp:DataGrid ID="DataGrid1" runat="server" DataSourceID="SqlDataSource1">
        </asp:DataGrid>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ItmsGrpCod" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="ItmsGrpCod" HeaderText="ItmsGrpCod" ReadOnly="True" SortExpression="ItmsGrpCod" />
                <asp:BoundField DataField="ItmsGrpNam" HeaderText="ItmsGrpNam" SortExpression="ItmsGrpNam" />
                <asp:BoundField DataField="Locked" HeaderText="Locked" SortExpression="Locked" />
            </Columns>
        </asp:GridView>
        <br />
    </form>
</body>
</html>
