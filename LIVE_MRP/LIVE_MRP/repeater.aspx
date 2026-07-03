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
            width: 200px;
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
        }

        table td {
            padding: 5px;
            text-align: center;
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
                    <asp:TextBox ID="txtDate" runat="server" CssClass="input-box" TextMode="Date" OnTextChanged="txtDate_TextChanged" />
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
                    <label>Operator Name</label>
                    <asp:DropDownList ID="ddlOperator" runat="server"
                        CssClass="input-box" OnSelectedIndexChanged="ddlOperator_SelectedIndexChanged" />
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Process Name</label>
                    <asp:DropDownList ID="ddlProcess" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlProcess_SelectedIndexChanged" CssClass="input-box" />
                </div>

                <div class="form-group">
                    <label>Cycle Time / Hour</label>
                    <asp:TextBox ID="txtCycleTime" TextMode="Number" min="0" runat="server" CssClass="input-box"
                        placeholder="एक पार्ट का साइकिल समय सेकंड में भरें"
                        OnTextChanged="txtCycleTime_TextChanged" />
                </div>
            </div>

            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-save" OnClick="btnSave_Click" ToolTip="हर घंटे सेव करें" />

            <asp:Label ID="Lblot" runat="server" Text="Over Time Hours"
                Style="color: #000000; font-weight: bold; border: 1px solid #ccc; padding: 5px; border-radius: 5px; border-block-color: #96f1e8;"
                ToolTip="ओवरटाइम का चयन करें" />

            <asp:DropDownList ID="DdlOT" runat="server"
                Style="width: 100px; background-color: #000000; color: #e6f0f5; padding: 6px; border-radius: 5px; text-align: center; font-weight: bold;"
                ToolTip="ओवरटाइम का चयन करें" OnSelectedIndexChanged="DdlOT_SelectedIndexChanged">
                <asp:ListItem Text="Select OT" Value="0" />
                <asp:ListItem Text="1 Hr" Value="1" />
                <asp:ListItem Text="2 Hrs" Value="2" />
                <asp:ListItem Text="3 Hrs" Value="3" />
                <asp:ListItem Text="4 Hrs" Value="4" />
            </asp:DropDownList>

        </div>

        <!-- TABLE -->
        <table>
            <thead>
                <tr>
                    <th>Time (Hrs)</th>
                    <th>Target</th>
                    <th>Actual</th>
                    <th>Reject</th>
                    <th>Rework</th>
                    <th>DownTime</th>
                    <th>Remarks</th>
                </tr>
            </thead>

            <tbody>
                <asp:Repeater ID="rptProduction" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("TimeSlot") %>
                                <asp:HiddenField ID="hdnTime" Value='<%# Eval("TimeSlot") %>' runat="server" />

                            </td>

                            <td>
                                <asp:TextBox ID="txtTarget" placeholder="लक्ष्य" runat="server" CssClass="num-box" TextMode="Number" min="0" /></td>
                            <td>
                                <asp:TextBox ID="txtActual" placeholder="वास्तविक संख्या" runat="server" CssClass="num-box" TextMode="Number" min="0" /></td>
                            <td>
                                <asp:TextBox ID="txtReject" ForeColor="Red" placeholder="अस्वीकृत" runat="server" CssClass="num-box" TextMode="Number" min="0" /></td>
                            <td>
                                <asp:TextBox ID="txtRework" placeholder="पुनर्निर्माण" runat="server" CssClass="num-box" TextMode="Number" min="0" /></td>
                            <td>
                                <asp:TextBox ID="txtDownTime" placeholder="डाउनटाइम" runat="server" CssClass="num-box" TextMode="Number" min="0"
                                    max="60" oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                    onkeydown="if(event.key === '-' || event.key === 'e') return false;" /></td>

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
