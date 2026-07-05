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

namespace LIVE_MRP
{
    public partial class repeater : System.Web.UI.Page
    {
        string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                         
                ddlShift.SelectedValue = "General";
                BindTimeSlots("General");
                LoadMachines();
                LoadOperators();
                ddlProcess.Items.Insert(0, new ListItem("-- Select Process --", "0"));

            }
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
        protected void btnSave_Click(object sender, EventArgs e)
        {

        }

        protected void ddlMachine_SelectedIndexChanged(object sender, EventArgs e)
        {
            int machineId = Convert.ToInt32(ddlMachine.SelectedValue);

            LoadProcess(machineId);
        }


        protected void ddlShift_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindTimeSlots(ddlShift.SelectedValue);
        }

        protected void ddlProcess_SelectedIndexChanged(object sender, EventArgs e)
        {
            string itemCode = ddlProcess.SelectedValue;

            LoadCycleTime(itemCode);
            
        }

        protected void txtCycleTime_TextChanged(object sender, EventArgs e)
        {
           
        }

        public int CalculateTarget(double cycleTime)
        {
            return (int)Math.Floor(3600 / cycleTime);
        }

        protected void ddlOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "calc", "calculateTarget();", true);
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {

        }

        private void LoadMachines()
        {
            string conStr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("spGetMachines", con)) // ✅ FIXED NAME
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    ddlMachine.DataSource = dr;
                    ddlMachine.DataTextField = "MachineName"; // matches SP column
                    ddlMachine.DataValueField = "Id";         // matches SP column
                    ddlMachine.DataBind();

                    ddlMachine.Items.Insert(0, new ListItem("-- Select Machine --", "0")); // ✅ better
                }
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

        private void LoadProcess(int machineId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
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
            string conStr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("spGetCycleTimeByProcess", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ItemCode", itemCode);

                    con.Open();

                    object result = cmd.ExecuteScalar();

                    //if (result != null)
                    //{
                    //    txtCycleTime.Text = result.ToString(); // ✅ Auto fill
                    //}
                    //else
                    //{
                    //    txtCycleTime.Text = "";
                    //}

                    if (result != null)
                    {
                        double cycleTime = Convert.ToDouble(result);
                        txtCycleTime.Text = cycleTime.ToString();

                        // ✅ Hourly Target = 3600 / CycleTime
                        int target = (int)Math.Floor(3600 / cycleTime);

                        txtCycleTime.Text = target.ToString(); // 🔥 show in textbox/label
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

            // 🔹 1. Load Normal Shift Slots from XML
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

            // 🔥 2. ADD OT SLOTS
            for (int i = 0; i < otHours; i++)
            {
                DateTime start = lastEndTime.AddHours(i);
                DateTime end = start.AddHours(1);

                string newSlot = start.ToString("hh:mmtt") + " - " + end.ToString("hh:mmtt");

                dt.Rows.Add(newSlot);
            }

            // 🔹 Bind to repeater
            rptProduction.DataSource = dt;
            rptProduction.DataBind();
        }

        protected void rptProduction_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HiddenField hdnTime = (HiddenField)e.Item.FindControl("hdnTime");
                TextBox txtDownTime = (TextBox)e.Item.FindControl("txtDownTime");
                DropDownList ddlRemarks = (DropDownList)e.Item.FindControl("ddlRemarks");

                if (hdnTime == null || txtDownTime == null || ddlRemarks == null)
                    return;

                string timeSlot = hdnTime.Value.Trim();

                switch (timeSlot)
                {
                    case "09:00AM - 10:00AM" when ddlShift.SelectedValue == "General":
                        txtDownTime.Text = "10";
                        ddlRemarks.SelectedValue = "Tea";
                        break;

                    case "12:00PM - 01:00PM" when ddlShift.SelectedValue == "General":
                        txtDownTime.Text = "30";
                        ddlRemarks.SelectedValue = "Lunch";
                        break;

                    case "03:00PM - 04:00PM" when ddlShift.SelectedValue == "General":
                        txtDownTime.Text = "10";
                        ddlRemarks.SelectedValue = "Tea";
                        break;

                    case "07:00AM - 08:00AM" when ddlShift.SelectedValue == "A":
                        txtDownTime.Text = "10";
                        ddlRemarks.SelectedValue = "Tea";
                        break;

                    case "10:00AM - 11:00AM" when ddlShift.SelectedValue == "A":
                        txtDownTime.Text = "30";
                        ddlRemarks.SelectedValue = "Lunch";
                        break;

                    case "01:00PM - 02:00PM" when ddlShift.SelectedValue == "A":
                        txtDownTime.Text = "10";
                        ddlRemarks.SelectedValue = "Tea";
                        break;
                }
            }
        }


    }
}