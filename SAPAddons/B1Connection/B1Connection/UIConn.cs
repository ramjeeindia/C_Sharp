using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SAPbouiCOM;

namespace B1Connection
{
    class UIConn
    {
        private SAPbouiCOM.Application SBO_Application;
        
        public UIConn()
        {
            SetApplication();
            SBO_Application.MessageBox("Hello, World!");
        }

        private void SetApplication()
        {
            string connectionString = Environment.GetCommandLineArgs().GetValue(1).ToString();
            SboGuiApi sboGuiApi = new SboGuiApi();
            sboGuiApi.Connect(connectionString);
            SBO_Application = sboGuiApi.GetApplication(-1);
        }
    }
}
