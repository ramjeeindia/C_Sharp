using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADO._5_SqlInjection
{
    public partial class InjPrevention : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btngetitm_Click(object sender, EventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                //SqlCommand cmd = new SqlCommand("SELECT * FROM tblProductInventory WHERE ProductName Like @ProdName", con);
                //cmd.Parameters.AddWithValue("@ProdName",TextBox1.Text + "%");
                ////this method required two value for parameter and % for like command
                //con.Open();
                //GridView1.DataSource = cmd.ExecuteReader();
                //GridView1.DataBind();


                //SqlCommand cmd = new SqlCommand("SELECT ItemCode , ItemName, OnHand FROM OITM WHERE ItemName Like @ItemName", con);
                //cmd.Parameters.AddWithValue("@ItemName", TextBox1.Text + "%");
                ////this method required two value for parameter and % for like command
                //con.Open();
                //GridView1.DataSource = cmd.ExecuteReader();
                //GridView1.DataBind();



                // link with sql store procedure
                SqlCommand cmd = new SqlCommand("spGetItemName", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure; // this method call store proc
                cmd.Parameters.AddWithValue("@ItemName", TextBox1.Text + "%");
                con.Open();
                GridView1.DataSource = cmd.ExecuteReader();
                GridView1.DataBind();
            }
        }
    }
}