<%@ Page Language="VB" AutoEventWireup="true" CodeFile="newChart.aspx.vb" Inherits="newChart" %>

<!-- Iteration 1 code for seating chart application. -->
<!-- Created and revised by JHKL 3/31/2015 -->
<!-- The purpose of this program is to have the availability for a client to store multiple charts on a website, and be able to pull data from them for in-class use. -->
<!-- Input: From standard input:: Button clicking, typing, form evaluation: From database:: seating chart data-->

<!DOCTYPE html>
<html>
    <!-- Start header -->
    <head align="center">
        <meta charset="UTF-8" />
	    <title>Seating Chart Application</title>
	    <link rel="shortcut icon" type="image/png" href="images/favicon/apple.png"/>
        <link rel="stylesheet"  href="css/seatingChartnew.css" />
        <script src="js/studentInfo.js"> </script>
    </head>
    <!-- End header -->
    
    <body>
        <section align="center" class="info"> 
	    <!--Start left nav bar -->
	        <form runat="server"> 
	        <!--Form Start-->
                Name: <br>
				<asp:TextBox runat="server" ID="chartName" /> 
				<br>
				Rows: <br>
				<asp:TextBox runat="server" ID="chartRows" /> 
				<br>
				Columns: <br>
				<asp:TextBox runat="server" ID="chartColumns" />  
				<br>
				<br>
                <asp:Button runat="server" ID="btnSubmit" Text="Submit" Class="FormNav" OnClick="btnSubmit_Click" />
                <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="FormNav" OnClick="btnCancel_Click" />
                <asp:TextBox runat="server" ID="HiddenProfessorEmail" Visible="false"></asp:TextBox>	  
	        </form> <!-- End Form -->
	    </section> <!--End left nav bar-->
    </body>

</html>
