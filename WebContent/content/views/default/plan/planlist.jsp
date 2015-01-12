<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<script type="text/javascript">
	// Popup window code
	function reloadData() {
		setTimeout(function() {
			window.location.reload();
		}, 1000);
	}
	function popupwindow(url) {
		var w = 700;
		var h = 1200;
		var title = "";
		var left = (screen.width / 2) - (w / 2);
		var top = (screen.height / 2) - (h / 2);
		return window
				.open(
						url,
						title,
						'directories=0,titlebar=0,toolbar=0,location=0,status=0,menubar=0,scrollbars=yes,resizable=yes, width='
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
		<div class="row clearfix">
			<hr />
			<div class="list-group">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<c:if test="${loginUser.role == 'PATIENT' }">
							   ${loginUser.userName }的监测计划
							    <a href="../patient/index"><span
						class="badge navbar-right">返回</span></a>
							</c:if>
							<c:if test="${loginUser.role == 'DOCTOR' }">
							   <c:if test="${rolechange }">
							     ${patient.userName }的监测计划
							    <a href="../patient/index"><span
						class="badge navbar-right">返回</span></a>
                               </c:if>
                               <c:if test="${!rolechange}">
                                 ${loginUser.userName }医生的工作计划
							    <a href="../doctor/index"><span
						class="badge navbar-right">返回</span></a>
                               </c:if>
                            </c:if>
							<a href="./addPlan?rolechange=${rolechange }">(+)</a>
						</h3>
					</div>
					<div class="list-group-item">
					
						<table class="table table-striped">
							<tbody>
								<tr>
									<th>类型</th>
									<th>标题</th>
									<th>开始日期</th>
									<th>备注</th>
									<th></th>
								</tr>
								<c:forEach var="plan" items="${plans }" varStatus="loop">
									<c:choose>
										<c:when test="${loop.index%2==0 }">
											<tr>
										</c:when>
										<c:otherwise>
											<tr class="success">
										</c:otherwise>
									</c:choose>
									<td>
										<c:choose>
											<c:when test="${plan.type =='Followup'}">
												随访
											</c:when>
											<c:when test="${plan.type =='Medicine'}">
												服药
											</c:when>
											<c:when test="${plan.type =='Sputum'}">
												痰检
											</c:when>
											<c:when test="${plan.type =='XRay'}">
												胸透
											</c:when>
											<c:when test="${plan.type =='Hypertension'}">
												血压
											</c:when>
											<c:when test="${plan.type =='Glucose'}">
												血糖
											</c:when>
										</c:choose>
									</td>
									<td><a href="../plan/getPlan?id=${plan.id }" >${plan.title }</a></td>
									<td>${plan.fromDate }</td>
									<td>${plan.comments }</td>
									<td>
									<c:set var="currentUserId">${loginUser.id}</c:set>
									<c:if test="${currentUserId eq plan.createBy }">
									<a  href="../plan/updaterPlan?id=${plan.id }&rolechange=${rolechange }"
							><span class="badge">修改</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a  onclick=" return confirm('确定删除检测计划么？')" href="../plan/deletePlan?id=${plan.id }&rolechange=${rolechange }">
							<span class="badge">删除</span></a></c:if></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />
