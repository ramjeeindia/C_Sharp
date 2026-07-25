using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDK
{
    public class Constants
    {
        public struct User_Menus
        {
            public const string MENU_HelloWorld = "mnuHW";
            public const string MENU_FirstProgram = "mnuFP";
            public const string MENU_InternalSalesOrder = "mnuISO";
        }

        public struct System_Menus
        {
            public const string mnu_FIND = "1281";
            public const string mnu_ADD = "1282";
            public const string mnu_NEXT = "1288";
            public const string mnu_PREVIOUS = "1289";
            public const string mnu_FIRST = "1290";
            public const string mnu_LAST = "1291";
            public const string mnu_SalesOrder = "2050";
            public const string mnu_ItemMaster = "3073"; 
            public const string mnu_PurchaseOrder = "2305";
        }

        #region CONSTANTS FOR SYSTEM FORMS
        // Constants for System Forms
        public struct System_Forms
        {
            public const int WARE_HOUSES = 62;
            public const int ITEM_GROUPS = 63;
            public const int AR_INVOICE = 133;
            public const int BUSINESS_PARTNER = 134;
            public const int COMPANY_SETTINGS = 136;
            public const int SALES_ORDER = 139;
            public const int DELIVERY = 140;
            public const int AP_INVOICE = 141;
            public const int PURCHASE_ORDER = 142;
            public const int GRPO = 143;
            public const int SALES_QUOTATION = 149;
            public const int ITEM_MASTER = 150;
            public const int ARCreditMemo = 179;
            public const int BRANCH = 80300;
            public const int BatchSetup = 41;
            //public const int RECEIPT_PRODUCTION = 65214;

            public const int USER_MASTER = 20700;

            public const int JOURNAL_ENTRY = 392;
            public const int GOODS_ISSUE = 720;
            public const int GOODS_RECEIPT = 721;
            public const int INVENTORY_TRANSFER = 940;
            public const int PRODUCTION_ORDER = 65211;
            public const int ISSUE_PRODUCTION = 65213;
            public const int RECEIPT_PRODUCTION = 65214;
            public const int AR_DOWN_PAYMENT = 65300;
            public const int AR_DOWN_PAYMENT_REQUEST = 65308;

        }
        #endregion
        #region CONSTANTS FOR USER FORMS

        // Constants for XML Files
        public struct Forms
        {

            public const string xml_Collection = "Collection.xml";
            public const string xml_InternalSalesOder = "InternalSalesOrder.xml";

        }
        #endregion
        #region MENUS
        public struct Menus
        {
            public const string MENUS_ADD = "Menus.xml";
            public const string REMOVE_MENUS = "RemoveMenus.xml";
        }
        #endregion
    }
}
