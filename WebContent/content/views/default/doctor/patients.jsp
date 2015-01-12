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
		<div class="list-group">
			<a class="list-group-item active"
				onclick="" href="addReiation">我的病人(+)</a>
			<div class="list-group-item">
					<c:forEach var="patient" items="${patients }" varStatus="loop">
						<table class="table table-striped">
							<tr>
								<td rowspan="3" width="156px;"><img alt="140x140"
									src="../content/static/img/zhangsan.jpeg"></td>
								<td style="vertical-align: middle;" >姓名：${patient.patientName }</td>
							</tr>
							<tr>
								<td  style="vertical-align: middle;"  class="success" >电话：${patient.phone }</td>
							</tr>
							<tr><td style="vertical-align: middle;"  class="success" >服药：<c:if test="${patient.takenMedToday}">是</c:if>
									<c:if test="${!patient.takenMedToday}">否</c:if></td>
									</tr>
						</table>
					</c:forEach>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />
