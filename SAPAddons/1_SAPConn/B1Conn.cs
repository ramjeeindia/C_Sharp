using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SAPbobsCOM;
using SAPbouiCOM;


namespace _1_SAPConn
{
    public class B1Conn
    {
        public Application SBO_Application { get; private set; }

        public B1Conn() 
        {
            Connect();
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
