<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HourlyProd.aspx.cs" Inherits="ADO.HourlyProd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="height: 259px">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblOpName" runat="server" Text="Operator Name"></asp:Label>
            <asp:TextBox ID="txtOName" runat="server" style="margin-left: 11px" Width="150px" Height="16px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="Production Date"></asp:Label>
            <asp:TextBox ID="txtDate" runat="server" style="margin-left: 54px"  Width="100px" Height="16px"></asp:TextBox>
            <br />            
            <asp:Label ID="lblmach" runat="server" Text="Machine Name"></asp:Label>
            <asp:TextBox ID="txtmach" runat="server" style="margin-left: 11px" Width="150px" Height="16px"></asp:TextBox>
            <br />            
            <asp:Label ID="lblProcess" runat="server" Text="Process Name"></asp:Label>
            <asp:TextBox ID="txtprocess" runat="server" style="margin-left: 18px" Width="150px" Height="16px"></asp:TextBox>
        &nbsp;<asp:Label ID="lblctpsp" runat="server" Text="Cycle Time (Sec./ Pc.)"></asp:Label>
            <asp:TextBox ID="txtprocess0" runat="server" style="margin-left: 11px;" Height="16px" Width="106px"></asp:TextBox>
        </div>
    </form>
</body>
</html>
