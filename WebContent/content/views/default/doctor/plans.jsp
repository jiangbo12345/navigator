<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<link href="../content/static/css/datetime/jquery-clockpicker.min.css"
	rel="stylesheet">
<link href="../content/static/css/datetime/jquery.datetimepicker.css"
	rel="stylesheet">
<script type="text/javascript"
	src="../content/static/js/datetime/bootstrap-clockpicker.min.js"></script>
<script type="text/javascript"
	src="../content/static/js/datetime/jquery.datetimepicker.js"></script>
<script type="text/javascript">
	function reloadData() {
		setTimeout(function() {
			window.location.reload();
		}, 1000);
	}

	function popupwindow(url) {
		var w = 700;
		var h = 300;
		var title = "";
		var left = (screen.width / 2) - (w / 2);
		var top = (screen.height / 2) - (h / 2);
		return window
				.open(
						url,
						title,
						'directories=0,titlebar=0,toolbar=0,location=0,status=0,menubar=0,scrollbars=no,resizable=no, width='
								+ w
								+ ', height='
								+ h
								+ ', top='
								+ top
								+ ', left=' + left);
	}
</script>
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					本周计划(随访)
				</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>标题</th>
							<th>备注</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="notExcetuedPlan" items="${notExcetuedPlans }" varStatus="loop">
							<c:choose>
								<c:when test="${loop.index%2==0 }">
									<tr>
								</c:when>
								<c:otherwise>
									<tr class="success">
								</c:otherwise>
							</c:choose>
							<td>${notExcetuedPlan.title }</td>
							<td>${notExcetuedPlan.comments }</td>
							<td><a href="../plan/execute?planId=${notExcetuedPlan.id }&page=plans"><span class="badge">处理</span></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />
