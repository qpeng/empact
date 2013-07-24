<%@ page import="empact.ConceptNote" %>



<div class="fieldcontain ${hasErrors(bean: conceptNoteInstance, field: 'title', 'error')} required">
    <label for="title">
        <g:message code="conceptNote.title.label" default="Title" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="title" required="" value="${conceptNoteInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: conceptNoteInstance, field: 'applications', 'error')} required">
    <label for="applications">
        <g:message code="conceptNote.applications.label" default="Applications" />
        <span class="required-indicator">*</span>
    </label>
    <g:textArea name="applications" cols="40" rows="5" maxlength="5000" required="" value="${conceptNoteInstance?.applications}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: conceptNoteInstance, field: 'abstractDescription', 'error')} required">
    <label for="abstractDescription">
        <g:message code="conceptNote.abstractDescription.label" default="Abstract Description" />
        <span class="required-indicator">*</span>
    </label>
    <g:textArea name="abstractDescription" cols="40" rows="5" maxlength="5000" required="" value="${conceptNoteInstance?.abstractDescription}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: conceptNoteInstance, field: 'dataSources', 'error')} required">
    <label for="dataSources">
        <g:message code="conceptNote.dataSources.label" default="Data Sources" />
        <span class="required-indicator">*</span>
    </label>
    <g:textArea name="dataSources" cols="40" rows="5" maxlength="5000" required="" value="${conceptNoteInstance?.dataSources}"/>
</div>

