using System;//Basic system functions (date, time, etc.)
using System.Collections.Generic;
using System.Configuration; // Used to read connection string from Web.config
using System.Data; //Provides classes like: DataSet, DataTable, etc. for working with data in memory.
using System.Data.SqlClient; //Used to connect SQL Server and execute queries (SqlConnection, SqlCommand, SqlDataAdapter, etc.)
using System.Linq; //Used for collections and LINQ queries (not used here directly, but okay to keep)
using System.Web; //Required for web applications (ASP.NET)
using System.Web.UI;
using System.Web.UI.WebControls; //Needed to work with WebForms controls like: DropDownList,GridView, Button etc.


namespace WebAppCoding._22_Cascading
{
    public partial class CascadingDropdown : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) //Runs only first time page loads Prevents data from resetting after dropdown selection
            {
                ddlContinents.DataSource = GetData("spGetContinents", null); //Call method to get data for continents, no parameters needed
                ddlContinents.DataBind(); //Bind data to dropdown

                ListItem liContinent = new ListItem("Select Continent", "-1"); //Create default item for continent dropdown
                ddlContinents.Items.Insert(0, liContinent); //Add default item to the beginning of the dropdown

                ListItem liCountry = new ListItem("Select Country", "-1"); //Create default item for country dropdown
                ddlCountries.Items.Insert(0, liCountry); //Add default item to the beginning of the dropdown

                ListItem liCity = new ListItem("Select City", "-1"); //Create default item for city dropdown
                ddlCities.Items.Insert(0, liCity); //Add default item to the beginning of the dropdown

                ddlCountries.Enabled = false; //Disable country dropdown until a continent is selected
                ddlCities.Enabled = false; //Disable city dropdown until a country is selected
            }
        }
        //Method to get data from database using a stored procedure. Takes the name of the stored procedure and an optional parameter (for example, continent name when getting countries).
        private DataSet GetData(string SPName, SqlParameter SPParameter)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString; //Read connection string named "DBCS" from Web.config
            SqlConnection con = new SqlConnection(CS); //Create new SQL connection using the connection string
            SqlDataAdapter da = new SqlDataAdapter(SPName, con); //Create SqlDataAdapter with stored procedure name and connection. This adapter will execute the stored procedure and fill the DataSet.
            da.SelectCommand.CommandType = CommandType.StoredProcedure;//Tell the adapter that the command is a stored procedure, not a text query.
            if (SPParameter != null) //If a parameter was passed in (for example, when getting countries based on continent), add it to the command's parameters collection.
            {
                da.SelectCommand.Parameters.Add(SPParameter); //Add the parameter to the command that will be executed by the adapter.
            }

            DataSet DS = new DataSet(); //Create a new DataSet object. A DataSet can hold multiple DataTables and is used to store data in memory after retrieving it from the database.
            da.Fill(DS); //Execute the command (stored procedure) and fill the DataSet with the results. The stored procedure will return data based on the parameters provided (if any), and that data will be stored in the DataSet.

            return DS; //Return the filled DataSet back to the caller (for example, to bind it to a dropdown list).

        }

        protected void ddlContinents_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlContinents.SelectedIndex == 0)
            {
                ddlCountries.SelectedIndex = 0; //Reset country dropdown to default selection
                ddlCountries.Enabled = false; //Disable country dropdown

                ddlCities.SelectedIndex = 0; //Reset city dropdown to default selection
                ddlCities.Enabled = false; //Disable city dropdown
            }
            else
            {
                ddlCountries.Enabled = true; //Enable country dropdown when a continent is selected
                SqlParameter parameter = new SqlParameter("@ContinentId", ddlContinents.SelectedValue); //Create a new SQL parameter with the name expected by the stored procedure (for example, @ContinentId) and set its value to the selected value of the continent dropdown. This will be used to filter countries based on the selected continent.
                DataSet DS = GetData("spGetCountriesByContinentId", parameter); //Get countries based on selected continent

                ddlCountries.DataSource = DS; //Set the DataSet as the data source for the country dropdown. The stored procedure will return a list of countries that belong to the selected continent, and that list will be used to populate the country dropdown.
                ddlCountries.DataBind(); //Bind the data to the country dropdown, which will display the list of countries based on the selected continent.


                ListItem liCountry = new ListItem("Select Country", "-1");
                ddlCountries.Items.Insert(0, liCountry);

                ddlCities.SelectedIndex = 0; //Reset city dropdown to default selection
                ddlCities.Enabled = false; //Disable city dropdown until a country is selected

            }
        }

        protected void ddlCountries_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlCountries.SelectedIndex == 0)
            {
                ddlCities.SelectedIndex = 0; //Reset city dropdown to default selection
                ddlCities.Enabled = false; //Disable city dropdown
            }
            else
            {
                ddlCities.Enabled = true;
                SqlParameter parameter = new SqlParameter("@CountryId", ddlCountries.SelectedValue);
                DataSet DS = GetData("spGetCitiesByCountryId", parameter);

                ddlCities.DataSource = DS;
                ddlCities.DataBind();

                ListItem liCity = new ListItem("Select City", "-1");
                ddlCities.Items.Insert(0, liCity);
            }
        }

    }
}
      