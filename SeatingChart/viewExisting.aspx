<%@ Page Language="VB" AutoEventWireup="true" CodeFile="viewExisting.aspx.vb" Inherits="viewExisting" EnableEventValidation="true" %>

<!-- Iteration 3 code for seating chart application. -->
<!-- Created and revised by JHKL 3/31/2015, revised 4/29/2015 -->
<!-- The purpose of this program is to have the availability for a client to store multiple charts on a website, and be able to pull data from them for in-class use. -->
<!-- Input: From standard input:: Button clicking, typing, form evaluation: From database:: seating chart data-->

<!DOCTYPE html>
<html>
<!-- Start header -->
<head align="center">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width" />
    <title>Seating Chart Application</title>
    <link rel="shortcut icon" type="image/png" href="images/favicon/apple.png" />
    <link rel="stylesheet" href="css/seatingChartnew.css" />
</head>
<!-- End header -->
<!-- Start the menu at top of the page, home is the only option -->
<header>
    <nav id="nav">
        <ul>
            <li><a href="home.aspx">Home</a></li>
        </ul>
    </nav>

    <br />
    <br />

</header>

<body>

    <section align="center" class="left">
        <!--Start left nav bar -->
        <form runat="server">
            <!--Form Start-->
            <fieldset id="menu">
                <legend><span>Menu</span></legend>
                <section align="center" class="gridviewBox">
                    <!-- Delete button will delete the chart from the database, view button will take the user to that chart -->
                    <!-- Grid view populates with all of the user's charts -->
                    <asp:GridView runat="server" ID="ChartNameGridView" AutoGenerateColumns="False" DataKeyNames="ChartID" GridLines="None" Height="93px" Width="240px" OnRowDeleting="ChartNameGridView_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="ChartID" HeaderText="ChartID" SortExpression="ChartID" Visible="false" />
                            <asp:BoundField DataField="Name" SortExpression="Name" />
                            <asp:CommandField SelectText="View" ButtonType="Button" ShowSelectButton="True" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button runat="server" Text="Delete" CommandName="Delete" CommandArgument="ChartID" OnClientClick="return confirm('Are you sure you want to delete this chart?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </section>
            </fieldset>
            <!--End menu-->
            <asp:TextBox runat="server" ID="HiddenProfessorEmail" Visible="false"></asp:TextBox>
        </form>
        <!-- End Form -->
    </section>
    <!--End left nav bar-->


</body>
</html>
