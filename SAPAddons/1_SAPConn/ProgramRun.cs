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
            B1Connection objB1Connection = new B1Connection();
        }
    }
}