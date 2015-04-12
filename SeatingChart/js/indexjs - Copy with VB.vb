'/*
'Iteration 1 code for seating chart application.
'Created and revised by JHKL 3/31/2015
'*/

 'Initialize student list and load it into the dropdown of student names
  'var students = [];
  Dim NUM_ROWS = 8  'Number of rows + 1	 
  Dim NUM_COLS = 11 'Number of columns + 1
  Sub OnLoad(){ '---------VB
	  'fills the students array with these students + their info
	  'students.push(new studentInfo("None", "None", "None", "None", "None", "0000")); 'Dummy student to take index 0
	  'students.push(new studentInfo("Bob", "bob@email", "Premed", "Spanish", "None", "0201"));
	  'students.push(new studentInfo("Rick", "rick@email", "English", "Math", "None", "0102"));
	  'students.push(new studentInfo("Tim", "tim@email", "Equestrian", "Pre-vet", "None", "0000"));
	  'students.push(new studentInfo("Mary", "mary@email", "English", "Theatre", "None", "0000"));
	  'students.push(new studentInfo("Susan", "susan@email", "Math", "English", "None", "0000"));
	  'students.push(new studentInfo("Kali", "dumpertk@findlay.edu", "Computer Science", "None", "None", "0000"));
	  'students.push(new studentInfo("Heather", "beckh@findlay.edu", "Computer Science, Math", "None", "ACM", "0000"));
	  'students.push(new studentInfo("Jacob", "babionej@findlay.edu", "Computer Science, Math", "None", "ACM, TAG", "0000"));
	  'students.push(new studentInfo("Lucas", "kelleykiefferl@findlay.edu", "Computer Science", "None", "None", "0000")); 
	  'Adds each student's name to the list, and assigns them to a seat if they were given one above or from the database
	  'for(i = 1; i < students.length; i++)
	  {
		'byId("studentList").Items.Add(new ListItem(students[i].names))
		
		'if the student is assigned to a seat
		'if (students[i].seated != "0000")
		{
			'sets seatID to "btnSeatRRCC" (RRCC is the row number and column number)
			'var seatID = "btnSeat" + students[i].seated;
			byId(seatID).setAttribute("assigned", i) 'NOT SURE IF CORRECT
		}
	  }
  End Sub
  
  function byId(e)
	return document.getElementById(e)
  End function
  
  window.addEventListener("load", mInit, false)
  function byId(e)
	return document.getElementById(e)
  End function
  
  'Handles functions for clicking seats; if not assigned and taking attendance, can swap between check/X, otherwise opens student info; still javascript
  function SeatClicked(btnClickedID){ 'Still in javascript
	if (byId("btnAttend").innerHTML == "Save Attendance"){
		SeatAttndSwap(btnClickedID);
	}
	else{
		SeatAssignInfo(btnClickedID);
	}	
  }
  
  'Handles assigning seats and showing the info of the student assigned to the given seat
 Sub SeatAssignInfo(btnClickedID) '-------------VB
	Dim studentID as Integer = byId(btnClickedID).getAttribute("assigned") 'NOT SURE IF CORRECT
	'sets name to the name of the student assigned to the seat that was clicked
	'var name = students[studentID].name;
	
	'If the someone is assigned to the seat and btnAssign has not been toggled, displays student info
	
	if byId("btnAssign").innerHTML = "Assign Seats" Then 'NOT SURE IF CORRECT
		If studentID = 0 Then
			MsgBox("No student has been assigned this seat.")
		else
			ViewStudentInfo(name)
		End If
	else
		'if no student is assigned the seat and the user is assigning seats, requests the name of the student to put here
		If byId(btnClickedID).getAttribute("assigned") = 0 Then 'NOT SURE IF CORRECT
			Dim studentToAssign as String = InputBox("Enter the name of the student who will sit here.")
			Dim studentIndex as Integer = 0
			
			'for the number of students
			'for (i = 1; i < students.length; i++)
			{
				' if the student name matches the entered name
				'if (students[i].name.ToUpper() == studentToAssign.ToUpper())
				{
					studentIndex = i
				}
			}
			
			if studentIndex <> 0 Then
				'if the student is not seated
				'if (students[studentIndex].seated != "0000")
					MsgBox(studentToAssign + " is already assigned to a seat.")
				Else
					byId(btnClickedID).setAttribute("assigned", studentIndex) 'NOT SURE IF CORRECT
					MsgBox(studentToAssign + " has been assigned to the selected seat.")
					'Sets seated property to the current seat "RRCC"
					'students[studentIndex].seated = btnClickedID.substring(7, 11);
					Dim lblSeat as String = "lbl" + btnClickedID.substring(3, 8)
					byId(lblSeat).innerHTML = studentToAssign 'NOT SURE IF CORRECT
				End If
			Else
				MsgBox("This student is not on the list of students.  To add them to the list, click the 'Add Student' button.")
			End If
		End If

		'If a student is already assigned to this seat, asks if the user would like to remove the student from the seat		
		else
			
			if MsgBox("Would you like to remove " + name + " from this seat?  WARNING: Attendance data may be lost!", MsgBoxStyle.YesNo) = Windows.Forms.DialogResult.Yes Then
				byId(btnClickedID).setAttribute("assigned", 0) 'NOT SURE IF CORRECT
				'Sets seated property to a null seat
				'students[studentID].seated = "0000";
				Dim lblSeat as String = "lbl" + btnClickedID.substring(3, 8)
				byId(lblSeat).innerHTML = "Vacant Seat" 'NOT SURE IF CORRECT
				MsgBox("This seat is now available.")
			End If
		End If
	End If
 End Sub
  
  'Toggles between assigning seats and normal mode - This is all still javascript
  function AssignSeats(){ 'still in javascript
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
  
  'Handles swapping between checkmarks and X's if taking attendance - This is still all javascript
  function SeatAttndSwap(btnClickedID){ 'still in javascript
	var seatImg = "img" + btnClickedID.substring(3, 11);
    var tgt = byId(seatImg);
	if (tgt.getAttribute("src") == tgt.getAttribute("src1")){
		tgt.src = tgt.getAttribute("src2");
	}
	else if (tgt.getAttribute("src") == tgt.getAttribute("src2") && btnAttend.innerHTML == "Save Attendance"){
		tgt.src = tgt.getAttribute("src1");
	}
		
  }


'Swaps between viewing the seats and taking attendance
Sub toggleAttend(button_id) '------------------VB
   Dim btnText as Button = byId(button_id)
   Dim strRow as String
   Dim strCol as String
   Dim seatID as String
   if btnText.innerHTML = "Take Attendance" Then  'NOT SURE IF CORRECT
	'Toggles text and sets seats to checkmarks and allows them to be changed to take attendance
     btnText.innerHTML = "Save Attendance" 'NOT SURE IF CORRECT
	 byId("EditRoom").disabled = true 'NOT SURE IF CORRECT
	 byId("btnAssign").disabled = true 'NOT SURE IF CORRECT
	 for i as Integer = 1 to NUM_ROWS 
		strRow = i.toString()
		for j as Integer = 1 to NUM_COLS
			strCol = j.toString()
			If strCol < 10 Then
				seatID = "imgSeat0" + strRow + "0" + strCol				
			Else
				seatID = "imgSeat0" + strRow + strCol
			End If
			byId(seatID).src = byId(seatID).getAttribute("src1") 'NOT SURE IF CORRECT
		Next
	 Next
   Else
	'Toggles text and sets seat to Misc. icons if previously a checkmark, but leaves them as X if absent
	If MsgBox("Would you like to save the attendance as shown currently?", MsgBoxStyle.YesNo) = Windows.Forms.DialogResult.Yes Then
		btnText.innerHTML = "Take Attendance" 'NOT SURE IF CORRECT
		byId("EditRoom").disabled = false 'NOT SURE IF CORRECT
		byId("btnAssign").disabled = false 'NOT SURE IF CORRECT
		Dim curdate as Date
		for i as Integer = 1 to NUM_ROWS 
			strRow = i.toString()
			for j as Integer = 1 to NUM_COLS
				strCol = j.toString()
				If strCol < 10 Then
					seatID = "imgSeat0" + strRow + "0" + strCol			
				Else
					seatID =  "imgSeat0" + strRow + strCol
				End If
				
				'If the student is marked present [checkmarked], switches back to normal icon, if marked absent, saves the absent date
				If byId(seatID).getAttribute("src") = byId(seatID).getAttribute("src1") Then  'NOT SURE IF CORRECT
					byId(seatID).src = byId(seatID).getAttribute("src3"); 'NOT SURE IF CORRECT
				else
					If strCol < 10 Then
						seatID = "btnSeat0" + strRow + "0" + strCol			
					Else
						seatID = "btnSeat0" + strRow + strCol
					End If
					Dim studentID as Integer = byId(seatID).getAttribute("assigned") 'NOT SURE IF CORRECT
					'The current date is saved to the absences array for the student in the MM/DD/YYYY format
					'students[studentID].absences.push((curdate.getMonth() + 1).toString()  + "/" + (curdate.getDate()).toString() + "/" + (curdate.getFullYear()).toString());
				End If
			Next
		Next
	End If
  End If
End Sub
'Heather's to do list -->
'HB function either makes the room information editable or not
'TODO: check whether professor or not
'TODO: Connect changes to database entry of chart
'End Do list -->

'Handles changing the available seats based on the entered dimensions for the room layout
  Sub activeEdit()
    Dim chartName as TextBox = byId("ChartName")  'NOT SURE IF CORRECT
    Dim chartRows as TextBox = byId("RoomRows") 'NOT SURE IF CORRECT
    Dim chartColumns as TextBox = byId("RoomColumns") 'NOT SURE IF CORRECT
    Dim editBtn as Button = byId("EditRoom") 'NOT SURE IF CORRECT
	Dim rows as Integer = chartRows.value
	Dim cols as Integer = chartColumns.value
	Dim strRow as String
	Dim strCol as String
	Dim btnSeatID as String
	Dim lblSeatID as String
	
	'If the user clicks to save the changes, it checks for valid dimensions before adjusting the layout
    if editBtn.innerHTML = "Save Changes" Then 'NOT SURE IF CORRECT
		MsgBox("Information might be lost. Seats are deleted from the bottom and right; please reposition students if necessary.");
		if rows > 0 And rows < NUM_ROWS Then
			if cols > 0 And cols < NUM_COLS Then
				for i as integer = 1 to NUM_ROWS
					strRow = i.toString()
					for j as integer = 1 to NUM_COLS
						strCol = j.toString()
						If strCol < 10 Then
							btnSeatID = "btnSeat0" + strRow + "0" + strCol
							lblSeatID = "lblSeat0" + strRow + "0" + strCol		
						
						Else
							btnSeatID = "btnSeat0" + strRow + strCol
							lblSeatID = "lblSeat0" + strRow + strCol	
						End If
						
						If i <= rows And j <= cols Then
							byId(btnSeatID).style.visibility = "visible" 'NOT SURE IF CORRECT
							byId(lblSeatID).style.visibility = "visible" 'NOT SURE IF CORRECT
						
						Else
							byId(btnSeatID).style.visibility = "hidden" 'NOT SURE IF CORRECT
							byId(lblSeatID).style.visibility = "hidden" 'NOT SURE IF CORRECT
						End If
					Next
				Next
				chartName.readOnly = true 'NOT SURE IF CORRECT
				chartRows.readOnly = true 'NOT SURE IF CORRECT
				chartColumns.readOnly = true 'NOT SURE IF CORRECT
				byId("btnAttend").disabled = false 'NOT SURE IF CORRECT
				byId("btnAssign").disabled = false 'NOT SURE IF CORRECT
				editBtn.innerHTML = "Edit Room" 'NOT SURE IF CORRECT
				
			else
				MsgBox("There can only be up to 7 columns")
			End If
		else
			MsgBox("There can only be up to 5 rows")
		End If
    End If
	'Makes the textboxes editable and changes the button's text
    Else
	  byId("btnAttend").disabled = true 'NOT SURE IF CORRECT
	  byId("btnAssign").disabled = true 'NOT SURE IF CORRECT
      chartName.readOnly = false 'NOT SURE IF CORRECT
      chartRows.readOnly = false 'NOT SURE IF CORRECT
      chartColumns.readOnly = false 'NOT SURE IF CORRECT
      editBtn.innerHTML = "Save Changes" 'NOT SURE IF CORRECT
    End If
 End Sub
  

'HB function to remove a student from the class
'TODO: Check whether professor or not
'TODO: Connect changes to database entry of chart

'Handles creation of new students and their information; can be expanded further to include absences or something
 'function studentInfo(fullname, studemail, major, minor, extra, seat){
	'this.name = fullname;
	'this.email = studemail;
	'this.majors = major;
	'this.minors = minor;
	'this.extras = extra;
	'this.seated = seat;
	'this.absences = [];
  '}
  
  'Brings up an alert to view a student's information, given their name
  Sub ViewStudentInfo(name as String) '-----------VB
	Dim studentID as Integer = 0
	'for each student in the array
	'for (i = 1; i < students.length; i++)
	{
		'If the student's name is found in the array
		'if (name.ToUpper() == students[i].name.ToUpper())
		{
			studentID = i
		}
	}
	'
	'var email = students[studentID].email;	
	'var majors = students[studentID].majors;
	'var minors = students[studentID].minors;
	'var home = students[studentID].extras;
	'var absences = students[studentID].absences.length;
	
	Dim absenceList as String = "\nAbsences:    "
	
	'Shows dates absent, if any
	If absences > 0 Then
		absenceList = absenceList + absences
		for i as Integer = 1 to absences
			
			'absenceList = absenceList + "\n                    " + students[studentID].absences[i]
		Next
	Else
		absenceList = absenceList + "No days missed!"
	End If
	MsgBox("Name:         " + name + "\nEmail:          " + email + "\nMajor:         " + majors + "\nMinor:         " + minors + "\nExtracurriculars: " + home + absenceList)
  End Sub
  
  'Remove student from the studentList dropdown
  Sub removeStudent() '------------VB
    Dim studentList as Object = byId("studentList")  'NOT SURE IF CORRECT
    Dim studentToRemove as String = InputBox("Which student would you like to remove?")
    Dim found as Boolean = false
	'Looks for the requested name after confirming that the user would like to remove the student
    If MsgBox("Information will be lost. Are you sure you want to remove this student?", MsgBoxStyle.YesNo) = Windows.Forms.DialogResult.Yes Then
		for each student in studentList.Items 
		'Removes the name from the dropdown and from the students array
			if student.text.ToUpper() = studentToRemove.ToUpper() Then
				studentList.Items.RemoveAt(i)  'NOT SURE IF CORRECT
				'For each student in the array
				'for (j = 1; j < students.length; j++){
					'if (studentToRemove.ToUpper() == students[j].name.ToUpper()){
						'Sets the student's name to a blank name, thus it cannot be used; may recode later to use splice and manually change assigned value on seats, etc
						'students[j].name = "";
					}
				}
				found = true
				MsgBox(studentToRemove + " was removed")
				Exit For
			End If
		Next
  
		If found = false Then
			MsgBox("Student not found. Please try again.")
		End If
    Else
      MsgBox("No student removed.")
    End If
 End Sub
  
  'Add student to studentList dropdown; cannot add duplicate student names
  Sub addStudent()  '-------------VB
	Dim studentList as Object = byId("studentList") 'NOT SURE IF CORRECT
	Dim studentToAdd as String = InputBox("Please enter the name of the student.")
	Dim alreadyListed as Boolean = false
	
	'Checks to see if the name is already in the list
	For Each student as Option in studentList  'NOT SURE IF CORRECT
		If Option.text.ToUpper() = studentToAdd.ToUpper() Then
			alreadyListed = true
		End If
	Next
	
	'Only asks for further information if the name is unique
	if alreadyListed = false Then
		Dim studentEmail as String = InputBox("Please enter the student's email address.")
		Dim studentMajors as String = InputBox("Please enter the student's major(s).")
		Dim studentMinors as String = InputBox("Please enter the student's minor(s).")
		Dim studentExtra as String = InputBox("Please enter the student's extracurricular activities.")
		
		studentList.Items.Add(new ListItem(studentToAdd)) 
		'Adds the student to the end of the students array
		'students.push(new studentInfo(studentToAdd, studentEmail, studentMajors, studentMinors, studentExtra, false);
		MsgBox(studentToAdd + " was added to the student list.")
	
	'Shows an alert if the name was not unique
	Else
		MsgBox("This student is already on the list!");
	End If
  End Sub