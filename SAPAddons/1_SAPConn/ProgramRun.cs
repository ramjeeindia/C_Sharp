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
            //B1Connection objB1Connection = new B1Connection();  // 1st method           

            //ConnectMethod2 obconn = new ConnectMethod2();  // method second run

            //B1Conn varconn = new B1Conn();


            
                B1Conn connection = new B1Conn();
                DIConnection di = new DIConnection(connection.SBO_Application);

                new Menu(connection.SBO_Application);
                new EventHandler(connection.SBO_Application);

                connection.SBO_Application.MessageBox("Addon Loaded Successfully");
                System.Windows.Forms.Application.Run();
            
            
        }
    }
}
