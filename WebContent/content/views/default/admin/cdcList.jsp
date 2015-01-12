<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
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
	<jsp:include page='menu.jsp' />
	<div class="col-md-10 column">
		<div class="list-group">
			<form action="../admin/searchCDC" method="post">
			<table class="table table-striped">
			<tr class="">
			<th>CDC</th>
			<td><input name="cdcName" class="select"></td>
			<th>地市</th>
			<td>
			<input name="city" class="select"></td>
			<th>区县</th>
			<td>
			<input name="district" class="select"></td>
			<th><input type="submit" value="搜索" class="btn btn-default"></th>
			</tr>
			</table>
			</form>
			<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
				<a href="addCdc">CDC列表<span class="badge navbar-right">添加&nbsp;+</span></a>
				</h3>
			</div>
			<div class="list-group-item">
				<p class="list-group-item-text">
				<table class="table table-striped">
					<tr class="">
						<th>CDC姓名</th>
						<th>地市</th>
						<th>区县</th>
						<th>电话</th>
						<th></th>
					</tr>
					<c:forEach var="cdc" items="${list }" varStatus="loop">
						<c:choose>
							<c:when test="${loop.index%2==0 }">
								<tr>
							</c:when>
							<c:otherwise>
								<tr class="success">
							</c:otherwise>
						</c:choose>
						<td>${cdc.userName }</td>
						<td>${cdc.address.city }
						</td>
						<td>${cdc.address.district }
						</td>
						<td>${cdc.phone }
						</td>
						<td>
						<a onclick="" href="../admin/updateCDC?id=${cdc.id }"><span class="badge">修改</span></a></td>
						</tr>
					</c:forEach>
				</table>
				</p>
			</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />