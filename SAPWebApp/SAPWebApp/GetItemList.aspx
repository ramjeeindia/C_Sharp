<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetItemList.aspx.cs" Inherits="SAPWebApp.GetItemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Get All Item List</title>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');
        html{
            width:auto;
            background-color:#b4e9cd;
            font-family: "Poppins", sans-serif;
            font-weight: 400;
            font-style: normal
        }
        .find-section{
            padding:10px;

        }

        .find_btn.hover{
            background-color:#58d02e;

        }
        .find_place{
            background-color:#faf6f6;

        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
             <div class="find-section">
            <asp:TextBox ID="TextBox1" Class="find_place" placeholder="Type Item Name"  runat="server"></asp:TextBox>
            <asp:Button ID="btngetitm" Class="find_btn" runat="server" OnClick="btngetitm_Click" Text="Get Item List" />
             <br />
            </div>
        <asp:GridView ID="GridView1" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2">
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FFF1D4" />
            <SortedAscendingHeaderStyle BackColor="#B95C30" />
            <SortedDescendingCellStyle BackColor="#F1E5CE" />
            <SortedDescendingHeaderStyle BackColor="#93451F" />
        </asp:GridView>
    </form>
</body>
</html>
