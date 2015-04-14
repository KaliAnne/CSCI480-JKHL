<%@ Page Language="VB" AutoEventWireup="true" CodeFile="viewExisting.aspx.vb" Inherits="viewExisting" EnableEventValidation="true" %>

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
    </head>
    <!-- End header -->

    <header>
        <nav id="nav">
		    <ul>
			    <li class="current"><a href="home.html">Home</a></li>
				<li><a href="">Placeholder</a></li>
				<li><a href="">Placeholder</a></li>
				<li><a href="">Placeholder</a></li>
				<li><a href="">Placeholder</a></li>
				<li><a href="">Placeholder</a></li>
			</ul>
		</nav>

		<br />
		<br />

    </header>

    <body>
        <div align="center">
            <section align="center" class="left"> 
	        <!--Start left nav bar -->
	            <form runat="server"> 
	            <!--Form Start-->	
	                <fieldset id="menu">
			            <legend><span>Menu</span></legend>
                        <!--This div class needs to be fixed-->
                        
                            <!--Will fix the Edit and Delete Buttons tomorrow; want to review some work code before trying to do this-->
                            <asp:GridView runat="server" ID="ChartNameGridView" AutoGenerateColumns="False" OnRowEditing="ChartNameGridView_RowEditing" OnRowCancelingEdit="ChartNameGridView_RowCancelingEdit">
                                <Columns>
                                    <asp:BoundField DataField="ChartID" HeaderText="ChartID" SortExpression="ChartID" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:CommandField SelectText="View" ButtonType="Button" ShowSelectButton="True" />
                                    <asp:CommandField ShowEditButton="True" ButtonType="Button" />
                                    <asp:CommandField ShowDeleteButton="true" ButtonType="Button" />
                                </Columns>
                            </asp:GridView>
	                </fieldset> <!--End menu-->
	            </form> <!-- End Form -->
	        </section> <!--End left nav bar-->

            <section align="center">
	            <fieldset id="atteninfo">
	                <legend><span>Attendance</span></legend>	
                    <br>
	                <!-- PUT CODE HERE KALI -->
	                <br>
	            </fieldset>
            </section>

        </div>
    </body>
</html>
