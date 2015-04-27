/*
Iteration 1 code for seating chart application.
Created and revised by JHKL 3/31/2015
 */

 //Initialize student list and load it into the dropdown of student names
  var NUM_ROWS = 8;  //Max number of rows on the chart, + 1	 
  var NUM_COLS = 11; //Max number of columns on the chart, + 1

//Sets the size of the room when the page first opens
  function OnLoad(){
	  var rows = byId("RoomRows").value;
	  var cols = byId("RoomColumns").value;
	  ChangeRoomSize(rows, cols);
	  LoadSeats();
  }
  
  function byId(e){return document.getElementById(e);}
    window.addEventListener("load", mInit, false);
  function byId(e){return document.getElementById(e);}
  
  //Handles functions for clicking seats
  function SeatClicked(btnClickedID) {

      //Handles when in Attendance mode
      if (byId("btnAttend").innerHTML == "Exit Attendance Mode") {
          SeatAttndSwap(btnClickedID);
          return false;
      }

      //Handles when in Assign Seats mode
      else if (byId("btnAssign").innerHTML == "Exit Assignment Mode") {
          SeatAssignInfo(btnClickedID);
          return false;
      }

      //If no mode currently in use, the VB function is called for the student's informationw
      else {
          return true;
      }
  }
  
  //Handles assigning seats and showing the info of the student assigned to the given seat
 function SeatAssignInfo(btnClickedID){
	//if no student is assigned the seat and the user is assigning seats, requests the name of the student to put here
     if (byId("btnAssign").innerHTML != "Assign Seats") {
         if (byId(btnClickedID).getAttribute("assigned") == "") {
             var studList = byId("studentList");
             var studentToAssign = studList.value;
             var alreadyAssigned = false;
             var seatList = byId("SeatsInfo");
             var imagedir = "";
             for (i = 0; i < seatList.options.length; i++) {
                 var optText = seatList.options[i].text;
                 if (optText.substring(4, optText.length) == studentToAssign) {
                     alreadyAssigned = true;
                 }
             }

             if (studentToAssign != "" && alreadyAssigned == false) {
                 if (StudPicExists(studentToAssign, byId("ChartName").value)) {
                     imagedir = "images/StudentPictures/" + byId("ChartName").value + "_" + studentToAssign + ".png";
                 }
                 else {
                     imagedir = "images/icon_png/MiscStudent.png";
                 }
                 byId(btnClickedID).setAttribute("assigned", studentToAssign);
                 byId(btnClickedID).setAttribute("srcPic", imagedir);
                 byId(btnClickedID).src = byId(btnClickedID).getAttribute("srcPic");
                 alert(studentToAssign + " has been assigned to the selected seat.");
                 var lblSeat = "lbl" + btnClickedID.substring(3, 11);
                 byId(lblSeat).innerHTML = studentToAssign;
                 AddToSeatList(studentToAssign, btnClickedID.substring(7, 11));
                 RemindToSave = true;
             }
             else if (alreadyAssigned){
                 alert(studentToAssign + " has already been assigned to a seat");
             }
             else {
                 alert("Please select a student from the list.");
             }
         }

             //If a student is already assigned to this seat, asks if the user would like to remove the student from the seat		
         else {
             var unassign = confirm("Would you like to remove " + byId(btnClickedID).getAttribute("assigned") + " from this seat?");
             if (unassign) {
                 ResetSeat(btnClickedID);
                 RemoveFromSeatList(btnClickedID.substring(7, 11));
                 alert("This seat is now available.");
                 RemindToSave = true;
             }
         }
     }
 }
  
  //Toggles between assigning seats and normal mode
  function AssignSeats(){
	if (byId("btnAssign").innerHTML == "Assign Seats"){
	    StartMode("btnAssign");
		byId("btnAssign").innerHTML = "Exit Assignment Mode";
	}
	else{
		byId("btnAssign").innerHTML = "Assign Seats";
		EndMode("btnAssign");
		RemindToSave = true;
	}
  }
  
  //Handles swapping between checkmarks and X's if taking attendance
  function SeatAttndSwap(btnClickedID){
      var tgt = byId(btnClickedID);
    if (tgt.getAttribute("src") == tgt.getAttribute("srcCheck")){
		tgt.src = tgt.getAttribute("srcX");
	}
    else if (tgt.getAttribute("src") == tgt.getAttribute("srcX")) {
        tgt.src = tgt.getAttribute("srcCheck");
	}
    else {
        alert("There is no student assigned to this seat");
    }
  }


