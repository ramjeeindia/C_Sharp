using SAPbouiCOM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1_SAPConn
{
    public class SampleB1Form
    {
        private Application app;

        public SampleB1Form(Application application)
        {
            app = application;
        }

        public void CreateForm()
        {
            FormCreationParams fcp = (FormCreationParams)
                app.CreateObject(BoCreatableObjectType.cot_FormCreationParams);

            fcp.UniqueID = "frmTest";
            fcp.FormType = "frmTest";

            Form form = app.Forms.AddEx(fcp);
            form.Title = "My First Form";
            form.Width = 400;
            form.Height = 200;

            // Add Button
            Item btnItem = form.Items.Add("btn1", BoFormItemTypes.it_BUTTON);
            btnItem.Left = 150;
            btnItem.Top = 100;

            Button btn = (Button)btnItem.Specific;
            btn.Caption = "Click Me";
        }
    }
}