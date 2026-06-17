using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormPath.Categories.Electronics
{
    public partial class PageInElectronics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write("This is Electronics category page. <br />");

            //. sysntax showing current path of the page using Server.MapPath(.) method
            Response.Write("Current Path . Method : " + Server.MapPath(".") + "<br />");

            //. sysntax showing Parent directory of the page using Server.MapPath(..) method
            Response.Write("Parent Directory Path .. Method : " + Server.MapPath("..") + "<br />");

            //~ sysntax showing root directory path of the page using Server.MapPath(~) method
            Response.Write("Root Directory Path ~ Method : " + Server.MapPath("~") + "<br />");
            //../.. another method for root directory
            Response.Write("Root Directory Path ../..Method : " + Server.MapPath("..//..") + "<br />");
        }
    }
}