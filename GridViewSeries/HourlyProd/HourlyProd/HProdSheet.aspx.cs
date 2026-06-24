using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace HourlyProd
{
    public partial class HProdSheet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOperators();
                LoadProcess();
                LoadMachine();
                BindRemarks();
                txtProdDate.Text = DateTime.Now.ToString("dd-MM-yyyy");
            }
        }

        private void LoadOperators()
        {
            string connectionString = "Data Source=SAPSERV;Initial Catalog=SAVIOR;User ID=sa;Password=sa@2017;";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT DISTINCT Operator_Id, Operator_Name FROM VWSAVIORATT ORDER BY Operator_Name",
                    con);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                ddlOperator.DataSource = rdr;
                ddlOperator.DataTextField = "Operator_Name"; // Display
                ddlOperator.DataValueField = "Operator_Id";  // Value
                ddlOperator.DataBind();
            }

            // Default item
            ddlOperator.Items.Insert(0, new ListItem("--Select Operator--", "0"));
        }

        private void BindRemarks()
        {
            List<string> remarks = new List<string>()
            {
                "--Select--",
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
            ddl.DataSource = data;
            ddl.DataBind();
        }

        private void LoadProcess()
        {
            string conStr = "Data Source=SAPSERV;Initial Catalog=SHAPLLIVE;User ID=sa;Password=sa@2017;";

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("spProcessName", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
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

        //private void LoadReason()
        //{
        //    string conStr = "Data Source=SAPSERV;Initial Catalog=SHAPLLIVE;User ID=sa;Password=sa@2017;";

        //    using (SqlConnection con = new SqlConnection(conStr))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("SELECT ResonValue, ReasonText  FROM ReasonList ORDER BY ReasonText", con))
        //        {
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            con.Open();
        //            SqlDataReader dr = cmd.ExecuteReader();
        //            ddlprocess.DataSource = dr;
        //            ddlprocess.DataTextField = "ItemName";   // Display
        //            ddlprocess.DataValueField = "ItemCode";  // Value
        //            ddlprocess.DataBind();
        //            ddlprocess.Items.Insert(0, "-- Select Reason --");
        //        }
        //    }
        //}
        private void LoadMachine()
        {
            string conStr = "Data Source=SAPSERV;Initial Catalog=SHAPLLIVE;User ID=sa;Password=sa@2017;";

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("spMachineMaster", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    ddlMachine.DataSource = dr;
                    ddlMachine.DataTextField = "ItemName";   // Display
                    ddlMachine.DataValueField = "ItemCode";  // Value
                    ddlMachine.DataBind();
                    ddlMachine.Items.Insert(0, "-- Select Machine --");
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string cs = "Data Source=SAPSERV;Initial Catalog=QRCODE;User ID=sa;Password=sa@2017;";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Function to insert row
                SaveOrUpdateRow("06-07", TextBox1.Text, TextBox2.Text, TextBox3.Text, TextBox4.Text, ddlRemark1.SelectedValue, con);
                SaveOrUpdateRow("07-08", TextBox5.Text, TextBox6.Text, TextBox7.Text, TextBox8.Text, ddlRemark2.SelectedValue, con);
                SaveOrUpdateRow("08-09", TextBox9.Text, TextBox10.Text, TextBox11.Text, TextBox12.Text, ddlRemark3.SelectedValue, con);
                SaveOrUpdateRow("09-10", TextBox13.Text, TextBox14.Text, TextBox15.Text, TextBox16.Text, ddlRemark4.SelectedValue, con);
                SaveOrUpdateRow("10-11", TextBox17.Text, TextBox18.Text, TextBox19.Text, TextBox20.Text, ddlRemark5.SelectedValue, con);
                SaveOrUpdateRow("11-12", TextBox21.Text, TextBox22.Text, TextBox23.Text, TextBox24.Text, ddlRemark6.SelectedValue, con);
                SaveOrUpdateRow("12-13", TextBox25.Text, TextBox26.Text, TextBox27.Text, TextBox28.Text, ddlRemark7.SelectedValue, con);
                SaveOrUpdateRow("13-14", TextBox29.Text, TextBox30.Text, TextBox31.Text, TextBox32.Text, ddlRemark8.SelectedValue, con);
                SaveOrUpdateRow("14-15", TextBox33.Text, TextBox34.Text, TextBox35.Text, TextBox36.Text, ddlRemark9.SelectedValue, con);
                SaveOrUpdateRow("15-16", TextBox37.Text, TextBox38.Text, TextBox39.Text, TextBox40.Text, ddlRemark10.SelectedValue, con);
                SaveOrUpdateRow("16-17", TextBox41.Text, TextBox42.Text, TextBox43.Text, TextBox44.Text, ddlRemark11.SelectedValue, con);
                SaveOrUpdateRow("17-18", TextBox45.Text, TextBox46.Text, TextBox47.Text, TextBox48.Text, ddlRemark12.SelectedValue, con);
                SaveOrUpdateRow("18-19", TextBox49.Text, TextBox50.Text, TextBox51.Text, TextBox52.Text, ddlRemark13.SelectedValue, con);
                SaveOrUpdateRow("19-20", TextBox53.Text, TextBox54.Text, TextBox55.Text, TextBox56.Text, ddlRemark14.SelectedValue, con);
                SaveOrUpdateRow("20-21", TextBox57.Text, TextBox58.Text, TextBox59.Text, TextBox60.Text, ddlRemark15.SelectedValue, con);
                SaveOrUpdateRow("21-22", TextBox61.Text, TextBox62.Text, TextBox63.Text, TextBox64.Text, ddlRemark16.SelectedValue, con);
                SaveOrUpdateRow("22-23", TextBox65.Text, TextBox66.Text, TextBox67.Text, TextBox68.Text, ddlRemark17.SelectedValue, con);
            }

            Response.Write("<script>alert('Data Saved Successfully');</script>");
        }

        protected void ddlOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            string name = ddlOperator.SelectedItem.Text;
            string id = ddlOperator.SelectedValue;

            // Example usage
            //Response.Write("Selected: " + name);
        }

        void SaveOrUpdateRow(string time, string t, string a, string r, string rw, string remarks, SqlConnection con)
        {
            string checkQuery = @"SELECT COUNT(*) FROM ProductionSheet 
                          WHERE ProdDate=@date 
                          AND Shift=@Shift
                          AND MachineID=@mc 
                          AND OperatorID=@op                          
                          AND ProcessName=@process
                          AND TimeSlot=@time";

            SqlCommand checkCmd = new SqlCommand(checkQuery, con);

            checkCmd.Parameters.AddWithValue("@date", txtProdDate.Text);
            checkCmd.Parameters.AddWithValue("@Shift", ddlshift.SelectedValue);
            checkCmd.Parameters.AddWithValue("@op", ddlOperator.SelectedValue);
            checkCmd.Parameters.AddWithValue("@mc", ddlMachine.SelectedValue);
            checkCmd.Parameters.AddWithValue("@process", ddlprocess.Text);
            checkCmd.Parameters.AddWithValue("@time", time);

            int count = (int)checkCmd.ExecuteScalar();

            if (count > 0)
            {
                // ✅ UPDATE
                SqlCommand updateCmd = new SqlCommand(@"
        UPDATE ProductionSheet SET
            TargetQty=@target,
            ActualQty=@actual,
            RejectQty=@reject,
            ReworkQty=@rework,
            CycleTime=@cycle
            Remarks=@remarks
        WHERE ProdDate=@date
          AND Shift=@Shift
          AND OperatorID=@op 
          AND MachineID=@mc 
          AND ProcessName=@process
          AND TimeSlot=@time", con);

                updateCmd.Parameters.AddWithValue("@target", string.IsNullOrEmpty(t) ? 0 : Convert.ToInt32(t));
                updateCmd.Parameters.AddWithValue("@actual", string.IsNullOrEmpty(a) ? 0 : Convert.ToInt32(a));
                updateCmd.Parameters.AddWithValue("@reject", string.IsNullOrEmpty(r) ? 0 : Convert.ToInt32(r));
                updateCmd.Parameters.AddWithValue("@rework", string.IsNullOrEmpty(rw) ? 0 : Convert.ToInt32(rw));

                updateCmd.Parameters.AddWithValue("@cycle", txtCycleTime.Text);

                updateCmd.Parameters.AddWithValue("@remarks", remarks);

                updateCmd.Parameters.AddWithValue("@date", txtProdDate.Text);
                updateCmd.Parameters.AddWithValue("@Shift", ddlshift.SelectedValue);
                updateCmd.Parameters.AddWithValue("@op", ddlOperator.SelectedValue);
                updateCmd.Parameters.AddWithValue("@mc", ddlMachine.SelectedValue);
                updateCmd.Parameters.AddWithValue("@process", ddlprocess.Text);
                updateCmd.Parameters.AddWithValue("@time", time);

                updateCmd.ExecuteNonQuery();
            }
            else
            {
                // ✅ INSERT
                SqlCommand insertCmd = new SqlCommand(@"
        INSERT INTO ProductionSheet
        (ProdDate,Shift, OperatorID, MachineID, ProcessName, CycleTime, TimeSlot, TargetQty, ActualQty, RejectQty, ReworkQty, Remarks)
        VALUES (@date,@Shift,@op,@mc,@process,@cycle,@time,@target,@actual,@reject,@rework,@remarks)", con);

                insertCmd.Parameters.AddWithValue("@date", txtProdDate.Text);
                insertCmd.Parameters.AddWithValue("@shift", ddlshift.SelectedValue);
                insertCmd.Parameters.AddWithValue("@op", ddlOperator.SelectedValue);
                insertCmd.Parameters.AddWithValue("@mc", ddlMachine.SelectedValue);
                insertCmd.Parameters.AddWithValue("@process", ddlprocess.Text);
                insertCmd.Parameters.AddWithValue("@cycle", txtCycleTime.Text);

                insertCmd.Parameters.AddWithValue("@remarks", remarks);

                insertCmd.Parameters.AddWithValue("@time", time);
                insertCmd.Parameters.AddWithValue("@target", string.IsNullOrEmpty(t) ? 0 : Convert.ToInt32(t));
                insertCmd.Parameters.AddWithValue("@actual", string.IsNullOrEmpty(a) ? 0 : Convert.ToInt32(a));
                insertCmd.Parameters.AddWithValue("@reject", string.IsNullOrEmpty(r) ? 0 : Convert.ToInt32(r));
                insertCmd.Parameters.AddWithValue("@rework", string.IsNullOrEmpty(rw) ? 0 : Convert.ToInt32(rw));

                insertCmd.ExecuteNonQuery();
            }
        }


        protected void txtProdDate_TextChanged(object sender, EventArgs e)
        {
            
        }

        protected void ddlMachine_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void txtCycleTime_TextChanged(object sender, EventArgs e)
        {

        }
                
    }
}