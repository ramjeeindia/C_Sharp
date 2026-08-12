using _1_SAPConn;
using _1_SAPConn.Forms;
using SAPbouiCOM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


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

        #region MENU EVENT

        private void OnMenuEvent(ref MenuEvent pVal, out bool BubbleEvent)
        {
            BubbleEvent = true;

            try
            {
               
                if (!pVal.BeforeAction)
                {
                    if (pVal.MenuUID == "MY_MENU")
                    {
                        OpenSampleForm();
                    }
                }
            }
            catch (Exception ex)
            {
                app.StatusBar.SetText(
                    "Menu Error: " + ex.Message,
                    BoMessageTime.bmt_Short,
                    BoStatusBarMessageType.smt_Error
                );
            }
        }

        #endregion

        #region ITEM EVENT

        private void OnItemEvent(string FormUID, ref ItemEvent pVal, out bool BubbleEvent)
        {
            BubbleEvent = true;

            try
            {
       
                if (!pVal.BeforeAction)
                {
                    if (pVal.EventType == BoEventTypes.et_ITEM_PRESSED)
                    {
                        if (pVal.ItemUID == "btnAdd")
                        {
                            app.StatusBar.SetText(
                                "Add Button Clicked",
                                BoMessageTime.bmt_Short,
                                BoStatusBarMessageType.smt_Success
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                app.StatusBar.SetText(
                    "Item Event Error: " + ex.Message,
                    BoMessageTime.bmt_Short,
                    BoStatusBarMessageType.smt_Error
                );
            }
        }

        #endregion

        #region FORM LOADER

        private void OpenSampleForm()
        {
            try
            {

                foreach (Form form in app.Forms)
                {
                    if (form.TypeEx == "MY_FORM")
                    {
                        form.Select();
                        return;
                    }
                }

  
                SampleB1Form frm = new SampleB1Form(app);
                frm.CreateForm();
            }
            catch (Exception ex)
            {
                app.StatusBar.SetText(
                    "Form Load Error: " + ex.Message,
                    BoMessageTime.bmt_Short,
                    BoStatusBarMessageType.smt_Error
                );
            }
        }

        #endregion
    }
}
