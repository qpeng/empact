<%@ page import="empact.Link" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'link.label', default: 'Link')}"/>
    <title>External Links</title>
</head>

<body>
<center><h2>External Links</h2></center>

<div class="container">
    <a href="#newLink" role="button" class="btn btn-primary pull-right" data-toggle="modal">New Link</a><br><br>

    <div class="hero-unit">
        <table class="table">
            <g:each in="${linkInstanceList}" var="exlink">
                <tr>
                    <td width="30%"><a href="${exlink.link}">${exlink.name.toString()}</a></td>
                    <td width="70%">${exlink.description.toString()}</td>
                </tr>
            </g:each>
        </table>
    </div>

    <div class="pagination">
        <g:paginate total="${linkInstanceTotal}"/>
    </div>
</div>

<div id="newLink" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>

        <h3>New Project</h3>
    </div>

    <div class="modalbody-newProject">
        <div class="container">
            <g:form name="newProject" class="form-horizontal" url="[controller: 'link', action: 'create']">
                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="name">Title:<sup class='red'>*</sup></label>

                        <div class="controls">
                            <input type="text" name="name" id="name" placeholder="Name">
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="link">URL:<sup class='red'>*</sup></label>

                        <div class="controls">
                            <input type="text" name="link" id="link" placeholder="URL">
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label" for="description">Description<sup
                                class='red'>*</sup></label>

                        <div class="controls">
                            <textarea id="description" name="description" class="span3"
                                      placeholder="Link Description" rows="5"></textarea>
                        </div>
                    </div>

                    <div class="control-buttons" align="center">
                        <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Cancel</button>
                        %{--<g:submitButton id="create-link" name="create" value="Create" class="btn btn-primary"/>--}%
                        <input type="submit" name="create" class="save btn btn-primary" value="Create" id="create">
                    </div>

                </fieldset>
            </g:form>
        </div>
    </div>
</div>

<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>

</body>
</html>
