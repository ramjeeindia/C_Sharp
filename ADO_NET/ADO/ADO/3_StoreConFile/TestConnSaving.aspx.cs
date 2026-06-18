using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration; // This class is responsible for read the config file

namespace ADO._3_StoreConFile
{
    public partial class TestConnSaving : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string CS = "data source =.; database=SBODemoIN; integrated Security =SSPI";
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            //string CS = ConfigurationManager.ConnectionStrings[1].ConnectionString;
            //string CS = ConfigurationManager.ConnectionStrings["REMOTEDEMODB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
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