using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDK
{
    public class SalesOrder : Main
    {

        #region Constructor
        public SalesOrder() : base() { }
        #endregion

        #region MENU EVENT
        public override void Menu_Event(ref SAPbouiCOM.MenuEvent pVal, ref bool oBubbleEvent)
        {
            try
            {
                if (pVal.BeforeAction == true)
                {
                    switch (pVal.MenuUID)
                    {
                        case Constants.System_Menus.mnu_SalesOrder:
                            Utilities.oApplication.SBO_Application.StatusBar.SetText("Hello Bro. Opening Sales Order", SAPbouiCOM.BoMessageTime.bmt_Short, SAPbouiCOM.BoStatusBarMessageType.smt_Success);
                            Utilities.oApplication.SBO_Application.StatusBar.SetText("You are not authorised Person to use Sales Order", SAPbouiCOM.BoMessageTime.bmt_Short, SAPbouiCOM.BoStatusBarMessageType.smt_Success);
                            Utilities.oApplication.SBO_Application.Menus.Item("4885").Activate();   // Opening PO


                            //Utilities.Application.SBO_Application.Menus.Add("mnuHW", "Hello World", SAPbouiCOM.BoMenuType.mt_STRING, 0);
                            oBubbleEvent = false;
                            break;
                    }
                }
            }
            catch (Exception Ex)
            {
                throw;
            }
        }
        #endregion
    }
}
