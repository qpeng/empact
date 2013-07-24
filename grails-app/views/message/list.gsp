<%@ page import="empact.Message" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <div class="inbox">
        <g:render template="inbox" />
    </div>
</div>

<div id='message-modal' class='modal hide fade' tabindex='1' role='dialog' aria-labelledby='modal-label'
     aria-hidden='true'>
    <div class='modal-header'>
        <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>x</button>

        <h3 id='modal-label'>Compose Message</h3>
    </div>

    <div class='modal-body'>
        <form class='form-horizontal'>
            <div class='control-group'>
                <label class='control-label' for='recipient'>To:</label>

                <div class='controls'>
                    <select id="recipient">
                        <g:each in="${empact.EndUser.list()}" var="endUserInstance">
                            <g:if test="${!endUserInstance.toString().equals(session.user.toString())}">
                                <option value="${endUserInstance.id}" name="recipient">${endUserInstance.toString()}</option>
                            </g:if>
                        </g:each>
                    </select>
                </div>
            </div>

            <div class='control-group'>
                <label class='control-label' for='send-subject'>Subject:</label>

                <div class='controls'>
                    <input type='text' id='send-subject' name="subject" placeholder='Subject'>
                </div>
            </div>

            <div class='control-group'>
                <label class='control-label' for='message-details'>Message:</label>

                <div class='controls'>
                    <textarea id='message-details' placeholder='Enter Message'></textarea>
                </div>
            </div>

            <div class='control-group'>
                <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Cancel</button>
                <button id="send-message" class="btn btn-primary">Compose</button>
            </div>
        </form>
    </div>
</div>
<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {

        removeNotifications();

        $(document).on('click', '#nav-messages > a', function() {
            if ($(this).find('span.notification').length > 0) {
                $('span.notification').remove();
            }
        });

        $(document).on('click', '#message-thread > li.separator > .subject', function() {
            if (!$(this).parent().hasClass('closed')) {
                $(this).next('ul.unstyled').hide(200).parent().addClass('closed');
            } else {
                $(this).next('ul.unstyled').show(200).parent().removeClass('closed');
            }

        });

        $(document).on('click', '#users > .user', function() {
            $("#users > .user").removeClass('active');
            $(this).addClass('active');
            var user_id = $(this).data("user-id");

            $.ajax({
                url: "${g.createLink(controller:'message', action:'getConversation')}",
                type: 'post',
                data: {id: user_id},
                success: function (message) {
                    $('#message-thread').html(message);
                },
                error: function (request, status, error) {
                    alert(error)
                },
                complete: function () {

                }
            });
        });

        $(document).on('click', 'input.toggle-subject[type=checkbox]', function() {
            if ($(this).is(':checked')) {
                $('#new-subject').show(150);
            } else {
                $('#new-subject').hide(150);
            }
        });

        $(document).on('click', '#respond > .instant-reply', function(event) {
            event.preventDefault();

            if (!$(this).hasClass('disabled')) {
                $(this).addClass('disabled');
                var data = {
                    message_id: $('#message-thread > li.separator > ul.unstyled').last().data('message-id'),
                    subject: $('#new-subject').val(),
                    details: $('#message-response').val()
                }

                var url = ($('input.toggle-subject').is(':checked') && data.subject.length > 0) ? "${g.createLink(controller:'message', action:'createInPlace')}" : "${g.createLink(controller:'message', action:'respond')}";

                $.ajax({
                    url: url,
                    type: 'post',
                    data: data,
                    success: function (inbox) {
                        $('.inbox').html(inbox);
                    },
                    error: function (request, status, error) {
                        alert(error)
                    },
                    complete: function () {

                    }
                });
            }

        });

        $(document).on('click', '#send-message', function() {
            var data = {
                subject: $('#send-subject').val(),
                details: $('#message-details').val(),
                recipient: $('#recipient > option:selected').val()
            };

            $.ajax({
                url: "${g.createLink(controller:'message', action:'ajaxCreate')}",
                type: 'post',
                data: data,
                success: function (inbox) {
                    $('.inbox').html(inbox);
                },
                error: function (request, status, error) {
                    alert(error)
                },
                complete: function () {

                }
            });

            // Remove Modal
            $('#message-modal').modal('hide');
            $('body').removeClass('modal-open');
            $('.modal-backdrop').remove();
        });

        function removeNotifications() {
            if ($('#nav-messages > a > span.notification').length > 0) {
                $(this).remove();
            }
        }

    });
</script>
</body>
</html>
