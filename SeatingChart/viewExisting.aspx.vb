Option Explicit On
Imports System.Data
Imports System.Data.SqlClient
Imports System
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls

Partial Class viewExisting
    Inherits System.Web.UI.Page

    Sub Page_Load()

        If Not IsPostBack Then

            Dim storedProfessorEmail As String = CType(Session.Item("storedProfessorEmail"), String)

            HiddenProfessorEmail.Text = storedProfessorEmail

            'Start pulling information about the chart
            Dim cmdChartName As SqlCommand = New SqlCommand("" _
                & "SELECT ChartID, Name " _
                & "FROM   CHART " _
                & "WHERE  ProfessorEmail = @getProfessorEmail", _
                New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"))

            cmdChartName.Parameters.AddWithValue("@getProfessorEmail", HiddenProfessorEmail.Text)

            cmdChartName.Connection.Open()

            ChartNameGridView.DataSource = cmdChartName.ExecuteReader()
            ChartNameGridView.DataBind()

            cmdChartName.Connection.Close()
            cmdChartName.Connection.Dispose()
            'Finish pulling infomation about chart

        End If

    End Sub

    'Sends the person to the index page 
    Protected Sub ChartNameGridView_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ChartNameGridView.SelectedIndexChanged

            Dim index As Integer = ChartNameGridView.SelectedIndex
            Dim storedID As String = ChartNameGridView.DataKeys(index).Value.ToString

            Session("storedID") = storedID

            Response.Redirect("index.aspx")

    End Sub

    Protected Sub ChartNameGridView_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)

        Dim storedID As String = ChartNameGridView.DataKeys(e.RowIndex).Value.ToString

        'Start deleting the chart
        Dim cmdDeleteChart As SqlCommand = New SqlCommand("" _
            & "DELETE " _
            & "FROM   CHART " _
            & "WHERE  ChartID = @getChartID", _
            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"))

        cmdDeleteChart.Parameters.AddWithValue("@getChartID", storedID)

        cmdDeleteChart.Connection.Open()

        cmdDeleteChart.ExecuteNonQuery()

        cmdDeleteChart.Connection.Close()
        cmdDeleteChart.Connection.Dispose()
        'Finish deleting the chart


        'Reloads the page once it has finished deleting the chart row
        Session("storedProfessorEmail") = HiddenProfessorEmail.Text

        Response.Redirect("viewExisting.aspx")

    End Sub

End Class
