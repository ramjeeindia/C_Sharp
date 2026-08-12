using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SAPbobsCOM;
using SAPbouiCOM;
using Microsoft.CSharp;

// MICOSOFT CSHARP REFERENCE ADDED


namespace _1_SAPConn
{
    public class DIConnection
    {
        private SAPbobsCOM.Company oCompany;
        private Application app;

        private const string UDO_CODE = "MY_UDO";
        private const string CHILD_TABLE = "MY_DTL";

        public DIConnection(Application application)
        {
            app = application;
            oCompany = (SAPbobsCOM.Company)application.Company.GetDICompany();
        }

        // ✅ OPTIONAL: expose company safely
        public SAPbobsCOM.Company Company
        {
            get { return oCompany; }
        }

        // ✅ ADD UDO RECORD
        public void AddUDORecord(string machine, string itemCode, double qty)
        {
            CompanyService oCompanyService = null;
            GeneralService oGeneralService = null;
            GeneralData oGeneralData = null;
            GeneralDataCollection oChildren = null;

            try
            {
                if (oCompany == null || !oCompany.Connected)
                    throw new Exception("DI Company not connected");

                // ✅ Start Transaction
                if (!oCompany.InTransaction)
                    oCompany.StartTransaction();

                oCompanyService = oCompany.GetCompanyService();
                oGeneralService = oCompanyService.GetGeneralService(UDO_CODE);

                // ✅ HEADER
                oGeneralData = (GeneralData)oGeneralService
                    .GetDataInterface(GeneralServiceDataInterfaces.gsGeneralData);

                oGeneralData.SetProperty("U_Machine", machine);

                // ✅ CHILD TABLE
                oChildren = oGeneralData.Child(CHILD_TABLE);

                GeneralData oChild = oChildren.Add();
                oChild.SetProperty("U_ItemCode", itemCode);
                oChild.SetProperty("U_Qty", qty);

                // ✅ ADD RECORD
                oGeneralService.Add(oGeneralData);

                // ✅ COMMIT
                if (oCompany.InTransaction)
                    oCompany.EndTransaction(BoWfTransOpt.wf_Commit);

                app.StatusBar.SetText(
                    "UDO Record Added Successfully",
                    BoMessageTime.bmt_Short,
                    BoStatusBarMessageType.smt_Success
                );
            }
            catch (Exception ex)
            {
                // ❌ ROLLBACK
                if (oCompany.InTransaction)
                    oCompany.EndTransaction(BoWfTransOpt.wf_RollBack);

                oCompany.GetLastError(out int errCode, out string errMsg);

                app.StatusBar.SetText(
                    $"Error: {errCode} - {errMsg} | {ex.Message}",
                    BoMessageTime.bmt_Short,
                    BoStatusBarMessageType.smt_Error
                );
            }
            finally
            {
                // ✅ CLEANUP
                oChildren = null;
                oGeneralData = null;
                oGeneralService = null;
                oCompanyService = null;
            }
        }
    }
}