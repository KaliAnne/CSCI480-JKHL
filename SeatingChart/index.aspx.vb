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

    Sub Page_Load()
        If Page.IsPostBack = False Then
            Dim storedID As String = CType(Session.Item("storedID"), String)

            'Dim getChartId As String = Session("sendID")
            Dim getChartId As String = storedID

            'Start pulling information about the chart
            Dim cmdChartName As SqlCommand = New SqlCommand("" _
                & "SELECT Name, Rows, Columns " _
                & "FROM   CHART " _
                & "WHERE  ChartID = @chartID", _
                New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"))

            cmdChartName.Parameters.AddWithValue("@chartID", getChartId)

            cmdChartName.Connection.Open()

            ChartInfoGridView.DataSource = cmdChartName.ExecuteReader()
            ChartInfoGridView.DataBind()

            cmdChartName.Connection.Close()
            cmdChartName.Connection.Dispose()
            'Finish pulling infomation about chart

            'Sets the pulled information into the correct locations
            ChartName.Text = ChartInfoGridView.Rows(0).Cells(0).Text
            RoomRows.Text = ChartInfoGridView.Rows(0).Cells(1).Text
            RoomColumns.Text = ChartInfoGridView.Rows(0).Cells(2).Text

            'Start pulling information about the students
            Dim cmdStudents As SqlCommand = New SqlCommand("" _
                & "SELECT (FirstName + ' ' + LastName) AS Name " _
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

    Protected Sub btnAddStudent_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddStudent.Click
        Dim studentToAdd As String = InputBox("Please enter the name of the student.")
        Dim alreadyListed As Boolean = False

        'Checks to see if the name is already in the list
        For Each student As ListItem In studentList.Items
            If student.Text.ToUpper() = studentToAdd.ToUpper() Then
                alreadyListed = True
            End If
        Next

        'Only asks for further information if the name is unique
        If alreadyListed = False Then
            Session("storedStudName") = studentToAdd
            studentList.Items.Add(New ListItem(studentToAdd))
            OpenWindow("studentInfo.aspx") 'open student info window
            'INSERT SQL STATEMENT: Send student name to the database, the other information will be entered on the studentinfo page

            MsgBox(studentToAdd + " was added to the student list.")

            'Shows an alert if the name was not unique
        Else
            MsgBox("This student is already on the list!")
        End If
    End Sub

    Sub OpenWindow(url As String)
        Dim sb As New StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("window.open('")
        sb.Append(url)
        sb.Append("');")
        sb.Append("</script>")
        ClientScript.RegisterStartupScript(Me.GetType(), _
                  "script", sb.ToString())
    End Sub

End Class
