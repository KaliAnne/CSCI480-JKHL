<%@ Page Language="VB" AutoEventWireup="false" CodeFile="studentInfo.aspx.vb" Inherits="studentInfo" %>

<!-- Iteration 1 code for seating chart application. -->
<!-- Created and revised by JHKL 3/31/2015 -->
<!-- The purpose of this program is to have the availability for a client to store multiple charts on a website, and be able to pull data from them for in-class use. -->
<!-- Input: From standard input:: Button clicking, typing, form evaluation: From database:: seating chart data-->

<!DOCTYPE html>
<html>
  <!-- Start header -->
  <head align="center">
    <meta charset="UTF-8" />
	<title>Seating Chart Application</title>
	<link rel="shortcut icon" type="image/png" href="images/favicon/apple.png"/>
    <link rel="stylesheet"  href="css/seatingChartnew.css" />
  </head>
  <!-- End header -->
    <header>
  <nav id="nav">
						<ul>
							<li class="current"><a href="home.html">Home</a></li>
							<li><a href="">Dropdown</a></li>
							<li><a href="">Left Sidebar</a></li>
							<li><a href="">Right Sidebar</a></li>
							<li><a href="">Two Sidebar</a></li>
							<li><a href="">No Sidebar</a></li>
						</ul>
					</nav>
					<br>
					<br>
</header>
  <body>
    <section align="center" class="left"> 
	<!--Start left nav bar -->
	  <form> 
	  <!--Form Start-->	  
	  <fieldset id="menu">
			<legend><span>Menu</span></legend>
				<fieldset id="past1">
					<legend id="legend01"><span><input  id="existingstudent1" readonly="true" placeholder="(Student Name)" value=""></input></span></legend>
						
						Name: <br>
						<input  id="stufullname" readonly="true" placeholder="(This is placeholder text)" value=""></input>
						<br>
						Email: <br>
						<input  id="stuemail" readonly="true" placeholder="(This is placeholder text)" value=""></input> :
						<br>
						Major: <br>
						<input  id="stumajor" readonly="true" placeholder="(This is placeholder text)" value=""></input> :
						<br>
						Minor: <br>
						<input  id="stuminor" readonly="true" placeholder="(This is placeholder text)" value=""></input> :
						<br>
						Extracurriculars:<br>
						<input  id="stuextra" readonly="true" placeholder="(This is placeholder text)" value=""></input> :
						<br>
						Absences:<br>
						<input  id="stuabse" readonly="true" placeholder="(This is placeholder text)" value=""></input> :
						<br>
						Dates missed:<br>
						<input  id="studate" readonly="true" placeholder="(This is placeholder text)" value=""></input> :
						<br>

				</fieldset>
				
		 
	   </fieldset> <!--End menu-->
	  </form> <!-- End Form -->
	</section> <!--End left nav bar-->
   
  <section align="center">
	</section>
  </body>
</html>
