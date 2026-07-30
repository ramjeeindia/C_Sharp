using SAPbouiCOM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _1_SAPConn;

namespace _1_SAPConn
{
    public class B1EventHandler
    {
        private Application app;

        public B1EventHandler(Application application)
        {
            app = application;

            app.MenuEvent += OnMenuEvent;
            app.ItemEvent += OnItemEvent;
        }

        private void OnMenuEvent(ref MenuEvent pVal, out bool BubbleEvent)
        {
            BubbleEvent = true;

            if (!pVal.BeforeAction && pVal.MenuUID == "MY_MENU")
            {
                new SampleB1Form(app).CreateForm();

            }
        }

        private void OnItemEvent(string FormUID, ref ItemEvent pVal, out bool BubbleEvent)
        {
            BubbleEvent = true;
        }
    }
}
