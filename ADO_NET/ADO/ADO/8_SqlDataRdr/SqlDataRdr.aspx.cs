using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADO._8_SqlDataRdr
{
    public partial class SqlDataRdr : System.Web.UI.Page 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open(); // need to open before reader
                SqlCommand cmd = new SqlCommand ("SELECT ITEMCODE, ITEMNAME, ONHAND FROM OITM", con);

               // SqlDataReader rdr = new SqlDataReader(); WE CAN NOT USE 
                SqlDataReader rdr = cmd.ExecuteReader();
                GridView1.DataSource =	rdr;
                GridView1.DataBind ();

            }

        }

    }
}