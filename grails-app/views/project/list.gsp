<%@ page import="empact.EndUser; empact.Project; empact.ConceptNote" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project.label', default: 'All Projects')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <h3 id="all-projects" class="inline">All Projects</h3>
    <g:if test="${session.user && (userType?.equals("Moderator") || userType?.equals("WHO Official") || userType?.equals("Country Official") || userType?.equals("Superuser"))}">
        <a href="#newProject" class="inline btn btn-primary" data-toggle="modal">New Project</a>
    </g:if>

    <div id="table-controller">
        <ul class="pager">
            <li class="previous disabled">
                <a href="#">&larr; prev</a>
            </li>

            <li class='next'>
                <a href='#'>next &rarr;</a>
            </li>
        </ul>
    </div>
    <table id="projects" class="tablesorter table table-stripped">
        <thead>
        <tr>

            <g:sortableColumn property="name" title="${message(code: 'project.name.label', default: 'Name')}"/>

            <g:sortableColumn property="conceptnote"
                              title="${message(code: 'project.conceptnote.label', default: 'Concept Note')}"/>

            <g:sortableColumn property="country" title="${message(code: 'project.country.label', default: 'Country')}"/>

            <g:sortableColumn property="status" title="${message(code: 'project.status.label', default: 'Status')}"/>

            <th class="preview">Preview</th>

        </tr>
        </thead>
        <tfoot>
        <tr>
            <td colspan='6'>
                Showing
                <input type='text' class='input-tiny' value='10'>
                of 50 results
            </td>
        </tr>
        </tfoot>
        <tbody id="proj-list">
        <g:render template="listitem"/>
        </tbody>
    </table>

</div>
<g:render template="modals" />

<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {

        var countries = new Array("Afganistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Brazil", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo (Republic of)", "Costa Rica", "Cote D'ivoire", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Korea (Democratic People's Republic", "Democratic Republic of the Congo", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Fiji", "Finalnd", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Rebublic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macedonia ",
        "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritus", "Mexico", "Micronesia (Federated States of)", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Republic of Korea", "Republic of Moldova", "Romania", "Russian Federation", "Rwanda", "Saint Kittis and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Swaziland", "Swden", "Switzerland", "Syrian Arab Republic", "Taijikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"
        );
        var codes = new Array("AF", "AL", "DZ", "AD", "AO", "AG", "AR", "AM", "AU", "AT", "AZ", "BS", "BH", "BD", "BB", "BY", "BE", "BZ", "BJ", "BT", "BO", "BA", "BW", "BR", "BN", "BG", "BF", "BI", "KH", "CM", "CA", "CV", "CF", "TD", "CL", "CN", "CO", "KM", "CG", "CR", "CI", "HR", "CU", "CY", "CZ", "KP", "CD", "DK", "DJ", "DM", "DO", "EC", "EG", "SV", "GQ", "ER", "EE", "ET", "FJ", "FI", "FR", "GA", "GM", "GE", "DE", "GH", "GR", "GD", "GT", "GN", "GW", "HT", "HN", "HU", "IS", "IN", "ID", "IR", "IQ", "IE", "IL", "IT", "JM", "JP", "JO", "KZ", "KE", "KI", "KW", "KG", "LA", "LV", "LB", "LS", "LR", "LY", "LI", "LT", "LU", "MK", "MG", "MW", "MY", "MV", "ML", "MT", "MH", "MR", "MU", "MX", "FM", "MC", "MN", "ME", "MA", "MZ", "MM", "NA", "NR", "NP", "NL", "NZ", "NI", "NE", "NG", "NO", "OM", "PK", "PW", "PA", "PG", "PY", "PE", "PH", "PL", "PT", "QA", "KR", "MD", "RO", "RU", "RW", "KN", "LC", "VC", "WS", "SM", "ST", "SA", "SN", "RS", "SC", "SL", "SG", "SK", "SI", "SB", "SO", "ZA", "SS", "ES", "LK", "SD", "SR", "SZ", "SE", "CH", "SY", "TJ", "TZ", "TH", "TL", "TG", "TO", "TT", "TN", "TR", "TM", "TV", "UG", "UA", "AE", "GB", "US", "UY", "UZ", "VU", "VE", "VN", "YE", "ZM", "ZW");

        init();
        $('.dropdown-toggle').dropdown();

        $(document).on('click', '#projects tbody td', function () {
            if ($(this).hasClass('preview')) {
                return;
            }
            $('#projects tr').removeClass('active');
            $(this).parent().addClass('active');

            // Get project description
            $.ajax({
                url: "${g.createLink(controller:'project', action:'showDesc')}",
                type: 'post',
                dataType: 'json',
                data: {id: $(this).parent().data('project-id')},
                success: function (data) {
                    $('#project-preview > #preview-description').html(data.description);
                },
                error: function (request, status, error) {
                    alert(error)
                },
                complete: function () {

                }
            });
        });

        function init() {
            $('td.preview').parent().addClass('active');

            for (var i = 0; i < countries.length; i++) {
                $(".bfh-countries").append(
                        "<option value='" + codes[i] + "'>" + countries[i] + "</option>");
            }
        }
    });
</script>
</body>
</html>
