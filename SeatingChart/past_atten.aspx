<%@ Page Language="VB" AutoEventWireup="true" CodeFile="past_atten.aspx.vb" Inherits="past_atten" %>

<!-- Iteration 1 code for seating chart application. -->
<!-- Created and revised by JHKL 3/31/2015 -->
<!-- The purpose of this program is to have the availability for a client to store multiple charts on a website, and be able to pull data from them for in-class use. -->
<!-- Input: From standard input:: Button clicking, typing, form evaluation: From database:: seating chart data-->

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <!-- Start header -->
    <head runat="server" align="center">
        <meta charset="UTF-8" />
	    <title>Seating Chart Application</title>
	    <link rel="shortcut icon" type="image/png" href="images/favicon/apple.png"/>
        <link rel="stylesheet"  href="css/seatingChartnew.css" />
	    <script src="js/indexjs.js"> </script>
    </head>
    <body onload="OnLoad()" onbeforeunload="return OnClose()">
    <header>
        <nav id="nav">
		    <ul>
			    <li><a href="home.aspx">Home</a></li>
			</ul>
		</nav>

		<br />
		<br />

    </header>

   
  
        <div align="center">
	
	        <form runat="server"> 
		    <!--Form Start-->
            <section align="center" class="left">
		    <!--Start left nav bar -->
	  
	                <fieldset id="menuopt">
		            <!-- Creates menu options, to change the option to scroll, please see CSS -->
                        <fieldset id="chartinfo">
			                <legend><span>Chart Name</span></legend>
                            <p><asp:TextBox runat="server" ID="ChartName" ReadOnly="true" /></p>
		                    <legend><span>Student Information<p>Please select a student:<fieldset id="studentinfo">
                            <asp:DropDownList runat="server" ID="studentList" AppendDataBoundItems="true" onchange="HighlightName(); return false;" >
                                <asp:ListItem Text="(None)" Value=""></asp:ListItem>
                            </asp:DropDownList>
	                    </fieldset>
			                    <button type="Button" class ="attenBtn" onclick="location.href='home.aspx'">Home</button>
                                </p>
                                </span></legend>
	                    </fieldset>
		                <br />
	  
	                    &nbsp;<br />
	  
                        &nbsp;<br />
      
	                    &nbsp;<br />
		
                        &nbsp;<br />
	                    <br />

                        <!--Hidden fields to store the IDs that are not needed to be seen by the user-->
		 
	                </fieldset>
			        <!--End menuopt-->
	        </section> 	
			<!--End left nav bar-->
                               <asp:GridView runat="server" ID="AttendanceInfo" AutoGenerateColumns="False" DataKeyNames="ChartID" GridLines="None" Height="93px" Width="240px">
                                <Columns>
                                    <asp:BoundField DataField="ChartID" HeaderText="ChartID" SortExpression="ChartID" Visible="false" />
                                    <asp:BoundField DataField="Name" SortExpression="Name" />
                                    <asp:CommandField SelectText="Edit" ButtonType="Button" ShowSelectButton="True" />
                                </Columns>
                            </asp:GridView>
            </form>
        </div>
    </body>

</html>

