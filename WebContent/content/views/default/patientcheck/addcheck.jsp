<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page='../common/header.jsp' />
<link href="../content/static/css/bootstrap/bootstrap.css"
	rel="stylesheet">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="../content/static/img/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="../content/static/img/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="../content/static/img/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="../content/static/img/apple-touch-icon-57-precomposed.png">
<link rel="shortcut icon" href="../content/static/img/favicon.png">

<script type="text/javascript"
	src="../content/static/js/lib/jquery.min.js"></script>
<script type="text/javascript"
	src="../content/static/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="../content/static/js/lib/scripts.js"></script>
<link href="../content/static/css/datetime/jquery-clockpicker.min.css"
	rel="stylesheet">
<link href="../content/static/css/datetime/jquery.datetimepicker.css"
	rel="stylesheet">
<script type="text/javascript"
	src="../content/static/js/datetime/bootstrap-clockpicker.min.js"></script>
<script type="text/javascript"
	src="../content/static/js/datetime/jquery.datetimepicker.js"></script>
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
<div class="row clearfix">
	<div class="col-md-6 column">
		<form class="form-horizontal" action="saveCheckRecord" method="POST"
			enctype="multipart/form-data">
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label"><a
					class="frred">*</a>检查项目</label>
				<div class="col-sm-10">
					<select name="checkType" class="form-control" id="inputCheckType"
						onchange="test()">
						<option value="Sputum" selected="selected">痰检
						<option value="XRay">胸片
					</select>
				</div>
			</div>
			<div class="form-group" id="XRay" style="display: none;">
				<label for="inputFileImage" class="col-sm-2 control-label"><a
					class="frred">*</a>胸片上传</label>
				<div class="col-sm-10">
					<input type="file" name="fileImage" class="form-control"
						id="inputFileImage">
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label"><a
					class="frred">*</a>检查日期</label>
				<div class="col-sm-10">
					<input type="text" name="checkDate" class="form-control"
						id="checkDate">
				</div>
			</div>
			<div class="form-group" id="Sputum">
				<label for="inputEmail3" class="col-sm-2 control-label"><a
					class="frred">*</a>检查结果</label>
				<div class="col-sm-10">
					<select name="result" class="form-control">
						<option value="NEGATIVE" selected="selected">涂阴
						<option value="POSITIVE">涂阳
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label"><a
					class="frred">*</a>备注</label>
				<div class="col-sm-10">
					<textarea rows="2" cols="10" name="remarks" class="form-control"></textarea>
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
			$('#checkDate').datetimepicker({
				lang : 'ch',
				timepicker : false,
				format : 'Y-m-d',
				formatDate : 'Y-m-d',
			});
			function test() {
				document.getElementById('XRay').style.display = 'none';
				document.getElementById('Sputum').style.display = 'none';
				var value = document.getElementById('inputCheckType').value;
				document.getElementById(value).style.display = 'block';
			}
			window.onload = function role() {
				if ("${isok}" == 'true') {
					closeAndRefresh();
				}
			}
		</script>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />