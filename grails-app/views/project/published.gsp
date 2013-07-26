<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Published Findings</title>
</head>
<body>
<div class='container'>
    <center><h2>Published Findings</h2></center>

        <g:if statement>
    <!--If there are no publishd findings -->
    <div class="alert alert-info">
        <center>There are no published findings at this time.</center>
    </div>
    </g:if>

%{--    <!-- If there are published findings -->
    <g:elseif>
        SORTABLE TABLE HERE
    </g:elseif>--}%
</div>
</body>
</html>
