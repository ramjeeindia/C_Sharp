using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SAPbouiCOM;


namespace _1_SAPConn
{
    public class B1Menu
    {
        private Application app;

        public B1Menu(Application application)
        {
            app = application;
            CreateMenu();
        }

        private void CreateMenu()
        {
            Menus menus = app.Menus;
            MenuItem root = menus.Item("43520"); // Modules

            MenuCreationParams mcp = (MenuCreationParams)
                app.CreateObject(BoCreatableObjectType.cot_MenuCreationParams);

            mcp.Type = BoMenuType.mt_STRING;
            mcp.UniqueID = "MY_MENU";
            mcp.String = "My Addon";
            mcp.Enabled = true;

            root.SubMenus.AddEx(mcp);
        }
    }
}
   
