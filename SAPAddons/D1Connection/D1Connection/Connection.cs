using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SAPbouiCOM;


namespace D1Connection
{
    class Connection
    {
        private SAPbouiCOM.Application SBO_Application;

        public Connection()
        {
            SetApplication();  // UI Connectivity method to connect to SAP Business One application
            SBO_Application.MessageBox("Commnad Line Argument Called from prodect debug settings");
        }

        private void SetApplication()  // UI Connectivity method to connect to SAP Business One application
        {
            SAPbouiCOM.SboGuiApi objsboguiap;   // Variable Declared 
            objsboguiap = new SAPbouiCOM.SboGuiApi();  // Memory allocation 
            //objsboguiap.Connect("0030002C0030002C00530041005000420044005F00440061007400650076002C0050004C006F006D0056004900490056");
            // Connecting string is given 

            objsboguiap.Connect(System.Convert.ToString(Environment.GetCommandLineArgs().GetValue(1)));  // Connecting string is given


            SBO_Application = objsboguiap.GetApplication(-1);
        }
    }
}
