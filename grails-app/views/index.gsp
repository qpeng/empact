<%@ page import="empact.Project" %>


<!DOCTYPE html>
<html>
<head>
    <g:set var="projectInstanceList" value="${empact.Project.list()}" />
    <meta name="layout" content="main"/>
    <title>Welcome to EMPaCT</title>

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">

        google.load("visualization", "1", {packages: ["map"]});
        google.setOnLoadCallback(drawMap);
        function drawMap() {
            var data = new google.visualization.DataTable();
            var elems = document.getElementsByClassName('project-data');
            data.addColumn('string', 'Name');
            data.addColumn('string', 'Address');
            for (var i = 0; i < elems.length; i++) {
                var desc = elems[i].getElementsByClassName('country-desc').item(0).innerText;
                var name = elems[i].getElementsByClassName('country-name').item(0).innerText;
                data.addRow(new Array(name, desc));
            }
            var map = new google.visualization.Map(document.getElementById('map'));
            map.draw(data, {showTip: true, zoomLevel: 2});
        }
    </script>
</head>

<body>
<!-- BEGIN BODY CONTAINER -->

<div class='container'>
    <div class="img">
        %{--<img src="EMPaCT.jpg" class="img-rounded">--}%
    </div>

    <div class='main'>
        <div id='map' class='inline'></div>

        <!-- Ticker -->
        <div id='ticker' class='inline'>

        <g:each in="${projectInstanceList}" status="i" var ="newproj">

            <div class='project-snippet'>${newproj.name}</div>

       </g:each>

        </div>
    </div>
</div>
<ul class="hide project-list">
    <g:each in="${projectInstanceList}" status="i" var="proj">
        <li class="project-data">
            <div class="country-name">${proj.country}</div>
            <div class="country-desc">${proj.description}</div>
        </li>
    </g:each>
</ul>

<br><br>
<div class="hero-unit home-hero">
    <center><h2>EMPaCT</h2></center>
    <p>A description about what EMPaCT is could go here!</p>
</div>

<center>
    <div class="row-fluid">
        <div class="span12">
            <h2><p>Want to get involved?</p></h2>
        </div>
        <div class="span4">
            <h4>If you want to do research...</h4>
            <p>We are always looking for researchers to help with analyzing data and finding solutions.
            Whether you're an undergraduate student interested in global health, a post-graduate hoping to help save the world, Batman,
            or anything in between - we'd be glad to have you on board.
            Take a look at our Open Projects to see if our projects align with your interests.</p>
        </div>
        <div class="span3">
            <h4>If you're with an NGO...</h4>
            <p>NGO Officials are a very important peoples to the EMPaCT machine!</p>
        </div>
        <div class="span4">
            <h4>If you work for the WHO...</h4>
            <p>WHO Officials are very important to this whole process.
            Too bad Annabelle doesn't really know what they're going to do.
            Whoops.</p>
        </div>
    </div>
</center>
<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.dropdown-toggle').dropdown();
        relevant('guest');

        $(document).on('click', '#user-toggle li > a', function (event) {
            event.preventDefault();
            relevant($(this).attr('id'));
        });

        function relevant(id) {
            //Remove previous active
            $('#user-toggle li').removeClass('active');

            // Set active
            $('#user-toggle li > #' + id).parent().addClass('active');

            // Show all elements regardless of the user
            $("[data-forbidden-users]").show();

            // Hide the forbidden elements
            $("[data-forbidden-users*='" + id + "']").hide();
        }

        var timer1 = setInterval(function () {
            $('.project-snippet').animate({
                top: -79
            }, 500);
        }, 3000);

        var timer2 = setInterval(function () {
            $('.project-snippet').each(function (index) {
                $(this).css({
                    top: 0
                });
            });

            var elem = $('.project-snippet').first();

            $('#ticker').append(elem);
            elem.next().addClass('top');
        }, 4000);

    });
</script>
</body>
</html>
