<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImageUpload_Sql.aspx.cs" Inherits="WebAppCoding._170_ImageUpload.ImageUpload_Sql" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <div>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <br />
        <br />
        <asp:Button ID="btnupload" runat="server" Text="Upload" OnClick="btnupload_Click"/>
        <br />
        <br />
        <asp:Label ID="lblMessage" runat="server"/>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server">View Uploaded Image</asp:HyperLink>
        <br />
        <br />      
  
        <%--   <asp:GridView ID="GridView1" runat="server"></asp:GridView>
        <Columns>
        <asp:BoundField datafield="Id" headertext="Id" />  
        <asp:BoundField datafield="Name" headertext="Name" /> 
        <asp:BoundField datafield="Size" headertext="Size (bytes) " />  
    
        </Columns>--%>
 </div>
    </form>
</body>
</html>
