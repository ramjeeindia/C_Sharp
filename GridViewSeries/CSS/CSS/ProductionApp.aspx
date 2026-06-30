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
            justify-content: center;
            position: relative;
            padding: 10px 10px;
            background: linear-gradient(to right, #7b2ff7, #9b3bff);
            color: white;
            border-radius: 4px;
        }

            .header img {
                position: absolute;
                left: 20px;
                height: 45px;
                width: auto;
                background: #c6dfe9;
                padding: 3px;
            }

        .header-title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
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
            text-align:center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 5px;
            text-align:center;
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
        .numeric-input {
            text-align: center;
        }
        
    </style>
    <script>
        function fillTarget() {

            var cycle = document.getElementById('<%= txtCycleTime.ClientID %>').value;

            if (cycle === "" || parseFloat(cycle) <= 0)
                return;

            // Target column inputs (inside repeater)
            var targets = document.querySelectorAll("[id*='txtTarget']");

            targets.forEach(function (txt) {
                txt.value = cycle;
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
                        <asp:DropDownList ID="ddlshift" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlShift_SelectedIndexChanged">
                            <asp:ListItem Value="G" Text="General"></asp:ListItem>
                            <asp:ListItem Value="A" Text="A Shift"></asp:ListItem>
                            <asp:ListItem Value="B" Text="B Shift"></asp:ListItem>
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
                        <asp:TextBox ID="txtCycleTime" placeholder="Fill Cycle Time" AutoPostBack="true" 
                            CssClass="form-control" onkeyup="fillTarget()" runat="server" OnTextChanged="txtCycleTime_TextChanged"></asp:TextBox>

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

                <button class="btn vw-btn" hidden="hidden">📊 View Report</button>
                <button class="btn get-btn">📥 Get Saved Data</button>

            </div>
        </div>
        <asp:Repeater ID="rptProduction" runat="server">
            <HeaderTemplate>
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
            </HeaderTemplate>

            <ItemTemplate>
                <tr>
                    <td><%# Eval("TimeRange") %></td>

                    <td>
                        <asp:TextBox ID="txtTarget" TextMode="Number" ReadOnly="true" color="green" runat="server" CssClass="form-control numeric-input"
                            style="background-color:#28a745; color: white; text-align: center; font-weight: 600;"/></td>
                    <td>
                        <asp:TextBox ID="txtActual" TextMode="Number" runat="server" CssClass="form-control numeric-input" /></td>
                    <td>
                        <asp:TextBox ID="txtReject" TextMode="Number" runat="server"
                            style="color:#fc1111; text-align: center; font-weight: 600;"
                            CssClass="form-control numeric-input" /></td>
                    <td>
                        <asp:TextBox ID="txtRework" TextMode="Number" runat="server" CssClass="form-control numeric-input" /></td>
                    <td>
                        <asp:TextBox ID="txtDownTime" TextMode="Number" runat="server" CssClass="form-control numeric-input" /></td>

                    <td>
                        <asp:DropDownList ID="ddlRemark" runat="server">
                            <asp:ListItem Text="--Select--" Value="" />
                            <asp:ListItem Text="OK" Value="OK" />
                            <asp:ListItem Text="Issue" Value="Issue" />
                            <asp:ListItem Text="Machine Down" Value="Machine Down" />
                        </asp:DropDownList>
                    </td>
                </tr>
            </ItemTemplate>

            <FooterTemplate>
                </tbody>
        </table>
   
            </FooterTemplate>
        </asp:Repeater>
    </form>
</body>
</html>
