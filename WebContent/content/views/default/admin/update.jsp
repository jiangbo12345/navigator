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
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div class="row clearfix">
					<br> <br>
				</div>

				<div class="row clearfix">
					<div class="col-md-3 column"></div>
					<div class="col-md-6 column">
						<c:if test="${user ==null }">
							<div class="form-group" style="text-align: center;">
								<label><font style="font-size: 40px; color: red;">没有找到该用户！！</font>
								</label> <br> <br>
							</div>
						</c:if>
						<c:if test="${user !=null }">
							<form class="form-horizontal" action="update" method="POST">
								<div class="form-group" style="text-align: center;">
									<c:if test="${ user.role =='PATIENT'}">
										<label><font style="font-size: 40px;">病人信息修改</font> </label>
										<br>
										<br>
									</c:if>
									<c:if test="${ user.role =='DOCTOR'}">
										<label><font style="font-size: 40px;">医生信息修改</font> </label>
										<br>
										<br>
									</c:if>
									<c:if test="${ user.role =='CDC'}">
										<label><font style="font-size: 40px;">CDC信息修改</font> </label>
										<br>
										<br>
									</c:if>
								</div>
								<input type="hidden" name="id" value="${user.id }">
								<jsp:include page='updateUser.jsp' />
								<div class="form-group">
									<label for="inputPassword3" class="col-sm-2 control-label">角色</label>
									<div class="col-sm-10">
										<select name="role" class="form-control" required="required"
											onload=" role()">
											<c:if test="${ user.role =='PATIENT'}">
												<option value="PATIENT" selected="selected">患者</option>
											</c:if>
											<c:if test="${ user.role =='DOCTOR'}">
												<option value="DOCTOR" selected="selected">医生</option>
											</c:if>
											<c:if test="${ user.role =='CDC'}">
												<option value="CDC" selected="selected">CDC</option>
											</c:if>
										</select>
									</div>
								</div>

								<c:if test="${ user.role =='PATIENT'}">
									<jsp:include page='updatePatient.jsp' />
								</c:if>
								<c:if test="${ user.role =='DOCTOR'}">
									<jsp:include page='updateDoctor.jsp' />
								</c:if>
								<c:if test="${ user.role =='CDC'}">
									<jsp:include page='updateCDC.jsp' />
								</c:if>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10"
										style="text-align: center;">
										<button type="submit" class="btn btn-default"  onClick="">修改</button>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-default"
											onclick="cancel()">取消</button>
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
									function cancel() {
										window.location.href = "../index.jsp?backurl="
												+ window.location.href;
									}
									function checkformname() {
										var fname = document
												.getElementById("inputEmail3");
										var ftname = document
												.getElementById("sname");
										if (fname.value == ""
												|| fname.value.length<2||fname.value.length>10) {
											ftname.className = "frred";
											fname.focus();
											ftname.innerHTML = "× 请输入2-10位用户名，可包含数字、字母、下划线";
										} else {
											ftname.className = "fgren";
											ftname.innerHTML = "√用户名可用!";
										}
									}
									function checkpwd() {
										var fpwd = document
												.getElementById("inputPassword3");
										var ftpwd = document
												.getElementById("spwd");
										if (fpwd.value == ""
												|| fpwd.value.length<6||fpwd.value.length>20) {
											ftpwd.className = "frred";
											fpwd.focus();
											ftpwd.innerHTML = "× 请输入6-20位用户密码！";
										} else {
											ftpwd.className = "fgren";
											ftpwd.innerHTML = "√密码可用！"
										}
									}
									function rcheckpwd() {
										var fpwd = document
												.getElementById("inputPassword3");
										var frpwd = document
												.getElementById("inputPassword4");
										var ftrpwd = document
												.getElementById("srpwd");
										if (frpwd.value == "") {
											ftrpwd.className = "frred";
											frpwd.focus();
											ftrpwd.innerHTML = "× 请输入您的重复密码！"
										} else {
											if (frpwd.value != fpwd.value) {
												ftrpwd.className = "frred";
												fpwd.focus();
												ftrpwd.innerHTML = "× 俩次密码输入不一致，请重新输入！";
											} else {
												ftrpwd.className = "fgren";
												ftrpwd.innerHTML = " √ 密码输入正确"
											}
										}
									}
								</script>
							</form>
						</c:if>
					</div>
					<div class="col-md-3 column"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
