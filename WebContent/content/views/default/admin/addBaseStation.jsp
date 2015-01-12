<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<link href="../content/static/css/bootstrap/bootstrap.css"
	rel="stylesheet">
<body>
	<form class="form-horizontal" action="./addBaseStation" method="POST">
		<div class="form-group" style="text-align: center;">
			<label><font style="font-size: 40px;">基站信息添加</font> </label> <br>
			<br>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>LAC</label>
			<div class="col-sm-10">
				<input type="text" name="lac" class="form-control" id="inputEmail3">
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>CELL</label>
			<div class="col-sm-10">
				<input type="text" name="cell" class="form-control" id="inputEmail3">
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>经度</label>
			<div class="col-sm-10">
				<input type="text" name="longitude" class="form-control"
					id="inputEmail3">
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>纬度</label>
			<div class="col-sm-10">
				<input type="text" name="latitude" class="form-control"
					id="inputEmail3">
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>基站地址</label>
			<div class="col-sm-10">
				<input type="text" name="location" class="form-control"
					id="inputEmail3">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10" style="text-align: center;">
				<button type="submit" class="btn btn-default"
					onClick="return closeAndRefresh();">添加</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-default" onclick="cancel()">取消</button>
			</div>
		</div>
	</form>
	<script type="text/javascript">
		function cancel() {
			window.location.href = "../index.jsp?backurl="
					+ window.location.href;
		}
		window.onunload = refreshParent;
		function refreshParent() {
			window.opener.location.reload();
		}
		function closeAndRefresh() {
			self.close();
			return true;
		}
	</script>
</body>
</html>
