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
    <body onload="OnLoad()" onbeforeunload="return OnClose();">
    <header>
        <nav id="nav">
		    <ul>
			    <li><a href="home.aspx">Home</a></li>
				<li><a href="viewExisting.aspx">View Existing</a></li>
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
			            <legend><span><h2>Menu Options</h2></span></legend>		

		                <br />
	  
	                    <fieldset id="chartinfo">
			                <legend><span>Chart Name</span></legend>
                            <p><asp:TextBox runat="server" ID="ChartName" /></p>
                            <asp:Button runat="server" ID="SaveChart" Text="Save Room" Class="attenBtn" OnClick="SaveChart_Click" OnClientClick="RemindToSave = false;" />
	                    </fieldset>	 
                         
		                <br />
	  
                        <fieldset id="roominfo">
		                    <legend><span>Room Size:</span></legend>
                            <p>Rows: <br /> <asp:TextBox runat="server" ID="RoomRows" /></p>
                            <p>Columns: <br /> <asp:TextBox runat="server" ID="RoomColumns" /></p>
			
                            <br />

                            
                            <asp:Button runat="server" ID="EditRoom" Text="Edit Room" CssClass="attenBtn" OnClientClick="return activeEdit();" />
	                    </fieldset>	  

		                <br />
      
	                    <fieldset id="studentinfo">
		                    <legend><span>Student Information</span></legend>
		                    <p>Please select a student:</p>
                            <asp:DropDownList runat="server" ID="studentList" AppendDataBoundItems="true" onchange="HighlightName(); return false;" >
                                <asp:ListItem Text="(None)" Value=""></asp:ListItem>
                            </asp:DropDownList>
	                    </fieldset>
	  
		                <br />
		
                        <fieldset id="extrainfo">
		                    <legend><span>Help Menu</span></legend>	
			                    <button type="Button" class ="attenBtn" onclick="location.href='home.aspx'">Home</button>
			                    <asp:Button runat="server" ID="btnDelChart" Text="Delete Room Chart" CssClass ="attenBtn" OnClick="btnDelChart_Click" OnClientClick="return confirm('Are you sure you want to delete this chart?');" />
                                <asp:Button runat="server" ID="btnAddStudent" Text="Add Student" CssClass="attenBtn" OnClick="btnAddStudent_Click" />
			                    <asp:Button runat="server" ID="btnRemoveStudent" Text="Remove Student" CssClass="attenBtn" OnClick="btnRemoveStudent_Click" OnClientClick="return confirm('Are you sure you want to delete this student?');" />
                                <asp:Button runat="server" ID="btnViewStuInfo" Text="View Student Information" CssClass="attenBtn" OnClick="btnViewStuInfo_Click" OnClientClick="return NoStudentSelected();" />
			                    <button type="Button" class ="attenBtn" id="btnAssign" onclick="AssignSeats();">Assign Seats</button>
			                    <asp:Button runat="server" ID="btnViewPastAttendance" Text="View Past Attendance" CssClass="attenBtn" OnClick="btnViewPastAttendance_Click" />
	                    </fieldset>
	   
	                    <br />
	                    <br />

                        <!--Hidden fields to store the IDs that are not needed to be seen by the user-->
                        <asp:TextBox runat="server" ID="HiddenChartID" Visible="false"></asp:TextBox>
                        <asp:TextBox runat="server" ID="HiddenProfessorEmail" Visible="false"></asp:TextBox>
                        <asp:TextBox runat="server" ID="Total"></asp:TextBox>
                        <asp:TextBox runat="server" ID="AddStud" ></asp:TextBox>
                        <asp:TextBox runat="server" ID="RmvStud" ></asp:TextBox>
                        <asp:TextBox runat="server" ID="AtndStud" ></asp:TextBox>
		                <br />
                        <asp:DropDownList runat="server" ID="SeatsInfo" AppendDataBoundItems="true">
                        </asp:DropDownList>
                        <br />
                        <asp:DropDownList runat="server" ID="AbsentStuds" AppendDataBoundItems="true">
                        </asp:DropDownList>

	                </fieldset>
			        <!--End menuopt-->
	        </section> 	
			<!--End left nav bar-->
   
            <section align="center">
	            <fieldset id="atteninfo" align="center">
	                <legend><span><h2>Attendance</h2></span></legend>	

	                <br />

                    <button class ="attenBtn" id="btnAttend" onclick="toggleAttend(this.id); return false;">Take Attendance</button>

	                <br />
                    <br />

	                <hr />
	
		            <!-- Row 7 -->
	                <fieldset id="Row7">
		                <legend><span>Row 7</span></legend>
		 
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0701" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0701" for="btnSeat0701">Vacant Seat</label>
                        </section>
		
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0702" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0702" for="btnSeat0702">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0703" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0703" for="btnSeat0703">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0704" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0704" for="btnSeat0704">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0705" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0705" for="btnSeat0705">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0706" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0706" for="btnSeat0706">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0707" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0707" for="btnSeat0707">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0708" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0708" for="btnSeat0708">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0709" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0709" for="btnSeat0709">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0710" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0710" for="btnSeat0710">Vacant Seat</label>
                        </section>
		
	                </fieldset>
	
	                <br />
	
		            <!-- Row 6 -->
	                <fieldset id="Row6">
		                <legend><span>Row 6</span></legend>
		 
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0601" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0601" for="btnSeat0601">Vacant Seat</label>
                        </section>
		
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0602" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0602" for="btnSeat0602">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0603" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0603" for="btnSeat0603">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0604" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0604" for="btnSeat0604">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0605" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0605" for="btnSeat0605">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0606" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0606" for="btnSeat0606">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0607" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0607" for="btnSeat0607">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0608" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0608" for="btnSeat0608">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0609" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0609" for="btnSeat0609">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0610" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0610" for="btnSeat0610">Vacant Seat</label>
                        </section>
		
	                </fieldset>
	
	                <br />

	                <!-- Row 5 -->
	                <fieldset id="Row5">
		                <legend><span>Row 5</span></legend>
		 
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0501" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0501" for="btnSeat0501">Vacant Seat</label>
                        </section>
		
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0502" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0502" for="btnSeat0502">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0503" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0503" for="btnSeat0503">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0504" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0504" for="btnSeat0504">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0505" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0505" for="btnSeat0505">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0506" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0506" for="btnSeat0506">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0507" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0507" for="btnSeat0507">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0508" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0508" for="btnSeat0508">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0509" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0509" for="btnSeat0509">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0510" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0510" for="btnSeat0510">Vacant Seat</label>
                        </section>
		
	                </fieldset>
	
	                <br />

	                <!-- Row 4 -->
	                <fieldset id="Row4">
		                <legend><span>Row 4</span></legend>
		 
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0401" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0401" for="btnSeat0401">Vacant Seat</label>
                        </section>
		
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0402" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0402" for="btnSeat0402">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0403" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0403" for="btnSeat0403">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0404" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0404" for="btnSeat0404">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0405"  OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0405" for="btnSeat0405">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0406" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0406" for="btnSeat0406">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0407" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0407" for="btnSeat0407">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0408" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0408" for="btnSeat0408">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0409" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0409" for="btnSeat0409">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0410" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0410" for="btnSeat0410">Vacant Seat</label>
                        </section>
		
	                </fieldset>
   
	                <br />
  
	                <!-- Row 3 -->
	                <fieldset id="Row3">
		                <legend><span>Row 3</span></legend>
		
    	                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0301" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0301" for="btnSeat0301">Vacant Seat</label>
                        </section>
		
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0302" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0302" for="btnSeat0302">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0303" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0303" for="btnSeat0303">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0304" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0304" for="btnSeat0304">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0305" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0305" for="btnSeat0305">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0306" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0306" for="btnSeat0306">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0307" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0307" for="btnSeat0307">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0308" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0308" for="btnSeat0308">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0309" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0309" for="btnSeat0309">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0310" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0310" for="btnSeat0310">Vacant Seat</label>
                        </section>
		
	                </fieldset>
	
	                <br />
	
	                <!-- Row 2 -->
	                <fieldset id="Row2">
		                <legend><span>Row 2</span></legend>

    	                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0201" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0201" for="btnSeat0201">Vacant Seat</label>
                        </section>
		
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0202" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0202" for="btnSeat0202">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0203" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0203" for="btnSeat0203">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0204" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0204" for="btnSeat0204">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0205" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0205" for="btnSeat0205">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0206" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0206" for="btnSeat0206">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0207" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0207" for="btnSeat0207">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0208" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0208" for="btnSeat0208">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0209" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0209" for="btnSeat0209">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0210" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0210" for="btnSeat0210">Vacant Seat</label>
                        </section>
		
	                </fieldset>
	
	                <br />

	                <!-- Row 1 -->
	                <fieldset id="Row1">
		                <legend><span>Row 1</span></legend>

		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0101" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0101" for="btnSeat0101">Vacant Seat</label>
                        </section>
		
		                <section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0102" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0102" for="btnSeat0102">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0103" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0103" for="btnSeat0103">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0104" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0104" for="btnSeat0104">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0105" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0105" for="btnSeat0105">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0106" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0106" for="btnSeat0106">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0107" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0107" for="btnSeat0107">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0108" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0108" for="btnSeat0108">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0109" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0109" for="btnSeat0109">Vacant Seat</label>
                        </section>
						
						<section class="picture">
		                    <asp:Imagebutton runat="server" ID="btnSeat0110" OnClick="ManageStudSeat" OnClientClick="return SeatClicked(this.id);" CssClass="SeatBtn" ImageUrl="images/icon_png/EmptySeat.png" assigned="" srcCheck="images/icon_png/Checkmark.png" srcX="images/icon_png/X.png" srcPic="images/icon_png/EmptySeat.png"  />
                            <br />
                            <label type="label" class="seatLbl" id="lblSeat0110" for="btnSeat0110">Vacant Seat</label>
                        </section>
		
	                </fieldset>

	                <br />

	                <h1>Front of the Classroom</h1>

	                <br />
 
                </fieldset>
            </section>
            </form>
        </div>
    </body>

</html>
