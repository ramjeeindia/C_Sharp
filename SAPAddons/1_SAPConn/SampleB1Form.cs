using SAPbouiCOM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace _1_SAPConn.Forms
{
    public class SampleB1Form
    {
        private Application app;
        private Form oForm;
        private Matrix oMatrix;

        public SampleB1Form(Application application)
        {
            app = application;
        }

        public void CreateForm()
        {
            try
            {
                // ✅ Prevent duplicate form
                try
                {
                    app.Forms.Item("frmUDO").Select();
                    return;
                }
                catch { }

                FormCreationParams fcp = (FormCreationParams)
                    app.CreateObject(BoCreatableObjectType.cot_FormCreationParams);

                fcp.UniqueID = "frmUDO";
                fcp.FormType = "frmUDO";

                oForm = app.Forms.AddEx(fcp);

                oForm.Title = "Hourly Production Sheet";
                oForm.Width = 600;
                oForm.Height = 400;

                oForm.Freeze(true);

                // =========================
                // ✅ DATASOURCES
                // =========================
                oForm.DataSources.UserDataSources.Add("Machine", BoDataType.dt_SHORT_TEXT, 50);

                DataTable dt = oForm.DataSources.DataTables.Add("DT");

                dt.Columns.Add("ItemCode", BoFieldsType.ft_AlphaNumeric, 50);
                dt.Columns.Add("Qty", BoFieldsType.ft_Quantity);

                // =========================
                // ✅ LABEL - MACHINE
                // =========================
                Item lbl = oForm.Items.Add("lblMach", BoFormItemTypes.it_STATIC);
                lbl.Left = 20;
                lbl.Top = 20;
                lbl.Width = 100;

                StaticText lblTxt = (StaticText)lbl.Specific;
                lblTxt.Caption = "Machine";

                // =========================
                // ✅ TEXTBOX - MACHINE
                // =========================
                Item txt = oForm.Items.Add("txtMach", BoFormItemTypes.it_EDIT);
                txt.Left = 120;
                txt.Top = 20;
                txt.Width = 150;

                EditText txtMach = (EditText)txt.Specific;
                txtMach.DataBind.SetBound(true, "", "Machine");

                // =========================
                // ✅ MATRIX
                // =========================
                Item mItem = oForm.Items.Add("mtx", BoFormItemTypes.it_MATRIX);
                mItem.Left = 20;
                mItem.Top = 60;
                mItem.Width = 540;
                mItem.Height = 250;

                oMatrix = (Matrix)mItem.Specific;

                // Bind matrix to DataTable
                oMatrix.Clear();

                // Column: ItemCode
                Column col1 = oMatrix.Columns.Add("colItem", BoFormItemTypes.it_EDIT);
                col1.TitleObject.Caption = "Item Code";
                col1.Width = 200;
                col1.DataBind.Bind("DT", "ItemCode");

                // Column: Qty
                Column col2 = oMatrix.Columns.Add("colQty", BoFormItemTypes.it_EDIT);
                col2.TitleObject.Caption = "Quantity";
                col2.Width = 100;
                col2.DataBind.Bind("DT", "Qty");

                // =========================
                // ✅ BUTTON - ADD ROW
                // =========================
                Item btnAdd = oForm.Items.Add("btnAdd", BoFormItemTypes.it_BUTTON);
                btnAdd.Left = 20;
                btnAdd.Top = 320;
                btnAdd.Width = 100;

                Button btn = (Button)btnAdd.Specific;
                btn.Caption = "Add Row";

                // =========================
                // ✅ INITIAL ROW
                // =========================
                dt.Rows.Add();
                oMatrix.LoadFromDataSource();

                oForm.Freeze(false);
            }
            catch (Exception ex)
            {
                app.MessageBox("Form Error: " + ex.Message);
            }
        }
    }
}