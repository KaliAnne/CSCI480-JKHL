<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Login.aspx.vb" Inherits="home" %>

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
    <script src="js/Login.js"> </script>
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

<body align="left" >
    <form runat="server">
        <asp:Label ID="lblWarning" runat="server" Text="" ForeColor="White"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblE" runat="server" Text="Email:  " ForeColor="White"></asp:Label>
        <br />
        <asp:TextBox ID="txtEmail" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblP" runat="server" Text="Password:  " ForeColor="White"></asp:Label>
        <br />
        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" ></asp:TextBox>
        <asp:Button ID="btnForgot" runat="server" Text="Forgot password?" OnClick="SendEmail" />
        <br />
        <br />
        <asp:Button ID="btnLogin" CssClass="attenBtn" runat="server" Text="Log In" />
        <button type="Button" class="attenBtn" onclick="location.href='newUser.aspx'">New User</button>
      
    </form>
</body>

</html>
