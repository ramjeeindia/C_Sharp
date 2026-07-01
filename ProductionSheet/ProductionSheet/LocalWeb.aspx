<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LocalWeb.aspx.cs" Inherits="ProductionSheet.LocalWeb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hourly Production Sheet</title>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #c6dfe9;
            font-family: 'Segoe UI','Poppins', Tahoma, sans-serif;
        }

        /* HEADER */
        .header {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            padding: 12px;
            background: linear-gradient(to right, #7b2ff7, #9b3bff);
            color: white;
            border-radius: 6px;
        }

        .header-title {
            text-align: center;
            font-size: 22px;
            font-weight: bold;
        }

        .header img {
            position: absolute;
            left: 15px;
            height: 40px;
            background: #fff;
            padding: 4px;
            border-radius: 4px;
        }

        /* MAIN LAYOUT */
        .main {
            display: flex;
            flex-wrap: wrap; /* IMPORTANT */
            gap: 15px;
            padding: 15px;
        }

        .header-panel {
            flex: 1 1 100%;
            background: #fff;
            border-radius: 6px;
            padding: 10px;
        }

        /* FORM GRID */
        .header-table {
            width: 100%;
        }

            .header-table td {
                vertical-align: middle;
            }

                .header-table td:nth-child(1),
                .header-table td:nth-child(3) {
                    font-weight: 600;
                    width: 15%;
                    white-space: nowrap;
                }

                /* Input column */
                .header-table td:nth-child(2),
                .header-table td:nth-child(4) {
                    width: 35%;
                    padding: 5px;
                }

            .header-table tr {
                border-bottom: 1px solid #f1f1f1;
            }

                .header-table tr:last-child {
                    border-bottom: none;
                }

        /* INPUTS */
        input, select {
            width: 100%; /* important for mobile */
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        /* BUTTON */
        .btn {
            padding: 10px 16px;
            border-radius: 6px;
            border: none;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-save {
            background: #28a745;
            color: white;
        }
        .auto-row {
            width: auto;
            padding: 15px;
            white-space: nowrap; /* prevent breaking */
            border-collapse: collapse;
            text-align: center;
        }

        /* TABLE */
        .table-container {
            width: 100%;
            overflow-x: auto; /* SCROLL ON MOBILE */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px; /* prevent breaking */
        }

        th {
            background: linear-gradient(135deg, #2b59c3, #4e73df);
            color: white;
            padding: 10px;
            font-size: 14px;
        }

        td {
            padding: 2px;
           
        }

        /* MOBILE RESPONSIVE */
        @media (max-width: 768px) {

            .header {
                flex-direction: column;
                text-align: center;
            }

                .header img {
                    position: static;
                    margin-bottom: 5px;
                }

            .header-title {
                font-size: 18px;
            }

            .header-table tr {
                display: flex;
                flex-direction: column;
                margin-bottom: 10px;
            }

            .header-table td {
                width: 100%;
                display: block;
            }
        }
    </style>

</head>

<body style="background-color: rgb(130, 176, 194); text-align: left;">
    <form id="form1" runat="server">

        <div class="header">
            <img src="Sabohema Logo.jpg" />
            <div class="header-title">Hourly Production Sheet</div>
        </div>

        <div class="main">
            <div class="header-panel">
                <table class="header-table">
                    <tr>
                        <td>Production Date</td>
                        <td>
                            <asp:TextBox ID="txtProdDate" runat="server"
                                OnTextChanged="txtProdDate_TextChanged" ToolTip="Date"></asp:TextBox></td>

                        <td>Shift</td>
                        <td>
                            <asp:DropDownList ID="ddlshift" runat="server" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlshift_SelectedIndexChanged">
                                <asp:ListItem Value="G" Text="General"></asp:ListItem>
                                <asp:ListItem Value="A" Text="A Shift"></asp:ListItem>
                                <asp:ListItem Value="B" Text="B Shift"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>


                    <tr>
                        <td>Machine Name</td>
                        <td>
                            <asp:DropDownList ID="ddlMachine" runat="server"
                                OnSelectedIndexChanged="ddlMachine_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>Operator Name</td>
                        <td>
                            <asp:DropDownList ID="ddlOperator" runat="server" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlOperator_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Process Name</td>
                        <td>
                            <asp:DropDownList ID="ddlprocess" runat="server"
                                OnSelectedIndexChanged="ddlprocess_SelectedIndexChanged">
                            </asp:DropDownList>

                        </td>
                        <td>Cycle Time/Hour</td>
                        <td>
                            <asp:TextBox ID="txtCycleTime" onkeyup="setTarget()" runat="server" OnTextChanged="txtCycleTime_TextChanged"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="Button1" runat="server" Width="127px" Text="Save" BackColor="#00CC00" BorderColor="Blue" BorderStyle="Dotted" OnClick="Button1_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="auto-row">
            <table>
                <thead>
                    <tr>
                        <th class="time-col">Time (Hrs)</th>
                        <th>Target-टारगेट</th>
                        <th>Actual-एक्चुअल</th>
                        <th>Reject-रिजेक्ट</th>
                        <th>Rework-रेवॉर्क</th>
                        <th>DownTime-डाउनटाइम</th>
                        <th>Remarks-रिमार्क्स</th>
                    </tr>
                </thead>
                <tbody>
                    <tr id="row1" runat="server">
                        <td class="time-col">06:00AM - 07:00 AM</td>
                        <td>
                            <asp:TextBox ID="TextBox1" onkeyup="setTarget()" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox2" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox3" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox4" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox5" TextMode="Number"
                                min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>
                        <td>
                            <asp:DropDownList ID="ddlRemark1" CssClass="row-remarks" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row2" runat="server">
                        <td class="time-col">07:00AM - 08:00 AM</td>
                        <td>
                            <asp:TextBox ID="TextBox6" onkeyup="setTarget()" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox7" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox8" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox9" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox10"
                                min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark2" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>

                    </tr>

                    <tr id="row3" runat="server">
                        <td class="time-col">08:00AM - 09:00AM</td>
                        <td>
                            <asp:TextBox ID="TextBox11" onkeyup="setTarget()" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox12" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox13" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox14" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox15"
                                min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>
                        <td>
                            <asp:DropDownList ID="ddlRemark3" CssClass="row-remarks" runat="server"></asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row4" runat="server">
                        <td class="time-col">09:00AM - 10:00AM</td>
                        <td>
                            <asp:TextBox ID="TextBox16" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox17" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox18" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox19" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox20" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark4" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row5" runat="server">
                        <td class="time-col">10:00AM - 11:00AM</td>
                        <td>
                            <asp:TextBox ID="TextBox21" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox22" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox23" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox24" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox25" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark5" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row6" runat="server">
                        <td class="time-col">11:00AM - 12:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox26" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox27" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox28" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox29" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox30" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark6" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row7" runat="server">
                        <td class="time-col">12:00PM - 13:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox31" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox32" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox33" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox34" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox35"
                                min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark7" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row8" runat="server">
                        <td class="time-col">13:00PM - 14:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox36" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox37" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox38" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox39" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox40"
                                min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark8" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row9" runat="server">
                        <td class="time-col">14:00PM - 15:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox41" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox42" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox43" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox44" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox45" TextMode="Number" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark9" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row10" runat="server">
                        <td class="time-col">15:00PM - 16:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox46" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox47" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox48" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox49" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox50" TextMode="Number" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark10" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row11" runat="server">
                        <td class="time-col">16:00PM - 17:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox51" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox52" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox53" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox54" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox55" TextMode="Number" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark11" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row12" runat="server">
                        <td class="time-col">17:00PM - 18:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox56" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox57" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox58" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox59" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox60" TextMode="Number" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark12" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row13" runat="server">
                        <td class="time-col">18:00PM - 19:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox61" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox62" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox63" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox64" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox65" TextMode="Number" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark13" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row14" runat="server">
                        <td class="time-col">19:00PM - 20:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox66" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox67" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox68" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox69" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox70" TextMode="Number" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark14" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="row15" runat="server">
                        <td class="time-col">20:00PM - 21:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox71" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox72" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox73" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox74" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox75" TextMode="Number" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark15" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row16" runat="server">
                        <td class="time-col">21:00PM - 22:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox76" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox77" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox78" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox79" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox80" TextMode="Number" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark16" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="row17" runat="server">
                        <td class="time-col">22:00PM - 23:00PM</td>
                        <td>
                            <asp:TextBox ID="TextBox81" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox82" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox83" TextMode="Number" min="0" runat="server"
                                Style="color: #fa0e0e; text-align: center; font-weight: 600;" /></td>
                        <td>
                            <asp:TextBox ID="TextBox84" TextMode="Number" min="0" runat="server" /></td>
                        <td>
                            <asp:TextBox ID="TextBox85" TextMode="Number" min="0" max="60"
                                oninput="if(this.value > 60) this.value = 60; if(this.value < 0) this.value = 0;"
                                onkeydown="if(event.key === '-' || event.key === 'e') return false;"
                                runat="server" /></td>

                        <td>
                            <asp:DropDownList ID="ddlRemark17" CssClass="row-remarks" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>

                </tbody>
            </table>

        </div>
    </form>
</body>
</html>
