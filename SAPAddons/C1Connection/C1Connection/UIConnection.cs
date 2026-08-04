using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SAPbouiCOM;


namespace C1Connection
{
    class UIConnection
    {
        public Application SBO_Application { get; private set; }

        

        public UIConnection()
        {
            Connect();
            SBO_Application.MessageBox("Connected to SAP Business One UI API successfully.");
        }

        private void Connect()
        {
            SboGuiApi guiApi = new SboGuiApi();
            string connStr = Environment.GetCommandLineArgs()[1];

            guiApi.Connect(connStr);
            SBO_Application = guiApi.GetApplication(-1);

            
        }
    }

}
