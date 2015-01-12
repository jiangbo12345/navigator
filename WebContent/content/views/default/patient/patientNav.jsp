<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript">
	function openNewPage(url) {
		window.location.href = url;
	}
</script>
<c:set var="currentUri" value="${pageContext.request.requestURI}"></c:set>
<c:set var="indexButton" value="btn-default" />
<c:set var="planButton" value="btn-default" />
<c:set var="messageButton" value="btn-select" />
<c:set var="emrButton" value="btn-default" />

<c:if test="${fn:contains(currentUri, 'index')}">
	<c:set var="indexButton" value="btn-select" />
	<c:set var="messageButton" value="btn-default" />
</c:if>

<c:if test="${fn:contains(currentUri, 'plan')}">
	<c:set var="planButton" value="btn-select" />
	<c:set var="messageButton" value="btn-default" />
</c:if>

<c:if test="${fn:contains(currentUri, 'emr')}">
	<c:set var="emrButton" value="btn-select" />
	<c:set var="messageButton" value="btn-default" />
</c:if>

<div class="row clearfix">
	<div class="col-md-6 column">
		<div class="btn-group btn-group-md">
			<button class="btn ${indexButton} " type="button"
				onclick="openNewPage('./index')">首页</button>
			<c:if test="${loginUser.role eq 'PATIENT' }">
			     <button class="btn ${planButton}" type="button"
				onclick="openNewPage('../plan/listplan')">检查监测计划</button>
			</c:if>
			<c:if test="${loginUser.role eq 'DOCTOR' }">
                 <button class="btn ${planButton}" type="button"
                onclick="openNewPage('../plan/listplan?rolechange=true')">检查监测计划</button>
            </c:if>
			<button class="btn ${messageButton}" type="button"
				onclick="openNewPage('./ruleRecord')">通知预警</button>
			<button class="btn ${emrButton}" type="button"
				onclick="openNewPage('./emr')">电子病历</button>
		</div>
	</div>
</div>

