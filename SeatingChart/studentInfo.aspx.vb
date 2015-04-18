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

    End Sub

    'Inserts all of the student information
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)

        If (stuEmail.Text = String.Empty) Then

            ClientScript.RegisterStartupScript(GetType(Page), "", "alert('Student Email cannot be empty. Please type an email.');", True)

        Else

            'Check if email is already in the database
            Dim cnCheckEmail As New SqlConnection

            cnCheckEmail.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"

            cnCheckEmail.Open()

            Dim cmdCheckEmail As New SqlCommand

            cmdCheckEmail.CommandText = "" _
                & "SELECT StudentEmail " _
                & "FROM   STUDENT " _
                & "WHERE  ChartID = @chartID " _
                & "AND    StudentEmail = @studentEmail"

            cmdCheckEmail.Connection = cnCheckEmail

            Dim drCheckEmail As SqlDataReader

            cmdCheckEmail.Parameters.AddWithValue("@chartID", HiddenChartID.Text)
            cmdCheckEmail.Parameters.AddWithValue("@studentEmail", stuEmail.Text)

            drCheckEmail = cmdCheckEmail.ExecuteReader()

            drCheckEmail.Read()
            'End of checking for an email

            'If a result returns, send a message saying the student already exists
            If (drCheckEmail.HasRows) Then

                ClientScript.RegisterStartupScript(GetType(Page), "", "alert('This student in already in this class. Please check the email you entered.');", True)

                drCheckEmail.Close()
                cnCheckEmail.Close()

            Else
                'Close the connection if there was no email returned
                drCheckEmail.Close()
                cnCheckEmail.Close()

                'Begin inserting student information
                Dim cnInsertStudent As New SqlConnection

                cnInsertStudent.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                        & "User ID=480-JKHL;Password=1104ncory"

                Dim cmdInsertStudent As New SqlCommand

                cmdInsertStudent.CommandText = "" _
                    & "INSERT INTO STUDENT(StudentEmail, ChartID, Name, StudentImage, Extracurriculars, Majors, Minors) " _
                    & "VALUES      ('" + stuEmail.Text + "','" + HiddenChartID.Text + "','" + stuName.Text + "','" + stuPicture.FileName + "','" + stuExtra.Text + "','" + stuMajor.Text + "','" + stuMinor.Text + "');"

                cmdInsertStudent.Connection = cnInsertStudent

                cnInsertStudent.Open()

                cmdInsertStudent.ExecuteNonQuery()

                cnInsertStudent.Close()
                'End inserting student information

                'Sends the user back to the index page
                Session("storedID") = HiddenChartID.Text

                Response.Redirect("index.aspx")
                'End sending the user back to the index page

            End If

        End If

    End Sub

End Class
