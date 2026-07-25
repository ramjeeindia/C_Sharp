using SDK.FrameWork;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SDK
{
    class SubMain
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>

        static void Main()      //First Executed statement in any programming by compiler
        {
            // We Created objHelloWorld Object For HelloWorld Class
            Utilities.oApplication = EventListener.getEventListener();       //Events are registered in system

            //Creating Tables and UDF's along with UDO
            //Database.InitializeDatabase();
            //Adding Menus 
            Utilities.LoadMenus(Constants.Menus.MENUS_ADD);
            SAPbouiCOM.Menus _Menus = Utilities.oApplication.SBO_Application.Menus;
            SAPbouiCOM.MenuItem oMenuItems;
            if (_Menus.Exists("mnuSDK"))
            {
                oMenuItems = Utilities.oApplication.SBO_Application.Menus.Item("mnuSDK");
                oMenuItems.Image = Utilities.getApplicationPath() + @"\Images\" + @"\logo.png";
            }
            //HelloWorld objHelloWorld = new HelloWorld();
            /*
            HelloWorld objHelloWorld = null;  // Class Instance (Variable) declared
            objHelloWorld = new HelloWorld(); // Obejct declared - using new keyword we can assign memory to instance (variable). it call that class constructor automatically.
            */
            System.Windows.Forms.Application.Run(); //To Execute this program continuously this statement is required
        }
    }
}
