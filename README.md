Web API Test Client

This was initially in C#.  I converted the source project from, https://github.com/yaohuang/WebApiTestClient.

A simple Test Client built on top of ASP.NET Web API Help Page.

Documentation

http://blogs.msdn.com/b/yaohuang1/archive/2012/12/04/10373804.aspx

Get it on NuGet.org
Install-Package WebApiTestClient.VB

Open the file Api.cshtml (under Areas\HelpPage\Views\Help) and add the following:
@Html.DisplayForModel("TestClientDialogs") 
@Html.DisplayForModel("TestClientReferences") 
Note that you add the @Html.DisplayForModel("TestClientDialogs") after the <div> and @Html.DisplayForModel("TestClientReferences") inside the Scripts section.


I eventually want to swap out jquery-ui for bootstrap.


LICENSE

Apache 2.0 License

Building the package

Open and build WebApiTestClient.sln. A NuGet package will be generated as part of the build process and it can be found under the bin folder.
