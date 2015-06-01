'This page populates the past_atten page and contains the click event for the Show
' Attendance button to display the student attendance information

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
Imports System.Globalization

Partial Class past_atten
    Inherits System.Web.UI.Page

    Sub Page_Load()

        If Not IsPostBack Then

            'Pulls the chart ID passed from the index page
            Dim storedID As String = CType(Session.Item("storedID"), String)
            HiddenChartID.Text = storedID

            'Start pulling the name of the chart from the ChartID from the previous page
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
            drChartName.Close()
            cnChartName.Close()
            'Finish pulling infomation about chart

            'Start pulling information about the students and populate drop down with their names
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
        End If


    End Sub

    Protected Sub ShowAttend() Handles ShowAtten.Click
        'Query using the student email and chart id
        'to database to show the selected student's attendance in the grid view
        Dim cmdChartName As SqlCommand = New SqlCommand("" _
            & "SELECT StudentEmail, Date, Present, Comments " _
            & "FROM   ATTENDANCE " _
            & "WHERE  ChartID = @getChartID " _
            & "AND    StudentEmail = (SELECT StudentEmail" _
            & "                         FROM STUDENT" _
            & "                          WHERE Name = @getStudentName" _
            & "                          AND ChartID = @getChartID)", _
            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                  & "User ID=480-JKHL;Password=1104ncory"))

        cmdChartName.Parameters.AddWithValue("@getChartID", HiddenChartID.Text)
        cmdChartName.Parameters.AddWithValue("@getStudentName", studentList.SelectedValue)

        cmdChartName.Connection.Open()

        AttendanceInfo.DataSource = cmdChartName.ExecuteReader()
        AttendanceInfo.DataBind()

        cmdChartName.Connection.Close()
        cmdChartName.Connection.Dispose()
        'Finish populating grid view with the information from the database

    End Sub

    Protected Sub AttendanceInfo_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles AttendanceInfo.RowEditing
        AttendanceInfo.EditIndex = e.NewEditIndex
        ShowAttend()
    End Sub

    Protected Sub OnUpdate(sender As Object, e As EventArgs)
        Dim row As GridViewRow = TryCast(TryCast(sender, LinkButton).NamingContainer, GridViewRow)
        Dim attendComment As String = TryCast(row.Cells(3).Controls(0), TextBox).Text

        If attendComment = "" Then
            attendComment = "None"
        End If

        'Update attendance comment
        Dim cnUpdateStudent As New SqlConnection

        cnUpdateStudent.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        Dim cmdUpdateStudent As New SqlCommand

        cmdUpdateStudent.CommandText = "" _
            & "UPDATE ATTENDANCE " _
            & "SET    Comments = @getComment " _
            & "WHERE  ChartID = @getChartID " _
            & "AND    StudentEmail = @getEmail " _
            & "AND    Present = @getPresent " _
            & "AND    Date = @getDate"

        cmdUpdateStudent.Connection = cnUpdateStudent
        cmdUpdateStudent.Parameters.AddWithValue("@getPresent", row.Cells(2).Text)
        cmdUpdateStudent.Parameters.AddWithValue("@getChartID", HiddenChartID.Text)
        cmdUpdateStudent.Parameters.AddWithValue("@getEmail", row.Cells(0).Text)
        cmdUpdateStudent.Parameters.AddWithValue("@getDate", row.Cells(1).Text)
        cmdUpdateStudent.Parameters.AddWithValue("@getComment", attendComment)

        cnUpdateStudent.Open()

        cmdUpdateStudent.ExecuteNonQuery()

        cnUpdateStudent.Close()
        'End updating the student's attendance

        AttendanceInfo.EditIndex = -1
        ShowAttend()
    End Sub

    Protected Sub OnCancel(sender As Object, e As EventArgs)
        AttendanceInfo.EditIndex = -1
        ShowAttend()
    End Sub

End Class