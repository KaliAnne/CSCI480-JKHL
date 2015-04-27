<%@ Page Language="VB" AutoEventWireup="true" CodeFile="past_atten.aspx.vb" Inherits="past_atten" %>
 
<!-- Iteration 1 code for seating chart application. -->
<!-- Created and revised by JHKL 3/31/2015 -->
<!-- The purpose of this program is to have the availability for a client to store multiple charts on a website, and be able to pull data from them for in-class use. -->
<!-- Input: From standard input:: Button clicking, typing, form evaluation: From database:: seating chart data-->
 
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
 
 
 
    <div align="center">
 
        <form runat="server">
            <!--Form Start-->
            <section align="center" class="left">
                <!--Start left nav bar -->
 
                <fieldset id="menuopt">
                    <!-- Creates menu options, to change the option to scroll, please see CSS -->
                    <fieldset id="chartinfo">
                        <legend><span>Chart Name</span></legend>
                        <p>
                            <asp:TextBox runat="server" ID="ChartName" ReadOnly="true" />
                        </p>
                        <legend><span>
                            <p>
                                Please select a student:<fieldset id="studentinfo">
                                    <asp:DropDownList runat="server" ID="studentList" AppendDataBoundItems="true" onchange="HighlightName(); return false;">
                                        <asp:ListItem Text="(None)" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </fieldset>
                                <p>
                                    <asp:Button runat="server" ID="ShowAtten" Text="Show Attendance" Class="attenBtn" OnClick="ShowAtten_Click" />
                                </p>
                                <p>
                                    <button type="Button" class="attenBtn" onclick="location.href='home.aspx'">Home</button>
                                </p>
                        </span></legend>
                    </fieldset>
                    <br />
 
                    &nbsp;<br />
 
                    <asp:TextBox runat="server" ID="HiddenChartID" Visible="false"></asp:TextBox>
 
                    &nbsp;<br />
 
                    &nbsp;<br />
 
                    &nbsp;<br />
                    <br />
 
                    <!--Hidden fields to store the IDs that are not needed to be seen by the user-->
 
                </fieldset>
                <!--End menuopt-->
 
            </section>
            <!--End left nav bar-->
            <section align="center" class="gridviewfullBox">
                <asp:GridView runat="server" ID="AttendanceInfo" AutoGenerateColumns="False" GridLines="None" Height="93px" Width="240px"
                    OnRowEditing="testGrid_RowEditing" OnRowCancelingEdit="testGrid_RowCancelingEdit" OnRowUpdating="testGrid_RowUpdating">
                    <Columns>
 
                        <asp:BoundField DataField="StudentEmail" HeaderText="Student Email" SortExpression="StudentEmail" />
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
 
 
                         <asp:TemplateField HeaderText="Present">
                            <EditItemTemplate>
                                <asp:TextBox ID="PresentText" runat="server" Text='<%# Bind("Present")%>'> </asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="PresentLabel" runat="server" Text='<%# Bind("Present")%>'> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
 
 
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit"
                                    OnClientClick="return confirm('Are you sure you want to update this?')"></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update"
                                    CommandName="Update" CommandArgument='<%# Container.DataItemIndex %>'
                                    OnClientClick="return confirm('Are you sure you want to update this?');">
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel"
                                    CommandName="Cancel" CommandArgument='<%# Container.DataItemIndex %>'>
                                </asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
 
 
 
 
 
<%--                        <asp:BoundField DataField="Present" SortExpression="Present" HeaderText="Present" />
                        <asp:TemplateField>
                            <ItemTemplate>
 
                                <asp:Button runat="server" Text="Edit" CommandName="Edit" CommandArgument="StudentEmail" />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
            </section>
        </form>
    </div>
</body>
 
</html>