using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;


namespace ProductionApp2
{
    public partial class Login : System.Web.UI.Page
    {
        string CS = "Data Source=ProIT;Initial Catalog=SHAPL;User ID=sa;Password=sa@1947;";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 🔁 Load Remember Me
                if (Request.Cookies["UserInfo"] != null)
                {
                    txtUserName.Text = Request.Cookies["UserInfo"]["UserName"];
                    txtPassword.Attributes["value"] = Request.Cookies["UserInfo"]["Password"];
                }
            }
        }

        public string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();

                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2")); 
                }

                return builder.ToString();
            }
        }

        protected void txtUserName_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtPassword_TextChanged(object sender, EventArgs e)
        {

        }

        protected void chkRemember_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUserName.Text.Trim();
            string password = txtPassword.Text.Trim();

            string hashedPassword = HashPassword(password); // 🔐 IMPORTANT

            string CS = "Data Source=ProIT;Initial Catalog=SHAPL;User ID=sa;Password=sa@1947;";

            using (SqlConnection con = new SqlConnection(CS))
            {
                string query = "SELECT Role FROM Users WHERE UserName=@u AND Password=@p";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@u", username);
                cmd.Parameters.AddWithValue("@p", hashedPassword);

                con.Open();
                object role = cmd.ExecuteScalar();

                if (role != null)
                {
                    // ✅ Session
                    Session["UserName"] = username;
                    Session["Role"] = role.ToString();

                    // ✅ Remember Me
                    if (chkRemember.Checked)
                    {
                        Response.Cookies["UserInfo"]["UserName"] = username;
                        Response.Cookies["UserInfo"]["Password"] = password;
                        Response.Cookies["UserInfo"].Expires = DateTime.Now.AddDays(7);
                    }

                    // 🔀 Redirect
                    if (role.ToString() == "Admin")
                        Response.Redirect("ProductionApp.aspx");
                    else
                        Response.Redirect("UserDashboard.aspx");
                }
                else
                {
                    Response.Write("<script>alert('❌ Invalid Username or Password');</script>");
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Write(HashPassword("user123"));
        }
    }
}