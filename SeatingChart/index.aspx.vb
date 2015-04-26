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

Partial Class index
    Inherits System.Web.UI.Page

    'Loads all of the chart information based on the Chart selected
    Sub Page_Load()
        If Page.IsPostBack = False Then
            Dim storedID As String = CType(Session.Item("storedID"), String)

            Dim getChartId As String = storedID
            HiddenChartID.Text = storedID

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

            cmdChartName.Parameters.AddWithValue("@chartID", getChartId)

            drChartName = cmdChartName.ExecuteReader()

            drChartName.Read()

            ChartName.Text = drChartName.Item("Name")
            RoomRows.Text = drChartName.Item("Rows")
            RoomColumns.Text = drChartName.Item("Columns")

            drChartName.Close()

            cnChartName.Close()
            'Finish pulling infomation about chart

            'Start pulling information about the students
            Dim cmdStudents As SqlCommand = New SqlCommand("" _
                & "SELECT Name " _
                & "FROM   STUDENT " _
                & "WHERE  ChartID = @chartID", _
                New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"))

            cmdStudents.Parameters.AddWithValue("@chartID", getChartId)

            cmdStudents.Connection.Open()

            studentList.DataSource = cmdStudents.ExecuteReader()
            studentList.DataTextField = "Name"
            studentList.DataValueField = "Name"

            studentList.DataBind()

            cmdStudents.Connection.Close()
            cmdStudents.Connection.Dispose()
            'Finish pulling information about the students
        End If

    End Sub

    'Saves the new fields to the database
    Protected Sub SaveChart_Click(sender As Object, e As EventArgs) Handles SaveChart.Click

        Dim cnUpdateChart As New SqlConnection

        cnUpdateChart.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        Dim cmdUpdateChart As New SqlCommand

        cmdUpdateChart.CommandText = "" _
            & "UPDATE CHART " _
            & "SET    Name = @getName, Rows = @getRows, Columns = @getColumns " _
            & "WHERE  ChartID = @getChartID"

        cmdUpdateChart.Connection = cnUpdateChart

        cmdUpdateChart.Parameters.AddWithValue("@getName", ChartName.Text)
        cmdUpdateChart.Parameters.AddWithValue("@getRows", RoomRows.Text)
        cmdUpdateChart.Parameters.AddWithValue("@getColumns", RoomColumns.Text)
        cmdUpdateChart.Parameters.AddWithValue("@getChartID", HiddenChartID.Text)

        cnUpdateChart.Open()

        cmdUpdateChart.ExecuteNonQuery()

        cnUpdateChart.Close()

    End Sub

    'Sets the Chart fields to false so that the changed items will be changed in the database
    Protected Sub EditRoom_Click(sender As Object, e As EventArgs)

        ChartName.ReadOnly = False
        RoomRows.ReadOnly = False
        RoomColumns.ReadOnly = False

    End Sub

    'Adds a new student to the class
    Protected Sub btnAddStudent_Click(sender As Object, e As EventArgs)

        Session("storedID") = HiddenChartID.Text

        Response.Redirect("studentInfo.aspx")

    End Sub

    'Delete the chart and send the user back to View Existing
    Protected Sub btnDelChart_Click(sender As Object, e As EventArgs)

        'Start pulling email for the chart
        Dim cnProfessorEmail As New SqlConnection

        cnProfessorEmail.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        cnProfessorEmail.Open()

        Dim cmdProfessorEmail As New SqlCommand

        cmdProfessorEmail.CommandText = "SELECT ProfessorEmail " _
            & "FROM   CHART " _
            & "WHERE  ChartID = @chartID"

        cmdProfessorEmail.Connection = cnProfessorEmail

        Dim drProfessorEmail As SqlDataReader

        cmdProfessorEmail.Parameters.AddWithValue("@chartID", HiddenChartID.Text)

        drProfessorEmail = cmdProfessorEmail.ExecuteReader()

        drProfessorEmail.Read()

        HiddenProfessorEmail.Text = drProfessorEmail.Item("ProfessorEmail")

        drProfessorEmail.Close()

        cnProfessorEmail.Close()
        'Finish pulling email for the chart

        'Start deleting the chart
        Dim cmdDeleteChart As SqlCommand = New SqlCommand("" _
            & "DELETE " _
            & "FROM   CHART " _
            & "WHERE  ChartID = @getChartID", _
            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"))

        cmdDeleteChart.Parameters.AddWithValue("@getChartID", HiddenChartID.Text)

        cmdDeleteChart.Connection.Open()

        cmdDeleteChart.ExecuteNonQuery()

        cmdDeleteChart.Connection.Close()
        cmdDeleteChart.Connection.Dispose()
        'Finish deleting the chart

        'Sends the user back to view Existing to see their charts
        Session("storedProfessorEmail") = HiddenProfessorEmail.Text

        Response.Redirect("viewExisting.aspx")

    End Sub

    Protected Sub btnRemoveStudent_Click(sender As Object, e As EventArgs)

        Dim deleteStudent As String = studentList.SelectedItem.Value

        If (deleteStudent = String.Empty) Then

            'Make this javascript later
            ClientScript.RegisterStartupScript(GetType(Page), "", "alert('Please select the student you wish to remove.');", True)
            'Response.Write("<script>alert('Please select the student you wish to remove.');</script>")

        Else

            'Start deleting the student
            Dim cmdDeleteStudent As SqlCommand = New SqlCommand("" _
            & "DELETE " _
             & "FROM   STUDENT " _
            & "WHERE  ChartID = @getChartID " _
            & "AND    Name = @getStudentName", _
            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
             & "User ID=480-JKHL;Password=1104ncory"))

            cmdDeleteStudent.Parameters.AddWithValue("@getStudentName", deleteStudent)
            cmdDeleteStudent.Parameters.AddWithValue("@getchartID", HiddenChartID.Text)

            cmdDeleteStudent.Connection.Open()

            cmdDeleteStudent.ExecuteNonQuery()

            cmdDeleteStudent.Connection.Close()
            cmdDeleteStudent.Connection.Dispose()
            'Finish deleting the student

            'Reload the page with the new information
            Session("storedID") = HiddenChartID.Text

            Response.Redirect("index.aspx")

        End If

    End Sub

End Class