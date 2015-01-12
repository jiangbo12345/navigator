<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<h3 class="panel-title">异常报告</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<tbody>
						<tr>
							<td><a href="./notakepatients?page=reports">服药(${numOfNoMedToday })</a></td>
						</tr>
						<tr class="success">
							<td><a href="./xrayabnormal?page=reports">胸片(${numOfXray })</a></td>
						</tr>
						<tr>
							<td><a href="./sputumabnormal?page=reports">痰检(${numOfSputum })</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />
