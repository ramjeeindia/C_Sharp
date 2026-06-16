<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ButtonControl.aspx.cs" Inherits="WebAppCoding._14_BtnControl.ButtonControl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" Text="Submit" runat="server" 
                    OnClick="Button1_Click"                 
                    OnClientClick=" return confirm ('Are you want to Cancel The Ticket ? ')" />
        </div>
        <p>
            <asp:LinkButton ID="LinkButton1" runat="server"
            OnClientClick="confirm('Who is going to Village Click OK for Saksham and CANCEL For Trisha ?');"
            OnClick="LinkButton1_Click">LinkButton</asp:LinkButton>
        </p>
        <p>
            <asp:ImageButton ID="ImageButton1" runat="server" Height="48px" ImageUrl="~/Images/FINISH_BTN_SMALL.jpg" OnClick="ImageButton1_Click" 
            OnClientClick="alert('You are about to Sumit the Image')" Width="146px" />
        </p>        
    </form>
</body>
</html>
