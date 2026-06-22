<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductionSheet.aspx.cs" Inherits="ADO._7_CallStrProc.ProductionSheet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hourly Production Sheet</title>
    <style>
    body {
        background-color: #82b0c2;
        font-family: Arial;
    }

    .container {
        width: 90%;
        margin: auto;
        background: #fff;
        padding: 20px;
        border-radius: 10px;

    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 10px;
    }

    caption {
        font-size: 22px;
        font-weight: bold;
        padding: 10px;
        border: 2px dotted red;
        margin-bottom: 10px;
    }

    td, th {
        padding: 5px;
        border: 1px solid #ccc;
        text-align: center;
    }

    th {
        background-color: #007acc;
        color: white;
    }

    input, select {
        width: 95%;
        padding: 5px;
    }

    .header-table td {
        border: none;
        text-align: left;
    }
    .time-col {
      white-space: nowrap;
      font-weight: bold;
    }
    .auto-style1 {
            width: 190px;
            white-space: nowrap; 
            font-weight: bold;
    }
    .auto-style2 {
                       
            width: 184px;
    }
    
    </style>

</head>
<body style="background-color: rgb(130, 176, 194)">
       <form id="form1" runat="server">
            <div class="container">
         <table class="header-table">
            <caption>Hourly Production Sheet</caption>
            <tr>
                <td>Production Date</td>
                <td><asp:TextBox ID="txtProdDate" runat="server"></asp:TextBox></td>

                <td>Operator Name</td>
                <td>
                    <asp:DropDownList ID="ddlOperator" runat="server">
                        <asp:ListItem Value="OP1">Operator1</asp:ListItem>
                        <asp:ListItem Value="OP2">Operator2</asp:ListItem>
                        <asp:ListItem Value="OP3">Operator3</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td>Machine Name</td>
                <td>
                    <asp:DropDownList ID="ddlMachine" runat="server">
                        <asp:ListItem Value="MC1">Machine1</asp:ListItem>
                        <asp:ListItem Value="MC2">Machine2</asp:ListItem>
                        <asp:ListItem Value="MC3">Machine3</asp:ListItem>
                    </asp:DropDownList>
                </td>

                <td>Process Name</td>
                <td><asp:TextBox ID="txtProcess" runat="server"></asp:TextBox></td>
            </tr>

            <tr>
                <td>Cycle Time</td>
                <td> <asp:TextBox ID="txtCycleTime" runat="server"></asp:TextBox></td>

                <td>Click Button to Save</td>
                <td>
                <asp:Button ID="Button1" runat="server" Text="Save" />
                  </td>
            </tr>
        </table>
            <table>
                <thead>
                <tr>
                    <th class="auto-style1">Time (Hrs)</th>
                    <th class="auto-style2">Target</th>
                    <th class="auto-style2">Actual</th>
                    <th class="auto-style2">Reject</th>
                    <th class="auto-style2">Rework</th>
                    
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td class="auto-style1">07:00AM - 08:00 AM</td>
                    <td class="auto-style2"><asp:TextBox ID="txt1" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt2" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt3" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt4" runat="server" /></td>
                
                </tr>

                <tr>
                    <td class="auto-style1">08:00AM - 09:00AM</td>
                    <td class="auto-style2"><asp:TextBox ID="txt5" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt6" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt7" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt8" runat="server" /></td>
                </tr>

                <tr>
                    <td class="auto-style1">09:00AM - 10:00AM</td>
                    <td class="auto-style2"><asp:TextBox ID="txt9" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt10" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt11" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt12" runat="server" /></td>
                </tr>

                <tr>
                    <td class="auto-style1">10:00AM - 11:00AM</td>
                    <td class="auto-style2"><asp:TextBox ID="txt13" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt14" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt15" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt16" runat="server" /></td>
                </tr>

                <tr>
                    <td class="auto-style1">11:00AM - 12:00PM</td>
                    <td class="auto-style2"><asp:TextBox ID="txt17" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt18" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt19" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt20" runat="server" /></td>
                </tr>

                <tr>
                    <td class="auto-style1">12:30PM - 01:30PM</td>
                    <td class="auto-style2"><asp:TextBox ID="txt21" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt22" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt23" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt24" runat="server" /></td>
                </tr>

                <tr>
                    <td class="auto-style1">01:30PM - 02:30PM</td>
                    <td class="auto-style2"><asp:TextBox ID="txt25" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt26" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt27" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt28" runat="server" /></td>
                </tr>

                <tr>
                    <td class="auto-style1">02:30PM - 03:30PM</td>
                    <td class="auto-style2"><asp:TextBox ID="txt29" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt30" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt31" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt32" runat="server" /></td>
                </tr>

                <tr>
                    <td class="auto-style1">03:30PM - 04:30PM</td>
                    <td class="auto-style2"><asp:TextBox ID="txt33" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt34" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt35" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt36" runat="server" /></td>
                </tr>

                <tr>
                    <td class="auto-style1">04:30PM - 05:30PM</td>
                    <td class="auto-style2"><asp:TextBox ID="txt37" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt38" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt39" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="txt40" runat="server" /></td>
                </tr>
                <tr>
                    <td class="auto-style1">05:30PM - 06:30PM</td>
                    <td class="auto-style2"><asp:TextBox ID="TextBox41" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="TextBox42" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="TextBox43" runat="server" /></td>
                    <td class="auto-style2"><asp:TextBox ID="TextBox44" runat="server" /></td>
                </tr>
            </tbody>
        </table>

                </div>
    </form>
</body>
</html>
