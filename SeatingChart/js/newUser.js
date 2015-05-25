/*
Code for seating chart application.
Created and revised by JHKL 5/24/2015
 */

function OnLoad() {
    byId("lblWarning").style.visibility = "hidden";
    OnFocusChange("lblEmail");
}

function byId(e) { return document.getElementById(e); }
window.addEventListener("load", mInit, false);
function byId(e) { return document.getElementById(e); }

function IfFieldsMatch() {
    byId("lblWarning").style.visibility = "visible";
    var pass = byId("txtPass").value;
    var confpass = byId("txtConfPass").value;
    var email = byId("txtEmail").value.toLowerCase();
    var confemail = byId("txtConfEmail").value.toLowerCase();
    if (pass == "" || email == "") {
        byId("lblWarning").innerHTML = "Please enter an e-mail address and a password.";
        return false;
    }
    else{
        if (email != confemail) {
            byId("lblWarning").innerHTML = "The E-mail and Confirm E-mail fields do not match.";
            return false;
        }
        else {
            if (pass != confpass) {
                byId("lblWarning").innerHTML = "The Password and Confirm Password fields do not match.";
                return false;
            }
            else {
                if (pass.length < 6) {
                    byId("lblWarning").innerHTML = "Your password must be at least 6 characters.";
                    return false;
                }
                else {
                    if (email.indexOf("@findlay.edu") == -1) {
                        byId("lblWarning").innerHTML = "You must use a findlay.edu email account.";
                        return false;
                    }
                    else return true;
                }
            }
        }
    }
}

function PassesMatch() {
    var pass = byId("txtPass").value;
    var confpass = byId("txtConfPass").value;
    if (pass != confpass) {
        byId("lblConfPass").innerHTML = "This does not match the Password field.";
    }
    else {
        byId("lblConfPass").innerHTML = "Passwords match!";
    }
    return false;
}

function EmailsMatch() {
    var email = byId("txtEmail").value;
    var confemail = byId("txtConfEmail").value;
    if (email != confemail) {
        byId("lblConfEmail").innerHTML = "This does not match the Email field.";
    }
    else {
        byId("lblConfEmail").innerHTML = "Emails match!";
    }
    return false;
}

function OnFocusChange(currentFocus) {
    byId("lblEmail").style.visibility = "hidden";
    byId("lblConfEmail").style.visibility = "hidden";
    byId("lblPass").style.visibility = "hidden";
    byId("lblConfPass").style.visibility = "hidden";
    byId(currentFocus).style.visibility = "visible";
}