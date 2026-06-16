<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RadioButton.aspx.cs" Inherits="WebAppCoding._11_RadioButton.RadioButton" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="height: 68px">
    <form id="form1" runat="server">
        <div style="font-family: Arial; height: 93px; width: 357px;">
            <fieldset style="width:300px">
                <legend style="font-style: italic; color: #FF0000; font-weight: bold;" >Gender</legend>
            <asp:RadioButton ID="MaleRadioButton1" Text = "Male" runat="server" OnCheckedChanged="MaleRadioButton1_CheckedChanged" GroupName="GenderGroup" />
            <asp:RadioButton ID="FemaleRadioButton2" Text = "Female" runat="server" GroupName="GenderGroup" />
            <asp:RadioButton ID="UnknownRadioButton3" Text = "Unknown" runat="server" GroupName="GenderGroup" />
            </fieldset><br />
        <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" BackColor="#00CC99" Font-Bold="True" Font-Size="Large" />
        </div>
    </form>
</body>
</html>
