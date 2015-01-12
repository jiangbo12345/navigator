<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>新华锐健康督导</title>

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
</head>
<body>

	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div class="row clearfix">
					<br> <br>
				</div>

				<div class="row clearfix">
					<div class="col-md-3 column"></div>
					<div class="col-md-6 column">
						<form class="form-horizontal" action="./updatePropDatum"
							method="POST"  enctype="multipart/form-data">
							<div class="form-group" style="text-align: center;">
								<label><font style="font-size: 40px;">宣教资料修改</font> </label> <br>
								<br>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label"><a
									class="frred">*</a>标题</label>
								<div class="col-sm-10">
									<input type="text" name="title" class="form-control"
										id="inputEmail3" value="${propDatum.title }">
									<input type="hidden" name="propDatumID" value="${propDatum.propDatumID }">
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label"><a
									class="frred">*</a>cdc机构</label>
								<div class="col-sm-10">
									<select id="inputCdcOrg" name="organID" class="form-control">
										<c:forEach var="cdcOrg" items="${list }">
											<option value="${cdcOrg.id }"
												<c:if test="${propDatum.organ.id==cdcOrg.id }">selected</c:if>>${cdcOrg.cdcOrgDesignation }
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label"><a
									class="frred">*</a>资料上传</label>
								<div class="col-sm-10">
									<input type="file" name="fileMp3" class="form-control"
										id="inputFileImage" value="${propDatum.datumName}" title="${propDatum.datumName}">
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label"><a
									class="frred">*</a>宣传语言</label>
								<div class="col-sm-10">
									<select name="language" id="language" class="form-control">
										<option value="Chinese" <c:if test="${propDatum.language=='Chinese' }">selected</c:if>>汉语
										<option value="Uighur" <c:if test="${propDatum.language=='Uighur' }">selected</c:if>>维语
										<option value="Azerbaijan" <c:if test="${propDatum.language=='Azerbaijan' }">selected</c:if>>阿塞拜疆语
										<option value="Russian" <c:if test="${propDatum.language=='Russian' }">selected</c:if>>俄语
										<option value="Kirgiz" <c:if test="${propDatum.language=='Kirgiz' }">selected</c:if>>柯尔克孜语
										<option value="Kazakh" <c:if test="${propDatum.language=='Kazakh' }">selected</c:if>>哈萨克语
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">备注</label>
								<div class="col-sm-10">
									<textarea rows="3" name="remarks" id="remarks" class="form-control" >${propDatum.remarks }</textarea>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10"
									style="text-align: center;">
									<button type="submit" class="btn btn-default"
										onClick="return closeAndRefresh();">修改</button>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="button" class="btn btn-default"
										onclick="cancel()">取消</button>
								</div>
							</div>
						</form>
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
				window.onunload = refreshParent;
				function refreshParent() {
					window.opener.location.reload();
				}
				function closeAndRefresh() {
					self.close();
					return true;
				}
			</script>
					</div>
					<div class="col-md-3 column"></div>
				</div>
			</div>
		</div>
	</div>
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
