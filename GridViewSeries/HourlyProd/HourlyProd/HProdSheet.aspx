﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HProdSheet.aspx.cs" Inherits="HourlyProd.HProdSheet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <titleHourly Production Sheet</title>
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
            position:relative;
            padding: 10px 10px;
            background: linear-gradient(to right, #7b2ff7, #9b3bff);
            color: white;
            border-radius: 4px;
            
        }
        .header img {
                position:absolute;
                left:20px;
                height: 33px;
                width:150px;
                background: #c6dfe9;
                padding: 3px;
            top: 8px;
        }

        .header-title {
            text-align: center;
            font-size: 22px;
            font-weight: bold;
        }

        .main {
            display: flex;
            gap:15px;
            padding: 15px;
        }
        .left-panel {
            flex:2;
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
            font-size: 13px;
            font-weight: 600;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            color:aliceblue;
            font-weight: bold;
            cursor: pointer;
            
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
            color: white;
        }

        .vw-btn {
            background: #ffc107;
            color:#000000;
        }
        .Header-Col{
            background: #000000;
            color:white;
            text-align:left;
        }
        /* TABLE */
        .table-container {
            width: 100%;
            overflow-x: auto;
            margin-left:15px;
            margin-right:10px;
            
        }

        table {
            width: auto;
            border-collapse: collapse;
            border-radius: 5px;
        }

        /* HEADER */
        th,td {
            padding: 3px;
        }

        /* ROW STRIPES */
