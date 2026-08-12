using SAPbobsCOM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;


namespace _1_SAPConn
{
    public class UDT_UDO
    {
        private Company oCompany;

        public UDT_UDO(Company company)
        {
            oCompany = company;

            CreateTables();
            CreateUDO();
        }

        #region CREATE TABLES

        private void CreateTables()
        {
            CreateUDT("MY_HDR", "My Header", BoUTBTableType.bott_MasterData);
            CreateUDT("MY_DTL", "My Detail", BoUTBTableType.bott_MasterDataLines);

            AddField("@MY_HDR", "DocDate", "Doc Date", BoFieldTypes.db_Date);
            AddField("@MY_HDR", "Machine", "Machine", BoFieldTypes.db_Alpha, 50);

            AddField("@MY_DTL", "ItemCode", "Item Code", BoFieldTypes.db_Alpha, 50);
            AddField("@MY_DTL", "Qty", "Quantity", BoFieldTypes.db_Numeric);
        }

        private void CreateUDT(string tableName, string desc, BoUTBTableType type)
        {
            UserTablesMD oTable = null;

            try
            {
                oTable = (UserTablesMD)oCompany.GetBusinessObject(BoObjectTypes.oUserTables);

                if (!oTable.GetByKey(tableName))
                {
                    oTable.TableName = tableName;
                    oTable.TableDescription = desc;
                    oTable.TableType = type;

                    int res = oTable.Add();

                    if (res != 0)
                        ThrowError("UDT", tableName);
                }
            }
            finally
            {
                Release(oTable);
            }
        }

        #endregion

        #region ADD FIELDS

        private void AddField(string table, string name, string desc, BoFieldTypes type, int size = 0)
        {
            if (FieldExists(table, name))
                return;

            UserFieldsMD oField = null;

            try
            {
                oField = (UserFieldsMD)oCompany.GetBusinessObject(BoObjectTypes.oUserFields);

                oField.TableName = table;
                oField.Name = name;
                oField.Description = desc;
                oField.Type = type;

                if (size > 0)
                    oField.Size = size;

                if (type == BoFieldTypes.db_Numeric)
                    oField.SubType = BoFldSubTypes.st_Quantity;

                int res = oField.Add();

                if (res != 0)
                    ThrowError("Field", name);
            }
            finally
            {
                Release(oField);
            }
        }

        private bool FieldExists(string table, string field)
        {
            Recordset rs = null;

            try
            {
                rs = (Recordset)oCompany.GetBusinessObject(BoObjectTypes.BoRecordset);

                rs.DoQuery($@"
                    SELECT COUNT(*) 
                    FROM CUFD 
                    WHERE TableID = '{table}' 
                    AND AliasID = '{field}'
                ");

                return (int)rs.Fields.Item(0).Value > 0;
            }
            finally
            {
                Release(rs);
            }
        }

        #endregion

        #region CREATE UDO

        private void CreateUDO()
        {
            UserObjectsMD udo = null;

            try
            {
                udo = (UserObjectsMD)oCompany.GetBusinessObject(BoObjectTypes.oUserObjectsMD);

                if (!udo.GetByKey("MY_UDO"))
                {
                    udo.Code = "MY_UDO";
                    udo.Name = "My UDO";
                    udo.TableName = "MY_HDR";

                    udo.ObjectType = BoUDOObjType.boud_MasterData;

                    // ✅ Behavior
                    udo.CanCancel = BoYesNoEnum.tYES;
                    udo.CanClose = BoYesNoEnum.tYES;
                    udo.CanDelete = BoYesNoEnum.tYES;
                    udo.CanFind = BoYesNoEnum.tYES;
                    udo.CanLog = BoYesNoEnum.tYES;

                    // ✅ Default Form
                    udo.CanCreateDefaultForm = BoYesNoEnum.tYES;
                    udo.EnableEnhancedForm = BoYesNoEnum.tYES;

                    // ✅ Child Table
                    udo.ChildTables.TableName = "MY_DTL";
                    udo.ChildTables.Add();

                    int res = udo.Add();

                    if (res != 0)
                        ThrowError("UDO", "MY_UDO");
                }
            }
            finally
            {
                Release(udo);
            }
        }

        #endregion

        #region HELPERS

        private void ThrowError(string type, string name)
        {
            oCompany.GetLastError(out int errCode, out string errMsg);
            throw new Exception($"{type} Error ({name}): {errCode} - {errMsg}");
        }

        private void Release(object obj)
        {
            if (obj != null)
            {
                Marshal.ReleaseComObject(obj);
                obj = null;
                GC.Collect();
            }
        }

        #endregion
    }
}