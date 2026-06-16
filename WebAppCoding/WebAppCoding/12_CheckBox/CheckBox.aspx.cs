using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppCoding._12_CheckBox
{
    public partial class CheckBox : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //CheckBox1.Focus(); // Set focus to the first checkbox when the page loads

            if (!IsPostBack)
            {
                PostGraduateCheckBox.Focus();
                PostGraduateCheckBox.Checked = true;

            }
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            StringBuilder sbUserChoices = new StringBuilder();
            if (CheckBox1.Checked)
            {
                sbUserChoices.Append(CheckBox1.Text);
            }
            if (PostGraduateCheckBox.Checked)
            {
                sbUserChoices.Append(" , " + PostGraduateCheckBox.Text);
            }
            if (DoctorateCheckBox.Checked)
            {
                sbUserChoices.Append(" , " + DoctorateCheckBox.Text);
            }
            Response.Write("Your Selections: " + sbUserChoices.ToString());
        }

    }
}
