using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppCoding._18_BindDropDownXml
{
    public partial class DataBindDDXml : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Create a new DataSet
                DataSet DS = new DataSet();
                //Read the xml data from the XML file using ReadXml() method

                // MapPath() method is used to get the physical path of the XML file on the server
                DS.ReadXml(Server.MapPath("DropDownXmlFile.xml"));
                DropDownList1.DataTextField = "CountryName";
                DropDownList1.DataValueField = "CountryId";
                DropDownList1.DataSource = DS;
                DropDownList1.DataBind();

                //Create a new ListItem and insert it at the first position of the DropDownList
                ListItem li = new ListItem("Select", "-1");
                DropDownList1.Items.Insert(0, li);
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}