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
	<form class="form-horizontal" action="./addHospital" method="POST">
		<div class="form-group" style="text-align: center;">
			<label><font style="font-size: 40px;">医院信息添加</font> </label> <br>
			<br>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>医院名称</label>
			<div class="col-sm-10">
				<input type="text" name="hospitalDesignation" class="form-control"
					id="inputEmail3" value="${hospital.hospitalDesignation }">
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>cdc机构</label>
			<div class="col-sm-10">
				<select id="inputCdcOrg" name="cdcOrgID" class="form-control">
					<c:forEach var="cdcOrg" items="${list }">
						<option value="${cdcOrg.id }"
							<c:if test="${hospital.cdcOrganization.id==cdcOrg.id }">selected</c:if>>${cdcOrg.cdcOrgDesignation }
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>省份</label>
			<div class="col-sm-10">
				<select name="provience" class="form-control"
					onchange="checkCity(this)" id="provience">
					<option value="-1" selected="selected">----省份----
						<c:forEach var="provience" items="${geographics }">
							<c:if test="${provience.nodeRank ==1 }">
								<option value="${provience.id }"
									<c:if test="${provience.geogDesignation==hospital.address.provience }">selected</c:if>>${provience.geogDesignation }
							</c:if>
						</c:forEach>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>地市</label>
			<div class="col-sm-10">
				<select name="city" class="form-control"
					onchange="checkDistrict(this)" id="city">
					<option value="-1">----地市----
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>区县</label>
			<div class="col-sm-10">
				<select name="district" onchange="checkStreet(this)" id="district"
					class="form-control">
					<option value="-1">----区县----
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>街道</label>
			<div class="col-sm-10">
				<select name="street" id="street" class="form-control">
					<option value="-1">----街道----
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>社区</label>
			<div class="col-sm-10">
				<input type="text" name="place" class="form-control"
					id="inputEmail3" value="${hospital.address.place }">
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
		function checkCity(obj) {
			var Code = obj.value;
			var citySelect = document.getElementById('city');
			var num = citySelect.options.length;
			for (i = num - 1; i >= 0; i--) {
				citySelect.remove(i);
			}
			var districtSelect = document.getElementById('district');
			var numd = districtSelect.options.length;
			for (i = numd - 1; i >= 0; i--) {
				districtSelect.remove(i);
			}
			var objOption = new Option("----区县----", '-1');
			districtSelect.options[districtSelect.options.length] = objOption;
			var objOption = new Option("----地市----", '-1');
			citySelect.options[citySelect.options.length] = objOption;
			<c:forEach items="${geographics }" var="city">
			if ('${city.parentNode }' == Code && '${city.nodeRank}' == 2) {
				var objOption = new Option("${city.geogDesignation }",
						'${city.id}');
				citySelect.options[citySelect.options.length] = objOption;
			}
			</c:forEach>
		}
		function checkDistrict(obj) {
			var Code = obj.value;
			var districtSelect = document.getElementById('district');
			var num = districtSelect.options.length;
			for (i = num - 1; i >= 0; i--) {
				districtSelect.remove(i);
			}
			var objOption = new Option("----区县----", '-1');
			districtSelect.options[districtSelect.options.length] = objOption;
			<c:forEach items="${geographics }" var="district">
			if ('${district.parentNode }' == Code
					&& '${district.nodeRank}' == 3) {
				var objOption = new Option("${district.geogDesignation }",
						'${district.id}');
				districtSelect.options[districtSelect.options.length] = objOption;
			}
			</c:forEach>
		}
		function checkStreet(obj) {
			var Code = obj.value;
			var streetSelect = document.getElementById('street');
			var num = streetSelect.options.length;
			for (i = num - 1; i >= 0; i--) {
				streetSelect.remove(i);
			}
			var objOption = new Option("----街道----", '-1');
			streetSelect.options[streetSelect.options.length] = objOption;
			<c:forEach items="${geographics }" var="street">
			if ('${street.parentNode }' == Code && '${street.nodeRank}' == 4) {
				var objOption = new Option("${street.geogDesignation }",
						'${street.id}');
				streetSelect.options[streetSelect.options.length] = objOption;
			}
			</c:forEach>
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
