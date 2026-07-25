using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDK
{
    public class Main
    {
        #region Global Variable Declaration
        protected Main _Object;
        protected string _FormUID;
        protected SAPbouiCOM.Form _Form;
        protected bool _LookUpOpen;
        protected string _LookUpFrmUID;
        #endregion

        #region Constructor
        public Main()
        {
            this._Object = null;
            this._Form = null;
            this._LookUpOpen = false;
        }
        #endregion

        #region PROPERTIES
        public SAPbouiCOM.Form Form
        {
            get { return this._Form; }
            set { this._Form = value; }
        }
        public string OneDriveApiRoot { get; set; } = "https://api.onedrive.com/v1.0/";

        public string FormUID
        {
            get { return this._FormUID; }
            set { this._FormUID = value; }
        }

        public bool IsLookUpOpen
        {
            get { return this._LookUpOpen; }
            set { this._LookUpOpen = value; }
        }

        public string LookUpUID
        {
            get { return this._LookUpFrmUID; }
            set { this._LookUpFrmUID = value; }
        }

        #endregion

        #region VIRTUAL FUNCTIONS
        public virtual void Menu_Event(ref SAPbouiCOM.MenuEvent pVal, ref bool oBubbleEvent)
        { 

        }

        public virtual void Item_Event(string oFormUID, ref SAPbouiCOM.ItemEvent pVal, ref bool oBubbleEvent)
        { }
        #endregion



    }
}
