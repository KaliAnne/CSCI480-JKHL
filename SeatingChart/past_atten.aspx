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

        If Not IsPostBack Then

            Dim storedID As String = CType(Session.Item("storedID"), String)
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

            cmdChartName.Parameters.AddWithValue("@chartID", storedID)

            drChartName = cmdChartName.ExecuteReader()

            drChartName.Read()

            ChartName.Text = drChartName.Item("Name")

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
        End If


    End Sub

    Protected Sub ShowAtten_Click(sender As Object, e As EventArgs) Handles ShowAtten.Click
        'If Not IsPostBack Then

        'Dim storedProfessorEmail As String = CType(Session.Item("storedProfessorEmail"), String)

        'HiddenProfessorEmail.Text = storedProfessorEmail


        '    Dim cmdChartName As SqlCommand = New SqlCommand("" _
        '& "SELECT StudentEmail, Date, Present " _
        '& "FROM   ATTENDANCE " _
        '& "WHERE  ChartID = @getChartID ", _

        'Start pulling information about the chart
        Dim cmdChartName As SqlCommand = New SqlCommand("" _
            & "SELECT StudentEmail, Date, Present " _
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
        'Finish pulling infomation about chart
    End Sub
End Class
