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
        
        'Start pulling information about the chart
        Dim cmdChartName As SqlCommand = New SqlCommand("" _
            & "SELECT Name, Rows, Columns " _
            & "FROM   CHART " _
            & "WHERE  ChartID = 1", _
            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"))

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
            & "WHERE  ChartID = 1", _
            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"))

        cmdStudents.Connection.Open()

        studentList.DataSource = cmdStudents.ExecuteReader()
        studentList.DataTextField = "Name"
        studentList.DataValueField = "Name"

        studentList.DataBind()

        cmdStudents.Connection.Close()
        cmdStudents.Connection.Dispose()
        'Finish pulling information about the students

    End Sub

End Class
