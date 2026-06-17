using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace ADO._1_Connection
{
    public partial class remoteconn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = "Data Source=SAPSERV;Initial Catalog=TESTSHAPLJUN;User ID=sa;Password=sa@2017;";
            // Data Source servername or IP Address
            // database indication as Initial Catalog or database

            // Using statement automatically closes and disposes resources even if errors occur
            SqlConnection con = new SqlConnection(connectionString);

            try
            {
                SqlCommand cmd = new SqlCommand("SELECT TOP 5 ItemCode,ItemName,ItmsGrpCod,OnHand FROM OITM WHERE ItmsGrpCod = 103", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                GridView1.DataSource = rdr;
                GridView1.DataBind();
            }
            catch
            {
                Response.Write("The Database is not connected");
            }
            finally 
            { 
                con.Close(); 
            }
            
        }
    }
}