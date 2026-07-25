using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SAPbobsCOM;   // For DB related operation we need this dll or reference
using SAPbouiCOM;   //For Evening handling this reference we have to add in our program


namespace SDK
{
    public sealed class EventListener
    {
        #region Global Variable Declaration
        private static EventListener _Listener;
        private string _FormUID;
        private SAPbobsCOM.Company _Company;
        private SAPbouiCOM.Application _Application;
        private Hashtable _Collection;
        private Hashtable _LookCollection;
#pragma warning disable CS0169 // The field 'EventListener._batchSetup' is never used
        //private Main _Object, _batchSetup;
        private Main _Object;
        #endregion

        #region Methods
        public static EventListener getEventListener()
        {
            if (_Listener == null)
                _Listener = new EventListener();
            return _Listener;
        }
        #endregion

        #region CONSTRUCTOR
        private EventListener()
        {
            this.Connect();
            //Adding Menus 
            this._Application.MenuEvent += new _IApplicationEvents_MenuEventEventHandler(SboApplication_MenuEvent);
            this._Application.ItemEvent += new SAPbouiCOM._IApplicationEvents_ItemEventEventHandler(SboApplication_ItemEvent);
            this._Collection = new Hashtable(10, (float)0.5);

        }
        #endregion

        #region COMPANY CONNECT

