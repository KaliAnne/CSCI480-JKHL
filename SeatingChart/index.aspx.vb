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

    'Loads all of the chart information based on the Chart selected
    Sub Page_Load()
        If Page.IsPostBack = False Then
            Dim storedID As String = CType(Session.Item("storedID"), String)

            Dim getChartId As String = storedID
            HiddenChartID.Text = storedID

            'Start pulling information about the chart
            Dim cnChartName As New SqlConnection

            cnChartName.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"

            cnChartName.Open()

            Dim cmdChartName As New SqlCommand

            cmdChartName.CommandText = "SELECT Name, Rows, Columns " _
                & "FROM   CHART " _
                & "WHERE  ChartID = @chartID"

            cmdChartName.Connection = cnChartName

            Dim drChartName As SqlDataReader

            cmdChartName.Parameters.AddWithValue("@chartID", getChartId)

            drChartName = cmdChartName.ExecuteReader()

            drChartName.Read()

            ChartName.Text = drChartName.Item("Name")
            RoomRows.Text = drChartName.Item("Rows")
            RoomColumns.Text = drChartName.Item("Columns")

            drChartName.Close()

            cnChartName.Close()
            'Finish pulling infomation about chart

            'Start pulling information about the students
            Dim cmdStudents As SqlCommand = New SqlCommand("" _
                & "SELECT Name " _
                & "FROM   STUDENT " _
                & "WHERE  ChartID = @chartID", _
                New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"))

            cmdStudents.Parameters.AddWithValue("@chartID", getChartId)

            cmdStudents.Connection.Open()

            studentList.DataSource = cmdStudents.ExecuteReader()
            studentList.DataTextField = "Name"
            studentList.DataValueField = "Name"

            studentList.DataBind()

            cmdStudents.Connection.Close()
            cmdStudents.Connection.Dispose()
            'Finish pulling information about the students

            'Pulls all of the student seating
            Dim cmdSeating As SqlCommand = New SqlCommand("" _
                & "SELECT     SeatNumber + ('') + Name AS Seat " _
                & "FROM       STUDENT " _
                & "INNER JOIN SEATS " _
                & "ON         STUDENT.StudentEmail = SEATS.StudentEmail " _
                & "WHERE      SEATS.ChartID = @chartID", _
                New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"))

            cmdSeating.Parameters.AddWithValue("@chartID", getChartId)

            cmdSeating.Connection.Open()

            SeatsInfo.DataSource = cmdSeating.ExecuteReader()
            SeatsInfo.DataTextField = "Seat"
            SeatsInfo.DataValueField = "Seat"

            SeatsInfo.DataBind()

            cmdSeating.Connection.Close()
            cmdSeating.Connection.Dispose()
            'End pulling all of the student seating

            'If SeatsInfo.Items.Count - 1 >= 0 Then

            'index = 0

            'End If
            InitAttendance()
        End If

    End Sub

    'Saves the new fields to the database
    Protected Sub SaveChart_Click(sender As Object, e As EventArgs) Handles SaveChart.Click

        Dim cnUpdateChart As New SqlConnection

        cnUpdateChart.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        Dim cmdUpdateChart As New SqlCommand

        cmdUpdateChart.CommandText = "" _
            & "UPDATE CHART " _
            & "SET    Name = @getName, Rows = @getRows, Columns = @getColumns " _
            & "WHERE  ChartID = @getChartID"

        cmdUpdateChart.Connection = cnUpdateChart

        cmdUpdateChart.Parameters.AddWithValue("@getName", ChartName.Text)
        cmdUpdateChart.Parameters.AddWithValue("@getRows", RoomRows.Text)
        cmdUpdateChart.Parameters.AddWithValue("@getColumns", RoomColumns.Text)
        cmdUpdateChart.Parameters.AddWithValue("@getChartID", HiddenChartID.Text)

        cnUpdateChart.Open()

        cmdUpdateChart.ExecuteNonQuery()

        cnUpdateChart.Close()

        'Total.Text = SeatsInfo.Items.Count - 1

        'Save attendance
        For index As Integer = 0 To AbsentStuds.Items.Count - 1

            'While index <= Total.Text And index >= 0

            Dim todayDate As String = Date.Now.ToString("MM/dd/yy")
            Dim seatEmail As String
            Dim attenLetter As String
            Dim seatName As String
            Dim text As String = CStr(AbsentStuds.Items(index).ToString)

            attenLetter = text.Substring(0, 1)
            seatName = text.Substring(1, (text.Length - 1))

            If attenLetter = "P" Then

                attenLetter = "Yes"

            Else

                attenLetter = "No"

            End If

            'Selects the student's email
            Dim cnGetEmail As New SqlConnection

            cnGetEmail.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"

            cnGetEmail.Open()

            Dim cmdGetEmail As New SqlCommand

            cmdGetEmail.CommandText = "" _
                & "SELECT StudentEmail " _
                & "FROM   STUDENT " _
                & "WHERE  ChartID = @chartID " _
                & "AND    Name = @getSeatName"

            cmdGetEmail.Connection = cnGetEmail

            Dim drGetEmail As SqlDataReader

            cmdGetEmail.Parameters.AddWithValue("@chartID", HiddenChartID.Text)
            cmdGetEmail.Parameters.AddWithValue("@getSeatName", seatName)

            drGetEmail = cmdGetEmail.ExecuteReader()

            drGetEmail.Read()

            seatEmail = drGetEmail.Item("StudentEmail").ToString

            drGetEmail.Close()

            cnGetEmail.Close()
            'End of selecting the student email






            'Check if email is already in the database for that day
            Dim cnCheckEmail As New SqlConnection

            cnCheckEmail.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"

            cnCheckEmail.Open()

            Dim cmdCheckEmail As New SqlCommand

            cmdCheckEmail.CommandText = "" _
                & "SELECT     Name " _
                & "FROM       STUDENT " _
                & "INNER JOIN ATTENDANCE " _
                & "ON         STUDENT.StudentEmail = ATTENDANCE.StudentEmail " _
                & "WHERE      STUDENT.ChartID = @chartID " _
                & "AND        STUDENT.StudentEmail = @studentEmail " _
                & "AND        STUDENT.Name = @getName " _
                & "AND        ATTENDANCE.Date = @getDate"

            cmdCheckEmail.Connection = cnCheckEmail

            Dim drCheckEmail As SqlDataReader

            cmdCheckEmail.Parameters.AddWithValue("@chartID", HiddenChartID.Text)
            cmdCheckEmail.Parameters.AddWithValue("@studentEmail", seatEmail)
            cmdCheckEmail.Parameters.AddWithValue("@getName", seatName)
            cmdCheckEmail.Parameters.AddWithValue("@getDate", todayDate)

            drCheckEmail = cmdCheckEmail.ExecuteReader()

            drCheckEmail.Read()
            'End of checking for an email for that day

            'If the student is already listed for that day, update their attendance
            If (drCheckEmail.HasRows) Then

                'Update student seat info
                Dim cnUpdateStudent As New SqlConnection

                cnUpdateStudent.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                        & "User ID=480-JKHL;Password=1104ncory"

                Dim cmdUpdateStudent As New SqlCommand

                cmdUpdateStudent.CommandText = "" _
                    & "UPDATE ATTENDANCE " _
                    & "SET    Present = @getPresent " _
                    & "WHERE  ChartID = @getChartID " _
                    & "AND    StudentEmail = @getEmail " _
                    & "AND    Date = @getDate"

                cmdUpdateStudent.Connection = cnUpdateStudent
                cmdUpdateStudent.Parameters.AddWithValue("@getPresent", attenLetter)
                cmdUpdateStudent.Parameters.AddWithValue("@getChartID", HiddenChartID.Text)
                cmdUpdateStudent.Parameters.AddWithValue("@getEmail", seatEmail)
                cmdUpdateStudent.Parameters.AddWithValue("@getDate", todayDate)

                cnUpdateStudent.Open()

                cmdUpdateStudent.ExecuteNonQuery()

                cnUpdateStudent.Close()
                'End updating the student's attendance

            Else

                'Begin inserting student attendance
                Dim cnInsertStudent As New SqlConnection

                cnInsertStudent.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                        & "User ID=480-JKHL;Password=1104ncory"

                Dim cmdInsertStudent As New SqlCommand

                cmdInsertStudent.CommandText = "" _
                    & "INSERT INTO ATTENDANCE(ChartID, StudentEmail, Date, Present) " _
                    & "VALUES      ('" + HiddenChartID.Text + "','" + seatEmail + "','" + todayDate + "','" + attenLetter + "');"

                cmdInsertStudent.Connection = cnInsertStudent

                cnInsertStudent.Open()

                cmdInsertStudent.ExecuteNonQuery()

                cnInsertStudent.Close()
                'End inserting student attendance

            End If

            'index = index + 1

            'SaveChart_Click(sender, e)

            'End While
        Next
        ''End 

    End Sub

    'Sets the Chart fields to false so that the changed items will be changed in the database
    Protected Sub EditRoom_Click(sender As Object, e As EventArgs)

        ChartName.ReadOnly = False
        RoomRows.ReadOnly = False
        RoomColumns.ReadOnly = False

    End Sub

    'Adds a new student to the class
    Protected Sub btnAddStudent_Click(sender As Object, e As EventArgs)

        Session("storedID") = HiddenChartID.Text
        Session("storedChartName") = ChartName.Text
        Response.Redirect("studentInfo.aspx")

    End Sub

    'Delete the chart and send the user back to View Existing
    Protected Sub btnDelChart_Click(sender As Object, e As EventArgs)

        'Start pulling email for the chart
        Dim cnProfessorEmail As New SqlConnection

        cnProfessorEmail.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        cnProfessorEmail.Open()

        Dim cmdProfessorEmail As New SqlCommand

        cmdProfessorEmail.CommandText = "SELECT ProfessorEmail " _
            & "FROM   CHART " _
            & "WHERE  ChartID = @chartID"

        cmdProfessorEmail.Connection = cnProfessorEmail

        Dim drProfessorEmail As SqlDataReader

        cmdProfessorEmail.Parameters.AddWithValue("@chartID", HiddenChartID.Text)

        drProfessorEmail = cmdProfessorEmail.ExecuteReader()

        drProfessorEmail.Read()

        HiddenProfessorEmail.Text = drProfessorEmail.Item("ProfessorEmail")

        drProfessorEmail.Close()

        cnProfessorEmail.Close()
        'Finish pulling email for the chart

        'Start deleting the chart
        Dim cmdDeleteChart As SqlCommand = New SqlCommand("" _
            & "DELETE " _
            & "FROM   CHART " _
            & "WHERE  ChartID = @getChartID", _
            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"))

        cmdDeleteChart.Parameters.AddWithValue("@getChartID", HiddenChartID.Text)

        cmdDeleteChart.Connection.Open()

        cmdDeleteChart.ExecuteNonQuery()

        cmdDeleteChart.Connection.Close()
        cmdDeleteChart.Connection.Dispose()
        'Finish deleting the chart

        'Sends the user back to view Existing to see their charts
        Session("storedProfessorEmail") = HiddenProfessorEmail.Text

        Response.Redirect("viewExisting.aspx")

    End Sub

    Protected Sub btnRemoveStudent_Click(sender As Object, e As EventArgs)

        Dim deleteStudent As String = studentList.SelectedItem.Value

        If (deleteStudent = String.Empty) Then

            'Make this javascript later
            ClientScript.RegisterStartupScript(GetType(Page), "", "alert('Please select the student you wish to remove.');", True)
            'Response.Write("<script>alert('Please select the student you wish to remove.');</script>")

        Else

            'Start deleting the student
            Dim cmdDeleteStudent As SqlCommand = New SqlCommand("" _
            & "DELETE " _
             & "FROM   STUDENT " _
            & "WHERE  ChartID = @getChartID " _
            & "AND    Name = @getStudentName", _
            New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
             & "User ID=480-JKHL;Password=1104ncory"))

            cmdDeleteStudent.Parameters.AddWithValue("@getStudentName", deleteStudent)
            cmdDeleteStudent.Parameters.AddWithValue("@getchartID", HiddenChartID.Text)

            cmdDeleteStudent.Connection.Open()

            cmdDeleteStudent.ExecuteNonQuery()

            cmdDeleteStudent.Connection.Close()
            cmdDeleteStudent.Connection.Dispose()
            'Finish deleting the student

            'Delete student picture from studentpictures folder
            Dim path = Server.MapPath("images/StudentPictures/") + ChartName.Text + "_" + deleteStudent + ".png"
            System.IO.File.Delete(path)

            'Reload the page with the new information
            Session("storedID") = HiddenChartID.Text

            Response.Redirect("index.aspx")

        End If

    End Sub

    'Opens the past attendance page with the current chart ID
    Protected Sub btnViewPastAttendance_Click(sender As Object, e As EventArgs)
        Session("storedID") = HiddenChartID.Text

        Response.Redirect("past_atten.aspx")
    End Sub

    'View the selected student's information
    Protected Sub btnViewStuInfo_Click(sender As Object, e As EventArgs)

        Dim selectedStudent As String = studentList.SelectedItem.Value

        Session("selectedStudent") = selectedStudent
        Session("storedID") = HiddenChartID.Text
        Session("storedChartName") = ChartName.Text

        Response.Redirect("viewStudentInfo.aspx")

    End Sub

    'Handles assigning, unassigning, and 
    Protected Sub ManageStudSeat()

        'Handles assigning the student to a seat and saving it to the database
        If Not AddStud.Text = "" Then
            SeatsInfo.Items.Add(AddStud.Text)
            AddStud.Text = ""
            RmvStud.Text = ""
            SaveAsnSeat()


        ElseIf Not RmvStud.Text = "" Then 'Handles removing the student from their seat in the database
            SeatsInfo.Items.Remove(RmvStud.Text)
            RemoveAsnSeat(RmvStud.Text)
            AddStud.Text = ""
            RmvStud.Text = ""


        Else 'Handles marking students as absent or present for the database 
            Dim atndText As String = AtndStud.Text
            If atndText.Substring(0, 1) = "P" Then
                AbsentStuds.Items.Remove("A" + atndText.Substring(1, atndText.Length - 1))
                AbsentStuds.Items.Add(atndText.Substring(0, atndText.Length))
            Else
                AbsentStuds.Items.Remove("P" + atndText.Substring(1, atndText.Length - 1))
                AbsentStuds.Items.Add(atndText.Substring(0, atndText.Length))
            End If
        End If

    End Sub

    'Saves the newly assigned seat to the database
    Protected Sub SaveAsnSeat()
        For index As Integer = 0 To SeatsInfo.Items.Count - 1

            'While index <= Total.Text And index >= 0

            Dim seatEmail As String
            Dim seatNumber As String
            Dim seatName As String
            Dim text As String = CStr(SeatsInfo.Items(index).ToString)

            seatNumber = text.Substring(0, 4)
            seatName = text.Substring(4, (text.Length - 4))

            'Selects the student's email
            Dim cnGetEmail As New SqlConnection

            cnGetEmail.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"

            cnGetEmail.Open()

            Dim cmdGetEmail As New SqlCommand

            cmdGetEmail.CommandText = "" _
                & "SELECT StudentEmail " _
                & "FROM   STUDENT " _
                & "WHERE  ChartID = @chartID " _
                & "AND    Name = @getSeatName"

            cmdGetEmail.Connection = cnGetEmail

            Dim drGetEmail As SqlDataReader

            cmdGetEmail.Parameters.AddWithValue("@chartID", HiddenChartID.Text)
            cmdGetEmail.Parameters.AddWithValue("@getSeatName", seatName)

            drGetEmail = cmdGetEmail.ExecuteReader()

            drGetEmail.Read()

            seatEmail = drGetEmail.Item("StudentEmail").ToString

            drGetEmail.Close()

            cnGetEmail.Close()
            'End of selecting the student email

            'Check if email is already in the database
            Dim cnCheckEmail As New SqlConnection

            cnCheckEmail.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"

            cnCheckEmail.Open()

            Dim cmdCheckEmail As New SqlCommand

            cmdCheckEmail.CommandText = "" _
                & "SELECT     Name " _
                & "FROM       STUDENT " _
                & "INNER JOIN SEATS " _
                & "ON         STUDENT.StudentEmail = SEATS.StudentEmail " _
                & "WHERE      STUDENT.ChartID = @chartID " _
                & "AND        STUDENT.StudentEmail = @studentEmail " _
                & "AND        STUDENT.Name = @getName"

            cmdCheckEmail.Connection = cnCheckEmail

            Dim drCheckEmail As SqlDataReader

            cmdCheckEmail.Parameters.AddWithValue("@chartID", HiddenChartID.Text)
            cmdCheckEmail.Parameters.AddWithValue("@studentEmail", seatEmail)
            cmdCheckEmail.Parameters.AddWithValue("@getName", seatName)

            drCheckEmail = cmdCheckEmail.ExecuteReader()

            drCheckEmail.Read()
            'End of checking for an email

            'If the student is already listed, then update that students seat number; otherwise, add the student to the seat
            If (drCheckEmail.HasRows) Then

                'Update student seat info
                Dim cnUpdateStudent As New SqlConnection

                cnUpdateStudent.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                        & "User ID=480-JKHL;Password=1104ncory"

                Dim cmdUpdateStudent As New SqlCommand

                cmdUpdateStudent.CommandText = "" _
                    & "UPDATE SEATS " _
                    & "SET    SeatNumber = @getSeat " _
                    & "WHERE  ChartID = @getChartID " _
                    & "AND    StudentEmail = @getEmail"

                cmdUpdateStudent.Connection = cnUpdateStudent

                cmdUpdateStudent.Parameters.AddWithValue("@getSeat", seatNumber)
                cmdUpdateStudent.Parameters.AddWithValue("@getChartID", HiddenChartID.Text)
                cmdUpdateStudent.Parameters.AddWithValue("@getEmail", seatEmail)

                cnUpdateStudent.Open()

                cmdUpdateStudent.ExecuteNonQuery()

                cnUpdateStudent.Close()
                'End updating student seat info

            Else

                'Begin inserting student seat information
                Dim cnInsertStudent As New SqlConnection

                cnInsertStudent.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                        & "User ID=480-JKHL;Password=1104ncory"

                Dim cmdInsertStudent As New SqlCommand

                cmdInsertStudent.CommandText = "" _
                    & "INSERT INTO SEATS(ChartID, StudentEmail, SeatNumber) " _
                    & "VALUES      ('" + HiddenChartID.Text + "','" + seatEmail + "','" + seatNumber + "');"

                cmdInsertStudent.Connection = cnInsertStudent

                cnInsertStudent.Open()

                cmdInsertStudent.ExecuteNonQuery()

                cnInsertStudent.Close()
                'End inserting student seat information

            End If

            'index = index + 1

            'SaveChart_Click(sender, e)

            'End While
        Next
    End Sub

    'student to remove is "0101Jacob Babione"
    Sub RemoveAsnSeat(studentToRemove As String)

        Dim seatEmail As String
        Dim seatNumber As String
        Dim seatName As String
        Dim text As String = studentToRemove

        seatNumber = text.Substring(0, 4)
        seatName = text.Substring(4, (text.Length - 4))

        'Selects the student's email
        Dim cnGetEmail As New SqlConnection

        cnGetEmail.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                & "User ID=480-JKHL;Password=1104ncory"

        cnGetEmail.Open()

        Dim cmdGetEmail As New SqlCommand

        cmdGetEmail.CommandText = "" _
            & "SELECT StudentEmail " _
            & "FROM   STUDENT " _
            & "WHERE  ChartID = @chartID " _
            & "AND    Name = @getSeatName"

        cmdGetEmail.Connection = cnGetEmail

        Dim drGetEmail As SqlDataReader

        cmdGetEmail.Parameters.AddWithValue("@chartID", HiddenChartID.Text)
        cmdGetEmail.Parameters.AddWithValue("@getSeatName", seatName)

        drGetEmail = cmdGetEmail.ExecuteReader()

        drGetEmail.Read()

        seatEmail = drGetEmail.Item("StudentEmail").ToString

        drGetEmail.Close()

        cnGetEmail.Close()
        'End of selecting the student email

        'Start deleting the student's seat assignment
        Dim cmdDeleteStudent As SqlCommand = New SqlCommand("" _
        & "DELETE " _
        & "FROM   SEATS " _
        & "WHERE  ChartID = @getChartID " _
        & "AND    StudentEmail = @getEmail", _
        New SqlConnection("Data Source=mars;Initial Catalog=480-AttendanceApp;" _
         & "User ID=480-JKHL;Password=1104ncory"))

        cmdDeleteStudent.Parameters.AddWithValue("@getEmail", seatEmail)
        cmdDeleteStudent.Parameters.AddWithValue("@getchartID", HiddenChartID.Text)

        cmdDeleteStudent.Connection.Open()

        cmdDeleteStudent.ExecuteNonQuery()

        cmdDeleteStudent.Connection.Close()
        cmdDeleteStudent.Connection.Dispose()
        'End deleting student seat assignment

    End Sub

    'Sets up the attendance dropdown with everyone as present
    Protected Sub InitAttendance()
        Dim seatText As String
        For seatIndex As Integer = 0 To SeatsInfo.Items.Count - 1
            seatText = SeatsInfo.Items(seatIndex).Text
            AbsentStuds.Items.Add("P" + seatText.Substring(4, seatText.Length - 4))
        Next
    End Sub

End Class