//Swaps between viewing the seats and taking attendance
function toggleAttend(button_id) {
   var btnText = byId(button_id);
   var strRow = ""; 
   var strCol = "";
   var seatID = "";
   if (btnText.innerHTML == "Take Attendance") 
   {
	//Toggles text and sets seats to checkmarks and allows them to be changed to take attendance
     btnText.innerHTML = "Exit Attendance Mode";
     StartMode(button_id);
	 for (i = 1; i < NUM_ROWS; i++) { 
		strRow = i.toString();
		for (j = 1; j < NUM_COLS; j++){
			strCol = j.toString();
			if (strCol < 10){
				seatID = "btnSeat0" + strRow + "0" + strCol;				
			}
			else{
				seatID = "btnSeat0" + strRow + strCol;
			}
			if (byId(seatID).getAttribute("src") == byId(seatID).getAttribute("srcpic") && byId(seatID).getAttribute("assigned") != ""){
			    byId(seatID).src = byId(seatID).getAttribute("srcCheck");
			}
		}
	 }
   }
       //Sets button text to "Take Attendance" and changes seats marked present to their student picture
   else{
		btnText.innerHTML = "Take Attendance";
		EndMode("btnAttend");
		RemindToSave = true;
		for (i = 1; i < NUM_ROWS; i++) { 
			strRow = i.toString();
			for (j = 1; j < NUM_COLS; j++){
				strCol = j.toString();
				if (strCol < 10){
					seatID = "btnSeat0" + strRow + "0" + strCol;			
				}
				else{
					seatID =  "btnSeat0" + strRow + strCol;
				}
				
				//If the student is marked present [checkmarked], switches back to normal icon, if marked absent, saves the absent date
				if (byId(seatID).getAttribute("src") == byId(seatID).getAttribute("srcCheck")) {
				    byId(seatID).src = byId(seatID).getAttribute("srcPic");
				}
			}
		}
  }
}

//Changes the room size to the inputted rows x cols size
function ChangeRoomSize(rows, cols){
	var strRow = "1";
	var strCol = "1";
	var btnSeatID = "";
	var lblSeatID = "";
	for (i = 1; i < NUM_ROWS; i++){
		strRow = i.toString();
		for (j = 1; j < NUM_COLS; j++){
			strCol = j.toString();
			if (strCol < 10){
				btnSeatID = "btnSeat0" + strRow + "0" + strCol;
				lblSeatID = "lblSeat0" + strRow + "0" + strCol;				
			}
			else{
				btnSeatID = "btnSeat0" + strRow + strCol;
				lblSeatID = "lblSeat0" + strRow + strCol;	
			}
			
			if (i <= rows && j <= cols){
				byId(btnSeatID).style.visibility = "visible";
				byId(lblSeatID).style.visibility = "visible";
			}
			else{
				byId(btnSeatID).style.visibility = "hidden";
				byId(lblSeatID).style.visibility = "hidden";
			}
		}
	}
}

