using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SAPbobsCOM;
using SAPbouiCOM;



namespace _1_SAPConn
{
    public class DIConnection
    {
        public SAPbobsCOM.Company oCompany;

        public DIConnection(SAPbouiCOM.Application app)
        {
            oCompany = (SAPbobsCOM.Company)app.Company.GetDICompany();
        }
    }
}
