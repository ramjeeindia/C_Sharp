<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CascadingDropdown.aspx.cs" Inherits="WebAppCoding._22_Cascading.CascadingDropdown" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form2" runat="server">
        <div>
            <h3>Cascading Dropdown </h3>
            <asp:DropDownList ID="ddlContinents" Width="200px" runat="server" 
            DataTextField="ContinentName" DataValueField="ContinentId" 
                OnSelectedIndexChanged="ddlContinents_SelectedIndexChanged" AutoPostBack="true">
            </asp:DropDownList>
            <br /><br />
            <asp:DropDownList ID="ddlCountries" Width="200px" runat="server" 
            DataTextField="CountryName" DataValueField="CountryId" AutoPostBack="true"
                OnSelectedIndexChanged="ddlCountries_SelectedIndexChanged" >
            </asp:DropDownList>
            <br /><br />
            <asp:DropDownList ID="ddlCities" Width="200px" runat="server"
            DataTextField="CityName" DataValueField="CityId" >
            </asp:DropDownList> 
        </div>
    </form>
</body>
</html>
        