//Handles changing the available seats based on the entered dimensions for the room layout
  function activeEdit(){
    var chartName  = byId("ChartName");
    var chartRows = byId("RoomRows");
    var chartColumns = byId("RoomColumns");
    var editBtn    = byId("EditRoom");
	var rows = chartRows.value;
	var cols = chartColumns.value;
	
	//If the user clicks to save the changes, it checks for valid dimensions before adjusting the layout
    if (editBtn.value == "Exit Edit Mode") {
		if (rows > 0 && rows < NUM_ROWS){
		    if (cols > 0 && cols < NUM_COLS) {
		        alert("Seats are deleted from the top and right; please reposition students if necessary.");
			    ChangeRoomSize(rows, cols);
			    RemindToSave = true;
			    EndMode("EditRoom");
				editBtn.value = "Edit Room";
				
			}
			else{
				alert("There can only be up to 7 columns");
			}
		}
		else{
			alert("There can only be up to 5 rows");
		}
    }
	//Makes the textboxes editable and changes the button's text
    else {
      StartMode("EditRoom");
      editBtn.value = "Exit Edit Mode";
    }
    return false;
  }

//If user selects a student on the dropdown, the name on their seat is highlighted (if they're assigned to a seat)
  function HighlightName() {
      var strRow = "1";
      var strCol = "1";
      var btnSeatID = "";
      var lblSeatID = "";
      for (i = 1; i < NUM_ROWS; i++) {
          strRow = i.toString();
          for (j = 1; j < NUM_COLS; j++) {
              strCol = j.toString();
              if (strCol < 10) {
                  btnSeatID = "btnSeat0" + strRow + "0" + strCol;
                  lblSeatID = "lblSeat0" + strRow + "0" + strCol;
              }
              else {
                  btnSeatID = "btnSeat0" + strRow + strCol;
                  lblSeatID = "lblSeat0" + strRow + strCol;
              }
              if (byId(btnSeatID).getAttribute("assigned") != byId("studentList").value){
                  byId(lblSeatID).style.backgroundColor = "transparent";
              }
              else {
                  byId(lblSeatID).style.backgroundColor = "#00FF00";
              }
          }
      }
  }

//Confirms that the selected student should be removed and makes sure they're not assigned a seat
  function ConfirmStudRemoval() {
      //Alerts user if no student is selected
      var studname = byId("studentList").value;
      if (studname == "") {
          alert("Please select a student from the list.");
          return false;
      }

      //Confirms that the selected student should be removed or not removed
      else {
          var deleteConfirmed = confirm("Are you sure you want to delete " + studname + " from this chart?");
          return deleteConfirmed;

          //If being removed, makes sure to unassign the seat that the student was assigned to, if any
          if (deleteConfirmed) {
              var strRow = "1";
              var strCol = "1";
              var btnSeatID = "";
              for (i = 1; i < NUM_ROWS; i++) {
                  strRow = i.toString();
                  for (j = 1; j < NUM_COLS; j++) {
                      strCol = j.toString();
                      if (strCol < 10) {
                          btnSeatID = "btnSeat0" + strRow + "0" + strCol;
                      }
                      else {
                          btnSeatID = "btnSeat0" + strRow + strCol;
                      }
                      if (byId(btnSeatID).getAttribute("assigned") == studname) {
                          ResetSeat(btnSeatID);
                      }
                  }
              }
          }
      }
  }

//Resets the desired seat to be unassigned
  function ResetSeat(btnSeatID) {
      var lblSeat = "lbl" + btnSeatID.substring(3, 11); //Used to find the label for the inputted seat

      byId(btnSeatID).setAttribute("assigned", "");
      byId(btnSeatID).setAttribute("srcPic", "images/icon_png/EmptySeat.png");
      byId(btnSeatID).src = byId(btnSeatID).getAttribute("srcPic");
      byId(lblSeat).innerHTML = "Vacant Seat";
      byId(lblSeat).style.backgroundColor = "transparent";
  }

