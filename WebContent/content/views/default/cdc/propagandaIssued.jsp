<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<jsp:include page='../cdc/noticeNav.jsp' />
<style type="text/css">
	.select{
		width: 100%;
  height: 34px;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.428571429;
  color: #555555;
  vertical-align: middle;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #cccccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
  -webkit-transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
          transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
	}
</style>
<script type="text/javascript">
	// Popup window code
	function popupWindow(url) {
		popupWindow = window
				.open(
						url,
						'popUpWindow',
						'height=600,width=600,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
	}
</script>
<div class="row clearfix">
	<div class="col-md-12 column">&nbsp;</div>
</div>
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="list-group">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
				<a href="addIssued">宣教下发<span class="badge navbar-right">添加&nbsp;+</span></a>
				</h3>
			</div>
			<div class="list-group-item">
				<p class="list-group-item-text">
				<table class="table table-striped">
					<tr class="">
						<th>cdc</th>
						<th>下发时间</th>
						<th>地市</th>
						<th>区县</th>
						<th>街道</th>
						<th></th>
					</tr>
					<c:forEach var="datum" items="${list }" varStatus="loop">
						<c:choose>
							<c:when test="${loop.index%2==0 }">
								<tr>
							</c:when>
							<c:otherwise>
								<tr class="success">
							</c:otherwise>
						</c:choose>
						<td>${datum.cdc.userName} </td>
						<td>${datum.issuedDate }</td>
						<td>${datum.address.city}</td>
						<td>${datum.address.district}</td>
						<td>${datum.address.street}</td>
						<td>
						<a onclick="" href="../cdc/deleteIssued?propIssuedID=${datum.propIssuedID } "><span class="badge">删除</span></a></td>
						</tr>
					</c:forEach>
				</table>
				</p>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />