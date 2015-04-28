'This file contains the back end capability for the home page

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
            'For future login implementation
            HiddenProfessorEmail.Text = "none@findlay.edu"

        End If

    End Sub

    Protected Sub btnCreateChart_Click(sender As Object, e As EventArgs)
        'For future login implementation, also sends user to the newChart page if the Create Chart button is pressed
        Session("storedProfessorEmail") = HiddenProfessorEmail.Text
        Response.Redirect("newChart.aspx")

    End Sub

    Protected Sub btnViewCharts_Click(sender As Object, e As EventArgs)
        'For future login implementation, also sends user to the viewExisting page if the View Existing button is pressed
        Session("storedProfessorEmail") = HiddenProfessorEmail.Text
        Response.Redirect("viewExisting.aspx")

    End Sub
End Class
