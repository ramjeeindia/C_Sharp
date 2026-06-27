﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HProdSheet.aspx.cs" Inherits="HourlyProd.HProdSheet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hourly Production Sheet</title>
    <style>
        .header-title {
            background: linear-gradient(135deg, #2b59c3, #4e73df);
            color: white;
            padding: 15px;
            font-size: 24px;
            text-align: center;
            font-weight: 600;
            border-radius: 8px;
            margin-bottom: 20px;
            letter-spacing: 1px;
        }
        /* FORM GRID */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px 20px;
            margin-bottom: 15px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

            .form-group label {
                font-weight: 600;
                margin-bottom: 5px;
                color: #333;
            }

        body {
            font-family: Arial;
        }

        .container {
            width: 95%;
            margin: 20px auto;
            background: #fff;
            padding: 20px 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        /* INPUTS */
        input, select {
            padding: 8px 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            transition: 0.2s;
            font-size: 14px;
        }

            input:focus, select:focus {
                border-color: #4e73df;
                outline: none;
                box-shadow: 0 0 4px rgba(78,115,223,0.4);
            }

        .btn {
            padding: 8px 18px;
            border-radius: 6px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn-save {
            background: #28a745;
            color: white;
        }

            .btn-save:hover {
                background: #218838;
            }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            border-radius: 8px;
            overflow: hidden;
        }

        /* TABLE HEADER */
        th {
            background: linear-gradient(135deg, #2b59c3, #4e73df);
            color: white;
            padding: 10px;
            font-size: 14px;
        }

        /* TABLE BODY */
        td {
            padding: 8px;
            border-bottom: 1px solid #eee;
            text-align: center;
        }

        /* ROW STRIPES */
        tbody tr:nth-child(even) {
            background: #f8f9fc;
        }

        .time-col {
            font-weight: 600;
            text-align: left;
            white-space: nowrap;
        }

        caption {
            font-size: 22px;
            font-weight: bold;
            padding: 10px;
            margin-bottom: 10px;
            background-color:blueviolet;
        }
        .auto-style1 {
            width: 190px; white-space: nowrap; font-weight: bold;
        }
        .auto-style2 {
            width: 330px;
        }
        .auto-style3 {
            width: 322px;
        }
        .auto-style4 {
            width: 321px;
        }
        .auto-style5 {
            width: 314px;
        }
        .auto-style6 {
            width: 279px;
        }
        .auto-style7 {
            width: 300px;
        }
        .auto-style8 {
            width: 283px;
        }
    </style>
    <script>
        function setTarget() {

            var cycle = document.getElementById('<%= txtCycleTime.ClientID %>').value;

            // Convert to number
            cycle = parseFloat(cycle);

            // Validation
            if (isNaN(cycle) || cycle <= 0) {
                return;
            }

            // Calculate target (1 hour = 3600 sec)
            var target = Math.floor(cycle);

            var targets = [
        '<%= TextBox1.ClientID %>',
        '<%= TextBox5.ClientID %>',
        '<%= TextBox9.ClientID %>',
        '<%= TextBox13.ClientID %>',
        '<%= TextBox17.ClientID %>',
        '<%= TextBox21.ClientID %>',
        '<%= TextBox25.ClientID %>',
        '<%= TextBox29.ClientID %>',
        '<%= TextBox33.ClientID %>',
        '<%= TextBox37.ClientID %>',
        '<%= TextBox41.ClientID %>',
        '<%= TextBox45.ClientID %>',
        '<%= TextBox49.ClientID %>',
        '<%= TextBox53.ClientID %>',
        '<%= TextBox57.ClientID %>',
        '<%= TextBox61.ClientID %>',
                '<%= TextBox65.ClientID %>'
            ];

            targets.forEach(function (id) {
                var el = document.getElementById(id);
                if (el) {
                    el.value = target;

                    // Optional highlight
                    el.style.backgroundColor = "#e7f3ff";
                }
            });
        }


    </script>
</head>
<body style="background-color: rgb(130, 176, 194); text-align: left;">
    <form id="form1" runat="server">
        <div class="container">
            <table class="header-table">
                <caption>Hourly Production Sheet</caption>
                <tr>
                    <td class="auto-style6">Production Date</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="txtProdDate" runat="server" TextMode="Date"
                            OnTextChanged="txtProdDate_TextChanged" ToolTip="Date"></asp:TextBox></td>
                    <td class="auto-style3">Shift</td>
                    <td class="auto-style3">
                        <asp:DropDownList ID="ddlshift" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlshift_SelectedIndexChanged">
                            <asp:ListItem Value="G">General</asp:ListItem>
                            <asp:ListItem Value="A">A Shift</asp:ListItem>
                            <asp:ListItem Value="B">B Shift</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Machine Name</td>
                    <td class="auto-style5">
                        <asp:DropDownList ID="ddlMachine" runat="server"
                            OnSelectedIndexChanged="ddlMachine_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style3">Operator Name</td>
                    <td class="auto-style3">
                        <asp:DropDownList ID="ddlOperator" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlOperator_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Process Name</td>
                    <td class="auto-style5">
                        <asp:DropDownList ID="ddlprocess" runat="server">
                        </asp:DropDownList>

                    </td>
                    <td>Cycle Time</td>
                    <td>
                        <asp:TextBox ID="txtCycleTime"  placeholder="Fill Cycle Time" onkeyup="setTarget()" runat="server" OnTextChanged="txtCycleTime_TextChanged"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:Button ID="Button1" runat="server" Width="127px" Text="Save" BackColor="#00CC00" BorderColor="Blue" BorderStyle="Dotted" OnClick="Button1_Click" />
                    </td>
                </tr>
            </table>
            <table>
                <thead>
                    <tr>
                        <th class="auto-style1">Time (Hrs)</th>
                        <th class="auto-style7">Target</th>
                        <th class="auto-style8">Actual OK</th>
                        <th class="auto-style2">Reject</th>
                        <th class="auto-style2">Rework</th>
                        <th class="auto-style2">Remarks</th>
                    </tr>
                </thead>
                <tbody>
                    <tr id="row1" runat="server">
                        <td class="auto-style1">06:00AM - 07:00 AM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox1" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox2" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox3" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox4" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark1" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row2" runat="server">
                        <td class="auto-style1">07:00AM - 08:00 AM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox5" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox6" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox7" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox8" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark2" runat="server">
                            </asp:DropDownList>
                        </td>

                    </tr>

                    <tr id="row3" runat="server">
                        <td class="auto-style1">08:00AM - 09:00AM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox9" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox10" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox11" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox12" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark3" runat="server"></asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row4" runat="server">
                        <td class="auto-style1">09:00AM - 10:00AM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox13" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox14" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox15" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox16" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark4" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row5" runat="server">
                        <td class="auto-style1">10:00AM - 11:00AM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox17" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox18" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox19" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox20" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark5" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row6" runat="server">
                        <td class="auto-style1">11:00AM - 12:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox21" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox22" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox23" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox24" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark6" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row7" runat="server">
                        <td class="auto-style1">12:00PM - 13:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox25" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox26" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox27" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox28" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark7" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row8" runat="server">
                        <td class="auto-style1">13:00PM - 14:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox29" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox30" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox31" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox32" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark8" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row9" runat="server">
                        <td class="auto-style1">14:00PM - 15:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox33" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox34" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox35" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox36" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark9" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row10" runat="server">
                        <td class="auto-style1">15:00PM - 16:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox37" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox38" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox39" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox40" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark10" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row11" runat="server">
                        <td class="auto-style1">16:00PM - 17:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox41" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox42" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox43" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox44" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark11" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row12" runat="server">
                        <td class="auto-style1">17:00PM - 18:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox45" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox46" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox47" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox48" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark12" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row13" runat="server">
                        <td class="auto-style1">18:00PM - 19:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox49" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox50" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox51" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox52" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark13" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row14" runat="server">
                        <td class="auto-style1">19:00PM - 20:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox53" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox54" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox55" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox56" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark14" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row15" runat="server">
                        <td class="auto-style1">20:00PM - 21:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox57" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox58" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox59" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox60" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark15" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row16" runat="server">
                        <td class="auto-style1">21:00PM - 22:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox61" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox62" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox63" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox64" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark16" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row17" runat="server">
                        <td class="auto-style1">22:00PM - 23:00PM</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TextBox65" runat="server" /></td>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBox66" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox67" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox68" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark17" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                </tbody>
            </table>

        </div>
    </form>
</body>
</html>