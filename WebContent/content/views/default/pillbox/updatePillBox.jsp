<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

</head>
<body>
	<br>
	<div class="form-group" style="text-align: center;">
		<label><font style="font-size: 30px;">药&nbsp;盒&nbsp;业&nbsp;务&nbsp;更&nbsp;正</font>
		</label> <br> <br>
	</div>
	<form action="savePillBox" method="POST">
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">编号</label>
			<div class="col-sm-10">
				<input type="text" readonly="readonly" name="identifier"
					class="form-control" value="${pillBox.identifier}"> <br>
			</div>
		</div>
		<div class="form-group">
			<label for="inputPassword3" class="col-sm-2 control-label">药盒状态</label>
			<div class="col-sm-10">
				<select name="state" class="form-control">
					<c:if test="${pillBox.state=='UNABLE'}">
						<option value="UNABLE" selected="selected">--请选择--
					</c:if>
					<c:if test="${pillBox.state=='ENABLE'}">
						<option value="ENABLE" selected="selected">--请选择--
						<option value="REPAIR">申请维修
						<option value="SCRAP">报废处理
					</c:if>
					<c:if test="${pillBox.state=='REPAIR'}">
						<option value="REPAIR" selected="selected">--请选择--
						<option value="UNABLE">维修成功
						<option value="SCRAP">报废处理
					</c:if>
					<c:if test="${pillBox.state=='SCRAP'}">
						<option value="SCRAP" selected="selected">--产品已报废--
					</c:if>
				</select><br>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">版本</label>
			<div class="col-sm-10">
				<input type="hidden" name="difference" value="update"> <input
					type="text" name="version" class="form-control" readonly="readonly"
					value="${pillBox.version}"><br>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">服务器地址</label>
			<div class="col-sm-10">
				<input type="text" name="serverAddress" readonly="readonly"
					class="form-control" value="${pillBox.serverAddress}"> <br>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">
				服务器端口</label>
			<div class="col-sm-10">
				<input type="text" name="serverPort" readonly="readonly"
					class="form-control" value="${pillBox.serverPort}"> <br>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">服务器APN</label>
			<div class="col-sm-10">
				<input type="text" name="serverAPN" readonly="readonly"
					class="form-control" value="${pillBox.serverAPN}"><br>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10" style="text-align: center;">
				<button type="submit" class="btn btn-default">确认更正</button>
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