using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SDK
{

    public class HelloWorld : Main
    {
        #region Global Variable Declaration
        public SAPbouiCOM.Application GOD_Application;
        public SAPbobsCOM.Company GOD_Company;
        #endregion

        #region Constructor
 public HelloWorld() : base()  // Class Constructor
        {
            SetApplication(); //same code written in Main Class

            GOD_Application.MessageBox("Hello Bro.");
            int i = GOD_Application.MessageBox("Do you want to Continue?", 1, "Yes", "No", "Cancel");

            if (i == 1)
            {
                GOD_Application.MessageBox("You selected Yes Option");
            }
            else if (i == 2)
            {
                GOD_Application.MessageBox("You selected No Option");
            }
            else
            {
                GOD_Application.MessageBox("Cancelling");
            }
            GOD_Application.MessageBox(i.ToString());

            GOD_Application.StatusBar.SetText("Hello Bro. Success", SAPbouiCOM.BoMessageTime.bmt_Short, SAPbouiCOM.BoStatusBarMessageType.smt_Success);       //Green
            GOD_Application.StatusBar.SetText("Hello Bro.Error", SAPbouiCOM.BoMessageTime.bmt_Short, SAPbouiCOM.BoStatusBarMessageType.smt_Error);            // Red
            GOD_Application.StatusBar.SetText("Hello Bro. Warining", SAPbouiCOM.BoMessageTime.bmt_Short, SAPbouiCOM.BoStatusBarMessageType.smt_Warning);      // Faint Blue
            GOD_Application.StatusBar.SetText("Hello Bro. None ", SAPbouiCOM.BoMessageTime.bmt_Short, SAPbouiCOM.BoStatusBarMessageType.smt_None);            // Faint Blue

            GOD_Application.SetStatusBarMessage("Addon Connected Successfully", SAPbouiCOM.BoMessageTime.bmt_Short, true);        // Red
            GOD_Application.SetStatusBarMessage("Opening Sales Order Screen...", SAPbouiCOM.BoMessageTime.bmt_Short, false);      // Plain Color
            GOD_Application.Menus.Item("2050").Activate();          //2050 is Sales Order Menu uid - Sales Order Menu Click (Activated)
            GOD_Application.Menus.Item("2561").Activate();          // BP Menu

            //Sales Order Screen Littlebit Customisation
            // On Sales Order Form-- > Ok Button Click --> Message as "Hey Dude"
            //Initialise Sales Order Form
            //Take that form in our control means in one form variable
            //using that form variable we will change form title
            //User can open maximum 7 sessions at a time. FP2204
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
                if (!pVal.BeforeAction)
                {
                    switch (pVal.MenuUID)
                    {
                        case Constants.User_Menus.MENU_HelloWorld:      // COM UI - 01_Hello World Program
                            Utilities.oApplication.SBO_Application.MessageBox("Hello World - Greetings From Mahendrakumar D.P.");
                            Utilities.oApplication.SBO_Application.MessageBox("Hello World - Greetings From Mahendrakumar D.P.", 1, "Okay", "", "");
                            Utilities.oApplication.SBO_Application.MessageBox("Hello World - Greetings From Mahendrakumar D.P.", 1, "Okay", "Yes", "No");
                            break;
                        case Constants.System_Menus.mnu_PREVIOUS:
                        case Constants.System_Menus.mnu_NEXT:
                        case Constants.System_Menus.mnu_FIRST:
                        case Constants.System_Menus.mnu_LAST:                           
                            break;                  
                        case Constants.System_Menus.mnu_FIND:
                            break;
                        case Constants.System_Menus.mnu_ADD:
                            break;
                    }
                }
                else
                {
                    switch (pVal.MenuUID)
                    {
                        case Constants.System_Menus.mnu_PREVIOUS:
                        case Constants.System_Menus.mnu_NEXT:
                        case Constants.System_Menus.mnu_FIRST:
                        case Constants.System_Menus.mnu_LAST:
                            break;
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
