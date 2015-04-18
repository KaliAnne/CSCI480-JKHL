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


Partial Class newChart
    Inherits System.Web.UI.Page

    Sub Page_Load()

        If Page.IsPostBack = False Then

            Dim storedProfessorEmail As String = CType(Session.Item("storedProfessorEmail"), String)

            HiddenProfessorEmail.Text = storedProfessorEmail

        End If

    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)

        If (chartName.Text = String.Empty) Then

            ClientScript.RegisterStartupScript(GetType(Page), "", "alert('Name cannot be empty. Please give your chart a name.');", True)

        ElseIf (chartRows.Text = String.Empty) Then

            ClientScript.RegisterStartupScript(GetType(Page), "", "alert('Rows cannot be empty. Please give your chart a row number.');", True)

        ElseIf (Convert.ToInt32(chartRows.Text) < 1 Or Convert.ToInt32(chartRows.Text) > 7) Then

            ClientScript.RegisterStartupScript(GetType(Page), "", "alert('Rows must be from 1 to 7.');", True)

        ElseIf (chartColumns.Text = String.Empty) Then

            ClientScript.RegisterStartupScript(GetType(Page), "", "alert('Columns cannot be empty. Please give your chart a column number.');", True)

        ElseIf (Convert.ToInt32(chartColumns.Text) < 1 Or Convert.ToInt32(chartColumns.Text) > 10) Then

            ClientScript.RegisterStartupScript(GetType(Page), "", "alert('Columns must be from 1 to 10.');", True)

        Else

            'Check if chart name is already in the database
            Dim cnCheckName As New SqlConnection

            cnCheckName.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                    & "User ID=480-JKHL;Password=1104ncory"

            cnCheckName.Open()

            Dim cmdCheckName As New SqlCommand

            cmdCheckName.CommandText = "" _
                & "SELECT Name " _
                & "FROM   CHART " _
                & "WHERE  ProfessorEmail = @professorEmail " _
                & "AND    Name = @name"

            cmdCheckName.Connection = cnCheckName

            Dim drCheckName As SqlDataReader

            cmdCheckName.Parameters.AddWithValue("@professorEmail", HiddenProfessorEmail.Text)
            cmdCheckName.Parameters.AddWithValue("@name", chartName.Text)

            drCheckName = cmdCheckName.ExecuteReader()

            drCheckName.Read()
            'End of checking for a chart name

            'If a result returns, send a message saying the student already exists
            If (drCheckName.HasRows) Then

                ClientScript.RegisterStartupScript(GetType(Page), "", "alert('This name is already in your chart list. Please check the name you entered.');", True)

                drCheckName.Close()
                drCheckName.Close()

            Else
                'Close the connection if there was no email returned
                drCheckName.Close()
                drCheckName.Close()

                'Begin inserting student information

                Dim dateSubmitted As String = Date.Now.ToString("MM/dd/yy")

                Dim cnInsertChart As New SqlConnection

                cnInsertChart.ConnectionString = "Data Source=mars;Initial Catalog=480-AttendanceApp;" _
                        & "User ID=480-JKHL;Password=1104ncory"

                Dim cmdInsertChart As New SqlCommand

                cmdInsertChart.CommandText = "" _
                    & "INSERT INTO CHART(Name, Rows, Columns, Date, ProfessorEmail) " _
                    & "VALUES      ('" + chartName.Text + "','" + chartRows.Text + "','" + chartColumns.Text + "','" + dateSubmitted + "','" + HiddenProfessorEmail.Text + "');"

                cmdInsertChart.Connection = cnInsertChart

                cnInsertChart.Open()

                cmdInsertChart.ExecuteNonQuery()

                cnInsertChart.Close()
                'End inserting student information

                'Sends the user back to the index page
                Session("storedProfessorEmail") = HiddenProfessorEmail.Text

                Response.Redirect("viewExisting.aspx")
                'End sending the user back to the index page
            End If

        End If

    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)

        'Sends the user back to the home page
        Session("storedProfessorEmail") = HiddenProfessorEmail.Text

        Response.Redirect("home.aspx")
        'End sending the user back to the home page

    End Sub

End Class
