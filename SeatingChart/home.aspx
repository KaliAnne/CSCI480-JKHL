<%@ Page Language="VB" AutoEventWireup="true" CodeFile="home.aspx.vb" Inherits="home" %>

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
<body align="center">
    <form runat="server">
        <asp:Button runat="server" ID="btnCreateChart" CssClass="homeBtns" Text="Create New Chart" OnClick="btnCreateChart_Click" />
        <asp:Button runat="server" ID="btnViewCharts" CssClass="homeBtns" Text="View Existing Chart" OnClick="btnViewCharts_Click" />
        <button id='btnSwitchMode' class="homeBtns" disabled="Disabled">Switch Modes</button>
        <asp:TextBox runat="server" ID="HiddenProfessorEmail" Visible="false"></asp:TextBox>
    </form>
</body>

</html>