//When assign seats, take attendance, or edit room are clicked, their mode starts and most buttons are made unavailable to prevent any conflicting data from possibly occuring 
  function StartMode(modeButtonID) {
      if (modeButtonID == "EditRoom") {
          byId("btnAttend").disabled = true;
          byId("btnAssign").disabled = true;
      }
      else if (modeButtonID == "btnAttend") {
          byId("EditRoom").disabled = true;
          byId("btnAssign").disabled = true;
      }
      else if (modeButtonID == "btnAssign") {
          byId("btnAttend").disabled = true;
          byId("EditRoom").disabled = true;
      }
      byId("SaveChart").disabled = true;
      byId("btnViewPastAttendance").disabled = true;
      byId("btnAddStudent").disabled = true;
      byId("btnRemoveStudent").disabled = true;
      byId("btnDelChart").disabled = true;
  }

  //When a button with "Exit X Mode" is clicked, this gets run and makes other buttons clickable again.
  function EndMode(modeButtonID) {
      if (modeButtonID == "EditRoom") {
          byId("btnAttend").disabled = false;
          byId("btnAssign").disabled = false;
      }
      else if (modeButtonID == "btnAttend") {
          byId("EditRoom").disabled = false;
          byId("btnAssign").disabled = false;
      }
      else if (modeButtonID == "btnAssign") {
          byId("btnAttend").disabled = false;
          byId("EditRoom").disabled = false;
      }
      byId("SaveChart").disabled = false;
      byId("btnViewPastAttendance").disabled = false;
      byId("btnAddStudent").disabled = false;
      byId("btnRemoveStudent").disabled = false;
      byId("btnDelChart").disabled = false;
  }

  var RemindToSave = false; //Is set to true if attendance is taken, the room size changes, or if a student is assigned to/removed from a seat, then is set back to false if saved

  function OnClose() {
    if (RemindToSave) { return "Any unsaved data will be lost."; }
  }

  //If no student was selected, send this alert to the user
  function NoStudentSelected() {

      //Alerts user if no student is selected
      var studname = byId("studentList").value;
      if (studname == "") {
          alert("Please select a student from the list.");
          return false;
      }
  }

  function AddToSeatList(studname, studseat) {
      var opt = document.createElement("option");
      opt.text = studseat + studname;
      opt.value = studseat + studname;
      byId("SeatsInfo").options.add(opt);
  }

  function RemoveFromSeatList(studseat) {
      var seatList = byId("SeatsInfo");
      for (i = 0; i < seatList.options.length; i++) {
          var optText = seatList.options[i].text;
          if (optText.substring(0, 4) == studseat) {
              seatList.remove(i);
          }
      }
  }

  function LoadSeats() {
      var btnSeatID = "";
      var lblSeatID = "";
      var assigned = "";
      var optText = "";
      var imagedir = "";
      var seatList = byId("SeatsInfo");
      for (r = 1; r < NUM_ROWS; r++) {
          for (c = 1; c < NUM_COLS; c++) {
              if (c < 10) {
                  btnSeatID = "btnSeat0" + r.toString() + "0" + c.toString();
              }
              else {
                  btnSeatID = "btnSeat0" + r.toString() + c.toString();
              }
              lblSeatID = "lbl" + btnSeatID.substring(3, 11);
              for (i = 0; i < seatList.options.length; i++) {
                  optText = seatList.options[i].text;
                  if (optText.substring(0, 4) == btnSeatID.substring(7, 11)) {
                      assigned = optText.substring(4, optText.length);
                      byId(btnSeatID).setAttribute("assigned", assigned);
                      byId(lblSeatID).innerHTML = assigned;
                      if (StudPicExists(assigned, byId("ChartName").value)) {
                          imagedir = "images/StudentPictures/" + byId("ChartName").value + "_" + assigned + ".png";
                      }
                      else {
                          imagedir = "images/icon_png/MiscStudent.png";
                      }
                      byId(btnSeatID).setAttribute("srcPic", imagedir);
                      byId(btnSeatID).src = byId(btnSeatID).getAttribute("srcPic");

                  }
              }

          }
      }
  }

  function StudPicExists(studname, chartname) {
      var img = new Image();
      var imagedir = "images/StudentPictures/" + chartname + "_" + studname + ".png";
      img.src = imagedir;
      return img.height != 0;
  }