<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Wizard.aspx.cs" Inherits="WebAppCoding._37_WizardControl.Wizard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: #7fffd4;" >
    <%--used css for backgroud color--%>

    <form id="form1" runat="server">
        <div>
            <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="2" CancelButtonImageUrl="~/Images/CANCEL_BTN.png" CancelButtonType="Image" CancelDestinationPageUrl="https://www.youtube.com/" DisplayCancelButton="True" FinishCompleteButtonImageUrl="~/Images/FINISH_BTN.png" FinishCompleteButtonType="Image" FinishPreviousButtonImageUrl="~/Images/PREVIOUS_BTN_SMALL.jpg" FinishPreviousButtonType="Image" Height="85px" OnFinishButtonClick="Wizard1_FinishButtonClick" StartNextButtonImageUrl="~/Images/SUBMIT_BTN.png" StartNextButtonType="Image" StepNextButtonImageUrl="~/Images/NEXT.png" StepNextButtonType="Image" StepPreviousButtonImageUrl="~/Images/PREVIOUS_BTN.png" StepPreviousButtonType="Image" Width="296px">
                <WizardSteps>
                    <asp:WizardStep runat="server" title="Step 1">
                    </asp:WizardStep>
                    <asp:WizardStep runat="server" title="Step 2">
                    </asp:WizardStep>
                    <asp:WizardStep runat="server" title="Step 3">
                    </asp:WizardStep>
                </WizardSteps>
            </asp:Wizard>
        </div>
    </form>
</body>
</html>
