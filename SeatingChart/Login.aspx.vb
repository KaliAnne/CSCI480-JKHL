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
Imports System.Net
Imports System.Net.Mail
Imports System.Drawing

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

    'Code based off of http://www.aspsnippets.com/Articles/Implement-Forgot-Password-Password-Recovery-and-send-password-in-Email-in-ASPNet.aspx
    Protected Sub SendEmail()
        Dim email As String = txtEmail.Text.Trim
        Dim pass As String

        'Make sure the email entered is valid
        Dim cnCheckEmail As New SqlConnection

        cnCheckEmail.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        cnCheckEmail.Open()

        Dim cmdCheckEmail As New SqlCommand

        cmdCheckEmail.CommandText = "" _
            & "SELECT     ProfessorEmail, Password " _
            & "FROM       PROFESSOR " _
            & "WHERE      ProfessorEmail = @ProfessorEmail "

        cmdCheckEmail.Connection = cnCheckEmail

        Dim drCheckEmail As SqlDataReader

        cmdCheckEmail.Parameters.AddWithValue("@ProfessorEmail", txtEmail.Text)

        drCheckEmail = cmdCheckEmail.ExecuteReader()

        drCheckEmail.Read()

        If (drCheckEmail.HasRows) Then
            'Send the email from the noreply.attendanceapp@gmail.com account
            pass = drCheckEmail.Item("Password")
            Dim mm As New MailMessage("noreply.attendanceapp@gmail.com", txtEmail.Text.Trim)
            mm.Subject = "Password Recovery"
            mm.Body = String.Format("Hi {0},<br /><br />Your password is {1}.<br /><br />Thank You.", email, pass)
            mm.IsBodyHtml = True
            Dim smtp As New SmtpClient()
            smtp.Host = "smtp.gmail.com"
            smtp.EnableSsl = True
            Dim NetworkCred As New NetworkCredential()
            NetworkCred.UserName = "noreply.attendanceapp@gmail.com"
            NetworkCred.Password = "1104ncory"
            smtp.UseDefaultCredentials = True
            smtp.Credentials = NetworkCred
            smtp.Port = 587
            smtp.Send(mm)
            lblWarning.Text = "Password has been sent to your email address."
        Else
            lblWarning.Text = "This email address does not match our records."
        End If
    End Sub

End Class
