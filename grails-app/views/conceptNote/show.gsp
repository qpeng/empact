
<%@ page import="empact.ConceptNote" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'conceptNote.label', default: 'ConceptNote')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<a href="#show-conceptNote" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
    </ul>
</div>
<div id="show-conceptNote" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list conceptNote">

        <g:if test="${conceptNoteInstance?.title}">
            <li class="fieldcontain">
                <span id="title-label" class="property-label"><g:message code="conceptNote.title.label" default="Title" /></span>

                <span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${conceptNoteInstance}" field="title"/></span>

            </li>
        </g:if>

        <g:if test="${conceptNoteInstance?.applications}">
            <li class="fieldcontain">
                <span id="applications-label" class="property-label"><g:message code="conceptNote.applications.label" default="Applications" /></span>

                <span class="property-value" aria-labelledby="applications-label"><g:fieldValue bean="${conceptNoteInstance}" field="applications"/></span>

            </li>
        </g:if>

        <g:if test="${conceptNoteInstance?.abstractDescription}">
            <li class="fieldcontain">
                <span id="abstractDescription-label" class="property-label"><g:message code="conceptNote.abstractDescription.label" default="Abstract Description" /></span>

                <span class="property-value" aria-labelledby="abstractDescription-label"><g:fieldValue bean="${conceptNoteInstance}" field="abstractDescription"/></span>

            </li>
        </g:if>

        <g:if test="${conceptNoteInstance?.dataSources}">
            <li class="fieldcontain">
                <span id="dataSources-label" class="property-label"><g:message code="conceptNote.dataSources.label" default="Data Sources" /></span>

                <span class="property-value" aria-labelledby="dataSources-label"><g:fieldValue bean="${conceptNoteInstance}" field="dataSources"/></span>

            </li>
        </g:if>

    </ol>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${conceptNoteInstance?.id}" />
            <g:link class="edit" action="edit" id="${conceptNoteInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
            <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
    </g:form>
</div>
</body>
</html>