/*        tbody tr:nth-child(even) {
            background-color:dimgray;
        }
*/

        /* INPUT IN TABLE */
        td input {
            width: 80%;
            padding: 5px;
            text-align:center;
            font-weight:bold;
        }
        .auto-style1{
            width:190px;
            white-space:nowrap;
            font-weight:bold;
        }

        .auto-style2{
            width:auto;
        }
        
        /* MOBILE RESPONSIVE */
        @media (max-width: 992px) {
            .form-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {

            .header {
                flex-direction: column;
                text-align: center;
                gap: 10px;
            }

            .header img {
                height: 40px;
            }

            .header-title {
                font-size: 18px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            td input {
                width: 100%;
            }
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
        '<%= TextBox6.ClientID %>',
        '<%= TextBox11.ClientID %>',
        '<%= TextBox16.ClientID %>',
        '<%= TextBox21.ClientID %>',
        '<%= TextBox26.ClientID %>',
        '<%= TextBox31.ClientID %>',
        '<%= TextBox36.ClientID %>',
        '<%= TextBox41.ClientID %>',
        '<%= TextBox46.ClientID %>',
        '<%= TextBox51.ClientID %>',
        '<%= TextBox56.ClientID %>',
        '<%= TextBox61.ClientID %>',
        '<%= TextBox66.ClientID %>',
        '<%= TextBox71.ClientID %>',
        '<%= TextBox76.ClientID %>',
        '<%= TextBox81.ClientID %>'
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

        <div class="header">
            <img src="Sabohema Logo.jpg" />
            <div class="header-title">Hourly Production Sheet</div>
        </div>

        <div class="main">
            <div class="left-panel">
                <div class="form-grid">
                    <div>
                        <label>Production Datee</label>
                        <asp:TextBox ID="txtProdDate" runat="server" TextMode="Date"
                            OnTextChanged="txtProdDate_TextChanged" ToolTip="Date"></asp:TextBox>
                    </div>

                    <div>
                        <label>Shift</label>
                        <asp:DropDownList ID="ddlshift" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlshift_SelectedIndexChanged">
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
                        <asp:DropDownList ID="ddlOperator" runat="server" OnSelectedIndexChanged="ddlOperator_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Process Name</label>
                        <asp:DropDownList ID="ddlprocess" runat="server" AutoPostBack="true">
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Cycle Time</label>
                        <asp:TextBox ID="txtCycleTime" placeholder="Fill Cycle Time" AutoPostBack="true"
                            CssClass="form-control" onkeyup="fillTarget()" runat="server" OnTextChanged="txtCycleTime_TextChanged"
                            style="background-color:#28a745; color: white; text-align: center; font-weight: 600;"></asp:TextBox>

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

        <div class="table-container">
            <table>
                <thead class="Header-Col">
                    <tr>
                        <th class="auto-style1">Time (Hrs)</th>
                        <th class="auto-style2">Target Qty</th>
                        <th class="auto-style2">Actual OK Qty</th>
                        <th class="auto-style2">Reject Qty</th>
                        <th class="auto-style2">Rework Qty </th>
                        <th class="auto-style2">DownTime(MM)</th>
                        <th class="auto-remarks">Remarks</th>
                    </tr>
                </thead>
                <tbody>
                    <tr id="row1" runat="server">
                        <td class="auto-style1">06:00AM - 07:00 AM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox1" TextMode="Number" min="0" runat="server"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox2" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox3" TextMode="Number" min="0" runat="server" 
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox4" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">07:00AM - 08:00 AM</td>                      
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox6" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox7" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox8" TextMode="Number" min="0" runat="server"
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox9" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">08:00AM - 09:00AM</td>           
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox11" TextMode="Number" min="0" runat="server"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox12" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox13" TextMode="Number" min="0" runat="server" 
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox14" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">09:00AM - 10:00AM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox16" TextMode="Number" min="0" runat="server"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox17" TextMode="Number" min="0" runat="server" /></td>
                            <td class="auto-style2">
                            <asp:TextBox ID="TextBox18" TextMode="Number" min="0" runat="server"
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                            <td class="auto-style2">
                            <asp:TextBox ID="TextBox19" TextMode="Number" min="0" runat="server" /></td>
                            <td class="auto-style2">
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
                        <td class="auto-style1">10:00AM - 11:00AM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox21" TextMode="Number" min="0" runat="server"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox22" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox23" TextMode="Number" min="0" runat="server" 
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox24" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">11:00AM - 12:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox26" TextMode="Number" min="0" runat="server"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox27" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox28" TextMode="Number" min="0" runat="server" 
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox29" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">12:00PM - 13:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox31" TextMode="Number" min="0" runat="server"
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox32" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox33" TextMode="Number" min="0" runat="server" 
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox34" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">13:00PM - 14:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox36" TextMode="Number" min="0" runat="server"
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox37" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox38" TextMode="Number" min="0" runat="server"
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox39" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">14:00PM - 15:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox41" TextMode="Number" min="0" runat="server"
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox42" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox43" TextMode="Number" min="0" runat="server" 
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox44" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">15:00PM - 16:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox46" TextMode="Number" min="0" runat="server"
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox47" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox48" TextMode="Number" min="0" runat="server"
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox49" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">16:00PM - 17:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox51" TextMode="Number" min="0" runat="server"
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox52" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox53" TextMode="Number" min="0" runat="server"
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox54" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">17:00PM - 18:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox56" TextMode="Number" min="0" runat="server"
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox57" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox58" TextMode="Number" min="0" runat="server"
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox59" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">18:00PM - 19:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox61" TextMode="Number" min="0" runat="server" 
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox62" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox63" TextMode="Number" min="0" runat="server" 
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox64" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">19:00PM - 20:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox66" TextMode="Number" min="0" runat="server" 
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox67" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox68" TextMode="Number" min="0" runat="server" 
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox69" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">20:00PM - 21:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox71" TextMode="Number" min="0" runat="server"
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox72" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox73" TextMode="Number" min="0" runat="server" 
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox74" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">21:00PM - 22:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox76" TextMode="Number" min="0" runat="server"
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox77" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox78" TextMode="Number" min="0" runat="server"
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox79" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
                        <td class="auto-style1">22:00PM - 23:00PM</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox81" TextMode="Number" min="0" runat="server"
                                /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox82" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox83" TextMode="Number" min="0" runat="server" 
                                style="color:#fa0e0e; text-align: center; font-weight: 600;"/></td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBox84" TextMode="Number" min="0" runat="server" /></td>
                        <td class="auto-style2">
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
