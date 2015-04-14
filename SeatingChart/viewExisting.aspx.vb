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

        'Start pulling information about the chart
        Dim cmdChartName As SqlCommand = New SqlCommand("" _
            & "SELECT ChartID, Name " _
            & "FROM   CHART " _
            & "WHERE  ProfessorEmail = 'none@findlay.edu' ", _
            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"))

        cmdChartName.Connection.Open()

        ChartNameGridView.DataSource = cmdChartName.ExecuteReader()
        ChartNameGridView.DataBind()

        cmdChartName.Connection.Close()
        cmdChartName.Connection.Dispose()
        'Finish pulling infomation about chart

    End Sub

    'Sends the person to the index page 
    Protected Sub ChartNameGridView_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ChartNameGridView.SelectedIndexChanged

        Dim storedID As String = ChartNameGridView.SelectedRow.Cells(0).Text

        Session("storedID") = storedID

        Response.Redirect("index.aspx")

    End Sub

    Protected Sub ChartNameGridView_RowEditing(sender As Object, e As GridViewEditEventArgs)

    End Sub

    Protected Sub ChartNameGridView_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        ChartNameGridView.EditIndex = -1

        ChartNameGridView.DataBind()

    End Sub
End Class
