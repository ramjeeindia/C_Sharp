using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppCoding._37_WizardControl
{
    public partial class Wizardbtn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        protected void Wizard1_ActiveStepChanged(object sender, EventArgs e)
        {
            Response.Write("The Activate Index Start with 0 and Clicked Event is :" + Wizard1.ActiveStepIndex.ToString());
        }
    }
}