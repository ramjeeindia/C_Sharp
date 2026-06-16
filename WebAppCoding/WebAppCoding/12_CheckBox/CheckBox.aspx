<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckBox.aspx.cs" Inherits="WebAppCoding._12_CheckBox.CheckBox" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>    
        <fieldset style="width:300px">
        <legend><b>Education Level</b></legend>
        <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="CheckBox1_CheckedChanged" Text="Graduate" />
        <asp:CheckBox ID="PostGraduateCheckBox" Text="Post Graduate" runat="server" />
        <asp:CheckBox ID="DoctorateCheckBox" Text="Doctorate" runat="server" />
    </fieldset>
</div>
<p>
    <asp:Button ID="Button1" runat="server" Text="Button" Font-Bold="True" OnClick="Button1_Click"/>
</p>
    </form>
</body>
</html>
