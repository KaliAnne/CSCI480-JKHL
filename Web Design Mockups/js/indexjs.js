/*
Iteration 1 code for seating chart application.
Created and revised by JHKL 3/31/2015
 */

 //Initialize student list and load it into the dropdown of student names
  var students = [];
  var NUM_ROWS = 8;  //Number of rows + 1	 
  var NUM_COLS = 11; //Number of columns + 1
  function OnLoad(){
	  students.push(new studentInfo("None", "None", "None", "None", "None", "0000")); //Dummy student to take index 0
	  students.push(new studentInfo("Bob", "bob@email", "Premed", "Spanish", "None", "0201"));
	  students.push(new studentInfo("Rick", "rick@email", "English", "Math", "None", "0102"));
	  students.push(new studentInfo("Tim", "tim@email", "Equestrian", "Pre-vet", "None", "0000"));
	  students.push(new studentInfo("Mary", "mary@email", "English", "Theatre", "None", "0000"));
	  students.push(new studentInfo("Susan", "susan@email", "Math", "English", "None", "0000"));
	  students.push(new studentInfo("Kali", "dumpertk@findlay.edu", "Computer Science", "None", "None", "0000"));
	  students.push(new studentInfo("Heather", "beckh@findlay.edu", "Computer Science, Math", "None", "ACM", "0000"));
	  students.push(new studentInfo("Jacob", "babionej@findlay.edu", "Computer Science, Math", "None", "ACM, TAG", "0000"));
	  students.push(new studentInfo("Lucas", "kelleykiefferl@findlay.edu", "Computer Science", "None", "None", "0000"));
	  
	  //Adds each student's name to the list, and assigns them to a seat if they were given one above or from the database
	  for(i = 1; i < students.length; i++){
		var studentOpt = document.createElement("option");
		studentOpt.text = students[i].name;
		byId("studentList").add(studentOpt);
		
		if (students[i].seated != "0000"){
			var seatID = "btnSeat" + students[i].seated;
			byId(seatID).setAttribute("assigned", i);
		}
	  }
  }
  
  function byId(e){return document.getElementById(e);}
    window.addEventListener("load", mInit, false);
  function byId(e){return document.getElementById(e);}
  
  //Handles functions for clicking seats; if not assigned and taking attendance, can swap between check/X, otherwise opens student info
  function SeatClicked(btnClickedID){
	if (byId("btnAttend").innerHTML == "Save Attendance"){
		SeatAttndSwap(btnClickedID);
	}
	else{
		SeatAssignInfo(btnClickedID);
	}	
  }
  
  //Handles assigning seats and showing the info of the student assigned to the given seat
 function SeatAssignInfo(btnClickedID){
	var studentID = byId(btnClickedID).getAttribute("assigned");
	var name = students[studentID].name;
	
	//If the someone is assigned to the seat and btnAssign has not been toggled, displays student info
	
	if (byId("btnAssign").innerHTML == "Assign Seats"){
		if (studentID == 0){
			alert("No student has been assigned this seat.")
		}	
		else{
			ViewStudentInfo(name);
		}
	}
	else{
		//if no student is assigned the seat and the user is assigning seats, requests the name of the student to put here
		if (byId(btnClickedID).getAttribute("assigned") == 0){
			var studentToAssign = prompt("Enter the name of the student who will sit here.");
			var studentIndex = 0;
			
			for (i = 1; i < students.length; i++){
				if (students[i].name.toUpperCase() == studentToAssign.toUpperCase()){
					studentIndex = i;
				}
			}
			
			if (studentIndex != 0){
				if (students[studentIndex].seated != "0000"){
					alert(studentToAssign + " is already assigned to a seat.");
				}
				else{
					byId(btnClickedID).setAttribute("assigned", studentIndex);
					alert(studentToAssign + " has been assigned to the selected seat.");
					students[studentIndex].seated = btnClickedID.substring(7, 11);
					var lblSeat = "lbl" + btnClickedID.substring(3, 11);
					byId(lblSeat).innerHTML = studentToAssign;
				}
			}
			
			else{
				alert("This student is not on the list of students.  To add them to the list, click the 'Add Student' button.");
			}
		}

		//If a student is already assigned to this seat, asks if the user would like to remove the student from the seat		
		else{
			var unassign = confirm("Would you like to remove " + name + " from this seat?  WARNING: Attendance data may be lost!");
			if (unassign){
				byId(btnClickedID).setAttribute("assigned", 0);
				students[studentID].seated = "0000";
				var lblSeat = "lbl" + btnClickedID.substring(3, 11);
				byId(lblSeat).innerHTML = "Vacant Seat";
				alert("This seat is now available.");
				
			}
		}
	}
 }
  
  //Toggles between assigning seats and normal mode
  function AssignSeats(){
	if (byId("btnAssign").innerHTML == "Assign Seats"){
		byId("btnAttend").disabled = true;
		byId("EditRoom").disabled = true;
		byId("btnAssign").innerHTML = "Save Seats";
	}
	else{
		byId("btnAssign").innerHTML = "Assign Seats";
		byId("btnAttend").disabled = false;
		byId("EditRoom").disabled = false;
	}
  }
  
  //Handles swapping between checkmarks and X's if taking attendance
  function SeatAttndSwap(btnClickedID){
	var seatImg = "img" + btnClickedID.substring(3, 11);
    var tgt = byId(seatImg);
	if (tgt.getAttribute("src") == tgt.getAttribute("src1")){
		tgt.src = tgt.getAttribute("src2");
	}
	else if (tgt.getAttribute("src") == tgt.getAttribute("src2") && btnAttend.innerHTML == "Save Attendance"){
		tgt.src = tgt.getAttribute("src1");
	}
		
  }


