<%@ Page Language="VB" AutoEventWireup="false" CodeFile="home.aspx.vb" Inherits="home" %>

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

    <header>
  <nav id="nav">
						<ul>
			    <li class="current"><a href="home.aspx">Home</a></li>
				<li><a href="index.aspx">Seating Chart Information</a></li>
				<li ><a href="viewExisting.aspx">View Existing</a></li>
				<li><a href="">Placeholder</a></li>
				<li><a href="">Placeholder</a></li>
				<li><a href="">Placeholder</a></li>
						</ul>
					</nav>
					<br>
					<br>
</header>

  <body align="center">

            <button id='btnCreateChart'onClick="location.href='index.aspx'">Create New Chart</button>
            <button id='btnViewCharts'onClick="location.href='viewExisting.aspx'">View Existing Chart</button>
            <button id='btnSwitchMode' disabled="true">Switch Modes</button>

  </body>
</html>
