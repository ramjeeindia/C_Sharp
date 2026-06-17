using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppCoding._37_WizardControl
{
    public partial class Wizard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {
            if (Wizard1.ActiveStepIndex == 0)
            {
                Wizard1.HeaderText = "Personal Information";
            }
            else if (Wizard1.ActiveStepIndex == 1)
            {
                Wizard1.HeaderText = "Contact Detail";
            }
            else
            {
                Wizard1.HeaderText = "Summary";
            }
        }
    }
}