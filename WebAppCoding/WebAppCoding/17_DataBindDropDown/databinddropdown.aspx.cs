using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppCoding._17_DataBindDropDown
{
    public partial class databinddropdown : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
                // using statement ensures that the connection is closed and disposed properly, even if an exception occurs
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("SELECT TOP 5 ItemCode,ItemName, Onhand FROM OITM", con);
                    con.Open();
                    DropDownList1.DataSource = cmd.ExecuteReader();
                    //DropDownList1.DataTextField = "ItemName";
                    //DropDownList1.DataValueField = "ItemCode";
                    DropDownList1.DataBind();
                }
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}