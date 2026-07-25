using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDK
{
    public class ItemMaster : Main
    {
        #region Global Variable Declaration

        #endregion

        #region Constructor
        public ItemMaster() : base() { }
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
                        case Constants.System_Menus.mnu_ItemMaster:
                            //Utilities.Application.SBO_Application.StatusBar.SetText("Hello Bro. Opening Item Master", SAPbouiCOM.BoMessageTime.bmt_Short, SAPbouiCOM.BoStatusBarMessageType.smt_Success);
                            Utilities.ShowSucessMessage("Hello Bro. Opening Item Master");
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

        #region ITEM EVENT
        public override void Item_Event(string oFormUID, ref SAPbouiCOM.ItemEvent pVal, ref bool oBubbleEvent)
        {
            try
            {
                if (pVal.BeforeAction == true)
                {
                    switch (pVal.EventType)
                    {
                        case SAPbouiCOM.BoEventTypes.et_CLICK:

                            break;

                    }
                }
                else
                {
                    switch (pVal.EventType)
                    {

                    }
                }
            }
            catch (Exception Ex)
            {
                Utilities.ShowErrorMessage(Ex.Message);
                oBubbleEvent = false;
                return;
            }
            finally
            {
                Form.Freeze(false);
            }
        }
        #endregion
    }
}
