<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileUpload.aspx.cs" Inherits="WebAppCoding._30_FileUpload.FileUpload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h3>Upload a Document on Server</h3>
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button ID="btnUpload" runat="server" Text="Upload File" OnClick="btnUpload_Click" />
        </div>
            <p>
            <asp:Label ID="lblMessage" runat="server" Font-Bold="True"></asp:Label>
            </p>
    </form>
</body>
</html>
