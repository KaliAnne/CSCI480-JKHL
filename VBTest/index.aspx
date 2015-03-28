<%@ Page Language="VB" AutoEventWireup="true" CodeFile="index.aspx.vb" Inherits="index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
  <!-- Start header -->
  <head runat="server" align="center">
    <meta char="UTF-8" />
	<title>Seating Chart Application</title>
	<link rel="shortcut icon" type="image/png" href="images/favicon/apple.png"/>
    <link rel="stylesheet" href="seatingChart.css" type="text/css" />
    <script src="seatingFunctions.js"></script>
  </head>
  <!-- End header -->

  <body>
    <div align="center">

    <!--Start left nav bar -->
    <nav align="center"> 

      <!--Form Start-->
	  <form runat="server"> 
	  
	  <fieldset id="menuopt">
			<legend><span>Menu Options</span></legend>
		
		<br />
	  
	  <fieldset id="chartinfo">
			<legend><span>Chart Name</span></legend>
                <p><asp:TextBox runat="server" ID="ChartName" ReadOnly="true" /></p>
	  </fieldset>
	  
	  <br />
	  
      <fieldset id="roominfo">
		<legend><span>Room Size:</span></legend>
			<dt>Rows: <br /><input id="RoomRows" readonly="true" placeholder="5"value="" /></dt>
			<dt>Columns: <br /><input id="RoomColumns" readonly="true" placeholder="7"value="" /></dt>
			<br />
			<button id="EditRoom" type="Button" class ="attenBtn" onClick="activeEdit();">Edit Room</button>
	  </fieldset>
	  
	  <br />
      
	  <fieldset id="studentinfo">
		<legend><span>Student Information</span></legend>
		<dt>Please select a student:  
			<select  id="studentList">
			<option>Bob</option>
			<option>Rick</option>
			<option>Tim</option>
			<option>Mary</option>
			<option>Susan</option>
			<option>Kali</option>
			<option>Heather</option>
			<option>Jacob</option>
			<option>Lucas</option>
			</select>
	
	  </fieldset>
	  
		<br />
		
      <fieldset id="extrainfo">
		<legend><span>Help Menu</span></legend>		
			<button type="Button" class ="attenBtn">Home</button>
			<button type="Button" class ="attenBtn">Delete Room Chart</button>
			<button type="Button" class ="attenBtn">Add Student</button>
			<button type="Button" class ="attenBtn" onClick="removeStudent();">Remove Student</button>
			<button type="Button" class ="attenBtn">Add Aisle</button>
			<button type="Button" class ="attenBtn">View Past Seating Charts</button>
	   </fieldset>
	   
	   <br />
	   <br />

		 
	   </fieldset> <!--End menuopt-->
	  </form> <!-- End Form -->
  </nav> <!--End left nav bar-->
   
  <section align="center">
	<fieldset id="atteninfo">
	<legend><span>Attendance</span></legend>	
	<br>

    <button id="btnAttend" onClick="toggleAttend(this.id);">Take Attendance</button>
	<br />
    <br />
	<hr>
	
	<!-- Row 1 -->
		<fieldset id="Row1">
		<legend><span>Row 1</span></legend>
		<button id='btnSeat0101' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0101' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0102' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0102' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0103' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0103' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0104' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0104' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0105' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0105' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0106' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0106' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0107' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0107' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
	</fieldset>
  <br />
  
    <!-- Row 2 -->
		<fieldset id="Row2">
		<legend><span>Row 2</span></legend>
    	<button id='btnSeat0201' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0201' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0202' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0202' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0203' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0203' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0204' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0204' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0205' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0205' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0206' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0206' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0207' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0207' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>

	</fieldset>
  <br />
  
	<!-- Row 3 -->
		<fieldset id="Row3">
		<legend><span>Row 3</span></legend>
    	<button id='btnSeat0301' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0301' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0302' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0302' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0303' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0303' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0304' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0304' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0305' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0305' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0306' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0306' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0307' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0307' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>

	</fieldset>
	<br />
	
	<!-- Row 4 -->
		<fieldset id="Row4">
		<legend><span>Row 4</span></legend>
    	<button id='btnSeat0401' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0401' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0402' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0402' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0403' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0403' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0404' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0404' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0405' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0405' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0406' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0406' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0407' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0407' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>

	</fieldset>
	<br />
	
	<!-- Row 5 -->
		<fieldset id="Row5">
		<legend><span>Row 5</span></legend>
    	<button id='btnSeat0501' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0501' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0502' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0502' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
    	<button id='btnSeat0503' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0503' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0504' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0504' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0505' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0505' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0506' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0506' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>
		<button id='btnSeat0507' onClick="SeatAttndSwap(this.id);"><img id='imgSeat0507' src="images/icon_png/MiscStudent.png" src3="images/icon_png/MiscStudent.png" src1="images/icon_png/Checkmark.png" src2='images/icon_png/X.png'</button>

	</fieldset>
	<br />
	<br />
	
  </section>
  </fieldset>
  </div>
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:480-JKHLConnectionString %>" SelectCommand="SELECT * FROM [CHART_INFORMATION]"></asp:SqlDataSource>
  </body>
</html>