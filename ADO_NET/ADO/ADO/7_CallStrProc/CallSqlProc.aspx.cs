using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace ADO._7_CallStrProc
{
    public partial class CallSqlProc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using(SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("spAddEmployee", con); // Call SQL store Proc
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                // link all parameter condition as per sql
                cmd.Parameters.AddWithValue("@Name", txtempname.Text); // link with input textbox 1
                cmd.Parameters.AddWithValue("@Gender", ddlGender.Text);
                cmd.Parameters.AddWithValue("@Salary", ddlGender.Text);

                // autogenerate oemply id as output parameter
                SqlParameter outputempid = new SqlParameter();
                outputempid.ParameterName = "@EmployeeId";
                outputempid.SqlDbType = System.Data.SqlDbType.Int;  // output is int
                outputempid.Direction = System.Data.ParameterDirection.Output;
                cmd.Parameters.Add(outputempid);

                con.Open();
                cmd.ExecuteNonQuery();

                string EmpId = outputempid.Value.ToString();

                lblmessage.Text = "New Employee Id Genereated : " + EmpId;
            }
        }
    }
}