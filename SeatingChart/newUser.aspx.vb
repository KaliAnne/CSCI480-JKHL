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
        txtConfPass.Attributes.Add("onkeyup", "PassesMatch();")
        txtConfEmail.Attributes.Add("onkeyup", "EmailsMatch();")
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        Dim cnInsertProf As New SqlConnection

        cnInsertProf.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        Dim cmdInsertProf As New SqlCommand

        cmdInsertProf.CommandText = "" _
            & "INSERT INTO PROFESSOR(ProfessorEmail, Password) " _
            & "VALUES      ('" + txtEmail.Text + "','" + txtPass.Text + "');"

        cmdInsertProf.Connection = cnInsertProf

        cnInsertProf.Open()

        cmdInsertProf.ExecuteNonQuery()

        cnInsertProf.Close()
    End Sub
End Class
