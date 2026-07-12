using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Web.Services;


namespace ProductionApp2
{
    public partial class ProductionApp : System.Web.UI.Page
    {
        string CS = "Data Source=ProBook;Initial Catalog=QRCODE;User ID=sa;Password=sa@2017;";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlShift.SelectedValue = "G";
                BindTimeSlots("G");
                LoadMachines();
                LoadOperators();
                ddlProcess.Items.Insert(0, new ListItem("-- Select Process --", "0"));
                
            }
        }

        public static List<object> GetHourlyDataJS(string date, string shift, string machine)
        {
            string CS = "Data Source=ProBook;Initial Catalog=QRCODE;User ID=sa;Password=sa@2017;";
            List<object> list = new List<object>();

            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("GetHourlyData", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ProductionDate", Convert.ToDateTime(date));
                    cmd.Parameters.AddWithValue("@Shift", shift);
                    cmd.Parameters.AddWithValue("@Machine", machine);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        list.Add(new
                        {
                            TimeSlot = dr["TimeSlot"].ToString(),
                            Target = dr["Target"].ToString(),
                            Actual = dr["Actual"].ToString(),
                            RejectQty = dr["RejectQty"].ToString(),
                            ReworkQty = dr["ReworkQty"].ToString(),
                            Reason = dr["Reason"].ToString(),
                            DownTime = dr["DownTime"].ToString(),
                            Remarks = dr["Remarks"].ToString()                            
                        });
                    }
                }
            }

            return list;
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "loadLocal",
        "setTimeout(function(){ loadFromLocal(); }, 500);", true);

        }

        protected void ddlShift_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindTimeSlots(ddlShift.SelectedValue);
            ScriptManager.RegisterStartupScript(this, this.GetType(),
        "loadLocal", "setTimeout(loadFromLocal, 500);", true);
        }

        protected void ddlMachine_SelectedIndexChanged(object sender, EventArgs e)
        {
            int machineId = Convert.ToInt32(ddlMachine.SelectedValue);
            LoadProcess(machineId);

            ScriptManager.RegisterStartupScript(this, this.GetType(),
        "loadLocal", "setTimeout(loadFromLocal, 500);", true);
        }

        protected void ddlProcess_SelectedIndexChanged(object sender, EventArgs e)
        {
            string itemCode = ddlProcess.SelectedValue;
            LoadCycleTime(itemCode);
        }

        public int CalculateTarget(double cycleTime)
        {
            return (int)Math.Floor(3600 / cycleTime);
        }

        protected void txtCycleTime_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "calc", "calculateTarget();", true);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string CS = "Data Source=ProBook;Initial Catalog=QRCODE;User ID=sa;Password=sa@2017;";

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                foreach (RepeaterItem item in rptProduction.Items)
                {
                    HiddenField hdnTime = (HiddenField)item.FindControl("hdnTime");
                    TextBox txtTarget = (TextBox)item.FindControl("txtTarget");
                    TextBox txtActual = (TextBox)item.FindControl("txtActual");
                    TextBox txtReject = (TextBox)item.FindControl("txtReject");
                    TextBox txtRework = (TextBox)item.FindControl("txtRework");
                    TextBox txtReason = (TextBox)item.FindControl("txtReason");
                    TextBox txtDownTime = (TextBox)item.FindControl("txtDownTime");
                    DropDownList ddlRemarks = (DropDownList)item.FindControl("ddlRemarks");

                    // CONVERSION
                    int actual = string.IsNullOrEmpty(txtActual.Text) ? 0 : Convert.ToInt32(txtActual.Text);
                    int reject = string.IsNullOrEmpty(txtReject.Text) ? 0 : Convert.ToInt32(txtReject.Text);
                    int rework = string.IsNullOrEmpty(txtRework.Text) ? 0 : Convert.ToInt32(txtRework.Text);
                    int downtime = string.IsNullOrEmpty(txtDownTime.Text) ? 0 : Convert.ToInt32(txtDownTime.Text);

                    if ((actual + reject + rework) == 0)
                    {
                        continue; // SKIP EMPTY ROW
                    }


                    string query = @"
IF EXISTS (
    SELECT 1 FROM HourlyProduction
    WHERE 
        ProductionDate = @ProductionDate
        AND Shift = @Shift
        AND Machine = @Machine
        AND Process = @Process
        AND TimeSlot = @TimeSlot
)
BEGIN
    UPDATE HourlyProduction
    SET
        Operator = @Operator,
        CycleTime = @CycleTime,
        Target = @Target,
        Actual = @Actual,
        RejectQty = @RejectQty,
        ReworkQty = @ReworkQty,
        Reason = @Reason,
        DownTime = @DownTime,
        Remarks = @Remarks
       
    WHERE 
        ProductionDate = @ProductionDate
        AND Shift = @Shift
        AND Machine = @Machine
        AND Process = @Process
        AND TimeSlot = @TimeSlot
END
ELSE
BEGIN
    INSERT INTO HourlyProduction
    (
        ProductionDate,
        Shift,
        Machine,
        Process,
        Operator,
        TimeSlot,
        CycleTime,
        Target,
        Actual,
        RejectQty,
        ReworkQty,
        Reason,
        DownTime,
        Remarks
    )
    VALUES
    (
        @ProductionDate,
        @Shift,
        @Machine,
        @Process,
        @Operator,
        @TimeSlot,
        @CycleTime,
        @Target,
        @Actual,
        @RejectQty,
        @ReworkQty,
        @Reason,
        @DownTime,
        @Remarks
    )
END
";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.Text;

                    cmd.Parameters.AddWithValue("@ProductionDate", txtDate.Text);
                    cmd.Parameters.AddWithValue("@Shift", ddlShift.SelectedValue);
                    cmd.Parameters.AddWithValue("@Machine", ddlMachine.SelectedValue);
                    cmd.Parameters.AddWithValue("@Process", ddlProcess.SelectedValue);
                    cmd.Parameters.AddWithValue("@Operator", ddlOperator.SelectedValue);
                    cmd.Parameters.AddWithValue("@TimeSlot", hdnTime.Value);

                    cmd.Parameters.AddWithValue("@CycleTime", string.IsNullOrEmpty(txtCycleTime.Text) ? 0 : Convert.ToInt32(txtCycleTime.Text));
                    cmd.Parameters.AddWithValue("@Target", string.IsNullOrEmpty(txtTarget.Text) ? 0 : Convert.ToInt32(txtTarget.Text));
                    cmd.Parameters.AddWithValue("@Actual", string.IsNullOrEmpty(txtActual.Text) ? 0 : Convert.ToInt32(txtActual.Text));
                    cmd.Parameters.AddWithValue("@RejectQty", string.IsNullOrEmpty(txtReject.Text) ? 0 : Convert.ToInt32(txtReject.Text));
                    cmd.Parameters.AddWithValue("@ReworkQty", string.IsNullOrEmpty(txtRework.Text) ? 0 : Convert.ToInt32(txtRework.Text));
                    cmd.Parameters.AddWithValue("@Reason", txtReason.Text);
                    cmd.Parameters.AddWithValue("@DownTime", string.IsNullOrEmpty(txtDownTime.Text) ? 0 : Convert.ToInt32(txtDownTime.Text));
                    cmd.Parameters.AddWithValue("@Remarks", ddlRemarks.SelectedValue);

                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Saved Successfully');", true);
        }

        protected void GetData_Click(object sender, EventArgs e)
        {

        }

        
        private void LoadMachines()
        {
            string CS = "Data Source=ProBook;Initial Catalog=QRCODE;User ID=sa;Password=sa@2017;";
            //string conStr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("spGetMachines", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    ddlMachine.DataSource = dr;
                    ddlMachine.DataTextField = "MachineName";
                    ddlMachine.DataValueField = "Id";
                    ddlMachine.DataBind();
                    ddlMachine.Items.Insert(0, new ListItem("-- Select Machine --", "0"));
                }
            }
        }

        private void LoadOperators()
        {
            string CS = "Data Source=ProBook;Initial Catalog=QRCODE;User ID=sa;Password=sa@2017;";
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

        private void LoadProcess(int machineId)
        {
            string CS = "Data Source=ProBook;Initial Catalog=QRCODE;User ID=sa;Password=sa@2017;";

            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("spGetProcessByMachine", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MachineId", machineId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    ddlProcess.DataSource = dr;
                    ddlProcess.DataTextField = "ItemName";   // Display
                    ddlProcess.DataValueField = "ItemCode";  // Value
                    ddlProcess.DataBind();
                    ddlProcess.Items.Insert(0, new ListItem("-- Select Process --", "0"));
                }
            }
        }


        private void LoadCycleTime(string itemCode)
        {
            string CS = "Data Source=ProBook;Initial Catalog=QRCODE;User ID=sa;Password=sa@2017;";

            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("spGetCycleTimeByProcess", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ItemCode", itemCode);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        double cycleTime = Convert.ToDouble(result);
                        txtCycleTime.Text = cycleTime.ToString();
                        int target = (int)Math.Floor(3600 / cycleTime);
                        txtCycleTime.Text = target.ToString();
                    }
                    else
                    {
                        txtCycleTime.Text = "";
                    }
                }
            }
        }

        protected void DdlOT_SelectedIndexChanged(object sender, EventArgs e)
        {
            int otHours = Convert.ToInt32(DdlOT.SelectedValue);
            string shiftName = ddlShift.SelectedValue;
            DataTable dt = new DataTable();
            dt.Columns.Add("TimeSlot");
            // Load Normal Shift Slots from XML
            string xmlPath = Server.MapPath("~/TimeSlot.xml");
            System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
            doc.Load(xmlPath);
            var nodes = doc.SelectNodes("//Shift[@Name='" + shiftName + "']/Slot");
            DateTime lastEndTime = DateTime.MinValue;
            foreach (System.Xml.XmlNode node in nodes)
            {
                string slot = node.InnerText.Trim();
                dt.Rows.Add(slot);
                // Get last end time
                string[] parts = slot.Split('-');
                lastEndTime = DateTime.Parse(parts[1].Trim());
            }

            // ADD OT SLOTS
            for (int i = 0; i < otHours; i++)
            {
                DateTime start = lastEndTime.AddHours(i);
                DateTime end = start.AddHours(1);
                string newSlot = start.ToString("hh:mmtt") + " - " + end.ToString("hh:mmtt");
                dt.Rows.Add(newSlot);
            }

            // Bind to repeater
            rptProduction.DataSource = dt;
            rptProduction.DataBind();
        }

        protected void rptProduction_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
                return;

            var hdnTime = (HiddenField)e.Item.FindControl("hdnTime");
            var txtDownTime = (TextBox)e.Item.FindControl("txtDownTime");
            var ddlRemarks = (DropDownList)e.Item.FindControl("ddlRemarks");
            if (hdnTime == null || txtDownTime == null || ddlRemarks == null) return;
            string key = $"{ddlShift.SelectedValue}|{hdnTime.Value.Trim()}";
            var rules = new Dictionary<string, Tuple<string, string>>
            {
                { "G|09:00AM - 10:00AM", Tuple.Create("15", "Tea") },
                { "G|12:00PM - 01:00PM", Tuple.Create("30", "Lunch") },
                { "G|03:00PM - 04:00PM", Tuple.Create("15", "Tea") },
                { "A|07:00AM - 08:00AM", Tuple.Create("15", "Tea") },
                { "A|10:00AM - 11:00AM", Tuple.Create("30", "Lunch") },
                { "A|01:00PM - 02:00PM", Tuple.Create("15", "Tea") },
                { "B|01:00PM - 02:00PM", Tuple.Create("15", "Tea") },
                { "B|04:00PM - 05:00PM", Tuple.Create("30", "Lunch") },
                { "B|07:00PM - 08:00PM", Tuple.Create("15", "Tea") }
            };

            if (rules.ContainsKey(key))
            {
                var rule = rules[key];
                txtDownTime.Text = rule.Item1;
                ddlRemarks.SelectedValue = rule.Item2;
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string CS = "Data Source=ProBook;Initial Catalog=QRCODE;User ID=sa;Password=sa@2017;";

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                foreach (RepeaterItem item in rptProduction.Items)
                {
                    HiddenField hdnTime = (HiddenField)item.FindControl("hdnTime");
                    TextBox txtTarget = (TextBox)item.FindControl("txtTarget");
                    TextBox txtActual = (TextBox)item.FindControl("txtActual");
                    TextBox txtReject = (TextBox)item.FindControl("txtReject");
                    TextBox txtRework = (TextBox)item.FindControl("txtRework");
                    TextBox txtReason = (TextBox)item.FindControl("txtReason");
                    TextBox txtDownTime = (TextBox)item.FindControl("txtDownTime");
                    DropDownList ddlRemarks = (DropDownList)item.FindControl("ddlRemarks");

                    int actual = string.IsNullOrEmpty(txtActual.Text) ? 0 : Convert.ToInt32(txtActual.Text);
                    int reject = string.IsNullOrEmpty(txtReject.Text) ? 0 : Convert.ToInt32(txtReject.Text);
                    int rework = string.IsNullOrEmpty(txtRework.Text) ? 0 : Convert.ToInt32(txtRework.Text);

                    // Skip empty rows
                    if ((actual + reject + rework) == 0)
                    {
                        continue;
                    }

                    string query = @"
INSERT INTO HourlyProduction
(
    ProductionDate,
    Shift,
    Machine,
    Process,
    Operator,
    TimeSlot,
    CycleTime,
    Target,
    Actual,
    RejectQty,
    ReworkQty,
    Reason,
    DownTime,
    Remarks
)
VALUES
(
    @ProductionDate,
    @Shift,
    @Machine,
    @Process,
    @Operator,
    @TimeSlot,
    @CycleTime,
    @Target,
    @Actual,
    @RejectQty,
    @ReworkQty,
    @Reason,
    @DownTime,
    @Remarks
)";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@ProductionDate", txtDate.Text);
                    cmd.Parameters.AddWithValue("@Shift", ddlShift.SelectedValue);
                    cmd.Parameters.AddWithValue("@Machine", ddlMachine.SelectedValue);
                    cmd.Parameters.AddWithValue("@Process", ddlProcess.SelectedValue);
                    cmd.Parameters.AddWithValue("@Operator", ddlOperator.SelectedValue);
                    cmd.Parameters.AddWithValue("@TimeSlot", hdnTime.Value);

                    cmd.Parameters.AddWithValue("@CycleTime", string.IsNullOrEmpty(txtCycleTime.Text) ? 0 : Convert.ToInt32(txtCycleTime.Text));
                    cmd.Parameters.AddWithValue("@Target", string.IsNullOrEmpty(txtTarget.Text) ? 0 : Convert.ToInt32(txtTarget.Text));
                    cmd.Parameters.AddWithValue("@Actual", actual);
                    cmd.Parameters.AddWithValue("@RejectQty", reject);
                    cmd.Parameters.AddWithValue("@ReworkQty", rework);
                    cmd.Parameters.AddWithValue("@Reason", txtReason.Text);
                    cmd.Parameters.AddWithValue("@DownTime", string.IsNullOrEmpty(txtDownTime.Text) ? 0 : Convert.ToInt32(txtDownTime.Text));
                    cmd.Parameters.AddWithValue("@Remarks", ddlRemarks.SelectedValue);

                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Submit Successfully');", true);
        }

        private void BindTimeSlots(string shiftName)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("TimeSlot");
            string xmlPath = Server.MapPath("~/TimeSlot.xml");
            System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
            doc.Load(xmlPath);
            var nodes = doc.SelectNodes("//Shift[@Name='" + shiftName + "']/Slot");
            foreach (System.Xml.XmlNode node in nodes)
            {
                dt.Rows.Add(node.InnerText.Trim());
            }
            rptProduction.DataSource = dt;
            rptProduction.DataBind();
        }

        private void AddOTSlots(int hours)
        {
            List<string> timeList = new List<string>();
            foreach (RepeaterItem item in rptProduction.Items)
            {
                Literal lit = (Literal)item.FindControl("litTimeSlot");
                timeList.Add(lit.Text);
            }

            if (timeList.Count == 0) return;
            string lastSlot = timeList.Last();
            string[] parts = lastSlot.Split('-');
            DateTime lastEnd = DateTime.Parse(parts[1].Trim());

            for (int i = 0; i < hours; i++)
            {
                DateTime newStart = lastEnd;
                DateTime newEnd = newStart.AddHours(1);
                string slot = newStart.ToString("hh:mmtt") + " - " + newEnd.ToString("hh:mmtt");
                timeList.Add(slot);
                lastEnd = newEnd;
            }

            DataTable dt = new DataTable();
            dt.Columns.Add("TimeSlot");
            foreach (var t in timeList)
            {
                dt.Rows.Add(t);
            }
            rptProduction.DataSource = dt;
            rptProduction.DataBind();
        }

        
    }
}