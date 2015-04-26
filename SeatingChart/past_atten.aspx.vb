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

Partial Class past_atten
    Inherits System.Web.UI.Page

    Sub Page_Load()

        'If Not IsPostBack Then

        Dim storedID As String = CType(Session.Item("storedID"), String)


        'Start pulling information about the chart
        Dim cnChartName As New SqlConnection

        cnChartName.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        cnChartName.Open()

        Dim cmdChartName As New SqlCommand

        cmdChartName.CommandText = "SELECT Name, Rows, Columns " _
            & "FROM   CHART " _
            & "WHERE  ChartID = @chartID"

        cmdChartName.Connection = cnChartName

        Dim drChartName As SqlDataReader

        cmdChartName.Parameters.AddWithValue("@chartID", storedID)

        drChartName = cmdChartName.ExecuteReader()

        drChartName.Read()

        ChartName.Text = drChartName.Item("Name")
        'RoomRows.Text = drChartName.Item("Rows")
        'RoomColumns.Text = drChartName.Item("Columns")

        drChartName.Close()

        cnChartName.Close()
        'Finish pulling infomation about chart



        'ChartName.Text = storedID

        'Start pulling information about the students
        Dim cmdStudents As SqlCommand = New SqlCommand("" _
            & "SELECT Name " _
            & "FROM   STUDENT " _
            & "WHERE  ChartID = @chartID", _
            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"))

        cmdStudents.Parameters.AddWithValue("@chartID", storedID)

        cmdStudents.Connection.Open()

        studentList.DataSource = cmdStudents.ExecuteReader()
        studentList.DataTextField = "Name"
        studentList.DataValueField = "Name"

        studentList.DataBind()

        cmdStudents.Connection.Close()
        cmdStudents.Connection.Dispose()
        'Finish pulling information about the students

        '        'Start pulling information about the chart
        '        Dim cmdChartName As SqlCommand = New SqlCommand("" _
        '            & "SELECT ChartID, Name " _
        '            & "FROM   CHART " _
        '            & "WHERE  ProfessorEmail = @getProfessorEmail", _
        '            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
        '                & "User ID=480-JKHL;Password=1104ncory"))

        '        cmdChartName.Parameters.AddWithValue("@getProfessorEmail", HiddenProfessorEmail.Text)

        '        cmdChartName.Connection.Open()

        '        ChartNameGridView.DataSource = cmdChartName.ExecuteReader()
        '        ChartNameGridView.DataBind()

        '        cmdChartName.Connection.Close()
        '        cmdChartName.Connection.Dispose()
        '        'Finish pulling infomation about chart

        '    End If

    End Sub

    ''Sends the person to the index page 
    'Protected Sub ChartNameGridView_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ChartNameGridView.SelectedIndexChanged

    '    Dim index As Integer = ChartNameGridView.SelectedIndex
    '    Dim storedID As String = ChartNameGridView.DataKeys(index).Value.ToString

    '    Session("storedID") = storedID

    '    Response.Redirect("index.aspx")

    'End Sub

    'Protected Sub ChartNameGridView_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)

    '    Dim storedID As String = ChartNameGridView.DataKeys(e.RowIndex).Value.ToString

    '    'Start deleting the chart
    '    Dim cmdDeleteChart As SqlCommand = New SqlCommand("" _
    '        & "DELETE " _
    '        & "FROM   CHART " _
    '        & "WHERE  ChartID = @getChartID", _
    '        New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
    '            & "User ID=480-JKHL;Password=1104ncory"))

    '    cmdDeleteChart.Parameters.AddWithValue("@getChartID", storedID)

    '    cmdDeleteChart.Connection.Open()

    '    cmdDeleteChart.ExecuteNonQuery()

    '    cmdDeleteChart.Connection.Close()
    '    cmdDeleteChart.Connection.Dispose()
    '    'Finish deleting the chart


    '    'Reloads the page once it has finished deleting the chart row
    '    Session("storedProfessorEmail") = HiddenProfessorEmail.Text

    '    Response.Redirect("viewExisting.aspx")

    'End Sub

End Class
