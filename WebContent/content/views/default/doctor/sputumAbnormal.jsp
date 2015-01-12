<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
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
				<a href="../doctor/${page }">痰检异常病人列表<span
								class="badge navbar-right">返回</span></a></h3>
			</div>
			<div class="panel-body">
				<p class="list-group-item-text">
				<table class="table table-striped">
					<tr class="">
						<th>姓名</th>
						<th>痰检时间</th>
						<th>痰检结果</th>
						<th></th>
					</tr>
					<c:forEach var="sputumAbnormal" items="${sputumAbnormalList }" varStatus="loop">
						<c:choose>
							<c:when test="${loop.index%2==0 }">
								<tr>
							</c:when>
							<c:otherwise>
								<tr class="success">
							</c:otherwise>
						</c:choose>
						<td>${sputumAbnormal.patient.userName }</td>
						<td>${sputumAbnormal.checkDate }</td>
						<td><c:if test="${sputumAbnormal.result =='NEGATIVE' }">涂阴</c:if>
												<c:if test="${sputumAbnormal.result =='POSITIVE' }">涂阳</c:if></td>
						<td>
						<a href="../patientcheck/deletePatientCheck?id=${sputumAbnormal.id }" onclick=" return confirm('确定不再查看检查结果？')"><span class="badge">－</span></a></td>
						</tr>
					</c:forEach>
				</table>
				</p>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />