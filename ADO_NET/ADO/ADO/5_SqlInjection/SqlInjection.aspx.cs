using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADO._5_SqlInjection
{
    public partial class SqlInjection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btngetitm_Click(object sender, EventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                //string Command = ("SELECT ITEMCODE, ITEMNAME, ONHAND FROM OITM WHERE ITEMNAME LIKE '" + TextBox1.Text + "%'");
                //SqlCommand cmd = new SqlCommand (Command, con);
                //con.Open();
                //GridView1.DataSource = cmd.ExecuteReader();
                //GridView1.DataBind();


                // ANOTHER TABLE EXAMPLE

                SqlCommand cmd = new SqlCommand("SELECT * FROM tblProductInventory WHERE ProductName Like '"+
                    TextBox1.Text + "%'", con);
                con.Open();
                GridView1.DataSource = cmd.ExecuteReader();
                GridView1.DataBind();

            }

        }
    }
}