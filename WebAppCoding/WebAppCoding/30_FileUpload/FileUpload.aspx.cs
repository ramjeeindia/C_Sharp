using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppCoding._30_FileUpload
{
    public partial class FileUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower(); //Get the file extension
            if (fileExtension.ToLower() != ".doc" && fileExtension.ToLower() != ".docx")
            {
                lblMessage.Text = "Only .doc and .docx files are allowed"; //Display error message
                lblMessage.ForeColor = System.Drawing.Color.Red; //Set the message color to red
            }
            else
            {
                if (FileUpload1.HasFile) //Check if a file is selected
                {
                    int fileSize = FileUpload1.PostedFile.ContentLength; //Get the file size
                    if (fileSize > 2097152)
                    {
                        lblMessage.Text = "File Size should be less than 2MB";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        FileUpload1.SaveAs(Server.MapPath("~/Uploads/") + FileUpload1.FileName);//Save the file to the server
                        lblMessage.Text = "File Uploaded Successfully"; //Display success message
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                }
                else
                {
                    lblMessage.Text = "Please select a file to upload"; //Display error message
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}
    
