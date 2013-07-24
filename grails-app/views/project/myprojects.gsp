<%@ page import="empact.EndUser; empact.Project" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project.label', default: 'All Projects')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">

    <h3 id="my-projects" class="inline">My Projects</h3>

    <g:if test="${session.user && (userType?.equals("Moderator") || userType?.equals("WHO Official") || userType?.equals("Country Official") || userType?.equals("Superuser"))}">
        <a href="#newProject" class="inline btn btn-primary" data-toggle="modal">New Project</a>
    </g:if>

    <g:if test="${projectInstanceTotal != 0}">
        <div class="row-fluid">
            <g:if test="${projectInstanceList.size() > 0}"><!--If a user has a project assigned to them.-->
                <div class="span4">
                    <div class="well">
                        <h5 style="margin-bottom: 0.8em;">My Projects List</h5>
                        <ul class="unstyled project-controls">
                            <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                                <li><g:link action="show" id="${projectInstance.id}" data-project-id="${projectInstance.id}">${fieldValue(bean: projectInstance, field: "name")}</g:link></li>
                            </g:each>
                        </ul>
                    </div>
                    <div class="well">
                        <h5>Helpful Links</h5>
                        <ul class="unstyled project-controls">
                            <li><a href="http://www.macalester.edu">Macalester College</a></li>
                            <li><a href="http://who.int">World Health Organization</a></li>
                        </ul>
                    </div>
                </div>

                <div id="project" class="span8 project-content round8-top">
                    <g:render template="project"/>
                </div>
            </g:if>
        </div>
        <div tabindex="-1" class="alert span10 update-alert hide"></div>
    </g:if>
    <g:else>
        <div class="alert alert-info span10 no-items-message">
            Looks like you do not have any projects. Visit our
            <g:link controller="project" action="list">projects page</g:link>
            to request to be on one.
        </div>
    </g:else>
</div>
<g:render template="modals" />

