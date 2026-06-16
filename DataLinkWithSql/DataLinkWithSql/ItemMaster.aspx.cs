using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataLinkWithSql
{
	public partial class ItemMaster : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            SqlConnection con = new SqlConnection("Data Source=.;database=SBODemoIN;Integrated Security= SSPI");
            SqlCommand cmd = new SqlCommand("SELECT TOP 5 ItemCode, ItemName, ItmsGrpCod, OnHand FROM OITM", con);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            GridView1.DataSource = rdr;
            GridView1.DataBind();
            con.Close();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}