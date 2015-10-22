param($installPath, $toolsPath, $package, $project)
$file = $project.ProjectItems.Item("Areas").ProjectItems.Item("HelpPage").ProjectItems.Item("Views").ProjectItems.Item("Help").ProjectItems.Item("Api.vbhtml")
if($file) {
    $file.Open()
    $file.Document.Activate()
    $file.Document.Selection.StartOfDocument()
    $file.Document.ReplaceText("@Html.DisplayForModel()`n @Html.DisplayForModel(`"TestClientDialogs`")`n </section>`n`n</div>`n @section Scripts `n @Html.DisplayForModel(`"TestClientReferences`") `n End Section", "@Html.DisplayForModel()`n</section>`n</div>")
	$file.Save()
}