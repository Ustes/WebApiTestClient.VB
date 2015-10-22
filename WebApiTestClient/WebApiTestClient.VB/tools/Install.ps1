param($installPath, $toolsPath, $package, $project)
$file = $project.ProjectItems.Item("Areas").ProjectItems.Item("HelpPage").ProjectItems.Item("Views").ProjectItems.Item("Help").ProjectItems.Item("Api.vbhtml")
if($file) {
    $file.Open()
    $file.Document.Activate()
    $file.Document.Selection.StartOfDocument()
	if(!$file.Document.MarkText("@Html.DisplayForModel(`"TestClientDialogs`")"))
	{
		$file.Document.ReplaceText("@Html.DisplayForModel()", "@Html.DisplayForModel()`n @Html.DisplayForModel(`"TestClientDialogs`")`n ")
	}
	else
	{
		$file.Document.ClearBookmarks()
	}

	$file.Document.Selection.EndOfDocument()
	if(!$file.Document.MarkText("@Html.DisplayForModel(`"TestClientReferences`")")){
		$file.Document.Selection.Insert("@section Scripts`n@Html.DisplayForModel(`"TestClientReferences`")`nEnd Section")
	}



	$file.Save()



}