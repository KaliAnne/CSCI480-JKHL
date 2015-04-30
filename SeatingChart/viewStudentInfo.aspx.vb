' This file contains the back end code for the view student info page

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

Partial Class viewStudentInfo
    Inherits System.Web.UI.Page

    Sub Page_Load()
        'Emphasize email and name as read only, by changing their colors
        stuEmail.ForeColor = System.Drawing.Color.Gray
        stuName.ForeColor = System.Drawing.Color.Gray

        If Page.IsPostBack = False Then

            Dim selectedStudent As String = CType(Session.Item("selectedStudent"), String)
            Dim storedID As String = CType(Session.Item("storedID"), String)
            Dim storedChartName As String = CType(Session.Item("storedChartName"), String)

            HiddenStudentName.Text = selectedStudent
            HiddenChartID.Text = storedID

            stuImage.ImageUrl = "images/StudentPictures/" + storedChartName + "_" + HiddenStudentName.Text + ".png"

            'Start pulling student information
            Dim cnStudentInfo As New SqlConnection

            cnStudentInfo.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"

            cnStudentInfo.Open()

            Dim cmdStudentInfo As New SqlCommand

            cmdStudentInfo.CommandText = "" _
                & "SELECT Name, StudentEmail, Majors, Minors, Extracurriculars " _
                & "FROM   STUDENT " _
                & "WHERE  ChartID = @chartID " _
                & "AND    Name = @studentName"

            cmdStudentInfo.Connection = cnStudentInfo

            Dim drStudentInfo As SqlDataReader

            cmdStudentInfo.Parameters.AddWithValue("@chartID", HiddenChartID.Text)
            cmdStudentInfo.Parameters.AddWithValue("@studentName", HiddenStudentName.Text)

            drStudentInfo = cmdStudentInfo.ExecuteReader()

            drStudentInfo.Read()

            stuName.Text = drStudentInfo.Item("Name")
            stuEmail.Text = drStudentInfo.Item("StudentEmail")
            stuMajor.Text = drStudentInfo.Item("Majors")
            stuMinor.Text = drStudentInfo.Item("Minors")
            stuExtra.Text = drStudentInfo.Item("Extracurriculars")

            drStudentInfo.Close()

            cnStudentInfo.Close()
            'Finish pulling student information

        End If

    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)

        'Sends the user back to the index page
        Session("storedID") = HiddenChartID.Text

        Response.Redirect("index.aspx")
        'End sending the user back to the index page

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs)

        'Update student info
        Dim cnUpdateStudent As New SqlConnection

        cnUpdateStudent.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        Dim cmdUpdateStudent As New SqlCommand

        cmdUpdateStudent.CommandText = "" _
            & "UPDATE STUDENT " _
            & "SET    Majors = @getMajor, Minors = @getMinor, Extracurriculars = @getExtra " _
            & "WHERE  ChartID = @getChartID " _
            & "AND    StudentEmail = @getEmail"

        cmdUpdateStudent.Connection = cnUpdateStudent

        cmdUpdateStudent.Parameters.AddWithValue("@getMajor", stuMajor.Text)
        cmdUpdateStudent.Parameters.AddWithValue("@getMinor", stuMinor.Text)
        cmdUpdateStudent.Parameters.AddWithValue("@getExtra", stuExtra.Text)
        cmdUpdateStudent.Parameters.AddWithValue("@getChartID", HiddenChartID.Text)
        cmdUpdateStudent.Parameters.AddWithValue("@getEmail", stuEmail.Text)

        cnUpdateStudent.Open()

        cmdUpdateStudent.ExecuteNonQuery()

        cnUpdateStudent.Close()
        'End updating student info

        'Sends the user back to the index page
        Session("storedID") = HiddenChartID.Text
        SaveStudPic(stuName.Text)
        Response.Redirect("index.aspx")
        'End sending the user back to the index page

    End Sub

    Sub SaveStudPic(studname As String)
        Dim chartname As String = CType(Session.Item("storedChartName"), String)
        Dim Savepath As String = Server.MapPath("images/StudentPictures/") + chartname + "_" + studname + ".png"
        'Allow the professor to replace the existing picture of the student
        If stuPicture.HasFile() Then
            System.IO.File.Delete(Savepath)
            stuPicture.PostedFile.SaveAs(Savepath)
        End If
    End Sub

End Class
