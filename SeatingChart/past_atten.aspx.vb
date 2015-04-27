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

    End Sub

    Protected Sub testGrid_RowEditing(ByVal sender As Object, ByVal e As GridViewEditEventArgs)

        AttendanceInfo.EditIndex = e.NewEditIndex
        AttendanceInfo.DataBind()
        ShowAtten_Click(sender, e)

    End Sub

    Protected Sub testGrid_RowCancelingEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)

        AttendanceInfo.EditIndex = -1
        AttendanceInfo.DataBind()
        ShowAtten_Click(sender, e)

    End Sub



    Protected Sub testGrid_RowUpdating(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)

        Dim con As New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                  & "User ID=480-JKHL;Password=1104ncory")
        Dim cmd As SqlCommand
        Dim sqlUpdate As String
        Dim index As Integer = 0

        sqlUpdate = "" _
            & "UPDATE ATTENDANCE " _
            & "SET Present = @present " _
            & "WHERE StudentEmail = @studentEmail " _
            & "AND Date = @dateAtten;"


        'Dim studentEmail As String = AttendanceInfo.Rows(e.RowIndex).Cells(0).Text
        'Dim dateAtten As String = AttendanceInfo.Rows(e.RowIndex).Cells(1).Text
        Dim present As String = AttendanceInfo.Rows(e.RowIndex).Cells(2).Text

        cmd = New SqlCommand(sqlUpdate, con)

        'cmd.Parameters.AddWithValue("@studentEmail", SqlDbType.VarChar, 50).Value = studentEmail
        'cmd.Parameters.Add("@dateAtten", SqlDbType.DateTime).Value = dateAtten
        cmd.Parameters.AddWithValue("@studentEmail", AttendanceInfo.Rows(e.RowIndex).Cells(0).Text)
        cmd.Parameters.AddWithValue("@dateAtten", AttendanceInfo.Rows(e.RowIndex).Cells(1).Text)
        cmd.Parameters.Add("@present", SqlDbType.VarChar, 10).Value = present

        con.Open()

        cmd.ExecuteNonQuery()

        AttendanceInfo.DataSource = cmd.ExecuteReader()

        AttendanceInfo.EditIndex = -1

        AttendanceInfo.DataBind()

        con.Close()
        ShowAtten_Click(sender, e)

    End Sub

End Class