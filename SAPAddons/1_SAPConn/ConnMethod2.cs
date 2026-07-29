using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SAPbouiCOM;


namespace _1_SAPConn
{
    class ConnectMethod2
    {
        public SAPbouiCOM.Application SBO_Application { get; private set; }

        public ConnectMethod2()
        {
            ConnectToSAP();
            SBO_Application.MessageBox("Connected to SAP B1");
        }

        private void ConnectToSAP()
        {
            var guiApi = new SboGuiApi();
            string connectionString = Environment.GetCommandLineArgs()[1];

            guiApi.Connect(connectionString);
            SBO_Application = guiApi.GetApplication(-1);
        }
    }
}
