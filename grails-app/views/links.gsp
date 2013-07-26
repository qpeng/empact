<%@ page import="empact.Link" %>
<!DOCTYPE html>
<html>
  <head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'link.label', default: 'Link')}" />
		<title>External Links</title>
	</head>
	<body>
             <center><h2>External Links</h2></center>
    <div class="container">
        <a href="#askMod" role="button" class="btn btn-primary pull-right" data-toggle="modal">New Link</a><br><br>
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
				<g:paginate total="${linkInstanceTotal}" />
			</div>
		</div>
    </div>

    <div id="askMod" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel">Title</h3>
        </div>
        <div class="modal-body">
            <p> Body text</p>
        </div>
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
            <button class="btn btn-primary">Send</button>
        </div>
    </div>

	</body>
</html>
