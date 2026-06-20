using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADO._8_SqlDataRdr
{
    public partial class rdreachrow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open(); 
                SqlCommand cmd = new SqlCommand("SELECT ITEMCODE, ITEMNAME, ONHAND FROM OITM", con);

                
                using (SqlDataReader rdr = cmd.ExecuteReader())  
                {
                    DataTable newtable = new DataTable();  // create table like tmp table
                    newtable.Columns.Add("Code");
                    newtable.Columns.Add("ItemDescription");
                    newtable.Columns.Add("Stock");
                    newtable.Columns.Add("SafetyStock");

                    while (rdr.Read()) 
                    { 
                        DataRow datarow = newtable.NewRow();

                        int ActualStock = Convert.ToInt32(rdr["ONHAND"]);
                        double SafetyStock = ActualStock * 0.9;

                        datarow["Code"] = rdr["ITEMCODE"];
                        datarow["ItemDescription"] = rdr["ITEMNAME"];
                        datarow["Stock"] = ActualStock;   //rdr["ITEMCODE"];
                        datarow["SafetyStock"] = SafetyStock;
                        newtable.Rows.Add(datarow); // add all in data row

                    }

                    GridView1.DataSource = newtable;
                    GridView1.DataBind();

                }


            }
        }
    }
}