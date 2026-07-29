using SAPbouiCOM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1_SAPConn
{
    public static class Helper
    {
        public static void ShowMessage(Application app, string msg)
        {
            app.StatusBar.SetText(msg, BoMessageTime.bmt_Short, BoStatusBarMessageType.smt_Success);
        }
    }
}