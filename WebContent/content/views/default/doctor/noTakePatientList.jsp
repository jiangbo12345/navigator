<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.xhr.entity.user.Patient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
					url);
}
</script>
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<a href="../doctor/${page }">未服药病人列表<span
						class="badge navbar-right">返回</span></a>
				</h3>
			</div>
			<div class="panel-body">
				<p class="list-group-item-text">
				<table class="table table-striped">
					<tr >
						<th>姓名</th>
						<th>服药时间</th>
						<th>电话</th>
						<th></th>
					</tr>
					<c:forEach var="plan" items="${noTakePatients }" varStatus="loop">
						<c:choose>
							<c:when test="${loop.index%2==0 }">
								<tr>
							</c:when>
							<c:otherwise>
								<tr class="success">
							</c:otherwise>
						</c:choose>
						<td>${plan.toUser.userName }</td>
						<%
						   Date a=new Date();
						   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						   request.setAttribute("a",sdf.format(a));
						 %>
						 <c:set var="i" value="${loop.index }"></c:set>
						<td>${a } &nbsp;${plan.times[loop.index-i]}</td>
						<td>
						<c:set var="isDo" value="0"></c:set>
						<c:forEach items="${patientList }" var="patient" varStatus="loop" >
							<c:if test="${isDo==0 }">
								<c:if test="${plan.toUser.id==patient.id }" >
										${patient.phone }
									<c:set var="isDo" value="1"></c:set>
								</c:if>
							</c:if>
						</c:forEach>
						</td>
						<td>
						<a href="../plan/execute?planId=${plan.id }&page=notakepatients"><span class="badge">处理</span></a></td>
						</tr>
					</c:forEach>
				</table>
				</p>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />