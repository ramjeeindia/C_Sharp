using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ImageDataUploadinSql
{
    public partial class ImageUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Visible = false;
                HyperLink1.Visible = false;
            }
        }

        protected void btnupload_Click(object sender, EventArgs e)
        {
            HttpPostedFile postedFile = FileUpload1.PostedFile;
            string filename = Path.GetFileName(postedFile.FileName);
            string fileExtension = Path.GetExtension(filename);
            int fileSize = postedFile.ContentLength;

            if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".png" ||
                fileExtension.ToLower() == ".bmp" || fileExtension.ToLower() == ".gif")
            {
                Stream stream = postedFile.InputStream;
                BinaryReader binaryreader = new BinaryReader(stream);
                byte[] bytes = binaryreader.ReadBytes((int)stream.Length);

                // ado connection string
                string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Your database operations here
                    SqlCommand cmd = new SqlCommand("spUploadImage", con); // link to stored procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    // add parameters to the command

                    SqlParameter paramName = new SqlParameter();
                    {
                        paramName.ParameterName = "@Name";
                        paramName.Value = filename;
                    }
                    cmd.Parameters.Add(paramName);

                    //parameter for file size 
                    SqlParameter paramSize = new SqlParameter();
                    {
                        paramSize.ParameterName = "@Size";
                        paramSize.Value = fileSize;
                    }
                    cmd.Parameters.Add(paramSize);

                    //parameter for Image data 
                    SqlParameter paramImageData = new SqlParameter();
                    {
                        paramImageData.ParameterName = "@ImageData";
                        paramImageData.Value = bytes;
                    }
                    cmd.Parameters.Add(paramImageData);

                    //parameter for Output ID
                    SqlParameter paramNewId = new SqlParameter();
                    {
                        paramNewId.ParameterName = "@NewId";
                        paramNewId.Value = -1; // get the data from db
                        paramNewId.Direction = ParameterDirection.Output;
                    }
                    cmd.Parameters.Add(paramNewId);

                    // open the connection and execute the command

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    // lbl message if file uploaded successfully
                    lblMessage.Visible = true;
                    lblMessage.Text = "file uploaded successfully";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    HyperLink1.Visible = true;
                    // redirect to the page to display the image
                    HyperLink1.NavigateUrl = "~/ImageData.aspx?Id=" + cmd.Parameters["@NewId"].Value.ToString();
                }

            }
            else
            {
                // return the message in red color if the file is not an image
                lblMessage.Visible = true;
                lblMessage.Text = "Only image files (jpg, png, bmp, gif) are allowed.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                HyperLink1.Visible = false;
                return;
            }
        }
    }
}
        
    
