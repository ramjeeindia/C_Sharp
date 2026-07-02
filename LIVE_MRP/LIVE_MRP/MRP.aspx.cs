using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LIVE_MRP
{
    public partial class MRP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            //using (SqlConnection con = new SqlConnection(CS))
            //{
            //    con.Open();

            //    string query = @"SELECT RDR1.ItemCode , OITM.ItemName, 
            //            SUM(RDR1.OpenQty)- [WIPSTK] AS L1Qty  
            //            FROM RDR1 
            //            INNER JOIN OITM ON OITM.ItemCode =RDR1.ItemCode
            //            INNER JOIN (
            //                SELECT ItemCode , SUM(OnHand) AS WIPSTK 
            //                FROM OITW 
            //                WHERE WhsCode in ('MST','IQC','ASM','FGW','PKG','PWH') 
            //                GROUP BY ItemCode
            //            ) STK ON STK.ItemCode = RDR1.ItemCode
            //            WHERE RDR1.LineStatus ='O'   
            //            GROUP BY RDR1.ItemCode , OITM.ItemName , WIPSTK
            //            HAVING (SUM(RDR1.OpenQty)- WIPSTK) > 0";

            //    SqlCommand cmd = new SqlCommand(query, con);

            //    SqlDataReader dr = cmd.ExecuteReader();

            //    // Load into DataTable (optional for GridView)
            //    System.Data.DataTable dt = new System.Data.DataTable();
            //    dt.Load(dr);

            //    // Bind to GridView
            //    GridView1.DataSource = dt;
            //    GridView1.DataBind();

            //    // Insert into table
            //    foreach (System.Data.DataRow row in dt.Rows)
            //    {
            //        SqlCommand insertCmd = new SqlCommand(
            //            "INSERT INTO MRP_Result (ItemCode, ItemName, L1Qty) VALUES (@ItemCode, @ItemName, @L1Qty)", con);

            //        insertCmd.Parameters.AddWithValue("@ItemCode", row["ItemCode"]);
            //        insertCmd.Parameters.AddWithValue("@ItemName", row["ItemName"]);
            //        insertCmd.Parameters.AddWithValue("@L1Qty", row["L1Qty"]);

            //        insertCmd.ExecuteNonQuery();
            //    }
            //}
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                // Step 1: Check if table exists and delete data
                string checkAndDelete = @"
        IF OBJECT_ID('MRP_Result', 'U') IS NOT NULL
        BEGIN
            DELETE FROM MRP_Result
        END";

                SqlCommand deleteCmd = new SqlCommand(checkAndDelete, con);
                deleteCmd.ExecuteNonQuery();

                // Step 2: Insert fresh data
                string insertQuery = @"
        INSERT INTO MRP_Result (ItemCode, ItemName, L1Qty)
        SELECT RDR1.ItemCode , OITM.ItemName, 
               SUM(RDR1.OpenQty)- WIPSTK  
        FROM RDR1 
        INNER JOIN OITM ON OITM.ItemCode =RDR1.ItemCode
        INNER JOIN (
            SELECT ItemCode , SUM(OnHand) AS WIPSTK 
            FROM OITW 
            WHERE WhsCode in ('MST','IQC','ASM','FGW','PKG','PWH') 
            GROUP BY ItemCode
        ) STK ON STK.ItemCode = RDR1.ItemCode
        WHERE RDR1.LineStatus ='O' AND   WIPSTK >100
        GROUP BY RDR1.ItemCode , OITM.ItemName , WIPSTK
        HAVING (SUM(RDR1.OpenQty)- WIPSTK) > 0";

                SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                insertCmd.ExecuteNonQuery();

                // Step 3: Bind Grid (optional)
                SqlCommand cmd = new SqlCommand("SELECT * FROM MRP_Result", con);
                GridView1.DataSource = cmd.ExecuteReader();
                GridView1.DataBind();
            }
        }


    }
}