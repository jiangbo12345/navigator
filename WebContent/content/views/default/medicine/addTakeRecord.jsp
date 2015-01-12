<%@page import="java.util.Date"%>
<%@page import="com.xhr.entity.user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<link href="../content/static/css/bootstrap/bootstrap.css" rel="stylesheet">

<!-- Fav and touch icons -->
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../content/static/img/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="../content/static/img/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="../content/static/img/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed" href="../content/static/img/apple-touch-icon-57-precomposed.png">
<link rel="shortcut icon" href="../content/static/img/favicon.png">

<script type="text/javascript" src="../content/static/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="../content/static/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="../content/static/js/lib/scripts.js"></script>
<link href="../content/static/css/datetime/jquery-clockpicker.min.css"
	rel="stylesheet">
<link href="../content/static/css/datetime/jquery.datetimepicker.css"
	rel="stylesheet">
<script type="text/javascript"
	src="../content/static/js/datetime/bootstrap-clockpicker.min.js"></script>
<script type="text/javascript"
	src="../content/static/js/datetime/jquery.datetimepicker.js"></script>
<script>
	window.onunload = refreshParent;
	function refreshParent() {
		window.opener.reloadData();
	}
	function closeAndRefresh() {
		self.close();
		return true;
	}
</script>
</head>

<body>
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<br />
			</div>
			<div class="col-md-12 column">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">服药记录</h3>
					</div>
					<div class="panel-body">
						<form action="./saveTakeRecord" method="POST">
							<table class="table">
								<tr>
									<td>日期</td>
									<td><input type="text" name="executeDate" id="executeDate" class="form-control"></td>
								</tr>
								<tr>
									<td>时间</td>
									<td><input type="text" name="executeTime"  id="executeTime" class="form-control"></td>
								</tr>
								<tr>
									<td></td>
									<td><button type="submit" class="btn btn-default" onClick="return closeAndRefresh();">提交</button></td>
								</tr>

							</table>
						</form>
						<script type="text/javascript">
						$('#executeDate').datetimepicker({
							lang:'ch',
							timepicker:false,
							format:'Y-m-d',
							formatDate:'Y-m-d',
						});
						
					$('#executeTime').clockpicker({
						placement: 'bottom',
						align: 'left',
						autoclose: true,
						'default': <%=(new  Date()).getHours() %>+':'+<%=(new  Date()).getMinutes() %>
					});
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>