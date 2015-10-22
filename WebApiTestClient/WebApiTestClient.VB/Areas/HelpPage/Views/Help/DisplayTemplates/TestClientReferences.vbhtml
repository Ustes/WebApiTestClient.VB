@imports System.Text.RegularExpressions

<link href="~/Content/themes/base/jquery.ui.all.css" rel="stylesheet" />
<link href="~/Areas/HelpPage/TestClient.css" rel="stylesheet" />
@* Automatically grabs the installed version of JQuery/JQueryUI/KnockoutJS *@

@code

    Dim regexTest = New Func(Of String, Boolean)(Function(i) Regex.IsMatch(i, "jquery-[0-9]+.[0-9]+.[0-9]+.js|bootstrap.js|knockout-[0-9]+.[0-9]+.[0-9]+.js", RegexOptions.Compiled Or RegexOptions.IgnoreCase))
    Dim files = Directory.GetFiles(HttpContext.Current.Server.MapPath("~/Scripts")).Where(regexTest)

    For Each item As String In files
        @<script src="@Url.Content(String.Format("~/Scripts/{0}", Path.GetFileName(item)))"></script>
    Next


End Code

<script src="~/Scripts/WebApiTestClient.js" defer="defer"></script>