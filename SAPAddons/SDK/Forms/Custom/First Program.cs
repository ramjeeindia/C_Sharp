using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SDK
{

    public class FirstProgram : Main
    {
        #region Global Variable Declaration
        public SAPbouiCOM.Application GOD_Application;
        public SAPbobsCOM.Company GOD_Company;
        #endregion

        #region Constructor
        public FirstProgram() : base()  // Class Constructor
        {
            //SetApplication(); //same code written in Main Class       
        }
        #endregion

        #region SingleSignOn
        private void SetApplication()       //UI Connectivity
        {
            string Cookie = String.Empty;
            string conStr = string.Empty;
            int ret = 0;

            //UI Connectivity
            SAPbouiCOM.SboGuiApi SboGuiApi = new SAPbouiCOM.SboGuiApi(); // SboGuiApi object is created and memory is assinged to instance using "new" keyword
            SboGuiApi.Connect(System.Convert.ToString(Environment.GetCommandLineArgs().GetValue(1)));   //Valid for all countries
            GOD_Application = SboGuiApi.GetApplication(-1);  // We took Connected application in our control means in GOD_Application object
            // -1 means last sap instance number 0,1,2 -- To connect last logged sap b1 instance

            //DI Connectivity 
            SAPbobsCOM.Company GOD_Company = new SAPbobsCOM.Company();  // Memory is allocated to Company Object
            conStr = GOD_Application.Company.GetConnectionContext(GOD_Company.GetContextCookie());       // Login Credentials
            GOD_Company.SetSboLoginContext(conStr);
            ret = GOD_Company.Connect();
            if (ret == 0)
            {
                GOD_Application.SetStatusBarMessage("Addon Connected Successfully to " + GOD_Company.CompanyName, SAPbouiCOM.BoMessageTime.bmt_Short, false);
            }
            //Single Signon = UI + DI Connectivity

            /*
            SAPbouiCOM.SboGuiApi SboGuiApi = null;      // SboGuiApi - Method Provided to UI Connectivity
            SboGuiApi = new SAPbouiCOM.SboGuiApi();     // SboGuiApi object is created and memory is assinged to instance using "new" keyword
            string sConnectionString = null;            // Getting Connection String
            sConnectionString = System.Convert.ToString(Environment.GetCommandLineArgs().GetValue(1));
            SboGuiApi.Connect(sConnectionString);       // Actual UI Connectivity
            GOD_Application = SboGuiApi.GetApplication(-1);  // We took Connected application in our control means in GOD_Application object
            
             Cookie = GOD_Company.GetContextCookie();        // Cookies will get generated.. binary format long string...confidential information
            conStr = GOD_Application.Company.GetConnectionContext(Cookie);       // Login Credentials
            GOD_Company.Connect();

            //If Mulitple SAP instances opened then our application will connect to last one...
             */
        }
        #endregion

        #region Event Handling

        #region Menu Event
        public override void Menu_Event(ref SAPbouiCOM.MenuEvent pVal, ref bool oBubbleEvent)
        {
            try
            {
                if (pVal.BeforeAction == true)
                {
                    switch (pVal.MenuUID)
                    {
                        case Constants.User_Menus.MENU_FirstProgram:
                            Utilities.oApplication.SBO_Application.MessageBox("You are in First Program");

                                
                            break;
                    }
                }
                else
                {
                    switch (pVal.MenuUID)
                    {

                    }
                }
            }
            catch (Exception Ex)
            {
                Utilities.ShowErrorMessage(Ex.Message);
                oBubbleEvent = false;
                return;
            }
        }
        #endregion

        #region Item Events

        #endregion

        #endregion

    }
}
