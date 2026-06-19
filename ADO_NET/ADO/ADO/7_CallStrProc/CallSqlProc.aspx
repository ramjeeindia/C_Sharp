<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CallSqlProc.aspx.cs" Inherits="ADO._7_CallStrProc.CallSqlProc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <table>
           <tr>
               <td>Employee Name</td>
               <td><asp:TextBox ID="txtempname" runat="server"></asp:TextBox></td>
           </tr>
           <tr>
               <td>Gender</td>
               <td>
                   <asp:DropDownList ID="ddlGender" runat="server">
                   <asp:ListItem Value="1">Male</asp:ListItem>
                   <asp:ListItem Value="2">Female</asp:ListItem>
                   <asp:ListItem Value="3">Other</asp:ListItem>
                   </asp:DropDownList>
                </td>
           </tr>
           <tr>
               <td>Salary</td>
               <td><asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
           </tr>
           <tr>
               <td><asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" /></td>
           </tr>
           <tr>
               <td><asp:Label ID="lblmessage" runat="server" Text="Message"></asp:Label></td>
           </tr>
           
       </table>
    </form>
</body>
</html>
