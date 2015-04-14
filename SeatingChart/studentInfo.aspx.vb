
Partial Class studentInfo
    Inherits System.Web.UI.Page
    Sub Page_Load()
        stuName.Text = "Jacob"
        stuName.ReadOnly = True
    End Sub
    Sub SubmitInfo()
        'Send the data entered in the majors/minors/extras
    End Sub
End Class
