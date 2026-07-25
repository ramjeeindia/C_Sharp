using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//1000 functions
namespace SDK
{
    public class Utilities
    {
        #region Global Variable Declaration
        public static EventListener oApplication;
        private static int FormCounter;
        #endregion

        #region CONSTRUCTOR & DISTRUCTOR
        public Utilities()  //Constructor
        {
            //Always called class class is initialized and memory is allocated to class instance - Creating Clss object
        }
        ~Utilities()        //Destructor
        {
            //To release that memory destructor is called
        }
        #endregion
              

        #region SHOW MESSAGE
        public static void ShowErrorMessage(string oText)
        {
            Message(oText, SAPbouiCOM.BoStatusBarMessageType.smt_Error);
        }

        public static void ShowWarningMessage(string oText)
        {
            Message(oText, SAPbouiCOM.BoStatusBarMessageType.smt_Warning);
        }

        public static void ShowSucessMessage(string oText)
        {
            Message(oText, SAPbouiCOM.BoStatusBarMessageType.smt_Success);
        }

        public static void Message(string oText, SAPbouiCOM.BoStatusBarMessageType oType)
        {
            if (oApplication != null && oApplication.Company != null)
            {
                oApplication.SBO_Application.StatusBar.SetText(oText, SAPbouiCOM.BoMessageTime.bmt_Short, oType);
            }
            else
            {
                //oApplication.SBO_Application.StatusBar.SetText(oText + " Addon", SAPbouiCOM.BoMessageTime.bmt_Short, oType);
                //System.Windows.Forms.MessageBox.Show(oText, "Addon", System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Error, System.Windows.Forms.MessageBoxDefaultButton.Button1, System.Windows.Forms.MessageBoxOptions.DefaultDesktopOnly);
            }
        }
        #endregion

        #region LOAD XML FILES
        public static void LoadForm(Main oObject, string oFile)
        {
            oObject.FormUID = LoadFromXML(oFile, true);
            oObject.Form = oApplication.SBO_Application.Forms.Item(oObject.FormUID);

            if (!oApplication.Collection.ContainsKey(oObject.FormUID))
            {
                oApplication.Collection.Add(oObject.FormUID, oObject);
            }
        }
        #region EXECUTE QUERY
        public static void ExecuteSQL(ref SAPbobsCOM.Recordset oRecordSet, string oSql)
        {
            if (oRecordSet == null)
                oRecordSet = (SAPbobsCOM.Recordset)oApplication.Company.GetBusinessObject(SAPbobsCOM.BoObjectTypes.BoRecordset);

            oRecordSet.DoQuery(oSql);
        }
        #endregion
        public static void LoadMenus(string oFileName)
        {
            LoadFromXML(oFileName, false);

        }

        private static string LoadFromXML(string oFileName, bool oIsForm)
        {
            string oPath = null;
            string _FormUID = null;
            System.Xml.XmlDocument oXmlDoc = null;
            System.Xml.XmlNode oXmlNode = null;
            System.Xml.XmlAttribute oAttri = null;

            oXmlDoc = new System.Xml.XmlDocument();

            oPath = getApplicationPath() + @"\XML Files\" + oFileName;
            oXmlDoc.Load(oPath);

            if (oIsForm)
            {
                oXmlNode = oXmlDoc.GetElementsByTagName("form").Item(0);
                oAttri = (System.Xml.XmlAttribute)oXmlNode.Attributes.GetNamedItem("uid");
                oAttri.Value = oAttri.Value.ToString().Trim() + FormCounter.ToString();
                _FormUID = oAttri.Value;
                FormCounter++;
            }

            string ostrXML = oXmlDoc.InnerXml.ToString();
            oApplication.SBO_Application.LoadBatchActions(ref ostrXML);

            return _FormUID;
        }
        #endregion


        #region GET APPLICATION PATH
        public static string getApplicationPath()
        {
            string oPath;

            oPath = System.Windows.Forms.Application.StartupPath.Trim();
            //oPath = System.IO.Directory.GetParent(sPath).ToString(); 

            return oPath;
        }
        #endregion

    }
}
