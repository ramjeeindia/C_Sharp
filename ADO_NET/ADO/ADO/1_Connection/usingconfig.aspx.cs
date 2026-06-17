using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace ADO._1_Connection
{
    public partial class usingconfig : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string CS = "data source =.; database=SBODemoIN; integrated Security =SSPI";
            using (SqlConnection con = new SqlConnection(CS)) // using syntax auto close the connect after execution
            {
                SqlCommand cmd = new SqlCommand("SELECT TOP 5 ItemCode, ItemName, ItmsGrpCod , OnHand FROM OITM", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                GridView1.DataSource = rdr;
                GridView1.DataBind();
            }
        }
    }
}