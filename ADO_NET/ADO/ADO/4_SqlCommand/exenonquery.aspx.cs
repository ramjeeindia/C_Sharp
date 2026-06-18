using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADO._4_SqlCommand
{
    public partial class exenonquery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = ("SELECT COUNT(ItemCode) FROM OITM ");
                cmd.Connection = con;
                con.Open();
                int TotalRow = (int)cmd.ExecuteScalar();
                Response.Write("The Total Item Count is : " + TotalRow.ToString());

            }
        }
    }
}