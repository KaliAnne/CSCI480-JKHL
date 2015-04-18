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

Partial Class home
    Inherits System.Web.UI.Page

    Sub Page_Load()

        If Page.IsPostBack = False Then

            'Dim storedProfessorEmail As String = CType(Session.Item("storedProfessorEmail"), String)

            'HiddenProfessorEmail.Text = storedProfessorEmail
            HiddenProfessorEmail.Text = "none@findlay.edu"

        End If

    End Sub

    Protected Sub btnCreateChart_Click(sender As Object, e As EventArgs)

        Session("storedProfessorEmail") = HiddenProfessorEmail.Text

        Response.Redirect("newChart.aspx")

    End Sub

    Protected Sub btnViewCharts_Click(sender As Object, e As EventArgs)

        Session("storedProfessorEmail") = HiddenProfessorEmail.Text

        Response.Redirect("viewExisting.aspx")

    End Sub
End Class
