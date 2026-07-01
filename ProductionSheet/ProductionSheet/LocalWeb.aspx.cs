using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ProductionSheet
{
    public partial class LocalWeb : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOperators();
                LoadProcess();
                LoadMachine();
                BindRemarks();
                HideRowsBasedOnShift();
                txtProdDate.Text = DateTime.Now.ToString("dd-MM-yyyy");
                ddlshift.SelectedValue = "G";
            }
        }

        private void LoadOperators()
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT [Operator_Id],[Operator_Name] FROM [dbo].[Operators]", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                ddlOperator.DataSource = rdr;
                ddlOperator.DataTextField = "Operator_Name"; // Display
                ddlOperator.DataValueField = "Operator_Id";  // Value
                ddlOperator.DataBind();
            }
            ddlOperator.Items.Insert(0, new ListItem("--Select Operator--", "0"));
        }

        private void LoadReason()
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ResonValue, ReasonText  FROM ReasonList ORDER BY ReasonText", con))
                {
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    ddlprocess.DataSource = rdr;
                    ddlprocess.DataTextField = "ItemName";   // Display
                    ddlprocess.DataValueField = "ItemCode";  // Value
                    ddlprocess.DataBind();
                    ddlprocess.Items.Insert(0, "-- Select Reason --");
                }
            }
        }
        private void LoadMachine()
        {
            string conStr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("spMachineMaster", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    ddlMachine.DataSource = dr;
                    ddlMachine.DataTextField = "MachineName";   // Display
                    ddlMachine.DataValueField = "MachineCode";  // Value
                    ddlMachine.DataBind();
                    ddlMachine.Items.Insert(0, "-- Select Machine --");
                }
            }
        }
        private void LoadProcess()
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT [ItemCode],[ItemName] FROM [dbo].[Process]", con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    ddlprocess.DataSource = dr;
                    ddlprocess.DataTextField = "ItemName";   // Display
                    ddlprocess.DataValueField = "ItemCode";  // Value
                    ddlprocess.DataBind();
                    ddlprocess.Items.Insert(0, "-- Select Process --");
                }
            }
        }



        private void BindRemarks()
        {
            List<string> remarks = new List<string>()
            {
               // "--Select--",
               "",
                "Tea Break",
                "Lunch Break",
                "Model Change",
                "Operator Change",
                "Admin Activity",
                "Machine Breakdown",
                "Under Maintenance",
                "Material Shortage",
                "Trial Runs"
                
            };


            BindDropDown(ddlRemark1, remarks);
            BindDropDown(ddlRemark2, remarks);
            BindDropDown(ddlRemark3, remarks);
            BindDropDown(ddlRemark4, remarks);
            BindDropDown(ddlRemark5, remarks);
            BindDropDown(ddlRemark6, remarks);
            BindDropDown(ddlRemark7, remarks);
            BindDropDown(ddlRemark8, remarks);
            BindDropDown(ddlRemark9, remarks);
            BindDropDown(ddlRemark10, remarks);
            BindDropDown(ddlRemark11, remarks);
            BindDropDown(ddlRemark12, remarks);
            BindDropDown(ddlRemark13, remarks);
            BindDropDown(ddlRemark14, remarks);
            BindDropDown(ddlRemark15, remarks);
            BindDropDown(ddlRemark16, remarks);
            BindDropDown(ddlRemark17, remarks);

        }


        private void BindDropDown(DropDownList ddl, List<string> data)
        {
            ddl.Items.Clear();
            ddl.Items.Insert(0, new ListItem("--Select--", "")); // UI only
            foreach (var item in data)
            {
                if (!string.IsNullOrWhiteSpace(item))
                    ddl.Items.Add(new ListItem(item, item));
            }
            //ddl.DataSource = data;
            //ddl.DataBind();
        }


        protected void txtProdDate_TextChanged(object sender, EventArgs e)
        {

        }



        protected void ddlshift_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlshift.SelectedValue == "G") // General Shift
            {
                row1.Visible = false;
                row2.Visible = false;
                row13.Visible = false;
                row14.Visible = false;
                row15.Visible = false;
                row16.Visible = false;
                row17.Visible = false;
                row3.Visible = true;
                row4.Visible = true;
                row5.Visible = true;
                row6.Visible = true;
                row7.Visible = true;
                row8.Visible = true;
                row9.Visible = true;
                row10.Visible = true;
                row11.Visible = true;
                row12.Visible = true;

            }
            else if (ddlshift.SelectedValue == "A")
            {
                row1.Visible = true;
                row2.Visible = true;
                row3.Visible = true;
                row4.Visible = true;
                row5.Visible = true;
                row6.Visible = true;
                row7.Visible = true;
                row8.Visible = true;
                row9.Visible = true;
                row10.Visible = true;
                row11.Visible = false;
                row12.Visible = false;
                row13.Visible = false;
                row14.Visible = false;
                row15.Visible = false;
                row16.Visible = false;
                row17.Visible = false;
            }
            else
            {
                row7.Visible = true;
                row8.Visible = true;
                row9.Visible = true;
                row10.Visible = true;
                row11.Visible = true;
                row12.Visible = true;
                row13.Visible = true;
                row14.Visible = true;
                row15.Visible = true;
                row16.Visible = true;
                row17.Visible = true;
                row1.Visible = false;
                row2.Visible = false;
                row3.Visible = false;
                row4.Visible = false;
                row5.Visible = false;
                row6.Visible = false;
            }
        }

        private void HideRowsBasedOnShift()
        {
            if (ddlshift.SelectedValue == "G") // General Shift
            {
                row1.Visible = false;
                row2.Visible = false;
                row13.Visible = false;
                row14.Visible = false;
                row15.Visible = false;
                row16.Visible = false;
                row17.Visible = false;

            }
            else
            {
                row3.Visible = true;
                row4.Visible = true;
                row5.Visible = true;
                row6.Visible = true;
                row7.Visible = true;
                row8.Visible = true;
                row9.Visible = true;
                row10.Visible = true;
                row11.Visible = true;
                row12.Visible = true;

            }
        }
        protected void ddlMachine_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlOperator_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlprocess_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void txtCycleTime_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlRemark1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private string GetTimeSlot(int index)
        {
     
            int startHour = 8; // default (G shift)
            string shift = ddlshift.SelectedValue;

            if (shift == "G")
            {
                startHour = 8;
            }
            else if (shift == "A")
            {
                startHour = 6;
            }
            else if (shift == "B")
            {
                startHour = 12;
            }

            int currentHour = startHour + (index - 1);
            int endHour = currentHour + 1;

            return $"{currentHour:00}-{endHour:00}";
        }

        
        protected void Button1_Click(object sender, EventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();
                for (int i = 1; i <= 17; i++)
                {
                    Control row = FindControl("row" + i);
                    if (row == null || !row.Visible) continue;  
                    TextBox txtTarget = (TextBox)row.FindControl("TextBox" + ((i - 1) * 4 + 1));
                    TextBox txtActual = (TextBox)row.FindControl("TextBox" + ((i - 1) * 4 + 2));
                    TextBox txtReject = (TextBox)row.FindControl("TextBox" + ((i - 1) * 4 + 3));
                    TextBox txtRework = (TextBox)row.FindControl("TextBox" + ((i - 1) * 4 + 4));

                    DropDownList ddlRemarks = (DropDownList)row.FindControl("ddlRemark" + i);

                    if (txtActual == null) continue;

                    if (string.IsNullOrWhiteSpace(txtActual.Text.Trim()))
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                            $"alert('Actual Qty Saved and Balance Entry required for row {i}');", true);
                        return;
                    }

                    if (txtActual == null)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                            $"alert('Control not found for row {i}');", true);
                        return;
                    }


                    string timeSlot = GetTimeSlot(i);

                    string remarks = ddlRemarks != null ? ddlRemarks.SelectedValue : "";
                    remarks = (remarks ?? "").Trim();
                    if (remarks == "" || remarks == "--Select--")
                    {
                        remarks = "";   
                    }

                    SaveOrUpdateRow(
                        timeSlot,
                        txtTarget?.Text,
                        txtActual?.Text,
                        txtReject?.Text,
                        txtRework?.Text,
                        remarks,
                        con);
                }
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                "alert('✅ Data Saved Successfully');", true);
        }


        void SaveOrUpdateRow(string time, string t, string a, string r, string rw, string remarks, SqlConnection con)
        {
            int target = string.IsNullOrEmpty(t) ? 0 : Convert.ToInt32(t);
            int actual = string.IsNullOrEmpty(a) ? 0 : Convert.ToInt32(a);
            int reject = string.IsNullOrEmpty(r) ? 0 : Convert.ToInt32(r);
            int rework = string.IsNullOrEmpty(rw) ? 0 : Convert.ToInt32(rw);

            string query = @"
IF EXISTS (
    SELECT 1 FROM ProductionSheet 
    WHERE ProdDate=@date AND OperatorID=@op 
    AND MachineID=@mc AND ProcessName=@process AND TimeSlot=@time
)
BEGIN
    UPDATE ProductionSheet SET
        Shift=@shift,
        TargetQty=@target,
        ActualQty=@actual,
        RejectQty=@reject,
        ReworkQty=@rework,
        Remarks=@remarks
    WHERE ProdDate=@date AND OperatorID=@op 
    AND MachineID=@mc AND ProcessName=@process AND TimeSlot=@time
END
ELSE
BEGIN
    INSERT INTO ProductionSheet
    (ProdDate, Shift, OperatorID, MachineID, ProcessName, CycleTime, TimeSlot, TargetQty, ActualQty, RejectQty, ReworkQty, Remarks)
    VALUES
    (@date,@shift,@op,@mc,@process,@cycle,@time,@target,@actual,@reject,@rework,@remarks)
END";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@date", txtProdDate.Text);
            cmd.Parameters.AddWithValue("@shift", ddlshift.SelectedValue);   
            cmd.Parameters.AddWithValue("@op", ddlOperator.SelectedValue);
            cmd.Parameters.AddWithValue("@mc", ddlMachine.SelectedValue);
            cmd.Parameters.AddWithValue("@process", ddlprocess.SelectedValue);
            cmd.Parameters.AddWithValue("@cycle", txtCycleTime.Text);

            cmd.Parameters.AddWithValue("@time", time);
            cmd.Parameters.AddWithValue("@target", target);
            cmd.Parameters.AddWithValue("@actual", actual);
            cmd.Parameters.AddWithValue("@reject", reject);
            cmd.Parameters.AddWithValue("@rework", rework);
            //cmd.Parameters.AddWithValue("@remarks", remarks ?? "");
            cmd.Parameters.AddWithValue("@remarks", string.IsNullOrWhiteSpace(remarks) ? "" : remarks);

            cmd.ExecuteNonQuery();
        }

        private int GetShiftHours()
        {
            string shift = ddlshift.SelectedValue;

            if (shift == "G") return 10; // 8–18
            if (shift == "A") return 10; // 6–16
            if (shift == "B") return 10; // 12–22

            return 10;

            //BindTimeSlots();
        }



    }
}
