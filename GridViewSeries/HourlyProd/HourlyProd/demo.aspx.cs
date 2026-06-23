using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace HourlyProd
{
    public partial class demo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("TimeSlot");

            dt.Rows.Add("06-07");
            dt.Rows.Add("07-08");
            dt.Rows.Add("08-09");
            dt.Rows.Add("09-10");
            dt.Rows.Add("10-11");
            dt.Rows.Add("11-12");
            dt.Rows.Add("12-01");

            gvProd.DataSource = dt;
            gvProd.DataBind();
        }

        protected void gvProd_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlRemark");

                List<string> remarks = new List<string>()
                {
                    "--Select--",
                    "Admin Activity",
                    "Electrical",
                    "Lunch Break",
                    "Maintenance",
                    "Material Shortage",
                    "Model Change",
                    "Operator Change",
                    "Tea Break",
                    "Trial Runs"
                };

                ddl.DataSource = remarks;
                ddl.DataBind();
            }
        }

        protected void btnFillTarget_Click(object sender, EventArgs e)
        {
            string cycle = txtCycleTime.Text;

            foreach (GridViewRow row in gvProd.Rows)
            {
                TextBox txtTarget = (TextBox)row.FindControl("txtTarget");
                txtTarget.Text = cycle;
            }
        }


        protected void ddlShift_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void txtProdDate_TextChanged()
        {

        }

        protected void ddlProcess_SelectedIndexChanged()
        {

        }

        protected void txtCycleTime_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click()
        {
            foreach (GridViewRow row in gvProd.Rows)
            {
                string time = row.Cells[0].Text;

                string target = ((TextBox)row.FindControl("txtTarget")).Text;
                string actual = ((TextBox)row.FindControl("txtActual")).Text;
                string reject = ((TextBox)row.FindControl("txtReject")).Text;
                string rework = ((TextBox)row.FindControl("txtRework")).Text;
                string remark = ((DropDownList)row.FindControl("ddlRemark")).SelectedValue;

                // 🔥 Example: Save to DB
                // InsertProduction(time, target, actual, reject, rework, remark);

                System.Diagnostics.Debug.WriteLine(
                    time + " | " + target + " | " + actual + " | " + remark
                );
            }
        }

        protected void txtProdDate_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlMachine_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlOperator_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlProcess_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnSave_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

        }
    }
}