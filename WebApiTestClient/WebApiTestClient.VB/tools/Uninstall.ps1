param($installPath, $toolsPath, $package, $project)
$file = $project.ProjectItems.Item("Areas").ProjectItems.Item("HelpPage").ProjectItems.Item("Views").ProjectItems.Item("Help").ProjectItems.Item("Api.vbhtml")
if($file) {
    $file.Open()
    $file.Document.Activate()
    $file.Document.Selection.StartOfDocument()
    $file.Document.ReplaceText("@Html.DisplayForModel()`n@Html.DisplayForModel(`"TestClientDialogs`")", "@Html.DisplayForModel()`n")
	$file.Save()
}