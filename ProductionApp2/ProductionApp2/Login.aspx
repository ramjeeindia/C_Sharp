<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProductionApp2.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Login</h2>

            <asp:TextBox ID="txtUserName" runat="server" Placeholder="Username" OnTextChanged="txtUserName_TextChanged"></asp:TextBox><br />
            <br />

            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password" OnTextChanged="txtPassword_TextChanged"></asp:TextBox><br />
            <br />

            <asp:CheckBox ID="chkRemember" runat="server" Text="Remember Me" OnCheckedChanged="chkRemember_CheckedChanged" /><br />
            <br />

            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />

            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Cancel" />

        </div>
    </form>
</body>
</html>