<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {

        var countries = new Array("Afganistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Brazil", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo (Republic of)", "Costa Rica", "Cote D'ivoire", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Korea (Democratic People's Republic", "Democratic Republic of the Congo", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Fiji", "Finalnd", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Rebublic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritus", "Mexico", "Micronesia (Federated States of)", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Republic of Korea", "Republic of Moldova", "Romania", "Russian Federation", "Rwanda", "Saint Kittis and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Swaziland", "Swden", "Switzerland", "Syrian Arab Republic", "Taijikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe");
        var codes = new Array("AF", "AL", "DZ", "AD", "AO", "AG", "AR", "AM", "AU", "AT", "AZ", "BS", "BH", "BD", "BB", "BY", "BE", "BZ", "BJ", "BT", "BO", "BA", "BW", "BR", "BN", "BG", "BF", "BI", "KH", "CM", "CA", "CV", "CF", "TD", "CL", "CN", "CO", "KM", "CG", "CR", "CI", "HR", "CU", "CY", "CZ", "KP", "CD", "DK", "DJ", "DM", "DO", "EC", "EG", "SV", "GQ", "ER", "EE", "ET", "FJ", "FI", "FR", "GA", "GM", "GE", "DE", "GH", "GR", "GD", "GT", "GN", "GW", "GY", "HT", "HN", "HU", "IS", "IN", "ID", "IR", "IQ", "IE", "IL", "IT", "JM", "JP", "JO", "KZ", "KE", "KI", "KW", "KG", "LA", "LV", "LB", "LS", "LR", "LY", "LI", "LT", "LU", "MK", "MG", "MW", "MY", "MV", "ML", "MT", "MH", "MR", "MU", "MX", "FM", "MC", "MN", "ME", "MA", "MZ", "MM", "NA", "NR", "NP", "NL", "NZ", "NI", "NE", "NG", "NO", "OM", "PK", "PW", "PA", "PG", "PY", "PE", "PH", "PL", "PT", "QA", "KR", "MD", "RO", "RU", "RW", "KN", "LC", "VC", "WS", "SM", "ST", "SA", "SN", "RS", "SC", "SL", "SG", "SK", "SI", "SB", "SO", "ZA", "SS", "ES", "LK", "SD", "SR", "SZ", "SE", "CH", "SY", "TJ", "TZ", "TH", "TL", "TG", "TO", "TT", "TN", "TR", "TM", "TV", "UG", "UA", "AE", "GB", "US", "UY", "UZ", "VU", "VE", "VN", "YE", "ZM", "ZW");

        $('.project-controls > li').first().find('a').addClass('active');

        init();

        $(document).on('click', 'ul.project-controls > li > a', function (event) {
            event.preventDefault();

            if (!$(this).hasClass('active')) {
                $.ajax({
                    url: "${g.createLink(controller:'project', action:'ajaxShow')}",
                    type: 'post',
                    data: {id: $(this).data('project-id')},
                    success: function (project) {
                        $('#project').html(project);
                    },
                    error: function (request, status, error) {
                        alert(error)
                    },
                    complete: function () {

                    }
                });
                $(this).parent().parent().find('li > a').removeClass('active');
                $(this).addClass('active');
            }
        });

        $(document).on('click', '.edit-project', function(event) {
            event.preventDefault();

            $('.inline-edit').each(function(index) {
                var txt = $(this).data('property-value');

                if ($(this).data('property-name') == 'country'){
                    $(this).html("<select name='country' class='input-medium bfh-countries' size='10'></select>");
                    for (var i = 0; i < countries.length; i++) {
                        if ($(this).data('property-value') == codes[i]) {
                            $(".bfh-countries").append("<option value='" + codes[i] + "' selected='selected'>" + countries[i] + "</option>");
                        } else {
                            $(".bfh-countries").append("<option value='" + codes[i] + "'>" + countries[i] + "</option>");
                        }
                    }
                } else if ($(this).data('property-name') == 'language') {
                    $(this).html(
                            "<select name='language' size='6'>" +
                                    "<option value='ara'>Arabic</option>" +
                                    "<option value='chi'>Chinese</option>" +
                                    "<option value='eng'>English</option>" +
                                    "<option value='fre'>French</option>" +
                                    "<option value='rus'>Russian</option>" +
                                    "<option value='spa'>Spanish</option>" +
                                    "</select>"
                    );
                    $(this).find('select').find("option[value='" + $(this).data('property-value') + "']").attr('selected', 'selected');
                } else if ($(this).data('property-name') != 'description') {
                    $(this).html("<input type='text' class='inline-text' name='" + $(this).data('property-name') +
                            "' value='" + txt +"' />");
                }

                else {
                    $(this).html("<textarea type='text' class='inline-text' name='" + $(this).data('property-name') +
                            "'>" + txt + "</textarea>");
                }
            });
            /*$('.link-to-edit > ul').hide().after(
             "<a href='" + "${g.createLink(controller:'endUser', action:'matchusers')}" + "' class='external-link'>Add Users</a>"
             );*/
            $(this).removeClass('edit-project').addClass('save-project').html('Save Project');
        });

        $(document).on('click', '.save-project', function(event) {
            event.preventDefault();

            var edited = {id: $('.project-controls a.active').data('project-id')};
            $('.inline-edit > .inline-text').each(function() {
                edited[$(this).attr('name')] = $(this).val();
            });
            $('.inline-edit > select > option:selected').each(function() {
                edited[$(this).parent().attr('name')] = $(this).val();
            });

            $.ajax({
                url: "${g.createLink(controller:'project', action:'ajaxUpdate')}",
                type: 'post',
                dataType: 'json',
                data: edited,
                success: function (data) {
                    if (data.ok) {
                        $('.inline-edit > .inline-text').each(function() {
                            $(this).after($(this).val());
                        });
                        $('.inline-edit > .inline-text').empty().remove();

                        $('.inline-edit > select > option:selected').each(function() {
                            $(this).parent().after($(this).text());
                        });
                        $('.inline-edit > select').empty().remove();

                        $('.save-project').removeClass('save-project').addClass('edit-project').html('Edit Project');
                        $('.update-alert').removeClass('hide alert-error').addClass('alert-success').html(
                                "Project successfully updated"
                        ).show().fadeOut(5000);
                    } else {
                        $('.update-alert').removeClass('hide alert-success').addClass('alert-error').html(
                                "Project could not be updated"
                        ).show().fadeOut(5000);
                    }
                },
                error: function (request, status, error) {
                    $('.update-alert').removeClass('hide alert-success').addClass('alert-error').html(
                            error
                    ).show().fadeOut(5000);
                },
                complete: function () {

                }
            });
        });

        function init(){
            for (var i = 0; i < countries.length; i++) {
                $(".bfh-countries").append(
                        "<option value='" + codes[i] + "'>" + countries[i] + "</option>");
            }
        }

    });
</script>
</body>
</html>
