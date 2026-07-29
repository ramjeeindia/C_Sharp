using SAPbouiCOM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1_SAPConn
{
    public class EventHandler
    {
        private Application app;

        public EventHandler(Application application)
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
               new Forms.SampleForm(app).CreateForm();
            }
        }

        private void OnItemEvent(string FormUID, ref ItemEvent pVal, out bool BubbleEvent)
        {
            BubbleEvent = true;
        }
    }
}
