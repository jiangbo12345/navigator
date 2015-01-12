<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	<div class="col-md-2 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">异常报告</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<tbody>
						<tr>
							<td><a href="./notakepatients?page=index">服药(${numOfNoMedToday })</a></td>
						</tr>
						<tr class="success">
							<td><a href="./xrayabnormal?page=index">胸片(${numOfXray })</a></td>
						</tr>
						<tr>
							<td><a href="./sputumabnormal?page=index">痰检(${numOfSputum })</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">统计报告</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<tbody>
						<tr>
							<td><a href="./index">服药</a></td>
						</tr>
						<tr class="success">
							<td><a href="#">胸片</a></td>
						</tr>
						<tr>
							<td><a href="#">痰检</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="col-md-5 column">
		<c:if test="${list != null || fn:length(notices) > 0}">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					公告与消息
				</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>消息类型</th>
							<th>发送日期</th>
							<th>消息内容</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="notice" items="${notices }" varStatus="loop">
							<c:choose>
								<c:when test="${loop.index%2==0 }">
									<tr>
								</c:when>
								<c:otherwise>
									<tr class="success">
								</c:otherwise>
							</c:choose>
							<td>
							<c:if test="${notice.noticeType=='text' }">文字</c:if>
							<c:if test="${notice.noticeType=='voice' }">语音</c:if>
							<c:if test="${notice.noticeType=='news' }">图文</c:if>
							</td>
							<td>${notice.noticeDate }</td>
							<td>
							<c:if test="${notice.noticeType=='text' }">
							<a
										href="../doctor/getNotice?id=${notice.noticeId }&noticeType=text">
										<c:if test="${!fn:contains(notice.content,'<') }">
										<c:if test="${fn:length(notice.content)<=10}">${notice.content }</c:if>
											<c:if test="${fn:length(notice.content )>10}">${fn:substring(notice.content, 0, 8)}.....</c:if>
										</c:if>
											<c:if test="${fn:contains(notice.content,'<') }">${notice.content }</c:if>
										</a>
							</c:if>
							<c:if test="${notice.noticeType=='voice' }">
								<a
										href="../doctor/getNotice?id=${notice.noticeId }&noticeType=voice"><c:if
												test="${fn:length(notice.path )<=10}">${fn:substringAfter(notice.path,'/content/static/img/cdc/dddd/') }</c:if>
											<c:if test="${fn:length(notice.path )>10}">${fn:substring(fn:substringAfter(fn:substringAfter(notice.path,"/content/static/img/cdc/"),'/' ), 0, 12)}.....</c:if></a>
							</c:if>
							<c:if test="${notice.noticeType=='news' }">
							<c:forEach items="${articles }" var="article">
											<c:if test="${article.notice.noticeId==notice.noticeId}">
												<a
													href="../doctor/getNotice?id=${notice.noticeId }&noticeType=news">
													<c:if test="${fn:length(article.title )<=10}">${article.title }</c:if>
													<c:if test="${fn:length(article.title)>10}">${fn:substring(article.title, 0, 11)}.....</c:if>
												</a>
											</c:if>
										</c:forEach>
							</c:if>
							</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		</c:if>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					本周计划(随访)<a href="../plan/listplan" class="navbar-right">&gt;&gt;</a>
				</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>标题</th>
							<th>备注</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="notExcetuedPlan" items="${notExcetuedPlans }" varStatus="loop">
							<c:choose>
								<c:when test="${loop.index%2==0 }">
									<tr>
								</c:when>
								<c:otherwise>
									<tr class="success">
								</c:otherwise>
							</c:choose>
							<td>${notExcetuedPlan.title }</td>
							<td>${notExcetuedPlan.comments }</td>
							<td><a href="../plan/execute?planId=${notExcetuedPlan.id }&page=index"><span class="badge">处理</span></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">待办事项</h3>
			</div>
			<div class="panel-body">
				<form action="addToDoMessage" method="POST">
					<textarea rows="3" cols="10" name="todoMessage" class="form-control"></textarea>
					例：9月20号9点去医院痰检<br /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;每天/周日9点服药<br />
					<button type="submit" class="btn btn-default">添加</button>
				</form>
				<table class="table table-striped">
					<tbody>
						<c:forEach var="todoMessage" items="${toDoMessages }" varStatus="loop">
							<c:choose>
								<c:when test="${loop.index%2==0 }">
									<tr>
								</c:when>
								<c:otherwise>
									<tr class="success">
								</c:otherwise>
							</c:choose>
							<td>${todoMessage.content }<c:if test="${empty todoMessage.from }">(系统)</c:if></td>
							<td><c:if test="${not empty todoMessage.from }">
									<a href="deleteToDoMessage?id=${todoMessage.id }" onclick=" return confirm('确定删除该待办事项？')"><span class="badge">－</span></a>
								</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="col-md-5 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					督导的患者&nbsp;<input type="text" />
				</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>病人姓名</th>
							<th>随访电话</th>
							<th>是否服药</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="patient" items="${patients }" varStatus="loop">
							<c:choose>
								<c:when test="${loop.index%2==0 }">
									<tr>
								</c:when>
								<c:otherwise>
									<tr class="success">
								</c:otherwise>
							</c:choose>
							<td><a href="./patient?id=${patient.patientId}">${patient.patientName }</a></td>
							<td>${patient.phone }</td>
							<td><c:if test="${patient.takenMedToday}">是</c:if> <c:if test="${!patient.takenMedToday}">否</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">患者关联</h3>
			</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form" action="relation" method="post">
					<div class="form-group">
						<label for="inputPatientName" class="col-sm-3 control-label">姓名</label>
						<div class="col-sm-9">
							<input type="text" name="patientName" class="form-control" id="patientName">
						</div>
					</div>
					<div class="form-group">
						<label for="inputIdentifier" class="col-sm-3 control-label">身份证</label>
						<div class="col-sm-9">
							<input type="text" name="identifier" class="form-control" id="inputIdentifier">
						</div>
					</div>
					<div class="form-group">
						<label for="inputTreatNo" class="col-sm-3 control-label">督导语言</label>
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
						<label for="inputPillBoxID" class="col-sm-3 control-label">设备编码</label>
						<div class="col-sm-9">
							<input type="text" name="pillBoxID" class="form-control" id="inputPillBoxID">
						</div>
					</div>
					<div class="form-group">
						<label for="inputPillBoxID" class="col-sm-3 control-label">确诊日期</label>
						<div class="col-sm-9">
							<input type="text" name="registrationDate" class="form-control" id="inputRegistrationDate"  onclick="dateInfoxxx('inputRegistrationDate')">
						</div>
					</div>
					<div class="form-group">
						<label for="inputPillBoxID" class="col-sm-3 control-label">服药日期</label>
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
