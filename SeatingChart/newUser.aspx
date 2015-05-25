<%@ Page Language="VB" AutoEventWireup="true" CodeFile="newUser.aspx.vb" Inherits="home" %>

<!-- Iteration 3 code for seating chart application. -->
<!-- Created and revised by JHKL 4/29/2015 -->
<!-- The purpose of this program is to have the availability for a client to store multiple charts on a website, and be able to pull data from them for in-class use. -->
<!-- Input: From standard input:: Button clicking, typing, form evaluation: From database:: seating chart data-->

<!DOCTYPE html>
<html>
<!-- Start header -->
<head align="center">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width" />
    <title>Seating Chart Application</title>
    <link rel="shortcut icon" type="image/png" href="images/favicon/apple.png" />
    <link rel="stylesheet" href="css/seatingChartnew.css" />
    <script src="js/newUser.js"> </script>
</head>

<!--Start menu a the top of the page, home is the only option-->
<header>
    <nav id="nav">
        <ul>
            <li class="current"><a href="home.aspx">Home</a></li>
        </ul>
    </nav>

    <br>
    <br>
</header>

<!--Display three option buttons, switch modes not implemented yet-->
<body align="left" onload="OnLoad()">
    <form runat="server">
        <asp:Label ID="lblWarning" runat="server" Text="" ForeColor="White"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblE" runat="server" Text="Email:  " ForeColor="White"></asp:Label>
        <br />
        <asp:TextBox ID="txtEmail" runat="server" onfocus="OnFocusChange('lblEmail');"></asp:TextBox>
        <asp:Label ID="lblEmail" runat="server" ForeColor="White" Text="Enter an e-mail address ending in '@findlay.edu'"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblCE" runat="server" Text="Confirm Email:  " ForeColor="White"></asp:Label>
        <br />
        <asp:TextBox ID="txtConfEmail" runat="server" onfocus="OnFocusChange('lblConfEmail');"></asp:TextBox>
        <asp:Label ID="lblConfEmail" runat="server" ForeColor="White" Text="This does not match the Email field."></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblP" runat="server" Text="Password:  " ForeColor="White"></asp:Label>
        <br />
        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" onfocus="OnFocusChange('lblPass');"></asp:TextBox>
        <asp:Label ID="lblPass" runat="server" ForeColor="White" Text="Enter a password containing at least 6 characters"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblCP" runat="server" Text="Confirm Password:  " ForeColor="White"></asp:Label>
        <br />
        <asp:TextBox ID="txtConfPass" runat="server" TextMode="Password" onfocus="OnFocusChange('lblConfPass');"></asp:TextBox>
        <asp:Label ID="lblConfPass" runat="server" ForeColor="White" Text="This does not match the Password field."></asp:Label>
        <br />
        <br />
        <asp:Button ID="btnSubmit" CssClass="attenBtn" runat="server" Text="Create User" OnClientClick="return IfFieldsMatch();" />
        <button type="Button" class="attenBtn" onclick="location.href='home.aspx'">Cancel</button>
      
    </form>
</body>

</html>