        private void Connect()      //Single Signon
        {
            this.SetApplication();      //UI Connectivity
            this.ConnectToCompany();    // DI Connectivity
        }
        public Hashtable Collection
        {
            get { return this._Collection; }
        }
        private void SetApplication()
        {
            SAPbouiCOM.SboGuiApi oSboGuiApi;
            string oConnectionString;

            try
            {
                if (Environment.GetCommandLineArgs().Length > 0)
                {
                    oSboGuiApi = new SAPbouiCOM.SboGuiApi();
                    oConnectionString = Convert.ToString(Environment.GetCommandLineArgs().GetValue(1));

                    oSboGuiApi.Connect(oConnectionString);
                    this._Application = oSboGuiApi.GetApplication(-1);
                    this._Company = new SAPbobsCOM.Company();
                    _Application.SetStatusBarMessage("Mahi Addon Connected.", BoMessageTime.bmt_Short, false);
                    //_Application.MessageBox("Mahi Addon Connected.");
                }
                else
                {
                    throw new Exception("Connection string missing.");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void ConnectToCompany()
        {
            string oCookie, oConnectionContext;
            try
            {
                oCookie = this._Company.GetContextCookie();
                oConnectionContext = this._Application.Company.GetConnectionContext(oCookie);
                this._Company.SetSboLoginContext(oConnectionContext);

                if (this._Company.Connect() != 0)
                {
                    //_Application.StatusBar.SetText("Mahi Add-Ons is not Connected", SAPbouiCOM.BoMessageTime.bmt_Short, SAPbouiCOM.BoStatusBarMessageType.smt_Error);
                    Utilities.ShowErrorMessage("Mahi Add-Ons is not Connected");
                    throw new Exception(_Company.GetLastErrorDescription());
                }
                else
                {
                    Utilities.ShowSucessMessage("Mahi Add-Ons is Connecting");
                    //_Application.StatusBar.SetText("Mahi Add-Ons is Connecting...", SAPbouiCOM.BoMessageTime.bmt_Short, SAPbouiCOM.BoStatusBarMessageType.smt_Success);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region EVENT HANDLERS
        #region MENU EVENT

        private void SboApplication_MenuEvent(ref SAPbouiCOM.MenuEvent pVal, out bool BubbleEvent)
        {
            BubbleEvent = true;
            try
            {
                if (pVal.BeforeAction == true)
                {
                    switch (pVal.MenuUID)
                    {
                        case Constants.System_Menus.mnu_SalesOrder:
                            this._Object = new SalesOrder();
                            this._Object.Menu_Event(ref pVal, ref BubbleEvent);
                            break;
                        case Constants.System_Menus.mnu_PurchaseOrder:
                            this._Object = new PurchaseOrder();                        
                            this._Object.Menu_Event(ref pVal, ref BubbleEvent);                          
                            break;
                        case Constants.System_Menus.mnu_ItemMaster:
                            this._Object = new ItemMaster();
                            this._Object.Menu_Event(ref pVal, ref BubbleEvent);
                            break;
                        case Constants.User_Menus.MENU_FirstProgram:
                            this._Object = new FirstProgram();
                            this._Object.Menu_Event(ref pVal, ref BubbleEvent);
                            break;
                        case Constants.User_Menus.MENU_InternalSalesOrder:
                            this._Object = new InternalSalesOrder();
                            //Load User Defined Form here
                            Utilities.LoadForm(this._Object, Constants.Forms.xml_InternalSalesOder);
                            this._Object.Menu_Event(ref pVal, ref BubbleEvent);
                            ((InternalSalesOrder)this._Object).FormLoad();
                            break;
                        
                    }
                }
                //else
                //{
                //    switch (pVal.MenuUID)
                //    {
                //        case Constants.System_Menus.mnu_ROW_DETAILS:
                //            BubbleEvent = false;
                //            break;
                //        case Constants.System_Menus.mnu_GROSS_PROFIT:
                //            BubbleEvent = false;
                //            break;
                //    }

                if (this._Collection.Contains(this._FormUID))
                {
                    this._Object = (Main)this._Collection[this._FormUID];
                    ((Main)this._Object).Menu_Event(ref pVal, ref BubbleEvent);
                }
            }
            catch (Exception ex)
            {
                Utilities.Message(ex.Message, SAPbouiCOM.BoStatusBarMessageType.smt_Error);
            }
        }

        #endregion

        #region ITEM EVENT

        private void SboApplication_ItemEvent(string FormUID, ref SAPbouiCOM.ItemEvent pVal, out bool BubbleEvent)
        {
            BubbleEvent = true;
            try
            {
                this._FormUID = FormUID;

                if (!pVal.BeforeAction && pVal.EventType == SAPbouiCOM.BoEventTypes.et_FORM_LOAD)
                {
                    switch (pVal.FormType)
                    {                        
                        case Constants.System_Forms.ITEM_MASTER:
                            this._Object = new ItemMaster();
                            if (!_Collection.Contains(FormUID))
                                _Collection.Add(FormUID, this._Object);
                            ((ItemMaster)this._Object).Form = SBO_Application.Forms.Item(FormUID);
                            //((ItemMaster)this._Object).FormLoad();
                            break;
                    }
                }
                if (this._Collection.Contains(FormUID))
                {
                    this._Object = (Main)this._Collection[FormUID];
                    if (pVal.BeforeAction && this._Object.IsLookUpOpen)
                    {
                        BubbleEvent = false;
                        _Application.Forms.Item(this._Object.LookUpUID).Select();
                    }
                    else
                    {
                        this._Object.Item_Event(FormUID, ref pVal, ref BubbleEvent);
                    }

                    if (!pVal.BeforeAction && pVal.EventType == SAPbouiCOM.BoEventTypes.et_FORM_UNLOAD)
                    {
                        if (_LookCollection.ContainsKey(FormUID))
                        {
                            this._Object = (Main)_Collection[_LookCollection[FormUID]];
                            _LookCollection.Remove(FormUID);
                            this._Object.IsLookUpOpen = false;
                        }
                        _Collection.Remove(FormUID);
                    }
                }
            }
            catch (Exception ex)
            {
                Utilities.Message(ex.Message, SAPbouiCOM.BoStatusBarMessageType.smt_Error);
            }
        }
        #endregion
        #endregion



        #region Properties
        public SAPbouiCOM.Application SBO_Application
        {
            get { return this._Application; }
        }

        public SAPbobsCOM.Company Company
        {
            get { return this._Company; }
        }
        #endregion
    }
}
