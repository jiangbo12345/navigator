<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<script type="text/javascript">
	function reloadData() {
		setTimeout(function() {
			window.location.reload();
		}, 1000);
	}
	// Popup window code
	function popupWindow(url) {
		popupWindow = window
				.open(
						url,
						'popUpWindow',
						'height=400,width=600,left=300,top=300,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
	}
</script>
<div class="row clearfix">
	<div class="col-md-10 column">
		<jsp:include page='patientNav.jsp' />
		<div class="row clearfix">
			<hr />
			<div class="col-md-12 column">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<a href="../patient/index">痰检纪录<span
								class="badge navbar-right">返回</span></a>
						</h3>
					</div>
					<div class="panel-body">
						<p class="list-group-item-text">
						<table class="table table-striped">
							<tr>
								<th>检测日期</th>
								<th>检测结果</th>
								<th>备注</th>
								<th></th>
							</tr>
							<c:forEach var="patientCheck" items="${checks }" varStatus="loop">
								<c:choose>
									<c:when test="${patientCheck.checkType=='Sputum' }">
										<c:choose>
											<c:when test="${loop.index%2==0 }">
												<tr>
											</c:when>
											<c:otherwise>
												<tr class="success">
											</c:otherwise>
										</c:choose>
										<td>${patientCheck.checkDate }</td>
										<td><c:if test="${patientCheck.result =='NEGATIVE' }">涂阴</c:if>
											<c:if test="${patientCheck.result =='POSITIVE' }">涂阳</c:if></td>
											<td>${patientCheck.remarks }</td>
										<td><a href="deletePatientCheck?id=${patientCheck.id }"
											onclick=" return confirm('确定删除该检查结果？')"><span
												class="badge">－</span></a></td>
										</tr>
									</c:when>
								</c:choose>
							</c:forEach>
						</table>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page='patientInfo.jsp' />
</div>
<jsp:include page='../common/footer.jsp' />
