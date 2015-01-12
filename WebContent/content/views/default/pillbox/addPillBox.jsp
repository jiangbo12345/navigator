<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<jsp:include page='../common/header.jsp' />
<script>
	window.onunload = refreshParent;
	function refreshParent() {
		window.opener.location.reload();
	}
	function closeAndRefresh() {
		self.close();
		return true;
	}
</script>
<link href="../content/static/css/bootstrap/bootstrap.css"
	rel="stylesheet">

<body>
	<br>
	<div class="form-group" style="text-align: center;">
		<label><font style="font-size: 30px;">药&nbsp;盒&nbsp;添&nbsp;加</font>
		</label> <br> <br>
	</div>
	<form action="savePillBox" method="POST">
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">编号</label>
			<div class="col-sm-10">
				<input type="text" name="identifier" class="form-control"><br>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">版本</label>
			<div class="col-sm-10">
				<input type="text" name="version" class="form-control"><br>
			</div>
		</div>
		<input type="hidden" name="state" value="UNABLE"><input
			type="hidden" name="difference" value="add">
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">服务器地址</label>
			<div class="col-sm-10">
				<input type="text" name="serverAddress" class="form-control"><br>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">
				服务器端口</label>
			<div class="col-sm-10">
				<input type="text" name="serverPort" class="form-control"><br>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">服务器APN</label>
			<div class="col-sm-10">
				<input type="text" name="serverAPN" class="form-control"><br>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10" style="text-align: center;">
				<button type="submit" class="btn btn-default">添加</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-default" onclick="cancel()">取消</button>
			</div>
		</div>
	</form>
	<script type="text/javascript">
		function cancel() {
			if (confirm("您确定要取消并关闭本页吗？")) {
				window.opener = null;
				window.open('', '_self');
				window.close();
			} else {
			}
		}
	</script>
</body>
</html>