<%@ Page Language="VB" AutoEventWireup="true" CodeFile="past_atten.aspx.vb" Inherits="past_atten" %>

<!-- Iteration 3 code for seating chart application. -->
<!-- Revised by JHKL 4/28/2015 -->
<!-- The purpose of this code is to display the UI elements for the view past functionality. -->
<!-- Input: From standard input:: Button clicking, form evaluation: From database:: attendance data-->

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- Start header -->
<head runat="server" align="center">
    <meta charset="UTF-8" />
    <title>Seating Chart Application</title>
    <link rel="shortcut icon" type="image/png" href="images/favicon/apple.png" />
    <link rel="stylesheet" href="css/seatingChartnew.css" />
    <script src="js/indexjs.js"> </script>
</head>
<!-- End header, import data mostly -->

<!-- Start menu -->
<body onload="OnLoad()" onbeforeunload="return OnClose()">
    <header>
        <nav id="nav">
            <ul>
                <li><a href="home.aspx">Home</a></li>
            </ul>
        </nav>

        <br />
        <br />

    </header>
    <!-- End menu at top of page -->


    <div align="center">
        <!-- Start div -->
        <form runat="server">
            <!--Form Start-->
            <section align="center" class="left">
                <!--Start left nav bar -->
                <fieldset id="menuopt">
                    <!-- Creates menu options-->
                    <fieldset id="chartinfo">
                        <legend><span>Chart Name</span></legend>
                        <p>
                            <!-- Display Chart name, derived from chartID from previous page-->
                            <asp:TextBox runat="server" ID="ChartName" ReadOnly="true" />
                        </p>
                        <legend><span>
                            <p>
                                <!-- Display students associated with this chart-->
                                Please select a student:<fieldset id="studentinfo">
                                    <asp:DropDownList runat="server" ID="studentList" AppendDataBoundItems="true" onchange="HighlightName(); return false;">
                                        <asp:ListItem Text="(None)" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </fieldset>
                                <p>
                                    <!-- Display attendance info for the selected student-->
                                    <asp:Button runat="server" ID="ShowAtten" Text="Show Attendance" Class="attenBtn" OnClick="ShowAtten_Click" />
                                </p>
                                <p>
                                    <!--Home button-->
                                    <button type="Button" class="attenBtn" onclick="location.href='home.aspx'">Home</button>
                                </p>
                        </span></legend>
                    </fieldset>
                    <br />

                    &nbsp;<br />
                    <!-- Hide Chart id, passed from previous page, not to be edited or visible-->
                    <asp:TextBox runat="server" ID="HiddenChartID" Visible="false"></asp:TextBox>

                    &nbsp;<br />

                    &nbsp;<br />

                    &nbsp;<br />
                    <br />

                </fieldset>
                <!--End menuopt-->

            </section>
            <!--End left nav bar-->


            <section align="center" class="gridviewfullBox">
                <!-- Start div -->
                <asp:GridView runat="server" ID="AttendanceInfo" AutoGenerateColumns="False" GridLines="None" Height="93px" Width="240px">
                    
                    <Columns>
                        <asp:BoundField DataField="StudentEmail" HeaderText="Student Email" SortExpression="StudentEmail" ReadOnly="true" />
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" ReadOnly="true" />
                        <asp:BoundField DataField="Present" HeaderText="Present" SortExpression="Present" ReadOnly="true"></asp:BoundField>
                    </Columns>
                </asp:GridView>
            </section>
        </form>
    </div>
</body>

</html>
