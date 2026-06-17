<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Wizardbtn.aspx.cs" Inherits="WebAppCoding._37_WizardControl.Wizardbtn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Applied CSS ON Wizard Control</title>

<%--    css addded font import from google and applied on page--%>
       <style>
            @import url("https://fonts.googleapis.com/css2?family=Poppins&display=swap");
           * {
        margin: 0;
        padding: 0;
        background-color: #dfdfdd;
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
      }
       </style>              
     
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 144px">
            <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="-1" 
                DisplayCancelButton="True" 
                HeaderText="Wizard Control as Form of Button Event" 
                Height="20px" 
                ClientIDMode="AutoID" 
                OnActiveStepChanged="Wizard1_ActiveStepChanged">
                <HeaderStyle BackColor="Black" BorderColor="#3333CC" BorderStyle="Double" ForeColor="White"/>                
                <WizardSteps>                  
                <asp:WizardStep runat="server" title="Step 1"> </asp:WizardStep>
                <asp:WizardStep runat="server" title="Step 2"> </asp:WizardStep>
                <asp:WizardStep runat="server" title="Step 3"> </asp:WizardStep>
                </WizardSteps>                    
            </asp:Wizard>
        </div>
    </form>
</body>
</html>
