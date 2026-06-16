<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DropDown.aspx.cs" Inherits="WebAppCoding._16_DropDown.DropDown" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            <asp:ListItem Value="1">Male</asp:ListItem>
            <asp:ListItem Value="2" 
                enabled="false" 
                Selected ="True" >Female</asp:ListItem>
            </asp:DropDownList>
        </div>
    </form>
</body>
</html>
