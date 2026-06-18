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
    public partial class insertnonquery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                //SqlCommand cmd = new SqlCommand();
                //cmd.CommandText = ("INSERT INTO [dbo].[tblCities] VALUES('PATNA', 1)");
                //cmd.Connection = con;
                //con.Open();
                //int TotalRowAffected = cmd.ExecuteNonQuery();
                //Response.Write("The Total Row Affected is : " + TotalRowAffected.ToString());


                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();

                cmd.CommandText = ("DELETE FROM [dbo].[tblCities] WHERE CityId = 29");
                int TotalRowDel = cmd.ExecuteNonQuery();
                Response.Write("The Total Row Deleted is : " + TotalRowDel.ToString() + "</br>");

                cmd.CommandText = ("INSERT INTO [dbo].[tblCities] VALUES('PATNA', 1)");
                int TotalRowAffected = cmd.ExecuteNonQuery();
                Response.Write("The Total Row Inserted is : " + TotalRowAffected.ToString() + "</br>");

                cmd.CommandText = ("UPDATE [dbo].[tblCities] SET CityName = 'Rajgir' WHERE CityId=25");
                int TotalRowUpdated = cmd.ExecuteNonQuery();
                Response.Write("The Total Row Updated is : " + TotalRowUpdated.ToString() + "</br>");

            }
        }
    }
}