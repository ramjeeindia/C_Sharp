using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace LIVE_MRP
{
    public partial class repeater : System.Web.UI.Page
    {
        string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMachines();
                BindTimeSlots();
                ddlProcess.Enabled = false;
                txtCycleTime.ReadOnly = true;
            }
        }

        private void BindTimeSlots()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("TimeSlot");
           
            dt.Rows.Add("06:00AM - 07:00AM");
            dt.Rows.Add("07:00AM - 08:00AM");


            dt.Rows.Add("08:00AM - 09:00AM");
            dt.Rows.Add("09:00AM - 10:00AM");
            dt.Rows.Add("10:00AM - 11:00AM");
            dt.Rows.Add("11:00AM - 12:00PM");

            dt.Rows.Add("12:00PM - 01:00PM");
            dt.Rows.Add("01:00PM - 02:00PM");
            dt.Rows.Add("02:00PM - 03:00PM");
            dt.Rows.Add("03:00PM - 04:00PM");

            dt.Rows.Add("04:00PM - 05:00PM");
            dt.Rows.Add("05:00PM - 06:00PM");


            dt.Rows.Add("06:00PM - 07:00PM");
            dt.Rows.Add("07:00PM - 08:00PM");
            dt.Rows.Add("08:00PM - 09:00PM");
            dt.Rows.Add("09:00PM - 10:00PM");
            dt.Rows.Add("10:00PM - 11:00PM");
            
          
            rptProduction.DataSource = dt;
            rptProduction.DataBind();
        }

        private DataSet GetData(string spName, SqlParameter param)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(spName, con))
                {
                    da.SelectCommand.CommandType = CommandType.StoredProcedure;
                    if (param != null)
                    {
                        da.SelectCommand.Parameters.Add(param);
                    }

                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    return ds;
                }
            }
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {

        }

        protected void ddlMachine_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlMachine.SelectedIndex == 0)
            {
                ddlProcess.Items.Clear();
                ddlProcess.Items.Insert(0, new ListItem("Select Process", "0"));
                txtCycleTime.Text = "";

                if (ddlMachine.SelectedIndex == 0)
                {
                    ddlProcess.Enabled = false;
                    return;
                }

                ddlProcess.Enabled = true;

                SqlParameter param = new SqlParameter("@MachineCode", ddlMachine.SelectedValue);
                ddlProcess.DataSource = GetData("spGetProcessByMachine", param);
                ddlProcess.DataTextField = "ItemName";
                ddlProcess.DataValueField = "ItemCode";
                ddlProcess.DataBind();

                ddlProcess.Items.Insert(0, new ListItem("Select Process", "0"));

            }
        }


        protected void ddlShift_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlProcess_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtCycleTime.Text = "";

            if (ddlProcess.SelectedIndex == 0)
                return;

            SqlParameter param = new SqlParameter("@ItemCode", ddlProcess.SelectedValue);
            DataSet ds = GetData("spGetCycleTimeByProcess", param);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtCycleTime.Text = ds.Tables[0].Rows[0]["CycleTime"].ToString();
            }

        }

        protected void txtCycleTime_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlOperator_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {

        }

        private void LoadMachines()
        {
            ddlMachine.DataSource = GetData("spGetMachines", null);
            ddlMachine.DataTextField = "MachineName";
            ddlMachine.DataValueField = "Id";
            ddlMachine.DataBind();

            ddlMachine.Items.Insert(0, new ListItem("Select Machine", "0"));
        }

        protected void DdlOT_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}