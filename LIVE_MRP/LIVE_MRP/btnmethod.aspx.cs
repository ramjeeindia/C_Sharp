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
    public partial class btnmethod : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private System.Data.DataTable LoadMRPData()
        {
            System.Data.DataTable dt = new System.Data.DataTable();

            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                // Step 1: Clear table (if exists)
                string clearQuery = @"
        IF OBJECT_ID('MRP_Result', 'U') IS NOT NULL
        BEGIN
            TRUNCATE TABLE MRP_Result
        END";

                SqlCommand clearCmd = new SqlCommand(clearQuery, con);
                clearCmd.ExecuteNonQuery();

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
        WHERE RDR1.LineStatus ='O' AND WIPSTK > 100
        GROUP BY RDR1.ItemCode , OITM.ItemName , WIPSTK
        HAVING (SUM(RDR1.OpenQty)- WIPSTK) > 0";

                SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                insertCmd.ExecuteNonQuery();

                // Step 3: Get data for GridView
                SqlCommand selectCmd = new SqlCommand("SELECT * FROM MRP_Result", con);
                SqlDataAdapter da = new SqlDataAdapter(selectCmd);
                da.Fill(dt);
            }

            return dt;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            System.Data.DataTable dt = LoadMRPData();

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }



        protected void Button2_Click(object sender, EventArgs e)
        {
            System.Data.DataTable dt = LoadMRPData();
            if (!IsPostBack)
            {
                GridView1.DataSource = LoadMRPData();
                GridView1.DataBind();
            }
        }
    }
}