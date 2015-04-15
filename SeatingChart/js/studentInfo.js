/*
Iteration 3 code for seating chart application.
Created and revised by JHKL 4/15/2015
 */

function OnLoad() {
    var studname = localStorage.getItem("AddStudName");
    document.getElementById("stuName").value = studname;
    document.getElementById("stuName").disabled = true;
}