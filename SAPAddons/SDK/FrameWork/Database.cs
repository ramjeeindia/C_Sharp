
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDK.FrameWork
{
    public sealed class Database
    {

        private Database()  //Constructor
        {
        }


        public static void InitializeDatabase()
        {
            string[] oChildTables = new string[3];
            string[] oFindColumns = new string[10];
            string[] oColumnName = new string[2];

            if (!Utilities.oApplication.Company.InTransaction)
                Utilities.oApplication.Company.StartTransaction();

            #region Internal Sales Order

            #endregion
            #region AddTable
            CreateTable("GOD_ORDR", "Internal Sales Order", SAPbobsCOM.BoUTBTableType.bott_Document);
            CreateTable("GOD_RDR1", "Sales Order - Contents", SAPbobsCOM.BoUTBTableType.bott_DocumentLines);
            CreateTable("GOD_RDR2", "Sales Order - Attachments", SAPbobsCOM.BoUTBTableType.bott_DocumentLines);
            #endregion

            #region AddColumn
            AddColumn("GOD_ORDR", "CardCode", "Customer Code", 120, SAPbobsCOM.BoFieldTypes.db_Alpha, SAPbobsCOM.BoFldSubTypes.st_None, SAPbobsCOM.BoYesNoEnum.tNO, SAPbobsCOM.BoYesNoEnum.tNO);
            AddColumn("GOD_ORDR", "CardName", "Customer Name", 200, SAPbobsCOM.BoFieldTypes.db_Alpha, SAPbobsCOM.BoFldSubTypes.st_None, SAPbobsCOM.BoYesNoEnum.tNO, SAPbobsCOM.BoYesNoEnum.tNO);
            AddColumn("GOD_ORDR", "DocTotal", "Document Total", 120, SAPbobsCOM.BoFieldTypes.db_Float, SAPbobsCOM.BoFldSubTypes.st_Sum, SAPbobsCOM.BoYesNoEnum.tNO, SAPbobsCOM.BoYesNoEnum.tNO);

            AddColumn("GOD_RDR1", "ItemCode", "Item Code", 120, SAPbobsCOM.BoFieldTypes.db_Alpha, SAPbobsCOM.BoFldSubTypes.st_None, SAPbobsCOM.BoYesNoEnum.tNO, SAPbobsCOM.BoYesNoEnum.tNO);
            AddColumn("GOD_RDR1", "ItemName", "Item Name", 200, SAPbobsCOM.BoFieldTypes.db_Alpha, SAPbobsCOM.BoFldSubTypes.st_None, SAPbobsCOM.BoYesNoEnum.tNO, SAPbobsCOM.BoYesNoEnum.tNO);
            AddColumn("GOD_RDR1", "Quantity", "Quantity", 120, SAPbobsCOM.BoFieldTypes.db_Float, SAPbobsCOM.BoFldSubTypes.st_Measurement, SAPbobsCOM.BoYesNoEnum.tNO, SAPbobsCOM.BoYesNoEnum.tNO);
            AddColumn("GOD_RDR1", "Price", "Price", 120, SAPbobsCOM.BoFieldTypes.db_Float, SAPbobsCOM.BoFldSubTypes.st_Rate, SAPbobsCOM.BoYesNoEnum.tNO, SAPbobsCOM.BoYesNoEnum.tNO);
            AddColumn("GOD_RDR1", "LineTotal", "LineTotal", 120, SAPbobsCOM.BoFieldTypes.db_Float, SAPbobsCOM.BoFldSubTypes.st_Sum, SAPbobsCOM.BoYesNoEnum.tNO, SAPbobsCOM.BoYesNoEnum.tNO);

            #endregion

            #region Add UDO
            oChildTables = new string[3];
            oChildTables[0] = "GOD_RDR1";
            oChildTables[1] = "GOD_RDR2";
            oFindColumns = new string[10];
            oFindColumns[0] = "U_CardCode";
            oFindColumns[1] = "U_CardName";
            CreateUDO("GOD_ORDR", "Internal Sales Order", "GOD_ORDR", SAPbobsCOM.BoUDOObjType.boud_Document, oFindColumns, oChildTables);
            #endregion

            Utilities.oApplication.Company.EndTransaction(SAPbobsCOM.BoWfTransOpt.wf_Commit);

        }


        #region DATABASE CREATION FUNCTIONS

        #region CREATE USER DEFINED TABLE

        private static void CreateTable(string oTable, string oDescription, SAPbobsCOM.BoUTBTableType oType)
        {
            SAPbobsCOM.UserTablesMD oUserTable = null;

            try
            {
                oUserTable = (SAPbobsCOM.UserTablesMD)Utilities.oApplication.Company.GetBusinessObject(SAPbobsCOM.BoObjectTypes.oUserTables);

                if (!oUserTable.GetByKey(oTable))
                {
                    oUserTable.TableName = oTable;
                    oUserTable.TableDescription = oDescription;
                    oUserTable.TableType = oType;

                    if (oUserTable.Add() != 0)
                        throw new Exception(Utilities.oApplication.Company.GetLastErrorDescription());

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(oUserTable);
                oUserTable = null;
                GC.Collect();
            }
        }
        #endregion

        #region ADD COLUMN
        private static void AddColumn(string oTable, string oName, string oDescription, int oSize, SAPbobsCOM.BoFieldTypes oType, SAPbobsCOM.BoFldSubTypes oSubType, SAPbobsCOM.BoYesNoEnum
            oMandatory, SAPbobsCOM.BoYesNoEnum oIsSystemTable)
        {
            SAPbobsCOM.UserFieldsMD oUserField = null;

            try
            {
                oUserField = (SAPbobsCOM.UserFieldsMD)Utilities.oApplication.Company.GetBusinessObject(SAPbobsCOM.BoObjectTypes.oUserFields);

                if (ColumnExists(oTable, oName, oIsSystemTable) == SAPbobsCOM.BoYesNoEnum.tNO)
                {
                    oUserField.TableName = oTable;
                    oUserField.Name = oName;
                    oUserField.Description = oDescription;

                    if (oType != SAPbobsCOM.BoFieldTypes.db_Numeric)
                        oUserField.Size = oSize;

                    oUserField.Type = oType;
                    oUserField.SubType = oSubType;
                    oUserField.Mandatory = oMandatory;

                    if (oTable == "CIN_OCAT" && oName == "AcctType")
                    {

                        oUserField.ValidValues.Value = "0";
                        oUserField.ValidValues.Description = "Cash";
                        oUserField.ValidValues.Add();
                        oUserField.ValidValues.Value = "1";
                        oUserField.ValidValues.Description = "RTGS/NEFT";
                        oUserField.ValidValues.Add();
                        oUserField.ValidValues.Value = "2";
                        oUserField.ValidValues.Description = "Cheques";
                        oUserField.ValidValues.Add();
                        oUserField.DefaultValue = "0";
                    }


                    //if (oTable == "CIN_OGAE" && oName == "GateNo")
                    //{
                    //    oUserField.LinkedTable = "CIN_OGNO";
                    //}




                    if (oUserField.Add() != 0)
                        throw new Exception(Utilities.oApplication.Company.GetLastErrorDescription());
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(oUserField);
                oUserField = null;
                GC.Collect();
            }
        }

        #endregion

        #region IS COLUMN EXISTS
        private static SAPbobsCOM.BoYesNoEnum ColumnExists(string oTable, string oColumn, SAPbobsCOM.BoYesNoEnum oIsSystemTable)
        {
            SAPbobsCOM.Recordset oRSColumn = null;
            string oSQL = string.Empty;

            try
            {
                if (oIsSystemTable == SAPbobsCOM.BoYesNoEnum.tNO)
                    oTable = @"@" + oTable;

                oSQL = "Select Count(*) From \"CUFD\" Where \"TableID\" = '" + oTable + "' And \"AliasID\" = '" + oColumn + "'";
                Utilities.ExecuteSQL(ref oRSColumn, oSQL);

                if ((int)oRSColumn.Fields.Item(0).Value == 0)
                    return SAPbobsCOM.BoYesNoEnum.tNO;

                else
                    return SAPbobsCOM.BoYesNoEnum.tYES;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(oRSColumn);
                oRSColumn = null;
                GC.Collect();
            }
        }
        #endregion

        #region CREATE UDO
        private static void CreateUDO(string oUniqueID, string oDescription, string oTable, SAPbobsCOM.BoUDOObjType oType, string[] oFindColumns, string[] oChildTables)
        {
            SAPbobsCOM.UserObjectsMD oUserObject = null;
            int oCount;

            try
            {
                oUserObject = (SAPbobsCOM.UserObjectsMD)Utilities.oApplication.Company.GetBusinessObject(SAPbobsCOM.BoObjectTypes.oUserObjectsMD);

                if (!oUserObject.GetByKey(oUniqueID))
                {
                    oUserObject.Code = oUniqueID;
                    oUserObject.Name = oDescription;
                    oUserObject.ObjectType = oType;
                    oUserObject.TableName = oTable;

                    oUserObject.ManageSeries = SAPbobsCOM.BoYesNoEnum.tYES;
                    oUserObject.CanCancel = SAPbobsCOM.BoYesNoEnum.tYES;
                    oUserObject.CanClose = SAPbobsCOM.BoYesNoEnum.tYES;
                    oUserObject.CanCreateDefaultForm = SAPbobsCOM.BoYesNoEnum.tNO;
                    oUserObject.CanDelete = SAPbobsCOM.BoYesNoEnum.tNO;

                    if (oFindColumns != null)
                    {
                        if (oFindColumns.Length > 0)
                        {
                            oUserObject.CanFind = SAPbobsCOM.BoYesNoEnum.tYES;

                            for (oCount = 0; oCount <= oFindColumns.Length - 1; oCount++)
                            {
                                if (!String.IsNullOrEmpty(oFindColumns[oCount]))
                                {
                                    oUserObject.FindColumns.ColumnAlias = oFindColumns[oCount];
                                    oUserObject.FindColumns.Add();
                                }

                                oFindColumns[oCount] = null;
                            }
                        }
                    }

                    if (oChildTables != null)
                    {
                        if (oChildTables.Length > 0)
                        {
                            for (oCount = 0; oCount <= oChildTables.Length - 1; oCount++)
                            {
                                if (!String.IsNullOrEmpty(oChildTables[oCount]))
                                {
                                    oUserObject.ChildTables.TableName = oChildTables[oCount];

                                    if (oCount != oChildTables.Length - 1)
                                        oUserObject.ChildTables.Add();
                                }

                                oChildTables[oCount] = null;
                            }
                        }
                    }

                    if (oUserObject.Add() != 0)
                        throw new Exception(Utilities.oApplication.Company.GetLastErrorDescription());
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(oUserObject);
                oUserObject = null;
                GC.Collect();
            }
        }
        #endregion

        #region IS KEY EXISTS
        private static SAPbobsCOM.BoYesNoEnum KeyExists(string oTable, string oKeyName, SAPbobsCOM.BoYesNoEnum oIsSystemTable)
        {
            SAPbobsCOM.Recordset oRSColumn = null;
            string oSQL = string.Empty;

            try
            {
                if (oIsSystemTable == SAPbobsCOM.BoYesNoEnum.tNO)
                    oTable = @"@" + oTable;
                oSQL = "Select Count(*) From \"OUKD\" Where \"TableName\" = '" + oTable + "' AND \"KeyName\" = '" + oKeyName + "' ";
                Utilities.ExecuteSQL(ref oRSColumn, oSQL);

                if ((int)oRSColumn.Fields.Item(0).Value == 0)
                    return SAPbobsCOM.BoYesNoEnum.tNO;

                else
                    return SAPbobsCOM.BoYesNoEnum.tYES;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(oRSColumn);
                oRSColumn = null;
                GC.Collect();
            }
        }
        #endregion

        #region ADD KEYS
        private static void AddKey(string oTable, string[] oColumnName, string oKeyName, SAPbobsCOM.BoYesNoEnum oIsSystemTable)
        {
            SAPbobsCOM.UserKeysMD oUserKey = null;
            int oCount;
            try
            {
                oUserKey = (SAPbobsCOM.UserKeysMD)Utilities.oApplication.Company.GetBusinessObject(SAPbobsCOM.BoObjectTypes.oUserKeys);
                if (KeyExists(oTable, oKeyName, oIsSystemTable) == SAPbobsCOM.BoYesNoEnum.tNO)
                {
                    oUserKey.TableName = oTable;
                    oUserKey.KeyName = oKeyName;
                    if (oColumnName != null)
                    {
                        if (oColumnName.Length > 0)
                        {
                            for (oCount = 0; oCount <= oColumnName.Length - 1; oCount++)
                            {
                                if (oColumnName[oCount] != null)
                                {
                                    oUserKey.Elements.ColumnAlias = oColumnName[oCount];
                                    oUserKey.Elements.Add();
                                }

                                oColumnName[oCount] = null;
                            }
                        }
                    }
                    oUserKey.Unique = SAPbobsCOM.BoYesNoEnum.tYES;
                    if (oUserKey.Add() != 0)
                        throw new Exception(Utilities.oApplication.Company.GetLastErrorDescription());
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(oUserKey);
                oUserKey = null;
                GC.Collect();
            }
        }
        #endregion
        #endregion
    }
}
