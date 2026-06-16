<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="hyperlink.aspx.cs" Inherits="WebAppCoding._13_Hyperlink.hyperlink" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="https://github.com/ramjeeindia">Github WebSite</asp:HyperLink>
                </div>
        <p>
                <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" NavigateUrl="~/30_FileUpload/FileUpload.aspx">File Upload</asp:HyperLink>
        </p>
                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Images/KhatuShyam.jpg">Internal Image Link</asp:HyperLink>
    </form>
</body>
</html>
