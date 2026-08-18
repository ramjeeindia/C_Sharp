using _1_SAPConn;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SAPConn
{
    class ProgramRun
    {
        [STAThread]
        static void Main()

        {
            
            B1Conn connection = new B1Conn();
            //DIConnection di = new DIConnection(connection.SBO_Application);
            //new UDT_UDO(di.oCompany);

            //new B1Menu(connection.SBO_Application);
            //new B1EventHandler(connection.SBO_Application);

            //connection.SBO_Application.MessageBox("Addon Loaded Successfully");
            //System.Windows.Forms.Application.Run();


        }
    }
}
