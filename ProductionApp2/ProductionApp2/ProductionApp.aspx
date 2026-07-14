<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductionApp.aspx.cs" Inherits="ProductionApp2.ProductionApp" %>

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

        .header {
            position: relative;
            margin-bottom: 10px;
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

        .header img {
            position: absolute;
            top: 6px;
            left: 10px;
            height: 33px;
            width: 150px;
            background: #c6dfe9;
            border-radius: 3px;
        }

        .container-box {
            background: #fff;
            padding: 10px;
            border-radius: 6px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 10px;
        }

        .form-row {
            display: flex;
            gap: 10px;
            margin-bottom: 12px;
        }

        .form-group {
            flex: 1;
            display: flex;
            align-items: center;
        }

        .input-box {
            width: 95%;
            height: 32px;
            flex: 1;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .form-group label {
            width: 150px;
            font-weight: 600;
        }

        .button-group {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .btn-save {
            background: #00c853;
            color: white;
            padding: 8px 20px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            width: 150px;
            white-space: nowrap;
        }

        .btn-get {
            background: #ff6a00;
            color: #fff;
            padding: 8px 18px;
            border-radius: 6px;
            border: none;
            font-weight: bold;
            cursor: pointer;
            white-space: nowrap;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            min-width: 900px;
        }

        .num-box {
            width: 80%;
            height: 34px;
            text-align: center;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .remarks-ddl {
            width: 100%;
            height: 32px;
            border-radius: 6px;
            border: 1px solid #ccc;
            text-align: center;
            min-width: 120px;
        }

        td:first-child {
            white-space: nowrap;
            width: 200px;
            font-weight: 500;
        }

        table th {
            background: #4e73df;
            color: white;
            text-align: center;
            white-space: nowrap;
            padding: 8px;
            border-radius: 4px;
        }

        table td {
            padding: 5px;
            text-align: center;
            overflow-x: auto;
            vertical-align: middle;
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
                flex-direction: column;
                gap: 8px;
            }

            .button-group {
                flex-direction: column;
                align-items: stretch;
                gap: 8px;
            }

                .button-group > * {
                    width: 100% !important;
                    text-align: center;
                }

            .form-group {
                flex-direction: column;
                align-items: flex-start;
            }

                .form-group label {
                    width: 100%;
                    margin-bottom: 4px;
                }

            .input-box {
                width: 100%;
            }

            .btn-save,
            .btn-get {
                width: 100%;
            }

            .remarks-ddl {
                width: 100%;
            }

            table {
                font-size: 12px;
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
                if (remark === "Tea") { downtime = 15; }
                else if (remark === "Lunch" || remark === "Admin") { downtime = 30; }
                if (downtimeBox) downtimeBox.value = downtime;
                var availableTime = 3600 - (downtime * 60);
                var target = Math.floor(availableTime / cycleTime);
                if (targetBox) targetBox.value = target;
            });
            updateTotalTarget();
        }

        function updateTotalTarget() {
            let totalTarget = 0;
            let totalActual = 0;
            document.querySelectorAll("tbody tr").forEach(row => {
                if (row.offsetParent === null) return;
                totalTarget += parseInt(row.querySelector(".target-box")?.value) || 0;
                totalActual += parseInt(row.querySelector(".actual")?.value) || 0;
            });

            document.getElementById("totalTargetValue").innerText = totalTarget;
            document.getElementById("totalActualValue").innerText = totalActual;

            // Efficiency
            let efficiency = totalTarget > 0 ? ((totalActual / totalTarget) * 100).toFixed(1) : 0;
            let effEl = document.getElementById("efficiencyValue");
            effEl.innerText = efficiency + "%";
            if (efficiency >= 90) effEl.style.color = "green";
            else if (efficiency >= 70) effEl.style.color = "orange";
            else effEl.style.color = "red";
        }

        // Recalculate when remark changes
        document.addEventListener("change", function (e) {
            if (e.target.classList.contains("remarks-ddl")) { calculateTarget(); }
        });

        // Actual typing
        document.addEventListener("input", function (e) {
            if (e.target.classList.contains("actual")) { updateTotalTarget(); }
        });


        // DIGITAL CLOCK
        function updateClock() {
            var now = new Date();
            var hours = now.getHours();
            var minutes = now.getMinutes();
            var seconds = now.getSeconds();
            var ampm = hours >= 12 ? "PM" : "AM";
            hours = hours % 12 || 12;
            hours = hours < 10 ? "0" + hours : hours;
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;
            var date = now.getDate();
            var month = now.toLocaleString('default', { month: 'short' });
            var year = now.getFullYear();
            var timeString = hours + ":" + minutes + ":" + seconds + " " + ampm;
            var fullString = "📅 " + date + " " + month + " " + year + " ⏰ " + timeString;
            var clock = document.getElementById("digitalClock");
            if (clock) { clock.innerHTML = fullString; }
        }

        // Run on load
        window.onload = function () {
            calculateTarget();
            updateClock();
            setInterval(updateClock, 1000);
        };

        function validateHeader() {

            // Header Validation Data Shift , Machine, Operator, Process, Cycle Time Required

            var date = document.getElementById('<%= txtDate.ClientID %>').value;
            var shift = document.getElementById('<%= ddlShift.ClientID %>').value;
            var machine = document.getElementById('<%= ddlMachine.ClientID %>').value;
            var operator = document.getElementById('<%= ddlOperator.ClientID %>').value;
            var process = document.getElementById('<%= ddlProcess.ClientID %>').value;
            var cycle = document.getElementById('<%= txtCycleTime.ClientID %>').value;

            if (date.trim() === "") { alert("⚠ Please select Production Date"); return false; }
            if (shift === "0" || shift === "") { alert("⚠ Please select Shift"); return false; }
            if (machine === "0" || machine === "") { alert("⚠ Please select Machine"); return false; }
            if (operator === "0" || operator === "") { alert("⚠ Please select Operator"); return false; }
            if (process === "0" || process === "") { alert("⚠ Please select Process"); return false; }
            if (cycle.trim() === "" || isNaN(cycle) || parseInt(cycle) <= 0) { alert("⚠ Enter valid Cycle Time"); return false; }

            // Row Validation (Remarks → Downtime)
            var rows = document.querySelectorAll("table tbody tr");

            for (var i = 0; i < rows.length; i++) {

                var remarks = rows[i].querySelector(".remarks-ddl");
                var downtime = rows[i].querySelector(".downtime");

                if (!remarks || !downtime) continue;

                var remarksValue = remarks.value.trim();
                var downtimeValue = downtime.value.trim();

                // If remarks selected → downtime required
                if (remarksValue !== "" && (downtimeValue === "" || parseInt(downtimeValue) <= 0)) {

                    alert("⚠ Row " + (i + 1) + ":उत्पादन कम होने का कारण मिनट में भरें.");

                    // Highlight fields
                    remarks.style.border = "2px solid red";
                    downtime.style.border = "2px solid red";

                    downtime.focus();
                    return false;
                } else {
                    // Reset border if valid
                    remarks.style.border = "";
                    downtime.style.border = "";
                }
            }
            return true; //allow save
        }


        document.addEventListener("DOMContentLoaded", function () {

            function isToday(dateStr) {
                let today = new Date().toISOString().split('T')[0];
                return dateStr === today;
            }

            function loadSavedData() {

                let dateEl = document.getElementById('<%= txtDate.ClientID %>');
        let shiftEl = document.getElementById('<%= ddlShift.ClientID %>');
        let machineEl = document.getElementById('<%= ddlMachine.ClientID %>');

        if (!dateEl || !shiftEl || !machineEl) {
            console.log("Controls not found");
            return;
        }

        let date = dateEl.value;
        let shift = shiftEl.value;
        let machine = machineEl.value;

        if (!isToday(date)) {
            console.log("Not today → skip API");
            return;
        }

        fetch('<%= ResolveUrl("~/Production.aspx/GetSavedData") %>', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8'
                        },
                        body: JSON.stringify({
                            date: date,
                            shift: shift,
                            machine: machine
                        })
                    })
                        .then(res => res.json())
                        .then(res => {

                            console.log("API response:", res);

                            let data = res.d;

                            if (!data || data.length === 0) {
                                console.log("No data found");
                                return;
                            }

                            fillRows(data);
                        })
                        .catch(err => console.error("API error:", err));
                }

                function fillRows(data) {

                    let rows = document.querySelectorAll("#<%= rptProduction.ClientID %> tr");

                    console.log("Rows found:", rows.length);

                    data.forEach(item => {

                        rows.forEach(row => {

                            let time = row.querySelector("[id*=hdnTime]");

                            if (!time) return;

                            if (time.value === item.TimeSlot) {

                                row.querySelector("[id*=txtTarget]").value = item.Target || "";
                                row.querySelector("[id*=txtActual]").value = item.Actual || "";
                                row.querySelector("[id*=txtReject]").value = item.Reject || "";
                                row.querySelector("[id*=txtRework]").value = item.Rework || "";
                                row.querySelector("[id*=txtReason]").value = item.Reason || "";
                                row.querySelector("[id*=txtDownTime]").value = item.DownTime || "";
                                row.querySelector("[id*=ddlRemarks]").value = item.Remarks || "";

                                // 🔒 LOCK ROW
                                row.querySelectorAll("input, select").forEach(el => el.disabled = true);

                                let btn = row.querySelector("[id*=btnSubmit]");
                                if (btn) {
                                    btn.disabled = true;
                                    btn.style.background = "green";
                                    btn.value = "✔ Done";
                                }
                            }

                        });

                    });
                }

                // EVENTS
                document.getElementById('<%= ddlShift.ClientID %>')?.addEventListener("change", loadSavedData);
                document.getElementById('<%= ddlMachine.ClientID %>')?.addEventListener("change", loadSavedData);
                document.getElementById('<%= txtDate.ClientID %>')?.addEventListener("change", loadSavedData);

                // INITIAL LOAD
                loadSavedData();
            });

    </script>

