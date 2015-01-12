<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<link href="../content/static/css/bootstrap/bootstrap.css"
	rel="stylesheet">
<style>
.frred {
	color: #FF0000;
	font-size: 12px;
}

.frbule {
	color: #0066CC;
	font-size: 12px;
}

.fgren {
	color: #339933;
	font-size: 12px;
}
</style>
</head>
<body>
	<form class="form-horizontal" action="./addPropDatum" method="POST"
		enctype="multipart/form-data">
		<div class="form-group" style="text-align: center;">
			<label><font style="font-size: 40px;">宣教资料添加</font> </label> <br>
			<br>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>标题</label>
			<div class="col-sm-10">
				<input type="text" name="title" class="form-control"
					id="inputEmail3">
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>cdc机构</label>
			<div class="col-sm-10">
				<select id="inputCdcOrg" name="organID" class="form-control">
					<c:forEach var="cdcOrg" items="${list }">
						<option value="${cdcOrg.id }">${cdcOrg.cdcOrgDesignation }
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>资料上传</label>
			<div class="col-sm-10">
				<input type="file" name="fileMp3" class="form-control"
					id="inputFileImage">
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>督导语言</label>
			<div class="col-sm-10">
				<select name="language" id="language" class="form-control">
					<option value="Chinese">汉语
					<option value="Uighur">维语
					<option value="Azerbaijan">阿塞拜疆语
					<option value="Russian">俄语
					<option value="Kirgiz">柯尔克孜语
					<option value="Kazakh">哈萨克语
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">备注</label>
			<div class="col-sm-10">
				<textarea rows="3" name="remarks" id="remarks" class="form-control"></textarea>
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
		function dateInfoxxx(obj) {
			var date = obj;
			$('#' + date).datetimepicker({
				lang : 'ch',
				timepicker : false,
				format : 'Y-m-d',
				formatDate : 'Y-m-d',
			});
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
