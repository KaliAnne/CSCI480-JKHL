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
			    <li><a href="home.aspx">Home</a></li>
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
                        <section align="center" class="gridviewBox">
                            <!--Will fix the Edit and Delete Buttons tomorrow; want to review some work code before trying to do this-->
                            <asp:GridView runat="server" ID="ChartNameGridView" AutoGenerateColumns="False" DataKeyNames="ChartID" GridLines="None" Height="93px" Width="240px" OnRowDeleting="ChartNameGridView_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="ChartID" HeaderText="ChartID" SortExpression="ChartID" Visible="false" />
                                    <asp:BoundField DataField="Name" SortExpression="Name" />
                                    <asp:CommandField SelectText="View" ButtonType="Button" ShowSelectButton="True" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button runat="server" Text="Delete" CommandName="Delete" CommandArgument="ChartID" OnClientClick="return confirm('Are you sure you want to delete this chart?');" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </section>
	                </fieldset> <!--End menu-->
                    <asp:TextBox runat="server" ID="HiddenProfessorEmail" Visible="false"></asp:TextBox>
	            </form> <!-- End Form -->
	        </section> <!--End left nav bar-->

        </div>
    </body>
</html>
