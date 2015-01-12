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
						<h3 class="panel-title">执行备注</h3>
					</div>
					<div class="panel-body">
						<c:if test="${isok !=null}"><font style="color: red;">执行备注成功，请点击返回键返回</font></c:if>
						<form action="./execute" method="POST">
							<table class="table table-striped">
								<tr>
									<td><input type="hidden" name="planId" value="${planId }" />
									<input type="hidden" name="page" value="${page }" />
									<textarea rows="3" cols="10" name="comment" class="form-control"></textarea></td>
								</tr>
								<tr>
									<td>
										<button type="button" class="btn btn-default" onClick="window.close();">取消</button>&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="submit" class="btn btn-default" >提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-default" onclick="goBlock();">返回</button>
									</td>
								</tr>
							</table>
						</form>
						<script type="text/javascript">
						   function goBlock(){
							   if ('${page }'=='index') {
								   window.location.href='../doctor/index';
								}
							   if ('${page }'=='notakepatients') {
								   window.location.href='../doctor/notakepatients';
								}
							   if ('${page }'=='plans') {
								   window.location.href='../doctor/plans';
								}
							   if('${isok }' =='index'){
								   window.location.href='../doctor/index';
							   }
							   if ('${isok }'=='notakepatients') {
								   window.location.href='../doctor/notakepatients';
								}
							   if('${isok }' =='plans'){
								   window.location.href='../doctor/plans';
							   }
						   }
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>