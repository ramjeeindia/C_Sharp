<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="databinddropdown.aspx.cs" Inherits="WebAppCoding._17_DataBindDropDown.databinddropdown" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DropDownList ID="DropDownList1" runat="server"
                DataTextField="ItemName"
                DataValueField="ItemCode"
                OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
    </form>
</body>
</html>
