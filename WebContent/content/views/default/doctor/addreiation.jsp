<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<link href="../content/static/css/datetime/jquery-clockpicker.min.css"
	rel="stylesheet">
<link href="../content/static/css/datetime/jquery.datetimepicker.css"
	rel="stylesheet">
<script type="text/javascript"
	src="../content/static/js/datetime/bootstrap-clockpicker.min.js"></script>
<script type="text/javascript"
	src="../content/static/js/datetime/jquery.datetimepicker.js"></script>
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
						url,
						title,
						'directories=0,titlebar=0,toolbar=0,location=0,status=0,menubar=0,scrollbars=no,resizable=no, width='
								+ w
								+ ', height='
								+ h
								+ ', top='
								+ top
								+ ', left=' + left);
	}
</script>
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">患者关联</h3>
			</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form" action="saveRelation" method="post">
					<div class="form-group">
						<label for="inputPatientName" class="col-sm-2 control-label">姓名</label>
						<div class="col-sm-9">
							<input type="text" name="patientName" class="form-control" id="patientName">
						</div>
					</div>
					<div class="form-group">
						<label for="inputIdentifier" class="col-sm-2 control-label">身份证</label>
						<div class="col-sm-9">
							<input type="text" name="identifier" class="form-control" id="inputIdentifier">
						</div>
					</div>
					<div class="form-group">
						<label for="inputTreatNo" class="col-sm-2 control-label">督导语言</label>
						<div class="col-sm-9">
							<select name="language" id="language" class="form-control">
										<option value="Chinese">汉语
										<option value="Uighur">维语
										<option value="Azerbaijan">阿塞拜疆语
										<option value="Russian">俄语
										<option value="Kirgiz">柯尔克孜语
										<option value="Kazakh">哈萨克语
										<option value="Other">其它
									</select>
						</div>
					</div>
					<div class="form-group">
						<label for="inputPillBoxID" class="col-sm-2 control-label">设备编码</label>
						<div class="col-sm-9">
							<input type="text" name="pillBoxID" class="form-control" id="inputPillBoxID">
						</div>
					</div>
					<div class="form-group">
						<label for="inputPillBoxID" class="col-sm-2 control-label">确诊日期</label>
						<div class="col-sm-9">
							<input type="text" name="registrationDate" class="form-control" id="inputRegistrationDate"  onclick="dateInfoxxx('inputRegistrationDate')">
						</div>
					</div>
					<div class="form-group">
						<label for="inputPillBoxID" class="col-sm-2 control-label">服药日期</label>
						<div class="col-sm-9">
							<input type="text" name="firstTakeDate" class="form-control"  placeholder="（首次）" id="inputFirstTakeDate" onclick="dateInfoxxx('inputFirstTakeDate')">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-12">
							<button type="submit" class="btn btn-default">添加</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
<script type="text/javascript">
function dateInfoxxx(obj){
	var date = obj;
	$('#'+date).datetimepicker({
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		formatDate:'Y-m-d',
	});
}
</script>
</div>
<jsp:include page='../common/footer.jsp' />