//Swaps between viewing the seats and taking attendance
function toggleAttend(button_id) {
   var btnText = byId(button_id);
   var strRow = "1";
   var strCol = "1";
   var seatID = "imgSeat0101";
   if (btnText.innerHTML == "Take Attendance") 
   {
	//Toggles text and sets seats to checkmarks and allows them to be changed to take attendance
     btnText.innerHTML = "Save Attendance";
	 byId("EditRoom").disabled = true;
	 byId("btnAssign").disabled = true;
	 for (i = 1; i < NUM_ROWS; i++) { 
		strRow = i.toString();
		for (j = 1; j < NUM_COLS; j++){
			strCol = j.toString();
			if (strCol < 10){
				seatID = "imgSeat0" + strRow + "0" + strCol;				
			}
			else{
				seatID = "imgSeat0" + strRow + strCol;
			}
			byId(seatID).src = byId(seatID).getAttribute("src1");
		}
	 }
   }
   else{
	//Toggles text and sets seat to Misc. icons if previously a checkmark, but leaves them as X if absent
	var saveAttend = confirm("Would you like to save the attendance as shown currently?");
	if (saveAttend){
		btnText.innerHTML = "Take Attendance";
		byId("EditRoom").disabled = false;
		byId("btnAssign").disabled = false;
		var curdate = new Date();
		for (i = 1; i < NUM_ROWS; i++) { 
			strRow = i.toString();
			
			for (j = 1; j < NUM_COLS; j++){
				strCol = j.toString();
				if (strCol < 10){
					seatID = "imgSeat0" + strRow + "0" + strCol;			
				}
				else{
					seatID =  "imgSeat0" + strRow + strCol;
				}
				
				//If the student is marked present [checkmarked], switches back to normal icon, if marked absent, saves the absent date
				if (byId(seatID).getAttribute("src") == byId(seatID).getAttribute("src1")){
					byId(seatID).src = byId(seatID).getAttribute("src3");
				}
				else{
					if (strCol < 10){
						seatID = "btnSeat0" + strRow + "0" + strCol;			
					}
					else{
						seatID = "btnSeat0" + strRow + strCol;
					}
					var studentID = byId(seatID).getAttribute("assigned");
					students[studentID].absences.push((curdate.getMonth() + 1).toString()  + "/" + (curdate.getDate()).toString() + "/" + (curdate.getFullYear()).toString());
				}
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

//Handles changing the available seats based on the entered dimensions for the room layout
  function activeEdit(){
    var chartName  = byId("ChartName");
    var chartRows = byId("RoomRows");
    var chartColumns = byId("RoomColumns");
    var editBtn    = byId("EditRoom");
	var rows = chartRows.value;
	var cols = chartColumns.value;
	var strRow = "1";
	var strCol = "1";
	var btnSeatID = "";
	var lblSeatID = "";
	
	//If the user clicks to save the changes, it checks for valid dimensions before adjusting the layout
    if (editBtn.innerHTML == "Save Changes") {
		alert("Information might be lost. Seats are deleted from the bottom and right; please reposition students if necessary.");
		if (rows > 0 && rows < NUM_ROWS){
			if (cols > 0 && cols < NUM_COLS){
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
				chartName.readOnly = true;
				chartRows.readOnly = true;
				chartColumns.readOnly = true;
				byId("btnAttend").disabled = false;
				byId("btnAssign").disabled = false;
				editBtn.innerHTML = "Edit Room";
				
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
      editBtn.innerHTML = "Save Changes";
    }
  }
  

//HB function to remove a student from the class
//TODO: Check whether professor or not
//TODO: Connect changes to database entry of chart

//Handles creation of new students and their information; can be expanded further to include absences or something
  function studentInfo(fullname, studemail, major, minor, extra, seat){
	this.name = fullname;
	this.email = studemail;
	this.majors = major;
	this.minors = minor;
	this.extras = extra;
	this.seated = seat;
	this.absences = [];
  }
  
  //Brings up an alert to view a student's information, given their name
  function ViewStudentInfo(name){
	var studentID = 0;
	for (i = 1; i < students.length; i++){
		if (name.toUpperCase() == students[i].name.toUpperCase()){
			studentID = i;
		}
	}
	var email = students[studentID].email;	
	var majors = students[studentID].majors;
	var minors = students[studentID].minors;
	var home = students[studentID].extras;
	var absences = students[studentID].absences.length;
	var absenceList = "\nAbsences:    ";
	
	//Shows dates absent, if any
	if (absences > 0){
		absenceList = absenceList + absences;
		for (i = 0; i < absences; i++){
			absenceList = absenceList + "\n                    " + students[studentID].absences[i];
		}
	}
	else{
		absenceList = absenceList + "No days missed!";
	}
	alert("Name:         " + name + "\nEmail:          " + email + "\nMajor:         " + majors + "\nMinor:         " + minors + "\nExtracurriculars: " + home + absenceList);
  }
  
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
				for (j = 1; j < students.length; j++){
					if (studentToRemove.toUpperCase() == students[j].name.toUpperCase()){
						students.splice(j, 1);
					}
				}
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
  
  //Add student to studentList dropdown; cannot add duplicate student names
  function addStudent() {
	var studentList = byId('studentList');
	var studentToAdd = prompt("Please enter the name of the student.");
	var alreadyListed = "false";
	
	//Checks to see if the name is already in the list
	for (i=0; i<studentList.length; i++){
		if (studentList.options[i].text.toUpperCase() == studentToAdd.toUpperCase()){
			alreadyListed = "true";
		}
	}
	
	//Only asks for further information if the name is unique
	if (alreadyListed == "false"){
		var studentEmail = prompt("Please enter the student's email address.");
		var studentMajors = prompt("Please enter the student's major(s).");
		var studentMinors = prompt("Please enter the student's minor(s).");
		var studentExtra = prompt("Please enter the student's extracurricular activities.");		
		var newStudent = document.createElement("option");
		
		newStudent.text = studentToAdd;
		studentList.add(newStudent);
		students[students.length] = new studentInfo(studentToAdd, studentEmail, studentMajors, studentMinors, studentExtra, false);
		alert(studentToAdd + " was added to the student list.");
	}
	
	//Shows an alert if the name was not unique
	else{
		alert("This student is already on the list!");
	}
  }