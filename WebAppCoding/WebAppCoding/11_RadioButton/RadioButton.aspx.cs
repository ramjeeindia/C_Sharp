using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppCoding._11_RadioButton
{
    public partial class RadioButton : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (MaleRadioButton1.Checked)
            {
                Response.Write("You selected :" + MaleRadioButton1.Text + "<br/>");
            }
            else if (FemaleRadioButton2.Checked)
            {
                Response.Write("You selected :" + FemaleRadioButton2.Text + "<br/>");
            }
            else // (UnknownRadioButton3.Checked)
            {
                Response.Write("You selected :" + UnknownRadioButton3.Text + "<br/>");
            }
        }

        protected void MaleRadioButton1_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}