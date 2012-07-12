<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>
成绩文件上传
</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet">
    <style>
      body {        
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>
    <link href="/assets/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->

  </head>

  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">
成绩文件上传
</a>
          <div class="btn-group pull-right">
            <% if logged_in? %>
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
              <i class="icon-user"></i> <%= current_user.login %>
              <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
              <li><a href="/welcome/person/<%= current_user.id %>">个人设置</a></li>
              <li class="divider"></li>
              <li><a href="/logout">退出</a></li>
            </ul>
            <% else %>
            <a class="btn" href="/login">登录</a>
            <% end %>
          </div>
          <div class="nav-collapse">
            <ul class="nav">
              <li <%= 'class="active"' if controller_name=='welcome' && action_name=='index' %> >
                <a href="/">首页</a></li>
              <li <%= 'class="active"' if controller_name=='welcome' && action_name=='help' %> >
                <a href="/welcome/help">帮助</a></li>
              <%#*<li><a href="#contact">Contact</a></li>%>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container" >
      <% if flash[:notice] %>
        <div id="notice" class="alert alert-success">
          <button class="close" data-dismiss="alert">×</button>
          <%= flash[:notice] %>
        </div>
      <% end %>
      <% if flash[:error] %>
      
        <div id="error" class="alert alert-error">
          <button class="close" data-dismiss="alert">×</button>
          <%= flash[:error] %>
        </div>
      <% end %>
      <%= yield %>
    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/assets/js/jquery-1.7.2.min.js"></script>
    <script src="/assets/js/bootstrap.min.js"></script>

  </body>
</html>
