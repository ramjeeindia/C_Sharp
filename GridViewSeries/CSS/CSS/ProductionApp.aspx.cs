using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CSS
{
    public partial class ProductionApp : System.Web.UI.Page
    {
        string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOperators();
                LoadProcess();
                LoadMachine();

                ddlshift.SelectedValue = "G"; // Default Shift
                BindProductionGrid();
                
            }
        }

        #region LOAD DROPDOWNS

        private void LoadOperators()
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT Operator_Id, Operator_Name FROM dbo.Operators", con);

                con.Open();
                ddlOperator.DataSource = cmd.ExecuteReader();
                ddlOperator.DataTextField = "Operator_Name";
                ddlOperator.DataValueField = "Operator_Id";
                ddlOperator.DataBind();
            }

            ddlOperator.Items.Insert(0, new ListItem("--Select Operator--", "0"));
        }

        private void LoadProcess()
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT ItemCode, ItemName FROM dbo.Process", con);

                con.Open();
                ddlprocess.DataSource = cmd.ExecuteReader();
                ddlprocess.DataTextField = "ItemName";
                ddlprocess.DataValueField = "ItemCode";
                ddlprocess.DataBind();
            }

            ddlprocess.Items.Insert(0, new ListItem("-- Select Process --", "0"));
        }

        private void LoadMachine()
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT MachineCode, CONCAT(MachineCode,' : ',MachineName) AS MachineName FROM dbo.Machine_Master", con);

                con.Open();
                ddlMachine.DataSource = cmd.ExecuteReader();
                ddlMachine.DataTextField = "MachineName";
                ddlMachine.DataValueField = "MachineCode";
                ddlMachine.DataBind();
            }

            ddlMachine.Items.Insert(0, new ListItem("-- Select Machine --", "0"));
        }

        #endregion

        #region SHIFT CLASS (FIX FOR ERROR)

        public class ShiftHours
        {
            public int Start { get; set; }
            public int End { get; set; }
        }

        private ShiftHours GetShiftHours(string shift)
        {
            ShiftHours sh = new ShiftHours();

            switch (shift)
            {
                case "A":
                    sh.Start = 6;
                    sh.End = 16;
                    break;

                case "B":
                    sh.Start = 12;
                    sh.End = 22;
                    break;

                default: // General
                    sh.Start = 8;
                    sh.End = 18;
                    break;
            }

            return sh;
        }

        #endregion

        #region GRID BINDING

        public class ProductionRow
        {
            public string TimeRange { get; set; }
        }

        private void BindProductionGrid()
        {
            if (string.IsNullOrEmpty(ddlshift.SelectedValue))
                return;

            var hours = GetShiftHours(ddlshift.SelectedValue);
            List<ProductionRow> list = new List<ProductionRow>();

            for (int i = hours.Start; i < hours.End; i++)
            {
                list.Add(new ProductionRow
                {
                    TimeRange = FormatTime(i) + " - " + FormatTime(i + 1)
                });
            }

            rptProduction.DataSource = list;
            rptProduction.DataBind();
        }

        private string FormatTime(int hour)
        {
            DateTime time = DateTime.Today.AddHours(hour);
            return time.ToString("hh:mm tt"); // Example: 06:00 AM
        }

        protected void ddlShift_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindProductionGrid();
        }

        #endregion

        #region VALIDATION

        private bool ValidateHeader()
        {
            decimal cycle;

            return
                !string.IsNullOrWhiteSpace(txtProdDate.Text) &&
                ddlshift.SelectedValue != "0" &&
                ddlMachine.SelectedValue != "0" &&
                ddlOperator.SelectedValue != "0" &&
                ddlprocess.SelectedValue != "0" &&
                !string.IsNullOrWhiteSpace(txtCycleTime.Text) &&
                decimal.TryParse(txtCycleTime.Text, out cycle) &&
                cycle > 0;
        }

        #endregion

        #region SAVE DATA

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!ValidateHeader())
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    "alert('⚠ Please fill all header details correctly!');", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();
                SqlTransaction tran = con.BeginTransaction();

                try
                {
                    foreach (RepeaterItem item in rptProduction.Items)
                    {
                        Label lblTime = (Label)item.FindControl("lblTimeRange");

                        TextBox txtTarget = (TextBox)item.FindControl("txtTarget");
                        TextBox txtActual = (TextBox)item.FindControl("txtActual");
                        TextBox txtReject = (TextBox)item.FindControl("txtReject");
                        TextBox txtRework = (TextBox)item.FindControl("txtRework");
                        TextBox txtDownTime = (TextBox)item.FindControl("txtDownTime");

                        if (lblTime == null) continue;

                        // ❌ ACTUAL REQUIRED VALIDATION
                        if (txtActual == null || string.IsNullOrWhiteSpace(txtActual.Text))
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                                "alert('❌ Actual is required for " + lblTime.Text + "');", true);

                            tran.Rollback();
                            return;
                        }

                        // ✅ SAFE PARSE
                        decimal target = 0, actual = 0, reject = 0, rework = 0, downtime = 0;

                        decimal.TryParse(txtTarget?.Text, out target);
                        decimal.TryParse(txtActual.Text, out actual);
                        decimal.TryParse(txtReject?.Text, out reject);
                        decimal.TryParse(txtRework?.Text, out rework);
                        decimal.TryParse(txtDownTime?.Text, out downtime);

                        // ❌ BUSINESS VALIDATION
                        if ((actual + reject + rework) > target)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                                "alert('❌ Error at " + lblTime.Text + " → Total exceeds Target');", true);

                            tran.Rollback();
                            return;
                        }

                        // ✅ TYPE CONVERSION
                        DateTime prodDate = Convert.ToDateTime(txtProdDate.Text);

                        decimal cycle = 0;
                        decimal.TryParse(txtCycleTime.Text, out cycle);

                        SqlCommand cmd = new SqlCommand(@"
IF EXISTS (
    SELECT 1 FROM ProductionData 
    WHERE ProdDate = @Date 
    AND Shift = @Shift 
    AND Machine = @Machine 
    AND TimeRange = @Time
)
BEGIN
    UPDATE ProductionData
    SET 
        Operator = @Operator,
        Process = @Process,
        CycleTime = @Cycle,
        Target = @Target,
        Actual = @Actual,
        Reject = @Reject,
        Rework = @Rework,
        DownTime = @DownTime
    WHERE 
        ProdDate = @Date 
        AND Shift = @Shift 
        AND Machine = @Machine 
        AND TimeRange = @Time
END
ELSE
BEGIN
    INSERT INTO ProductionData
    (ProdDate, Shift, Machine, Operator, Process, CycleTime, TimeRange, Target, Actual, Reject, Rework, DownTime)
    VALUES
    (@Date, @Shift, @Machine, @Operator, @Process, @Cycle, @Time, @Target, @Actual, @Reject, @Rework, @DownTime)
END
", con, tran);

                        cmd.Parameters.AddWithValue("@Date", prodDate);
                        cmd.Parameters.AddWithValue("@Shift", ddlshift.SelectedValue);
                        cmd.Parameters.AddWithValue("@Machine", ddlMachine.SelectedValue);
                        cmd.Parameters.AddWithValue("@Operator", ddlOperator.SelectedValue);
                        cmd.Parameters.AddWithValue("@Process", ddlprocess.SelectedValue);
                        cmd.Parameters.AddWithValue("@Cycle", cycle);
                        cmd.Parameters.AddWithValue("@Time", lblTime.Text);

                        cmd.Parameters.AddWithValue("@Target", target);
                        cmd.Parameters.AddWithValue("@Actual", actual);
                        cmd.Parameters.AddWithValue("@Reject", reject);
                        cmd.Parameters.AddWithValue("@Rework", rework);
                        cmd.Parameters.AddWithValue("@DownTime", downtime);

                        cmd.ExecuteNonQuery();
                    }

                    tran.Commit();

                    ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                        "alert('✅ All hourly data saved successfully!');", true);

                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "fill", "setTimeout(function(){fillTarget();},100);", true);
                }
                catch (Exception ex)
                {
                    tran.Rollback();

                    Response.Write("<pre>" + ex.ToString() + "</pre>");
                }
            }
        }
        #endregion

        #region OPTIONAL EVENTS (KEEP EMPTY OR USE IF NEEDED)

        protected void ddlMachine_SelectedIndexChanged(object sender, EventArgs e) { }
        protected void ddlOperator_SelectedIndexChanged(object sender, EventArgs e) { }
        protected void txtProdDate_TextChanged(object sender, EventArgs e) { }
        protected void ddlprocess_SelectedIndexChanged(object sender, EventArgs e) { }
        protected void txtCycleTime_TextChanged(object sender, EventArgs e) 
        {
            decimal cycle = 0;
            decimal.TryParse(txtCycleTime.Text, out cycle);

            foreach (RepeaterItem item in rptProduction.Items)
            {
                TextBox txtTarget = (TextBox)item.FindControl("txtTarget");

                if (txtTarget != null)
                {
                    txtTarget.Text = cycle.ToString();
                }
            }
        }

        #endregion
    }
}