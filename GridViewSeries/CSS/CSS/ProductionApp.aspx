<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductionApp.aspx.cs" Inherits="CSS.ProductionApp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Production Sheet</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #c6dfe9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }


        .header {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
            color: white;
            height: 82px;
        }

            .header img {
                height: 40px;
                background-color: aliceblue;
                width: 150px;
            }

        .header-title {
            flex: 1;
            text-align: center;
            font-size: 24px;
            font-weight: 600;
        }

        .main {
            display: flex;
            gap: 15px;
            padding: 15px;
        }

        .left-panel {
            flex: 2;
            background: #fff;
            padding: 15px;
            border-radius: 6px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px 20px;
            margin-bottom: 20px;
        }

        label {
            font-size: 14px;
            font-weight: 600;
        }

        .btn {
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-bottom: 20px;
        }

        .save-btn {
            background: #28a745;
            padding: 10px 60px;
        }

        .get-btn {
            background: #007bff;
        }

        .OT-btn {
            background: #000000;
            color: #ffffff;
        }

        .vw-btn {
            background: #06fc13;
            color: #000000;
        }
        /* MOBILE RESPONSIVE */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 8px;
                text-align: center;
            }
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 5px;
        }

        thead {
            background: linear-gradient(to right, #3b5bbb, #5f7de0);
            color: white;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        tbody tr:nth-child(even) {
            background: #f2f2f2;
        }

        td input {
            width: 90%;
            padding: 5px;
        }

        tfoot {
            background: #ddd;
            font-weight: bold;
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
            background-color: blueviolet;
        }

        .auto-style1 {
            width: 190px;
            white-space: nowrap;
            font-weight: bold;
        }

        .auto-style2 {
            width: 330px;
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
<body>
    <form id="form1" runat="server">

        <div class="header">
            <img src="Sabohema Logo.jpg" />
            <div class="header-title">Hourly Production Sheet</div>
        </div>
        <%--    Header Level Field--%>
        <div class="main">
            <div class="left-panel">

                <!-- FORM -->
                <div class="form-grid">
                    <div>
                        <label>Production Date</label>
                        <asp:TextBox ID="txtProdDate" runat="server" TextMode="Date"
                            OnTextChanged="txtProdDate_TextChanged" ToolTip="Date"></asp:TextBox>
                    </div>

                    <div>
                        <label>Shift</label>
                        <asp:DropDownList ID="ddlshift" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlshift_SelectedIndexChanged">
                            <asp:ListItem Value="G">General</asp:ListItem>
                            <asp:ListItem Value="A">A Shift</asp:ListItem>
                            <asp:ListItem Value="B">B Shift</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Machine Name</label>
                        <asp:DropDownList ID="ddlMachine" runat="server"
                            OnSelectedIndexChanged="ddlMachine_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Operator Name</label>
                        <asp:DropDownList ID="ddlprocess" runat="server" OnSelectedIndexChanged="ddlprocess_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Process Name</label>
                        <asp:DropDownList ID="ddlOperator" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlOperator_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Cycle Time</label>
                        <asp:TextBox ID="txtCycleTime" placeholder="Fill Cycle Time" onkeyup="setTarget()" runat="server" OnTextChanged="txtCycleTime_TextChanged"></asp:TextBox>

                    </div>
                </div>

                <button class="btn save-btn">💾 Save</button>
                <select onchange="addOT(this.value)" class="btn OT-btn">
                    <option value="">⏱️ Add Overtime</option>
                    <option value="1">1 Hour OT</option>
                    <option value="2">2 Hours OT</option>
                    <option value="3">3 Hours OT</option>
                    <option value="4">4 Hours OT</option>
                </select>

                <button class="btn vw-btn">📊 View Report</button>
                <button class="btn get-btn">📥 Get Saved Data</button>

            </div>
        </div>
        <!-- TABLE -->
        <div class="table-container">
            <table id="prodTable">
                <thead>
                    <tr>
                        <th>Time (Hrs)</th>
                        <th>Target</th>
                        <th>Actual OK</th>
                        <th>Reject</th>
                        <th>Rework</th>
                        <th>DownTime</th>
                        <th>Remarks</th>
                    </tr>
                </thead>

                <tbody>
                    <tr id="row1" runat="server">
                        <td class="auto-style1">06:00AM - 07:00 AM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox1" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox2" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox3" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox4" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox5" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark1" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row2" runat="server">
                        <td class="auto-style1">07:00AM - 08:00 AM</td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox6" runat="server" /></td>
                        <td class="auto-style2"><asp:TextBox ID="TextBox7" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox8" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox9" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox10" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark2" runat="server">
                            </asp:DropDownList>
                        </td>

                    </tr>

                    <tr id="row3" runat="server">
                        <td class="auto-style1">08:00AM - 09:00AM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox11" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox12" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox13" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox14" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox15" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark3" runat="server"></asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row4" runat="server">
                        <td class="auto-style1">09:00AM - 10:00AM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox16" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox17" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox18" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox19" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox20" runat="server" /></td>
                        <td>
                            <asp:DropDownList ID="ddlRemark4" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row5" runat="server">
                        <td class="auto-style1">10:00AM - 11:00AM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox21" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox22" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox23" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox24" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox25" runat="server" /></td>
                        <td>
                            <asp:DropDownList ID="ddlRemark5" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row6" runat="server">
                        <td class="auto-style1">11:00AM - 12:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox26" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox27" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox28" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox29" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox30" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark6" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row7" runat="server">
                        <td class="auto-style1">12:00PM - 13:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox31" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox32" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox33" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox34" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox35" runat="server" /></td>
                        <td>
                            <asp:DropDownList ID="ddlRemark7" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row8" runat="server">
                        <td class="auto-style1">13:00PM - 14:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox36" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox37" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox38" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox39" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox40" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark8" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row9" runat="server">
                        <td class="auto-style1">14:00PM - 15:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox41" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox42" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox43" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox44" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox45" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark9" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row10" runat="server">
                        <td class="auto-style1">15:00PM - 16:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox46" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox47" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox48" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox49" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox50" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark10" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row11" runat="server">
                        <td class="auto-style1">16:00PM - 17:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox51" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox52" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox53" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox54" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox55" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark11" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row12" runat="server">
                        <td class="auto-style1">17:00PM - 18:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox56" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox57" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox58" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox59" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox60" runat="server" /></td>
                        <td>
                            <asp:DropDownList ID="ddlRemark12" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row13" runat="server">
                        <td class="auto-style1">18:00PM - 19:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox61" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox62" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox63" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox64" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox65" runat="server" /></td>
                        <td>
                            <asp:DropDownList ID="ddlRemark13" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row14" runat="server">
                        <td class="auto-style1">19:00PM - 20:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox66" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox67" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox68" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox69" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox70" runat="server" /></td>
                        <td>
                            <asp:DropDownList ID="ddlRemark14" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row15" runat="server">
                        <td class="auto-style1">20:00PM - 21:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox71" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox72" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox73" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox74" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox75" runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark15" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row16" runat="server">
                        <td class="auto-style1">21:00PM - 22:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox76" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox77" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox78" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox79" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox80" runat="server" /></td>
                        <td>
                            <asp:DropDownList ID="ddlRemark16" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row17" runat="server">
                        <td class="auto-style1">22:00PM - 23:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox81" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox82" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox83" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox84" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox85" runat="server" /></td>
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
