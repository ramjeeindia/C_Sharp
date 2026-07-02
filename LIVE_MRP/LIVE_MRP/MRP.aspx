<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MRP.aspx.cs" Inherits="LIVE_MRP.MRP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
        </div>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="AddinSql"/>
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="DELTHENINSERT" />
    </form>
</body>
</html>
