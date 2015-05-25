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
        If IsPostBack Then
            lblWarning.Text = "The username and password entered are invalid."
        End If
    End Sub

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        Dim cnCheckEmail As New SqlConnection

        cnCheckEmail.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        cnCheckEmail.Open()

        Dim cmdCheckEmail As New SqlCommand

        cmdCheckEmail.CommandText = "" _
            & "SELECT     ProfessorEmail, Password " _
            & "FROM       PROFESSOR " _
            & "WHERE      ProfessorEmail = @ProfessorEmail " _
            & "AND        Password = @Password "

        cmdCheckEmail.Connection = cnCheckEmail

        Dim drCheckEmail As SqlDataReader

        cmdCheckEmail.Parameters.AddWithValue("@ProfessorEmail", txtEmail.Text)
        cmdCheckEmail.Parameters.AddWithValue("@Password", txtPass.Text)

        drCheckEmail = cmdCheckEmail.ExecuteReader()

        drCheckEmail.Read()

        If (drCheckEmail.HasRows) Then
            Session("storedProfessorEmail") = txtEmail.Text

            Response.Redirect("home.aspx")
        End If
    End Sub
End Class
