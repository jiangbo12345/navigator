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
	<form class="form-horizontal" action="./saveCdcOrg" method="POST">
		<div class="form-group" style="text-align: center;">
			<label><font style="font-size: 40px;">CDC机构修改</font> </label> <br>
			<br>
		</div>
		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label"><a
				class="frred">*</a>CDC机构名称</label>
			<div class="col-sm-10">
				<input type="text" name="cdcOrgDesignation" class="form-control"
					id="inputEmail3" value="${cdcOrg.cdcOrgDesignation }"> <input
					type="hidden" name="id" value="${cdcOrg.id }">
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
									<c:if test="${provience.geogDesignation==cdcOrg.address.provience }">selected</c:if>>${provience.geogDesignation }
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
						<c:forEach var="city" items="${geographics }">
							<c:if test="${city.nodeRank ==2 }">
								<option value="${city.id }"
									<c:if test="${city.geogDesignation==cdcOrg.address.city }">selected</c:if>>${city.geogDesignation }
							</c:if>
						</c:forEach>
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
						<c:forEach var="district" items="${geographics }">
							<c:if test="${district.nodeRank ==3 }">
								<option value="${district.id }"
									<c:if test="${district.geogDesignation==cdcOrg.address.district }">selected</c:if>>${district.geogDesignation }
							</c:if>
						</c:forEach>
				</select>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10" style="text-align: center;">
				<button type="submit" class="btn btn-default"
					onClick="return closeAndRefresh();">修改</button>
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
			objOption.selected = true;
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
