 //Initialize student list and load it into the dropdown of student names
  var students = [];
  function OnLoad(){
	  students.push(new studentInfo("None", "None", "None", "None", "None", true)); //Dummy student to take index 0
	  students.push(new studentInfo("Bob", "bob@email", "Premed", "Spanish", "None", true));
	  students.push(new studentInfo("Rick", "rick@email", "English", "Math", "None", true));
	  students.push(new studentInfo("Tim", "tim@email", "Equestrian", "Pre-vet", "None", true));
	  students.push(new studentInfo("Mary", "mary@email", "English", "Theatre", "None", true));
	  students.push(new studentInfo("Susan", "susan@email", "Math", "English", "None", true));
	  students.push(new studentInfo("Kali", "dumpertk@findlay.edu", "Computer Science", "None", "None", true));
	  students.push(new studentInfo("Heather", "beckh@findlay.edu", "Computer Science, Math", "None", "None", true));
	  students.push(new studentInfo("Jacob", "babionej@findlay.edu", "Computer Science, Math", "None", "Findlay, OH", true));
	  students.push(new studentInfo("Lucas", "kelleykiefferl@findlay.edu", "Computer Science", "None", "Findlay, OH", true));
	  
	  //Adds each student's name to the list
	  for(i = 1; i < students.length; i++){
		var studentOpt = document.createElement("option");
		studentOpt.text = students[i].name;
		byId("studentList").add(studentOpt);
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
				if (students[studentIndex].seated){
					alert(studentToAssign + " is already assigned to a seat.");
				}
				else{
					byId(btnClickedID).setAttribute("assigned", studentIndex);
					alert(studentToAssign + " has been assigned to the selected seat.");
					students[studentIndex].seated = true;
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
				students[studentID].seated = false;
				alert("This seat is now available.");
			}
		}
	}
 }
  
  //Toggles between assigning seats and normal mode
  function AssignSeats(){
	if (byId("btnAssign").innerHTML == "Assign Seats"){
		byId("btnAssign").innerHTML = "Save Seats";
	}
	else{
		byId("btnAssign").innerHTML = "Assign Seats";
	}
  }
  
  //Handles swapping between checkmarks and X's if taking attendance
  function SeatAttndSwap(btnClickedID){
	var seatImg = "";
	switch (btnClickedID) {
		case 'btnSeat0101':
			seatImg = 'imgSeat0101';
			break;
		case 'btnSeat0102':
			seatImg = 'imgSeat0102';
			break;
		case 'btnSeat0103':
			seatImg = 'imgSeat0103';
			break;
		case 'btnSeat0104':
			seatImg = 'imgSeat0104';
			break;
		case 'btnSeat0105':
			seatImg = 'imgSeat0105';
			break;
		case 'btnSeat0106':
			seatImg = 'imgSeat0106';
			break;
		case 'btnSeat0107':
			seatImg = 'imgSeat0107';
			break;
		case 'btnSeat0201':
			seatImg = 'imgSeat0201';
			break;
		case 'btnSeat0202':
			seatImg = 'imgSeat0202';
			break;
		case 'btnSeat0203':
			seatImg = 'imgSeat0203';
			break;
		case 'btnSeat0204':
			seatImg = 'imgSeat0204';
			break;
		case 'btnSeat0205':
			seatImg = 'imgSeat0205';
			break;
		case 'btnSeat0206':
			seatImg = 'imgSeat0206';
			break;
		case 'btnSeat0207':
			seatImg = 'imgSeat0207';
			break;
		case 'btnSeat0301':
			seatImg = 'imgSeat0301';
			break;
		case 'btnSeat0302':
			seatImg = 'imgSeat0302';
			break;
		case 'btnSeat0303':
			seatImg = 'imgSeat0303';
			break;
		case 'btnSeat0304':
			seatImg = 'imgSeat0304';
			break;
		case 'btnSeat0305':
			seatImg = 'imgSeat0305';
			break;
		case 'btnSeat0306':
			seatImg = 'imgSeat0306';
			break;
		case 'btnSeat0307':
			seatImg = 'imgSeat0307';
			break;
		case 'btnSeat0401':
			seatImg = 'imgSeat0401';
			break;
		case 'btnSeat0402':
			seatImg = 'imgSeat0402';
			break;
		case 'btnSeat0403':
			seatImg = 'imgSeat0403';
			break;
		case 'btnSeat0404':
			seatImg = 'imgSeat0404';
			break;
		case 'btnSeat0405':
			seatImg = 'imgSeat0405';
			break;
		case 'btnSeat0406':
			seatImg = 'imgSeat0406';
			break;
		case 'btnSeat0407':
			seatImg = 'imgSeat0407';
			break;
		case 'btnSeat0501':
			seatImg = 'imgSeat0501';
			break;
		case 'btnSeat0502':
			seatImg = 'imgSeat0502';
			break;
		case 'btnSeat0503':
			seatImg = 'imgSeat0503';
			break;
		case 'btnSeat0504':
			seatImg = 'imgSeat0504';
			break;
		case 'btnSeat0505':
			seatImg = 'imgSeat0505';
			break;
		case 'btnSeat0506':
			seatImg = 'imgSeat0506';
			break;
		case 'btnSeat0507':
			seatImg = 'imgSeat0507';
			break;
			
	}
    var tgt = byId(seatImg);
	if (tgt.getAttribute("src") == tgt.getAttribute("src1")){
		tgt.src = tgt.getAttribute("src2");
	}
	else if (tgt.getAttribute("src") == tgt.getAttribute("src2") && btnAttend.innerHTML == "Save Attendance"){
		tgt.src = tgt.getAttribute("src1");
	}
		
  }
