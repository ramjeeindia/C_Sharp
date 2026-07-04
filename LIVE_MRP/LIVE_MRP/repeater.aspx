<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="repeater.aspx.cs" Inherits="LIVE_MRP.repeater" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hourly Production Sheet</title>

    <style>
        body {
            font-family: 'Segoe UI';
            background: #e6f0f5;
            margin: 20px;
        }

        .header-bar {
            background: linear-gradient(90deg, #7b2ff7, #00c6ff);
            color: white;
            padding: 10px;
            font-size: 22px;
            text-align: center;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .container-box {
            background: #fff;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 10px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 12px;
        }

        .form-group {
            flex: 1;
            display: flex;
            align-items: center; /* vertical alignment */
        }

        .input-box {
            flex: 1; /* take remaining space */
            height: 38px;
            border-radius: 6px;
            border: 1px solid #ccc;
            padding: 6px 10px;
            box-sizing: border-box;
        }

        .form-group label {
            width: 150px;
            font-weight: 600;
        }

        .button-group {
            display: flex;
            gap: 10px;
            justify-content: left;
        }

        .btn-save {
            background: #00c853;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            width: 200px;
        }

        .btn-get {
            background: #ff6a00;
            color: #fff;
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
            font-weight: bold;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        .num-box {
            width: 90%;
            height: 34px;
            text-align: center;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .remarks-ddl {
            width: 160px;
            height: 34px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        td:first-child {
            white-space: nowrap;
            width: 160px;
            font-weight: 500;
        }

        table th {
            background: #4e73df;
            color: white;
            padding: 10px;
            text-align: center;
            overflow-x: auto;
        }

        table td {
            padding: 5px;
            text-align: center;
            overflow-x: auto;
        }

        .form-control {
            width: 90%;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            text-align: center;
        }

        @media (max-width: 768px) {

            .form-row {
                flex-direction: column; /* stack rows */
                gap: 10px;
            }

            .form-group {
                flex-direction: column; /* label on top */
                align-items: flex-start;
            }

                .form-group label {
                    width: 100%;
                    margin-bottom: 5px;
                }

            .input-box {
                width: 100%;
            }

            .btn-save {
                width: 100%;
            }

            .remarks-ddl {
                width: 100%;
            }
        }
    </style>

    <script>
        function calculateTarget() {

            var cycleTimeBox = document.getElementById('<%= txtCycleTime.ClientID %>');
            if (!cycleTimeBox) return;

            var cycleTime = parseFloat(cycleTimeBox.value);

            var target = 0;

            if (cycleTime && cycleTime > 0) {
                target = Math.floor(3600 / cycleTime);
            }

            // Fill all target boxes
            document.querySelectorAll(".target-box").forEach(function (el) {
                el.value = target;
            });
        }

        // 🔥 AUTO RUN AFTER POSTBACK (IMPORTANT)
        window.onload = function () {
            calculateTarget();
        };

        // ⏰ DIGITAL CLOCK
        function updateClock() {
            var now = new Date();

            var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
            var months = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"];

            var dayName = days[now.getDay()];
            var date = now.getDate();
            var month = months[now.getMonth()];
            var year = now.getFullYear();

            var hours = now.getHours();
            var minutes = now.getMinutes();
            var seconds = now.getSeconds();

            // 12-hour format
            var ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12;

            // Leading zero
            hours = hours < 10 ? "0" + hours : hours;
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            var timeString = hours + ":" + minutes + ":" + seconds + " " + ampm;

            var fullString = date + " " + month + " " + year +
                " | " + dayName + "<br/>" + timeString;

            document.getElementById("digitalClock").innerHTML = fullString;
        }

        // Run every second
        setInterval(updateClock, 1000);
        updateClock();
    </script>


</head>

<body>
    <form id="form1" runat="server">

        <!-- HEADER -->
        <div class="header-bar">
            Hourly Production Sheet
        </div>

        <!-- TOP FORM -->
        <div class="container-box">

            <div class="form-row">
                <div class="form-group">
                    <label>Production Date</label>
                    <asp:TextBox ID="txtDate" type="date" runat="server" CssClass="input-box" TextMode="Date" OnTextChanged="txtDate_TextChanged" />
                    <script>
                        document.getElementById("txtDate").value = new Date().toISOString().split('T')[0];
                    </script>
                </div>

                <div class="form-group">
                    <label>Shift</label>
                    <asp:DropDownList ID="ddlShift" runat="server" AutoPostBack="true" CssClass="input-box" OnSelectedIndexChanged="ddlShift_SelectedIndexChanged">
                        <asp:ListItem Text="General" Value="General" />
                        <asp:ListItem Text="Shift A" Value="A" />
                        <asp:ListItem Text="Shift B" Value="B" />
                    </asp:DropDownList>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Machine Name</label>
                    <asp:DropDownList ID="ddlMachine" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlMachine_SelectedIndexChanged" CssClass="input-box" />
                </div>

                <div class="form-group">
                    <label>Process Name</label>
                    <asp:DropDownList ID="ddlProcess" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlProcess_SelectedIndexChanged" CssClass="input-box" />
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Cycle Time / Part</label>
                    <asp:TextBox ID="txtCycleTime" CssClass="input-box target-box" TextMode="Number" min="0" runat="server"
                        placeholder="एक पार्ट का साइकिल समय सेकंड में भरें"
                        ToolTip="एक पार्ट का साइकिल समय सेकंड में भरें"
                        OnTextChanged="txtCycleTime_TextChanged" onkeyup="calculateTarget()"></asp:TextBox>

                </div>

                <div class="form-group">

                    <label>Operator Name</label>
                    <asp:DropDownList ID="ddlOperator" runat="server"
                        CssClass="input-box" OnSelectedIndexChanged="ddlOperator_SelectedIndexChanged" />

                </div>

            </div>
            <div class="button-group">
                <asp:Button ID="btnSave" runat="server" Text="💾 Save" CssClass="btn-save" OnClick="btnSave_Click" ToolTip="हर घंटे सेव करें" />

                <asp:DropDownList ID="DdlOT" runat="server" AutoPostBack="true"
                    Style="background-color: #000000; color: #e6f0f5; padding: 6px; border-radius: 5px; text-align: left; font-weight: bold;"
                    ToolTip="ओवरटाइम का चयन करें" OnSelectedIndexChanged="DdlOT_SelectedIndexChanged">
                    <asp:ListItem Text="⏱️ Add Overtime" Value="0" />
                    <asp:ListItem Text=" OT-1 Hour" Value="1" />
                    <asp:ListItem Text=" OT-2 Hours" Value="2" />
                    <asp:ListItem Text=" OT-3 Hours" Value="3" />
                    <asp:ListItem Text=" OT-4 Hours" Value="4" />
                </asp:DropDownList>

                <div id="digitalClock" style="font-size: 14px; padding-left: 15px; padding-right: 15px; font-weight: bold; background: #57efd8; display:border-box; width: auto; border-radius: 6px; text-align: center;">
                </div>

                <asp:Button ID="GetData" runat="server" Text="📥 Get Saved Data" CssClass="btn-get" />
            </div>
        </div>

        <!-- TABLE -->
        <table>
            <thead>
                <tr>
                    <th>Time Slot (Hrs)</th>
                    <th>Target लक्ष्य संख्या</th>
                    <th>Actual वास्तविक संख्या</th>
                    <th>Reject अस्वीकृत</th>
                    <th>Rework पुनर्निर्माण</th>
                    <th>DownTime(मिनट)</th>
                    <th>Remarks</th>
                </tr>
            </thead>

            <tbody>
                <asp:Repeater ID="rptProduction" runat="server">
                    <ItemTemplate>
                        <tr>
                            <!-- ✅ Time Slot -->
                            <td>
                                <%# Eval("TimeSlot") %>
                                <asp:HiddenField ID="hdnTime" runat="server"
                                    Value='<%# Eval("TimeSlot") %>' />
                            </td>

                            <!-- Target -->
                            <td>
                                <asp:TextBox ID="txtTarget" runat="server"
                                    CssClass="num-box target-box" TextMode="Number" min="0" ReadOnly="true"
                                    Style="background: linear-gradient(90deg, #57efd8,#ffffff);" />
                            </td>

                            <!-- Actual -->
                            <td>
                                <asp:TextBox ID="txtActual" runat="server"
                                    CssClass="num-box" TextMode="Number" min="0"
                                     />
                            </td>

                            <!-- Reject -->
                            <td>
                                <asp:TextBox ID="txtReject" runat="server"
                                    CssClass="num-box" ForeColor="Red"
                                    TextMode="Number" min="0" Style="background: linear-gradient(90deg, #f2d2d2,#ffffff);"
                                    />
                            </td>

                            <!-- Rework -->
                            <td>
                                <asp:TextBox ID="txtRework" runat="server"
                                    CssClass="num-box" TextMode="Number" min="0"
                                    />
                            </td>

                            <!-- DownTime -->
                            <td>
                                <asp:TextBox ID="txtDownTime" runat="server"
                                    CssClass="num-box"
                                    TextMode="Number"
                                    min="0" max="60"
                                    placeholder="डाउनटाइम"
                                    oninput="if(this.value > 60) this.value = 60;"
                                    onkeydown="if(event.key === '-' || event.key === 'e') return false;" />
                            </td>

                            <!-- Remarks -->
                            <td>
                                <asp:DropDownList ID="ddlRemarks" runat="server"
                                    CssClass="remarks-ddl">
                                    <asp:ListItem Text="--Select--" Value="" />
                                    <asp:ListItem Text="Tea Break" Value="Tea" />
                                    <asp:ListItem Text="Lunch Break" Value="Lunch" />
                                    <asp:ListItem Text="Model Change" Value="Model" />
                                    <asp:ListItem Text="Operator Change" Value="Operator" />
                                    <asp:ListItem Text="HR/Admin Activity" Value="Admin" />
                                    <asp:ListItem Text="Machine Breakdown" Value="Breakdown" />
                                    <asp:ListItem Text="Under Maintenance" Value="Maintenance" />
                                    <asp:ListItem Text="Material Shortage" Value="Material" />
                                    <asp:ListItem Text="Trial Runs" Value="Trial" />
                                </asp:DropDownList>
                            </td>

                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

    </form>
</body>
</html>
