@imports System.Web.Http
@imports $rootnamespace$.Areas.HelpPage.Models
@ModelType HelpPageApiModel

@code
    Dim description = Model.ApiDescription
    Dim applicationPath As String = Request.ApplicationPath

    If applicationPath.EndsWith("/") = False Then
        applicationPath &= "/"
    End If
End Code


<!-- Button trigger modal -->
<button type="button" class="btn btn-primary btn-lg tester-button" data-toggle="modal" data-target="#modalTestClient">
    Launch API Test
</button>

<!-- Modal -->
<div class="modal fade" id="modalTestClient" tabindex="-1" role="dialog" aria-labelledby="modalTestClientLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header alert alert-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="modalTestClientLabel">@description.HttpMethod @description.RelativePath</h4>
            </div>
            <div class="modal-body">
                <div class="well well-sm">
                    <input class="httpMethod" spellcheck="false" data-bind="value: HttpMethod" disabled="disabled" />
                    <input class="uriPath" spellcheck="false" data-bind="value: UriPath" disabled="disabled" />
                </div>
                <div data-bind="visible: UriParameters.length > 0">
                    <h5 class="ui-widget-header">URI parameters</h5>
                    <div class="panel">
                        <div data-bind="foreach: UriParameters">
                            <div>
                                <input readonly="true" spellcheck="false" tabindex="100" class="uriParameterLabel" data-bind="value: '{' + name + '}'" />
                                <span>= </span>
                                <input spellcheck="false" data-bind="value: value, valueUpdate: 'afterkeydown', enable: enabled" />
                                <input type="checkbox" data-bind="checked: enabled" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">Headers | <a style="text-decoration: underline" href="#" data-bind="click: addHeader">Add header</a></div>
                    <div class="panel-body">
                        <div data-bind="foreach: RequestHeaders">
                            <div>
                                <input spellcheck="false" data-bind='value: name, uniqueName: true' />
                                <span>: </span>
                                <input spellcheck="false" data-bind='value: value, uniqueName: true' />
                                <a href='#' data-bind='click: $root.removeHeader'>Delete</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><input type='checkbox' data-bind='checked: ShouldShowBody' class="pull-left" />Body</h3>
                    </div>
                    <div class="panel-body">
                        <div data-bind="visible: ShouldShowBody">
                            <div data-bind="visible: SampleTypes.length > 0">
                                <span>Samples: </span>
                                <select data-bind="options: SampleTypes, value: RequestMediaType"></select>
                            </div>
                            <pre><textarea class="sampleArea" spellcheck="false" data-bind="value: RequestBody, valueUpdate: 'afterkeydown'" rows="7"></textarea></pre>
                        </div>
                    </div>
                </div>




            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary callback-btn">Send Test</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="testClientResponseDialog" tabindex="-1" role="dialog" aria-labelledby="modalTestClientResponseLabel" title="Response for @description.HttpMethod @description.RelativePath" data-bind="with: response">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="modalTestClientResponseLabel">Response for @description.HttpMethod @description.RelativePath</h4>
            </div>
            <div class="modal-body">


                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Status</h3>
                    </div>
                    <div class="panel-body">
                        <span data-bind="text: status"></span>
                    </div>
                </div>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Headers</h3>
                    </div>
                    <div class="panel-body">
                        <textarea spellcheck="false" data-bind="value: headers" class="sampleArea" readonly='readonly' rows="6"></textarea>
                    </div>
                </div>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Body</h3>
                    </div>
                    <div class="panel-body">
                        <textarea spellcheck="false" data-bind="value: content" class="sampleArea" readonly='readonly' rows="10"></textarea>
                    </div>
                </div>



            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    testClientModel = {
        HttpMethod: '@Model.ApiDescription.HttpMethod',
        UriPathTemplate: @Html.Raw(Json.Encode(Model.ApiDescription.RelativePath)),
        UriParameters: [
                @For each parameter in Model.ApiDescription.ParameterDescriptions
                if parameter.Source = System.Web.Http.Description.ApiParameterSource.FromUri then
                    @:{ name: "@parameter.Name", value: "" },
                    end if
            next
    ],
        Samples: {
            @Html.Raw([String].Join(",", Model.SampleRequests.[Select](Function(s) [String].Format("""{0}"": ""{1}""", s.Key, HttpUtility.UrlEncode(s.Value.ToString()))).ToArray()))
        },
        BaseAddress: '@applicationPath'
    };
</script>