<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<style type="text/css">
	.select{
		width: 30%;
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
			<form action="../admin/searchPillBox" method="post">
			<label style="font-size: 16px;">药盒编号：</label><input name="identifier" class="select">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<label  style="font-size: 16px;">药盒状态：</label>
			<select name="state" class="select">
				<option value="">--请选择--
				<option value="UNABLE">未发放
				<option value="ENABLE">已发放
				<option value="REPAIR">维修中
				<option value="SCRAP">已报废
			</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="submit" value="搜索查询" class="btn btn-default">
			</form>
			<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
				<a href="../pillBox/add">药盒列表<span class="badge navbar-right">添加&nbsp;+</span></a>
				</h3>
			</div>
			<div class="list-group-item">
				<p class="list-group-item-text">
				<table class="table table-striped">
					<tr class="">
						<th>药盒编号</th>
						<th>药盒状态</th>
						<th></th>
					</tr>
					<c:forEach var="pillBox" items="${pillBoxList }" varStatus="loop">
						<c:choose>
							<c:when test="${loop.index%2==0 }">
								<tr>
							</c:when>
							<c:otherwise>
								<tr class="success">
							</c:otherwise>
						</c:choose>
						<td>${pillBox.identifier }</td>
						<td><c:if test="${pillBox.state =='UNABLE'}">未发放</c:if>
						<c:if test="${pillBox.state =='ENABLE'}">已发放</c:if>
						<c:if test="${pillBox.state =='REPAIR'}">维修中</c:if>
						<c:if test="${pillBox.state =='SCRAP'}">已报废</c:if>
						</td>
						<td>
						<a onclick="" href="../pillBox/update?identifier=${pillBox.identifier }"><span class="badge">修改</span></a></td>
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