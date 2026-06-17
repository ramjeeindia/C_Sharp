using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient; // This is used for Sql connection
using System.Data.OleDb;
using System.Data.Odbc;



namespace ADO._1_Connection
{
    public partial class localconn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("data source =.; database=SBODemoIN; integrated Security =SSPI");
            SqlCommand cmd =  new SqlCommand("SELECT TOP 5 ItemCode, ItemName, ItmsGrpCod , OnHand FROM OITM",con);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            GridView1.DataSource = rdr;
            GridView1.DataBind();
            con.Close();
        }
    }
}