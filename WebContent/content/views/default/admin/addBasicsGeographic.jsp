<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<link href="../content/static/css/bootstrap/bootstrap.css"
	rel="stylesheet">
<script type="text/javascript">
	// Popup window code
	function popupWindow(url) {
		popupWindow = window
				.open(
						url,
						'popUpWindow',
						'height=600,width=600,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
	}
</script>

<form action="savebasgeog" method="post">
	<div class="form-group" style="text-align: center;">
		<label><font style="font-size: 40px;">区划地名信息</font> </label> <br>
		<br>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"><a
			class="frred">*</a>省份</label>
		<div class="col-sm-10">
			<select name="provience" class="form-control"
				onchange="checkCity(this)" id="provience"
				onkeydown="catch_keydown(this);" onkeypress="catch_press(this);"
				onblur="forProvienceText(this)">
				<option value="-1" selected="selected">----省份----
					<c:forEach var="provience" items="${list }">
						<c:if test="${provience.nodeRank ==1 }">
							<option value="${provience.id }"
								<c:if test="${provience.geogDesignation==hospital.address.provience }">selected</c:if>>${provience.geogDesignation }
						</c:if>
					</c:forEach>
			</select> <input type="hidden" name="provienceText" id="provienceText"><br>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"><a
			class="frred">*</a>地市</label>
		<div class="col-sm-10">
			<select name="city" class="form-control"
				onchange="checkDistrict(this)" id="city"
				onkeydown="catch_keydown(this);" onkeypress="catch_press(this);"
				onblur="forCityText(this)">
				<option value="-1">----地市----
			</select> <input type="hidden" name="cityText" id=cityText><br>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"><a
			class="frred">*</a>区县</label>
		<div class="col-sm-10">
			<select name="district" onchange="checkStreet(this)" id="district"
				class="form-control" onkeydown="catch_keydown(this);"
				onkeypress="catch_press(this);" onblur="forDistrictText(this)">
				<option value="-1">----区县----
			</select> <input type="hidden" name="districtText" id=districtText><br>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"><a
			class="frred">*</a>街道</label>
		<div class="col-sm-10">
			<select name="street" id="street" class="form-control"
				onkeydown="catch_keydown(this);" onkeypress="catch_press(this);"
				onblur="forStreetText(this)">
				<option value="-1">----街道----
			</select> <input type="hidden" name="streetText" id=streetText><br>
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10" style="text-align: center;">
			<button type="submit" class="btn btn-default"
				onClick="return closeAndRefresh();">添加</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-default"
				onclick="closeAndRefresh()">取消</button>
		</div>
	</div>
</form>
<script language="JavaScript">
	function forStreetText(sel) {
		var street = document.getElementById("streetText");
		street.value = sel.options[sel.selectedIndex].text;
	}
	function forDistrictText(sel) {
		var district = document.getElementById("districtText");
		district.value = sel.options[sel.selectedIndex].text;
	}
	function forCityText(sel) {
		var cityText = document.getElementById("cityText");
		cityText.value = sel.options[sel.selectedIndex].text;
	}
	function forProvienceText(sel) {
		var provienceText = document.getElementById("provienceText");
		provienceText.value = sel.options[sel.selectedIndex].text;
	}
	function catch_keydown(sel) {
		switch (event.keyCode) {
		case 13:
			//Enter;

			sel.options[sel.length] = new Option("", "", false, true);
			sel.options[sel.selectedIndex].text = sel.options[sel.selectedIndex].text
					+ String.fromCharCode(event.keyCode);
			sel.options[sel.selectedIndex].value = sel.options[sel.selectedIndex].text;
			event.returnValue = false;
			break;
		case 27:
			//Esc;
			alert("text:" + sel.options[sel.selectedIndex].text + ", value:"
					+ sel.options[sel.selectedIndex].value + ";");
			event.returnValue = false;
			break;
		case 8:
			//Back Space;
			var s = sel.options[sel.selectedIndex].text;
			sel.options[sel.selectedIndex].text = s.substr(0, s.length - 1);
			event.returnValue = false;
			break;
		}

	}
	function catch_press(sel) {
		sel.options[sel.selectedIndex].text = sel.options[sel.selectedIndex].text
				+ String.fromCharCode(event.keyCode);
		sel.options[sel.selectedIndex].value = sel.options[sel.selectedIndex].value;
		event.returnValue = false;
	}
</script>
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
		var objOption = new Option("----区县----", -1);
		districtSelect.options[districtSelect.options.length] = objOption;
		var streetSelect = document.getElementById('street');
		var nums = streetSelect.options.length;
		for (i = nums - 1; i >= 0; i--) {
			streetSelect.remove(i);
		}
		var objOption = new Option("----街道----", -1);
		streetSelect.options[streetSelect.options.length] = objOption;
		var objOption = new Option("----地市----", -1);
		citySelect.options[citySelect.options.length] = objOption;
		<c:forEach items="${list }" var="city">
		if ('${city.parentNode }' == Code && '${city.nodeRank}' == 2) {
			var objOption = new Option("${city.geogDesignation }", '${city.id}');
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
		var streetSelect = document.getElementById('street');
		var nums = streetSelect.options.length;
		for (i = nums - 1; i >= 0; i--) {
			streetSelect.remove(i);
		}
		var objOption = new Option("----街道----", -1);
		streetSelect.options[streetSelect.options.length] = objOption;
		var objOption = new Option("----区县----", -1);
		districtSelect.options[districtSelect.options.length] = objOption;
		<c:forEach items="${list }" var="district">
		if ('${district.parentNode }' == Code && '${district.nodeRank}' == 3) {
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
		var objOption = new Option("----街道----", -1);
		streetSelect.options[streetSelect.options.length] = objOption;
		<c:forEach items="${list }" var="street">
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
<jsp:include page='../common/footer.jsp' />