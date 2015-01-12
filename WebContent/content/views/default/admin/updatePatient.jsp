<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="../content/static/css/datetime/jquery-clockpicker.min.css"
	rel="stylesheet">
<link href="../content/static/css/datetime/jquery.datetimepicker.css"
	rel="stylesheet">
<script type="text/javascript"
	src="../content/static/js/datetime/bootstrap-clockpicker.min.js"></script>
<script type="text/javascript"
	src="../content/static/js/datetime/jquery.datetimepicker.js"></script>
<div id="PATIENT" style="display: block;">
	<div class="form-group">
		<label for="inputPhone" class="col-sm-2 control-label">姓名</label>
		<div class="col-sm-10">
			<input type="tel" id="inputPatientName" name="userName"
				class="form-control" value="${user.userName }">
		</div>
	</div>
	<div class="form-group">
		<label for="inputPhone" class="col-sm-2 control-label"><a
			class="frred">*</a>电话</label>
		<div class="col-sm-10">
			<input type="tel" id="inputPhone" name="phone" class="form-control"
				value="${user.phone }">
		</div>
	</div>
	<div class="form-group">
		<label for="inputIdentifier" class="col-sm-2 control-label"><a
			class="frred">*</a>身份证</label>
		<div class="col-sm-10">
			<input type="text" name="identifier" class="form-control"
				id="inputIdentifier" value="${user.identifier }" readonly="readonly">
		</div>
	</div>
	<div class="form-group">
		<label for="inputRegistrationDate" class="col-sm-2 control-label"><a
			class="frred">*</a>就诊日期</label>
		<div class="col-sm-10">
			<input type="text" name="registrationDate" class="form-control"
				id="inputRegistrationDate" value="${user.registrationDate }"
				onclick="dateInfoxxx('inputRegistrationDate');">
		</div>
	</div>
	<div class="form-group">
		<label for="inputFirstTakeDate" class="col-sm-2 control-label">首次服药日期</label>
		<div class="col-sm-10">
			<input type="text" name="firstTakeDate" class="form-control"
				id="inputFirstTakeDate"  value="${user.firstTakeDate }" onclick="dateInfoxxx('inputFirstTakeDate');">
		</div>
	</div>
	<div class="form-group">
		<label for="inputBirthDay" class="col-sm-2 control-label">出生日期</label>
		<div class="col-sm-10">
			<input type="text"  id="inputBirthDay" name="birthDay"
				class="form-control" value="${user.birthDay }"
				onclick="dateInfoxxx('inputBirthDay');">
		</div>
	</div>
	<div class="form-group">
		<label for="inputSex" class="col-sm-2 control-label">性别</label>
		<div class="col-sm-10">
			<input type="radio" id="inputSex" name="sex" value="m"
				<c:if test='${user.sex=="m"}'>checked</c:if>>男&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio"
				<c:if test="${user.sex=='w' }">checked</c:if> id="inputSex"
				name="sex" value="w" class="audio">女
		</div>
	</div>
	<div class="form-group">
		<label for="inputAddress" class="col-sm-2 control-label">地址</label>
		<div class="col-sm-10">
			<div class="form-group">
				<label for="inputSex" class="col-sm-2 control-label">省份</label>
				<div class="col-sm-10">
					<select id="inputProvience" name="provience" class="form-control">
						<option value="0"
							<c:if test="${user.address.provience=='0' }">selected</c:if>>新疆维吾尔自治区


						
						<option value="1"
							<c:if test="${user.address.provience=='1' }">selected</c:if>>北京

						
						<option value="2"
							<c:if test="${user.address.provience=='2' }">selected</c:if>>天津

						
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="inputSex" class="col-sm-2 control-label">地市</label>
				<div class="col-sm-10">
					<select id="inputCity" name="city" class="form-control">
						<option value="0"
							<c:if test="${user.address.city=='0' }">selected</c:if>>乌鲁木齐


						
						<option value="1"
							<c:if test="${user.address.city=='1' }">selected</c:if>>北京

						
						<option value="2"
							<c:if test="${user.address.city=='2' }">selected</c:if>>天津

						
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="inputSex" class="col-sm-2 control-label">区县</label>
				<div class="col-sm-10">
					<select id="inputDistrict" name="district" class="form-control">
						<option value="0"
							<c:if test="${user.address.district=='0' }">selected</c:if>>新市区


						
						<option value="1"
							<c:if test="${user.address.district=='1' }">selected</c:if>>开发区


						
						<option value="2"
							<c:if test="${user.address.district=='2' }">selected</c:if>>天山区


						
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="inputSex" class="col-sm-2 control-label">街道</label>
				<div class="col-sm-10">
					<input id="inputAddress" type="text" name="street"
						class="form-control" value="${user.address.street }">
				</div>
			</div>
			<div class="form-group">
				<label for="inputSex" class="col-sm-2 control-label">街道号</label>
				<div class="col-sm-10">
					<input id="inputAddress" type="text" name="streetNo"
						class="form-control" value="${user.address.streetNo }">
				</div>
			</div>
			<div class="form-group">
				<label for="inputSex" class="col-sm-2 control-label">小区</label>
				<div class="col-sm-10">
					<input id="inputAddress" type="text" name="place"
						class="form-control" value="${user.address.place }">
				</div>
			</div>
			<div class="form-group">
				<label for="inputSex" class="col-sm-2 control-label">楼号</label>
				<div class="col-sm-10">
					<input id="inputAddress" type="text" name="building"
						class="form-control" value="${user.address.building }">
				</div>
			</div>
			<div class="form-group">
				<label for="inputSex" class="col-sm-2 control-label">单元号</label>
				<div class="col-sm-10">
					<input id="inputAddress" type="text" name="unit"
						class="form-control" value="${user.address.unit }">
				</div>
			</div>
			<div class="form-group">
				<label for="inputSex" class="col-sm-2 control-label">房间号</label>
				<div class="col-sm-10">
					<input id="inputAddress" type="text" name="room"
						class="form-control" value="${user.address.room }">
				</div>
			</div>
		</div>
	</div>
</div>
