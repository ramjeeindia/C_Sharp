using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppCoding._16_DropDown
{
    public partial class DropDownUsingProgCode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListItem MaleListitem = new ListItem("Male", "1");
                ListItem FemaleListitem = new ListItem("Female", "2");
                ListItem OtherListitem = new ListItem("Other", "3");
                // DropDownList1.Items

                DropDownList1.Items.Add(MaleListitem);
                DropDownList1.Items.Add(FemaleListitem);
                DropDownList1.Items.Add(OtherListitem);
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}