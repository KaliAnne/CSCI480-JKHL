<%@ Page Language="VB" AutoEventWireup="true" CodeFile="studentInfo.aspx.vb" Inherits="studentInfo" %>

<!-- Iteration 3 code for seating chart application. -->
<!-- Created and revised by JHKL 3/31/2015 -->
<!-- The purpose of this program is to have the availability for a client to store multiple charts on a website, and be able to pull data from them for in-class use. -->
<!-- Input: From standard input:: Button clicking, typing, form evaluation: From database:: seating chart data-->

<!DOCTYPE html>
<html>
    <!-- Start header -->
    <head align="center">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width" />
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
	        <!--Form Start, allows user to enter in all student information-->	  
	            Name: <br>
				<asp:TextBox runat="server" ID="stuName" /> 
				<br>
				Email: <br>
				<asp:TextBox runat="server" ID="stuEmail" /> 
				<br>
				Major(s): <br>
				<asp:TextBox runat="server" ID="stuMajor" />  
				<br>
				Minor(s): <br>
				<asp:TextBox runat="server" ID="stuMinor" /> 
				<br>
				Extracurricular(s): <br>
				<asp:TextBox runat="server" ID="stuExtra" /> 
				<br>
				Picture: <br>   
                <asp:FileUpload ID="stuPicture" runat="server" />
				<br>
				<br>
                <!-- Cancel button and submit buttons -->
                <asp:Button runat="server" ID="btnSubmit" Text="Submit" Class="FormNav" OnClick="btnSubmit_Click" />
                <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="FormNave" OnClick="btnCancel_Click" />

                <!-- Hidden chart information that the user does not need to see -->
                <asp:TextBox runat="server" ID="HiddenChartID" Visible="false"></asp:TextBox>
                <asp:TextBox runat="server" ID="HiddenChartName" Visible="false"></asp:TextBox>
	        </form> <!-- End Form -->
	    </section> <!--End left nav bar-->
    </body>

</html>