<!-- End Script Button -->

//Swaps between viewing the seats and taking attendance
function toggleAttend(button_id) {
   var btnText = byId(button_id);
   var strRow = "1";
   var strCol = "1";
   var zero = "0";
   var seat = "imgSeat";
   var seatID = "imgSeat0101";
   if (btnText.innerHTML == "Take Attendance") 
   {
	<!-- Toggles text and sets seats to checkmarks and allows them to be changed to take attendance -->
     btnText.innerHTML = "Save Attendance";
	 for (i = 1; i < 6; i++) { 
		strRow = i.toString();
		for (j = 1; j < 8; j++){
			strCol = j.toString();
			seatID = seat.concat(zero, strRow, zero, strCol);
			byId(seatID).src = byId(seatID).getAttribute("src1");
			seat = "imgSeat";
		}
	 }
   }
   else 
   {
   <!-- Toggles text and sets seat to Misc. icons if previously a checkmark, but leaves them as X if absent -->
     btnText.innerHTML = "Take Attendance";
	  for (i = 1; i < 6; i++) { 
		strRow = i.toString();
		for (j = 1; j < 8; j++){
			strCol = j.toString();
			seatID = seat.concat(zero, strRow, zero, strCol);
			if (byId(seatID).getAttribute("src") == byId(seatID).getAttribute("src1")){
				byId(seatID).src = byId(seatID).getAttribute("src3");
			}
			seat = "imgSeat";
		}
	 }
   }
}
<!-- Heather's to do list -->
//HB function either makes the room information editable or not
//TODO: check whether professor or not
//TODO: Connect changes to database entry of chart
<!-- End Do list -->

//Handles changing the available seats based on the entered dimensions for the room layout
  function activeEdit(){
    var chartName  = byId("ChartName");
    var chartRows = byId("RoomRows");
    var chartColumns = byId("RoomColumns");
    var editBtn    = byId("EditRoom");
	var zero = "0";
	var rows = chartRows.value;
	var cols = chartColumns.value;
	var strRow = "1";
	var strCol = "1";
	var seat = "btnSeat";
	var seatID = "";
	
	//If the user clicks to save the changes, it checks for valid dimensions before adjusting the layout
    if (editBtn.innerHTML == "Save Changes") {
      alert("Information might be lost. Seats are deleted from the bottom and right; please reposition students if necessary.");
		if (rows > 0 && rows < 6){
			if (cols > 0 && cols < 8){
				for (i = 1; i < 6; i++){
					strRow = i.toString();
					for (j = 1; j < 8; j++){
						strCol = j.toString();
						seatID = seat.concat(zero, strRow, zero, strCol);
						if (i <= rows && j <= cols){
							byId(seatID).style.visibility = "visible";
						}
						else{
							byId(seatID).style.visibility = "hidden";
						}
						seat = "btnSeat";
					}
				}
				chartName.readOnly = true;
				chartRows.readOnly = true;
				chartColumns.readOnly = true;
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
      chartName.readOnly = false;
      chartRows.readOnly = false;
      chartColumns.readOnly = false;
      editBtn.innerHTML = "Save Changes";
    }
  }
  
<!-- Heather's to do list -->
//HB function to remove a student from the class
//TODO: Check whether professor or not
//TODO: Connect changes to database entry of chart
<!-- End Do list -->

//Handles creation of new students and their information; can be expanded further to include absences or something
  function studentInfo(fullname, studemail, major, minor, hometown, seat){
	this.name = fullname;
	this.email = studemail;
	this.majors = major;
	this.minors = minor;
	this.home = hometown;
	this.seated = seat;
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
	var home = students[studentID].home;
	alert("Name:         " + name + "\nEmail:          " + email + "\nMajor:         " + majors + "\nMinor:         " + minors + "\nHometown: " + home);
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
		var studentHometown = prompt("Please enter the student's hometown.");		
		var newStudent = document.createElement("option");
		
		newStudent.text = studentToAdd;
		studentList.add(newStudent);
		students[students.length] = new studentInfo(studentToAdd, studentEmail, studentMajors, studentMinors, studentHometown, false);
		alert(studentToAdd + " was added to the student list.");
	}
	
	//Shows an alert if the name was not unique
	else{
		alert("This student is already on the list!");
	}
  }