</head>
<body>
    <form id="form1" runat="server">

        <!-- HEADER -->
        <div class="header">
            <img src="Sabohema Logo.jpg" />
            <div class="header-bar">
                Hourly Production Sheet
            </div>
        </div>
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
                        <asp:ListItem Text="General" Value="G" />
                        <asp:ListItem Text="A Shift" Value="A" />
                        <asp:ListItem Text="B Shift" Value="B" />
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
                        placeholder="Auto Calculate as per Master" ReadOnly="true"
                        OnTextChanged="txtCycleTime_TextChanged" onkeyup="calculateTarget()"></asp:TextBox>

                </div>

                <div class="form-group">
                    <label>Operator Name</label>
                    <asp:DropDownList ID="ddlOperator" runat="server"
                        CssClass="input-box" OnSelectedIndexChanged="ddlOperator_SelectedIndexChanged" />
                </div>
            </div>
            <!-- Button Group: Save, Overtime, Clock, Total Target, Actual Total, Efficiency-->
            <div class="button-group">
                <asp:Button ID="btnSave" runat="server" Text="💾 Update" CssClass="btn-save"
                    OnClick="btnSave_Click"
                    OnClientClick="return checkPassword();" />

                <asp:DropDownList ID="DdlOT" runat="server" AutoPostBack="true"
                    Style="background-color: #000000; color: #e6f0f5; padding: 6px; border-radius: 5px; text-align: left; font-weight: bold;"
                    ToolTip="ओवरटाइम का चयन करें" OnSelectedIndexChanged="DdlOT_SelectedIndexChanged">
                    <asp:ListItem Text="⏱️ Add Overtime" Value="0" />
                    <asp:ListItem Text=" OT-1 Hour" Value="1" />
                    <asp:ListItem Text=" OT-2 Hours" Value="2" />
                    <asp:ListItem Text=" OT-3 Hours" Value="3" />
                    <asp:ListItem Text=" OT-4 Hours" Value="4" />
                </asp:DropDownList>

                <div id="digitalClock"
                    style="font-size: 14px; font-weight: bold; background: #000000; color: #17D4FE; display: flex; padding: 6px; border-radius: 6px; text-align: center;">
                </div>

                <div id="totalTargetBox"
                    style="background: #f1f3c2; padding: 8px; border-radius: 6px; font-weight: bold;">
                    🎯 Total Target: <span id="totalTargetValue">0</span>
                </div>

                <div class="summary-box" style="background: #f1f3c2; display: inline-block; box-shadow: 0 2px 5px rgba(0,0,0,0.1); padding: 8px; border-radius: 6px; font-weight: bold;">
                    ⚡Actual Total: <span id="totalActualValue">0</span>
                </div>
                <div class="summary-box"
                    style="background: linear-gradient(90deg, #f1f3c2, #ffffff); padding: 8px; border-radius: 6px; font-weight: bold;">
                    📊 Efficiency: <span id="efficiencyValue">0%</span>
                </div>

                <asp:Button ID="GetData" runat="server" Text="📥 Get Saved Data" CssClass="btn-get"
                    hidden="true" OnClick="GetData_Click" />
            </div>
        </div>
        <!-- ROW TABLE -->
        <table>
            <thead>
                <tr>
                    <th>Time Slot (Hrs)</th>
                    <th>Target</th>
                    <th>Actual</th>
                    <th>Reject</th>
                    <th>Rework</th>
                    <th>Reason</th>
                    <th>DownTime (मिनट)</th>
                    <th>Remarks</th>
                    <th>Submit</th>

                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptProduction" runat="server" OnItemDataBound="rptProduction_ItemDataBound">
                    <ItemTemplate>
                        <tr>
                            <!-- Time Slot -->
                            <td style="white-space: nowrap; width: 100%; display: block;">

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
                            <td>
                                <asp:TextBox ID="txtReason" runat="server"
                                    CssClass="num-box reason-box" TextMode="SingleLine"
                                    Style="background: linear-gradient(90deg,#d8d4d4,#ffffff); min-width: 120px; width: 100%" />
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
                                    Style="background: linear-gradient(90deg,#c6dfe9,#ffffff);"
                                    CssClass="remarks-ddl" OnClientClick="return validateHeader();">
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
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="num-box btn-get"
                                    CommandName="SubmitRow" OnClientClick="return validateHeader();"
                                    OnClick="btnSubmit_Click" ToolTip="हर घंटे सेव करें" />
                            </td>


                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </form>
    <script>

        // actual + reject + rework should not exceed target
        document.addEventListener("input", function (e) {
            if (!e.target.classList.contains("actual") &&
                !e.target.classList.contains("reject") &&
                !e.target.classList.contains("rework")) return;
            var row = e.target.closest("tr");
            if (!row) return;
            var actual = parseFloat(row.querySelector(".actual")?.value) || 0;
            var reject = parseFloat(row.querySelector(".reject")?.value) || 0;
            var rework = parseFloat(row.querySelector(".rework")?.value) || 0;
            var target = parseFloat(row.querySelector(".target-box")?.value) || 0;
            console.log("Check:", actual, reject, rework, target);
            if ((actual + reject + rework) > target) {
                alert("❌ Total exceeds Quantity! टारगेट से ज्यादा संख्या सेव नहीं होगी");
                e.target.value = "";
                e.target.focus();
            }
        });

    </script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function checkPassword() {

            Swal.fire({
                title: '🔐 Enter Password',
                input: 'password',   // ✅ THIS HIDES TYPING (••••)
                inputPlaceholder: 'Enter password',
                showCancelButton: true,
                confirmButtonText: 'OK'
            }).then((result) => {

                if (result.isConfirmed) {

                    if (result.value === "12345") {
                        __doPostBack('<%= btnSave.UniqueID %>', '');
                } else {
                    Swal.fire("❌ Wrong Password!");
                }

            }
        });

            return false; // stop default postback
        }
    </script>
</body>
</html>
