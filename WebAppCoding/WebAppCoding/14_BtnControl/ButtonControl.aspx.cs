using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppCoding._14_BtnControl
{
    public partial class ButtonControl : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Write("Submit button is clicked Saksham and Trisha Ticket Confirmed");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Write("Link button is clicked");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Write("Image button is clicked");
        }
    }
}
    
