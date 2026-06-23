<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="demo.aspx.cs" Inherits="HourlyProd.demo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>>Hourly Production Sheet</title>
<style>
        body { background:#82b0c2; font-family:Arial; }
        .container { width:90%; margin:auto; background:#fff; padding:20px; border-radius:10px; }
        table { width:100%; border-collapse:collapse; }
        th { background:#007acc; color:#fff; padding:6px; }
        td { border:1px solid #ccc; padding:5px; text-align:center; }
        input, select { width:95%; padding:5px; }
        caption { font-size:22px; font-weight:bold; border:2px dotted red; padding:10px; }
    </style>

</head>

<body>
<form id="form1" runat="server">

<div class="container">

<table>
<caption>Hourly Production Sheet</caption>

<tr>
<td>Production Date</td>
<td><asp:TextBox ID="txtProdDate" runat="server" TextMode="Date" OnTextChanged="txtProdDate_TextChanged"/></td>

<td>Shift</td>
<td>
<asp:DropDownList ID="ddlShift" runat="server" OnSelectedIndexChanged="ddlShift_SelectedIndexChanged">
    <asp:ListItem>General</asp:ListItem>
    <asp:ListItem>Morning</asp:ListItem>
</asp:DropDownList>
</td>
</tr>

<tr>
<td>Machine</td>
<td><asp:DropDownList ID="ddlMachine" runat="server" OnSelectedIndexChanged="ddlMachine_SelectedIndexChanged"></asp:DropDownList></td>

<td>Operator</td>
<td><asp:DropDownList ID="ddlOperator" runat="server" OnSelectedIndexChanged="ddlOperator_SelectedIndexChanged"></asp:DropDownList></td>
</tr>

<tr>
<td>Process</td>
<td><asp:DropDownList ID="ddlProcess" runat="server" OnSelectedIndexChanged="ddlProcess_SelectedIndexChanged"></asp:DropDownList></td>

<td>Cycle Time</td>
<td><asp:TextBox ID="txtCycleTime" runat="server" OnTextChanged="txtCycleTime_TextChanged" /></td>
</tr>

</table>

<br />

<asp:GridView ID="gvProd" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvProd_RowDataBound">
    <Columns>

        <asp:BoundField DataField="TimeSlot" HeaderText="Time" />

        <asp:TemplateField HeaderText="Target">
            <ItemTemplate>
                <asp:TextBox ID="txtTarget" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Actual">
            <ItemTemplate>
                <asp:TextBox ID="txtActual" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Reject">
            <ItemTemplate>
                <asp:TextBox ID="txtReject" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Rework">
            <ItemTemplate>
                <asp:TextBox ID="txtRework" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Remarks">
            <ItemTemplate>
                <asp:DropDownList ID="ddlRemark" runat="server"></asp:DropDownList>
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>

<br />

<asp:Button ID="btnFillTarget" runat="server" Text="Fill Target" OnClick="btnFillTarget_Click" />
<asp:Button ID="btnSave" runat="server" Text="Save" BackColor="Lime" OnClick="btnSave_Click" OnLoad="btnSave_Load" />

</div>

</form>
</body>
</html>