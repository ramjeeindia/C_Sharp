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
            padding: 8px;
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
            width: 150px;
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
            text-align: center;
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

            var cycleTime = parseFloat(cycleTimeBox.value) || 0;
            if (cycleTime <= 0) return;

            document.querySelectorAll("tbody tr").forEach(function (row) {

                if (row.offsetParent === null) return; // skip hidden rows

                var remark = row.querySelector(".remarks-ddl")?.value;
                var targetBox = row.querySelector(".target-box");
                var downtimeBox = row.querySelector(".downtime");

                var downtime = 0;

                if (remark === "Tea") {
                    downtime = 15;
                } else if (remark === "Lunch" || remark === "Admin") {
                    downtime = 30;
                }

                if (downtimeBox) downtimeBox.value = downtime;

                var availableTime = 3600 - (downtime * 60);
                var target = Math.floor(availableTime / cycleTime);

                if (targetBox) targetBox.value = target;

            });

            // ✅ ONLY HERE total should be calculated
            updateTotalTarget();
        }


        // 🔥 TOTAL CALCULATION (ONLY PLACE)
        function updateTotalTarget() {

            let totalTarget = 0;
            let totalActual = 0;

            document.querySelectorAll("tbody tr").forEach(row => {

                if (row.offsetParent === null) return;

                totalTarget += parseInt(row.querySelector(".target-box")?.value) || 0;
                totalActual += parseInt(row.querySelector(".actual")?.value) || 0; // ✅ FIXED
            });

            document.getElementById("totalTargetValue").innerText = totalTarget;
            document.getElementById("totalActualValue").innerText = totalActual;

            // ✅ Efficiency
            let efficiency = totalTarget > 0 ? ((totalActual / totalTarget) * 100).toFixed(1) : 0;

            let effEl = document.getElementById("efficiencyValue");
            effEl.innerText = efficiency + "%";

            // 🎨 Color
            if (efficiency >= 90) effEl.style.color = "green";
            else if (efficiency >= 70) effEl.style.color = "orange";
            else effEl.style.color = "red";
        }


        // 🔥 Run on load
        window.onload = function () {
            calculateTarget();
        };


        // 🔥 Recalculate when remark changes
        document.addEventListener("change", function (e) {
            if (e.target.classList.contains("remarks-ddl")) {
                calculateTarget();
            }
        });

        // ✅ LIVE Actual typing
        document.addEventListener("input", function (e) {
            if (e.target.classList.contains("actual")) { // ✅ FIXED
                updateTotalTarget();
            }
        });
        

        // ⏰ DIGITAL CLOCK
        function updateClock() {
            var now = new Date();

            var months = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"];

            var date = now.getDate();
            var month = months[now.getMonth()];
            var year = now.getFullYear();

            var hours = now.getHours();
            var minutes = now.getMinutes();
            var seconds = now.getSeconds();

            var ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12;

            hours = hours < 10 ? "0" + hours : hours;
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            var timeString = hours + ":" + minutes + ":" + seconds + " " + ampm;
            var fullString = "📅 " + date + " " + month + " " + year + " ⏱️ " + timeString;
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
                    <label>Hourly Target</label>
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

                <div id="digitalClock" style="font-size: 14px; font-weight: bold; background: #000000; color: #17D4FE; display: flex; padding: 6px; border-radius: 6px; text-align: center;">
                </div>

                 <!-- 🔥 Total Target Box -->
                <div id="totalTargetBox" 
                     style="background:#f1f3c2; padding:8px; border-radius:6px; font-weight:bold;">         
                    🎯 Total Target: <span id="totalTargetValue">0</span>
                </div>

                <div class="summary-box" style="background:#f1f3c2;display: inline-block;box-shadow: 0 2px 5px rgba(0,0,0,0.1); padding:8px; border-radius:6px; font-weight:bold;">⚡ Actual Total: <span id="totalActualValue"
                    >0</span>
                </div>
                <div class="summary-box" 
                    style="background: linear-gradient(90deg, #f1f3c2, #ffffff); padding:8px; border-radius:6px; font-weight:bold;">📊 Efficiency: <span id="efficiencyValue">0%</span>
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
                <asp:Repeater ID="rptProduction" runat="server" OnItemDataBound="rptProduction_ItemDataBound">
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
                                    CssClass="num-box target-box" TextMode="Number" min="0"
                                    ReadOnly="true"
                                    Style="background: linear-gradient(90deg, #57efd8,#ffffff);" />
                            </td>

                            <!-- Actual -->
                            <td>
                                <asp:TextBox ID="txtActual" runat="server"
                                    CssClass="num-box actual" TextMode="Number" min="0"
                                    Style="background: linear-gradient(90deg,#f7edb5,#ffffff);" />
                            </td>

                            <!-- Reject -->
                            <td>
                                <asp:TextBox ID="txtReject" runat="server"
                                    CssClass="num-box reject" ForeColor="Red"
                                    TextMode="Number" min="0" Style="background: linear-gradient(90deg, #f2d2d2,#ffffff);" />
                            </td>

                            <!-- Rework -->
                            <td>
                                <asp:TextBox ID="txtRework" runat="server"
                                    CssClass="num-box rework" TextMode="Number" min="0"
                                    Style="background: linear-gradient(90deg,#d8d4d4,#ffffff);" />
                            </td>

                            <!-- DownTime -->
                            <td>
                                <asp:TextBox ID="txtDownTime" runat="server"
                                    CssClass="num-box downtime"
                                    TextMode="Number"
                                    min="0" max="60"
                                    ToolTip="डाउनटाइम"
                                    oninput="if(this.value > 60) this.value = 60;"
                                    onkeydown="if(event.key === '-' || event.key === 'e') return false;" />
                            </td>

                            <!-- Remarks -->
                            <td>
                                <asp:DropDownList ID="ddlRemarks" runat="server" ToolTip="टार्गेट कम होने का कारण भरें"
                                    Style="background: linear-gradient(90deg,#fc3636,#00c853,#4e73df);"
                                    CssClass="remarks-ddl">
                                    <asp:ListItem Text=" " Value="" />
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
    <script>
        // actual + reject + rework should not exceed target
        // ✅ SINGLE EVENT HANDLER
        document.addEventListener("input", function (e) {

            // Only run for our fields
            if (!e.target.classList.contains("actual") &&
                !e.target.classList.contains("reject") &&
                !e.target.classList.contains("rework")) return;

            var row = e.target.closest("tr");
            if (!row) return;

            var actual = parseFloat(row.querySelector(".actual")?.value) || 0;
            var reject = parseFloat(row.querySelector(".reject")?.value) || 0;
            var rework = parseFloat(row.querySelector(".rework")?.value) || 0;
            var target = parseFloat(row.querySelector(".target-box")?.value) || 0;

            console.log("Check:", actual, reject, rework, target); // 👈 DEBUG

            if ((actual + reject + rework) > target) {

                alert("❌ Total exceeds Quantity! टारगेट से ज्यादा संख्या सेव नहीं होगी");

                e.target.value = "";
                e.target.focus();
            }
        });


    </script>
</body>
</html>
