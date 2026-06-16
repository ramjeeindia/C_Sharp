<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TextBox.aspx.cs" Inherits="WebAppCoding._10_TextBox.TextBox" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:TextBox ID="TextBox1" runat="server" BackColor="Blue" Height="16px" OnTextChanged="TextBox1_TextChanged" Rows="1" ToolTip="First Name"></asp:TextBox>
 <br />
 <br />
 <asp:TextBox ID="TextBox2" runat="server" BackColor="#CCFFFF" Height="16px" OnTextChanged="TextBox1_TextChanged" Rows="1" ToolTip="Middle Name"></asp:TextBox>
 <br />
 <br />
 <asp:TextBox ID="TextBox3" runat="server" BackColor="#FF9933" Height="16px" OnTextChanged="TextBox1_TextChanged" Rows="1" ToolTip="Last Name"></asp:TextBox>
 <p>
     <asp:Button ID="Button2" runat="server" ForeColor="Blue" Text="Submit" OnClick="Button1_Click" />
 </p>
        </div>
       
    </form>
</body>
</html>
