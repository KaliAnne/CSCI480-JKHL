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

Partial Class studentInfo
    Inherits System.Web.UI.Page

    Sub Page_Load()

        Dim storedID As String = CType(Session.Item("storedID"), String)

        HiddenChartID.Text = storedID

        stuEmail.ForeColor = System.Drawing.Color.Black

    End Sub

    'Inserts all of the student information
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)

        If (stuEmail.Text = String.Empty) Then

            ClientScript.RegisterStartupScript(GetType(Page), "", "alert('Student Email cannot be empty. Please type an email.');", True)
            stuEmail.ForeColor = System.Drawing.Color.Red

        Else

            'Begin inserting student information
            Dim cnInsertStudent As New SqlConnection

            cnInsertStudent.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"

            Dim cmdInsertStudent As New SqlCommand

            cmdInsertStudent.CommandText = "" _
                & "INSERT INTO STUDENT(StudentEmail, ChartID, Name, Extracurriculars, Majors, Minors) " _
                & "VALUES      ('" + stuEmail.Text + "','" + HiddenChartID.Text + "','" + stuName.Text + "','" + stuExtra.Text + "','" + stuMajor.Text + "','" + stuMinor.Text + "');"

            cmdInsertStudent.Connection = cnInsertStudent

            cnInsertStudent.Open()

            cmdInsertStudent.ExecuteNonQuery()

            cnInsertStudent.Close()
            'Finish inserting student information

            'Sends the user back to the index page
            Session("storedID") = HiddenChartID.Text

            Response.Redirect("index.aspx")
            'End sending the user back to the index page

        End If

    End Sub

End Class
