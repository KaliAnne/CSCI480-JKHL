//Script for the buttons to work correctly
function byId(e){return document.getElementById(e);}
window.addEventListener('load', mInit, false);
function byId(e){return document.getElementById(e);}
function SeatAttndSwap(btnClickedID)
{
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
    if (tgt.getAttribute("src")== tgt.getAttribute("src1")){
        tgt.src = tgt.getAttribute("src2");
    }
    else if (tgt.getAttribute("src") == tgt.getAttribute("src2")  && btnAttend.innerHTML == "Save Attendance"){
        tgt.src = tgt.getAttribute("src1")
    }
		
}
//<!-- End Script Button -->
function toggleAttend(button_id) 
{
    var btnText = byId(button_id);
    var strRow = "1";
    var strCol = "1";
    var zero = "0";
    var seat = "imgSeat";
    var seatID = "imgSeat0101"
    var tmp = "";
    if (btnText.innerHTML == "Take Attendance") 
    {
        //<!-- Toggles text and sets seats to checkmarks and allows them to be changed to take attendance -->
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
        //<!-- Toggles text and sets seat to Misc. icons if previously a checkmark, but leaves them as X if absent -->
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
//<!-- Heather's to do list -->
//HB function either makes the room information editable or not
//TODO: check whether professor or not
//TODO: confirmation that info will be lost
//TODO: change # of "buttons" or seats based on saved changes
//TODO: Connect changes to database entry of chart
//<!-- End Do list -->
  function activeEdit()
  {
      var chartName  = byId('ChartName');
      var chartRows = byId('RoomRows');
      var chartColumns = byId('RoomColumns');
      var editBtn    = byId('EditRoom');

      if (editBtn.innerHTML == "Save Changes") {
          chartName.readOnly = true;
          chartRows.readOnly = true;
          chartColumns.readOnly = true;
          editBtn.innerHTML = "Edit Room";
      }
      else {
          chartName.readOnly = false;
          chartRows.readOnly = false;
          chartColumns.readOnly = false;
          editBtn.innerHTML = "Save Changes";
      }
  }
//<!-- Heather's to do list -->
//HB function to remove a student from the class
//TODO: Confirmation data will be lost
//TODO: Check whether professor or not
//TODO: Connect changes to database entry of chart
//<!-- End Do list -->
  function removeStudent() {
      var studentList = byId('studentList');
      var studentToRemove = prompt("Which student would you like to remove?");
      var found = "false";
  
      for (i=0; i<studentList.length; i++){
          if(studentList.options[i].text == studentToRemove){
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
  //<!-- End script -->