
<%@ page import="empact.EndUser" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'endUser.label', default: 'EndUser')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-endUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-endUser" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="address" title="${message(code: 'endUser.address.label', default: 'Address')}" />
					
						<g:sortableColumn property="phone" title="${message(code: 'endUser.phone.label', default: 'Phone')}" />
					
						<g:sortableColumn property="institution" title="${message(code: 'endUser.institution.label', default: 'Institution')}" />
					
						<g:sortableColumn property="securityAnswer" title="${message(code: 'endUser.securityAnswer.label', default: 'Security Answer')}" />
					
						<g:sortableColumn property="securityQuestion" title="${message(code: 'endUser.securityQuestion.label', default: 'Security Question')}" />
					
						<g:sortableColumn property="email" title="${message(code: 'endUser.email.label', default: 'Email')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${endUserInstanceList}" status="i" var="endUserInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${endUserInstance.id}">${fieldValue(bean: endUserInstance, field: "address")}</g:link></td>
					
						<td>${fieldValue(bean: endUserInstance, field: "phone")}</td>
					
						<td>${fieldValue(bean: endUserInstance, field: "institution")}</td>
					
						<td>${fieldValue(bean: endUserInstance, field: "securityAnswer")}</td>
					
						<td>${fieldValue(bean: endUserInstance, field: "securityQuestion")}</td>
					
						<td>${fieldValue(bean: endUserInstance, field: "email")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${endUserInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
