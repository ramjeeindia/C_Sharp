<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HProdSheet.aspx.cs" Inherits="HourlyProd.HProdSheet" %>

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
            width: auto;
        }

        .auto-style3 {
            height: 40px;
        }


        #form1 {
        }
    </style>
    <script>
        function setTarget() {
            var cycle = document.getElementById('<%= txtCycleTime.ClientID %>').value;

            // if empty stop
            if (cycle === "") return;

            // get all target textboxes
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
                '<%= TextBox41.ClientID %>',
                '<%= TextBox45.ClientID %>',
                '<%= TextBox49.ClientID %>',
                '<%= TextBox53.ClientID %>',
                '<%= TextBox57.ClientID %>',
                '<%= TextBox61.ClientID %>',
                '<%= TextBox65.ClientID %>'
            ];

            // fill all targets
            targets.forEach(function (id) {
                document.getElementById(id).value = cycle;
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
                    <td class="auto-style3">Production Date</td>
                    <td class="auto-style3">
                        <asp:TextBox ID="txtProdDate" runat="server" TextMode="Date"
                         OnTextChanged="txtProdDate_TextChanged" ToolTip="Date"></asp:TextBox></td>
                    <td class="auto-style3">Shift</td>
                    <td class="auto-style3">
                        <asp:DropDownList ID="ddlshift" runat="server">
                            <asp:ListItem Value="G">General</asp:ListItem>
                            <asp:ListItem Value="M">Morning</asp:ListItem>
                            <asp:ListItem Value="D">Day</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Machine Name</td>
                    <td>
                        <asp:DropDownList ID="ddlMachine" runat="server"
                            OnSelectedIndexChanged="ddlMachine_SelectedIndexChanged">
                            <%--<asp:ListItem Value="MC1">LASA M/C</asp:ListItem>
                            <asp:ListItem Value="MC2">TASA M/C</asp:ListItem>
                            <asp:ListItem Value="MC3">Bush Pressing M/C</asp:ListItem>
                            <asp:ListItem Value="MC3">Other M/C</asp:ListItem>--%>
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
                    <td>Process Name</td>
                    <td>
                        <asp:DropDownList ID="ddlprocess" runat="server">
                          <%--  <asp:ListItem Value="P1">Welding</asp:ListItem>
                            <asp:ListItem Value="P2">Chipping</asp:ListItem>
                            <asp:ListItem Value="P3">Bush Pressing</asp:ListItem>
                            <asp:ListItem Value="P4">Oil Filing</asp:ListItem>
                            <asp:ListItem Value="P5">Curling</asp:ListItem>
                            <asp:ListItem Value="P6">Packing</asp:ListItem>
                            <asp:ListItem Value="P7">Other</asp:ListItem>--%>
                        </asp:DropDownList>

                    </td>
                    <td>Cycle Time</td>
                    <td>
                        <asp:TextBox ID="txtCycleTime" onkeyup="setTarget()" runat="server" OnTextChanged="txtCycleTime_TextChanged"></asp:TextBox></td>
                    <td>
                        <asp:Button ID="Button1" runat="server" Width="100px" Text="Save" BackColor="#00CC00" BorderColor="Blue" BorderStyle="Dotted" OnClick="Button1_Click" />
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
                        <th class="auto-style2">Remarks</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="auto-style1">06:00AM - 07:00 AM</td>
                             <td class="auto-style2"><asp:TextBox ID="TextBox1" runat="server" /></td>
                             <td class="auto-style2"><asp:TextBox ID="TextBox2" runat="server" /></td>
                             <td class="auto-style2"><asp:TextBox ID="TextBox3" runat="server" /></td>
                             <td class="auto-style2"><asp:TextBox ID="TextBox4" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>


                    </tr>
                    <tr>
                        <td class="auto-style1">07:00AM - 08:00 AM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox5" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox6" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox7" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox8" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>

                    </tr>

                    <tr>
                        <td class="auto-style1">08:00AM - 09:00AM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox9" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox10" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox11" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox12" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1">09:00AM - 10:00AM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox13" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox14" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox15" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox16" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList4" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1">10:00AM - 11:00AM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox17" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox18" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox19" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox20" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList5" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1">11:00AM - 12:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox21" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox22" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox23" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox24" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList6" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1">12:00PM - 01:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox25" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox26" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox27" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox28" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList7" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1">01:00PM - 02:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox29" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox30" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox31" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox32" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList8" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1">02:00PM - 03:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox33" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox34" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox35" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox36" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList9" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1">03:00PM - 04:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox37" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox38" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox39" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox40" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList10" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1">04:00PM - 05:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox41" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox42" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox43" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox44" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList11" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">05:00PM - 06:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox45" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox46" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox47" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox48" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList12" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">06:00PM - 07:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox49" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox50" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox51" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox52" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList13" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">07:00PM - 07:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox53" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox54" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox55" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox56" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList14" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style1">08:00PM - 09:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox57" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox58" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox59" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox60" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList15" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">09:00PM - 10:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox61" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox62" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox63" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox64" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList16" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">10:00PM - 11:00PM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox65" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox66" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox67" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox68" runat="server" /></td>
           
                        <td>
                            <asp:DropDownList ID="DropDownList17" runat="server">
                                <asp:ListItem Value="R1">Electrical</asp:ListItem>
                                <asp:ListItem Value="R2">Model Change</asp:ListItem>
                                <asp:ListItem Value="R3">Material Shortage</asp:ListItem>
                                <asp:ListItem Value="R4">Operator Change</asp:ListItem>
                                <asp:ListItem Value="R5">Tea</asp:ListItem>
                                <asp:ListItem Value="R6">Lunch</asp:ListItem>
                                <asp:ListItem Value="R7">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                </tbody>
            </table>

        </div>
    </form>
</body>
</html>
