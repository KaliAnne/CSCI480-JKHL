/*
Iteration 1 code for seating chart application.
Created and revised by JHKL 3/31/2015
 */

 //Initialize student list and load it into the dropdown of student names
  var NUM_ROWS = 8;  //Number of rows + 1	 
  var NUM_COLS = 11; //Number of columns + 1
  function OnLoad(){
	  var rows = byId("RoomRows").value;
	  var cols = byId("RoomColumns").value;
	  ChangeRoomSize(rows, cols);
  }
  
  function byId(e){return document.getElementById(e);}
    window.addEventListener("load", mInit, false);
  function byId(e){return document.getElementById(e);}
  
  //Handles functions for clicking seats; if not assigned and taking attendance, can swap between check/X, otherwise opens student info
  function SeatClicked(btnClickedID){
      if (byId("btnAttend").innerHTML == "Exit Attendance Mode") {
          SeatAttndSwap(btnClickedID);
          return false;
      }
      else if (byId("btnAssign").innerHTML == "Exit Assignment Mode") {
          SeatAssignInfo(btnClickedID);
          return false;
      }
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
             var studentToAssign = prompt("Enter the name of the student who will sit here.");
             var studentIndex = 0;
             for (i = 1; i < studList.options.length; i++) {
                 if (studList.options[i].text.toUpperCase() == studentToAssign.toUpperCase()) {
                     studentIndex = i;
                     studentToAssign = studList.options[i].text;
                 }
             }

             if (studentIndex != 0) {
                 byId(btnClickedID).setAttribute("assigned", studentToAssign);
                 byId(btnClickedID).setAttribute("srcPic", "images/icon_png/MiscStudent.png");
                 byId(btnClickedID).src = byId(btnClickedID).getAttribute("srcPic");
                 alert(studentToAssign + " has been assigned to the selected seat.");
                 var lblSeat = "lbl" + btnClickedID.substring(3, 11);
                 byId(lblSeat).innerHTML = studentToAssign;
                 RemindToSave = true;
             }

             else {
                 alert("This student is not on the list of students.  To add them to the list, click the 'Add Student' button.");
             }
         }

             //If a student is already assigned to this seat, asks if the user would like to remove the student from the seat		
         else {
             var unassign = confirm("Would you like to remove " + byId(btnClickedID).getAttribute("assigned") + " from this seat?");
             if (unassign) {
                 byId(btnClickedID).setAttribute("assigned", "");
                 var lblSeat = "lbl" + btnClickedID.substring(3, 11);
                 byId(btnClickedID).setAttribute("srcPic", "images/icon_png/EmptySeat.png");
                 byId(btnClickedID).src = byId(btnClickedID).getAttribute("srcPic");
                 byId(lblSeat).innerHTML = "Vacant Seat";
                 byId(lblSeat).style.backgroundColor = "transparent";
                 alert("This seat is now available.");
                 RemindToSave = true;
             }
         }
     }
 }
  
  //Toggles between assigning seats and normal mode
  function AssignSeats(){
	if (byId("btnAssign").innerHTML == "Assign Seats"){
		byId("btnAttend").disabled = true;
		byId("EditRoom").disabled = true;
		byId("btnAssign").innerHTML = "Exit Assignment Mode";
	}
	else{
		byId("btnAssign").innerHTML = "Assign Seats";
		byId("btnAttend").disabled = false;
		byId("EditRoom").disabled = false;
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
   var strRow = "1";
   var strCol = "1";
   var seatID = "test";
   if (btnText.innerHTML == "Take Attendance") 
   {
	//Toggles text and sets seats to checkmarks and allows them to be changed to take attendance
     btnText.innerHTML = "Exit Attendance Mode";
	 byId("EditRoom").disabled = true;
	 byId("btnAssign").disabled = true;
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
		byId("EditRoom").disabled = false;
		byId("btnAssign").disabled = false;
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
//Heather's to do list -->
//HB function either makes the room information editable or not
//TODO: check whether professor or not
//TODO: Connect changes to database entry of chart
//End Do list -->

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
				chartName.readOnly = true;
				chartRows.readOnly = true;
				chartColumns.readOnly = true;
				byId("btnAttend").disabled = false;
				byId("btnAssign").disabled = false;
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
	  byId("btnAttend").disabled = true;
	  byId("btnAssign").disabled = true;
      chartName.readOnly = false;
      chartRows.readOnly = false;
      chartColumns.readOnly = false;
      editBtn.value = "Exit Edit Mode";
    }
    return false;
  }
  

//HB function to remove a student from the class
//TODO: Check whether professor or not
//TODO: Connect changes to database entry of chart
  
  
  //Remove student from the studentList dropdown
  function removeStudent() {
    var studentList = byId("studentList");
    var studentToRemove = prompt("Which student would you like to remove?");
    var found = "false";
	//Looks for the requested name after confirming that the user would like to remove the student
    if(confirm("Information will be lost. Are you sure you want to remove this student?")){
		for (i=0; i<studentList.length; i++){
			//Removes the name from the dropdown and from the students array
			if(studentList.options[i].text.toUpperCase() == studentToRemove.toUpperCase()){
				studentList.remove(i);
				found = "true";
				alert(studentToRemove + " was removed");
				break;
			}
		}
  
		if (found == "false") {
			alert("Student not found. Please try again.");
		}	  
    }
    else{
      alert("No student removed.");
    }
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
                          byId(btnSeatID).setAttribute("assigned", "");
                          var lblSeat = "lbl" + btnSeatID.substring(3, 11);
                          byId(btnSeatID).setAttribute("srcPic", "images/icon_png/EmptySeat.png");
                          byId(btnSeatID).src = byId(btnClickedID).getAttribute("srcPic");
                          byId(lblSeat).innerHTML = "Vacant Seat";
                          byId(lblSeat).style.backgroundColor = "transparent";
                      }
                  }
              }
          }
      }
  }
  var RemindToSave = false; //Is set to true if attendance is taken, the room size changes, or if a student is assigned to/removed from a seat, then is set back to false if saved
function OnClose() {
    if (RemindToSave) { return "Any unsaved data will be lost."; }
}