<%@ Page Language="VB" AutoEventWireup="true" CodeFile="index.aspx.vb" Inherits="index" %>

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
				<li  class="current"><a href="index.aspx">Seating Chart Information</a></li>
				<li><a href="viewExisting.aspx">View Existing</a></li>
				<li><a href="">Placeholder</a></li>
				<li><a href="">Placeholder</a></li>
				<li><a href="">Placeholder</a></li>
			</ul>
		</nav>

		<br />
		<br />

    </header>

   
  
        <div align="center">
	
            <section align="center" class="left">
		    <!--Start left nav bar -->
	            <form runat="server"> 
		        <!--Form Start-->
	  
	                <fieldset id="menuopt">
		            <!-- Creates menu options, to change the option to scroll, please see CSS -->
			            <legend><span><h2>Menu Options</h2></span></legend>		

		                <br />
	  
	                    <fieldset id="chartinfo">
			                <legend><span>Chart Name</span></legend>
                            <p><asp:TextBox runat="server" ID="ChartName" ReadOnly="true" /></p>
	                    </fieldset>	 
                         
		                <br />
	  
                        <fieldset id="roominfo">
		                    <legend><span>Room Size:</span></legend>
                            <p>Rows: <br /> <asp:TextBox runat="server" ID="RoomRows" ReadOnly="true" /></p>
                            <p>Columns: <br /> <asp:TextBox runat="server" ID="RoomColumns" ReadOnly="true" /></p>
			
                            <br />

                            <asp:Button runat="server" ID="SaveChart" Text="Save Room" Class="attenBtn" OnClientClick="return false;" />
			                <button id="EditRoom" type="Button" class ="attenBtn" onclick="activeEdit();">Edit Room</button>
	                    </fieldset>	  

		                <br />
      
	                    <fieldset id="studentinfo">
		                    <legend><span>Student Information</span></legend>
		                    <p>Please select a student:</p>
                            <asp:DropDownList runat="server" ID="studentList" AppendDataBoundItems="true">
                                <asp:ListItem Text="(None)" Value=""></asp:ListItem>
                            </asp:DropDownList>
	                    </fieldset>
	  
		                <br />
		
                        <fieldset id="extrainfo">
		                    <legend><span>Help Menu</span></legend>		
			                    <button type="Button" class ="attenBtn" onclick="location.href='home.aspx'">Home</button>
			                    <button type="Button" class ="attenBtn">Delete Room Chart</button>
                                <asp:Button runat="server" ID="btnAddStudent" Text="Add Student" Class="attenBtn" OnClick="addStudent" OnClientClick="return false;" />
			                    <button type="Button" class ="attenBtn" onclick="removeStudent();">Remove Student</button>
			                    <button type="Button" class ="attenBtn" id="btnAssign" onclick="AssignSeats();">Assign Seats</button>
			                    <button type="Button" class ="attenBtn">View Past Seating Charts</button>
	                    </fieldset>
	   
	                    <br />
	                    <br />

		 
	                </fieldset>
			        <!--End menuopt-->

                    <!--This a gridview that the user will not be able to see. It pulls all of the chart information that is needed-->
                    <asp:GridView ID="ChartInfoGridView" runat="server" AutoGenerateColumns="false" Visible="false">
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                            <asp:BoundField DataField="Rows" HeaderText="Rows" SortExpression="Rows"></asp:BoundField>
                            <asp:BoundField DataField="Columns" HeaderText="Columns" SortExpression="Columns"></asp:BoundField>
                        </Columns>
                    </asp:GridView>

	            </form>
			    <!-- End Form -->

	        </section> 	
			<!--End left nav bar-->
   
            <section align="center">
	            <fieldset id="atteninfo" align="center">
	                <legend><span><h2>Attendance</h2></span></legend>	

	                <br />

                    <button type="Button" class ="attenBtn" id="btnAttend" onclick="toggleAttend(this.id);">Take Attendance</button>

	                <br />
                    <br />

	                <hr />
	
		            <!-- Row 7 -->
	                <fieldset id="Row7">
		                <legend><span>Row 7</span></legend>
		 
		                <section class="picture">
		                    <button id='btnSeat0701' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0701' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0701" for="btnSeat0701">Vacant Seat</label>
                        </section>
		
		                <section class="picture">
		                    <button id='btnSeat0702' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0702' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    	                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0702" for="btnSeat0702">Vacant Seat</label>
		                </section>

		                <section class="picture">
		                    <button id='btnSeat0703' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0703' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0703" for="btnSeat0703">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0704' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0704' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0704" for="btnSeat0704">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0705' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0705' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0705" for="btnSeat0705">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0706' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0706' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0706" for="btnSeat0706">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0707' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0707' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0707" for="btnSeat0707">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0708' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0708' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0708" for="btnSeat0708">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0709' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0709' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0709" for="btnSeat0709">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0710' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0710' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0710" for="btnSeat0710">Vacant Seat</label>
		                </section>
		
	                </fieldset>
	
	                <br />
	
		            <!-- Row 6 -->
	                <fieldset id="Row6">
		                <legend><span>Row 6</span></legend>
		 
		                <section class="picture">
		                    <button id='btnSeat0601' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0601' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    			            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0601" for="btnSeat0601">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0602' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0602' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    	                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0602" for="btnSeat0602">Vacant Seat</label>
		                </section>

		                <section class="picture">
		                    <button id='btnSeat0603' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0603' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0603" for="btnSeat0603">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0604' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0604' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0604" for="btnSeat0604">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0605' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0605' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0605" for="btnSeat0605">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0606' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0606' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0606" for="btnSeat0606">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0607' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0607' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0607" for="btnSeat0607">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0608' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0608' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0608" for="btnSeat0608">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0609' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0609' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0609" for="btnSeat0609">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0610' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0610' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0610" for="btnSeat0610">Vacant Seat</label>
		                </section>
		
	                </fieldset>
	
	                <br />

	                <!-- Row 5 -->
	                <fieldset id="Row5">
		                <legend><span>Row 5</span></legend>
		 
		                <section class="picture">
		                    <button id='btnSeat0501' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0501' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    			            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0501" for="btnSeat0501">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0502' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0502' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    	                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0502" for="btnSeat0502">Vacant Seat</label>
		                </section>

		                <section class="picture">
		                    <button id='btnSeat0503' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0503' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0503" for="btnSeat0503">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0504' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0504' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0504" for="btnSeat0504">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0505' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0505' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0505" for="btnSeat0505">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0506' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0506' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0506" for="btnSeat0506">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0507' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0507' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0507" for="btnSeat0507">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0508' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0508' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0508" for="btnSeat0508">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0509' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0509' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0509" for="btnSeat0509">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0510' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0510' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0510" for="btnSeat0510">Vacant Seat</label>
		                </section>
		
	                </fieldset>
	
	                <br />

	                <!-- Row 4 -->
	                <fieldset id="Row4">
		                <legend><span>Row 4</span></legend>
		 
		                <section class="picture">
		                    <button id='btnSeat0401' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0401' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    			            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0401" for="btnSeat0401">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0402' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0402' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    	                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0402" for="btnSeat0402">Vacant Seat</label>
		                </section>

		                <section class="picture">
		                    <button id='btnSeat0403' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0403' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0403" for="btnSeat0403">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0404' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0404' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0404" for="btnSeat0404">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0405' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0405' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0405" for="btnSeat0405">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0406' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0406' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0406" for="btnSeat0406">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0407' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0407' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0407" for="btnSeat0407">Vacant Seat</label>
		                </section>	
		
		                <section class="picture">
		                    <button id='btnSeat0408' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0408' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0408" for="btnSeat0408">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0409' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0409' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0409" for="btnSeat0409">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0410' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0410' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0410" for="btnSeat0410">Vacant Seat</label>
		                </section>
		
	                </fieldset>
   
	                <br />
  
	                <!-- Row 3 -->
	                <fieldset id="Row3">
		                <legend><span>Row 3</span></legend>
		
    	                <section class="picture">
		                    <button id='btnSeat0301' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0301' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    			            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0301" for="btnSeat0301">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0302' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0302' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    	                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0302" for="btnSeat0302">Vacant Seat</label>
		                </section>

		                <section class="picture">
		                    <button id='btnSeat0303' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0303' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0303" for="btnSeat0303">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0304' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0304' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0304" for="btnSeat0304">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0305' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0305' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0305" for="btnSeat0305">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0306' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0306' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0306" for="btnSeat0306">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0307' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0307' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0307" for="btnSeat0307">Vacant Seat</label>
		                </section>	
		
		                <section class="picture">
		                    <button id='btnSeat0308' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0308' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0308" for="btnSeat0308">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0309' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0309' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0309" for="btnSeat0309">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0310' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0310' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0310" for="btnSeat0310">Vacant Seat</label>
		                </section>
		
	                </fieldset>
	
	                <br />
	
	                <!-- Row 2 -->
	                <fieldset id="Row2">
		                <legend><span>Row 2</span></legend>

    	                <section class="picture">
		                    <button id='btnSeat0201' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0201' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    			            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0201" for="btnSeat0201">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0202' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0202' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    	                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0202" for="btnSeat0202">Vacant Seat</label>
		                </section>

		                <section class="picture">
		                    <button id='btnSeat0203' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0203' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0203" for="btnSeat0203">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0204' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0204' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0204" for="btnSeat0204">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0205' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0205' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0205" for="btnSeat0205">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0206' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0206' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0206" for="btnSeat0206">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0207' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0207' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0207" for="btnSeat0207">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0208' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0208' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0208" for="btnSeat0208">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0209' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0209' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0209" for="btnSeat0209">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0210' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0210' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0210" for="btnSeat0210">Vacant Seat</label>
		                </section>
		
	                </fieldset>
	
	                <br />

	                <!-- Row 1 -->
	                <fieldset id="Row1">
		                <legend><span>Row 1</span></legend>

		                <section class="picture">
		                    <button id='btnSeat0101' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0101' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    			            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0101" for="btnSeat0101">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0102' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0102' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
    	                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0102" for="btnSeat0102">Vacant Seat</label>
		                </section>

		                <section class="picture">
		                    <button id='btnSeat0103' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0103' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0103" for="btnSeat0103">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0104' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0104' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0104" for="btnSeat0104">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0105' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0105' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0105" for="btnSeat0105">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0106' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0106' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0106" for="btnSeat0106">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0107' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0107' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0107" for="btnSeat0107">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0108' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0108' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0108" for="btnSeat0108">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0109' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0109' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
		                    <br />
		                    <label type="label" class="seatLbl" id="lblSeat0109" for="btnSeat0109">Vacant Seat</label>
		                </section>
		
		                <section class="picture">
		                    <button id='btnSeat0110' assigned="" onclick="SeatClicked(this.id);"><img id='imgSeat0110' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'></button>
                            <br />
		                    <label type="label" class="seatLbl" id="lblSeat0110" for="btnSeat0110">Vacant Seat</label>
		                </section>
		
	                </fieldset>

	                <br />

	                <h1>Front of the Classroom</h1>

	                <br />
 
                </fieldset>
            </section>
   
        </div>
    </body>

</html>

