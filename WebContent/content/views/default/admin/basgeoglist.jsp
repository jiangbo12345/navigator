<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<style type="text/css">
.select {
	width: 100%;
	height: 34px;
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.428571429;
	color: #555555;
	vertical-align: middle;
	background-color: #ffffff;
	background-image: none;
	border: 1px solid #cccccc;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	-webkit-transition: border-color ease-in-out 0.15s, box-shadow
		ease-in-out 0.15s;
	transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
}
</style>
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
<div class="row clearfix">
	<jsp:include page='menu.jsp' />
	<div class="col-md-10 column">
		<div class="list-group">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
				<a href="addbasegeographic">地理位置<span class="badge navbar-right">添加&nbsp;+</span></a>
				</h3>
			</div>
				<form action="deleteGeog" method="post">
			<table class="table table-striped">
				<tr class="">
					<td><select name="provience" class="select"
						onchange="checkCity(this)" id="provience" onblur="forProvienceText(this)"  >
							<option value="-1" selected="selected">----省份----
								<c:forEach var="provience" items="${list }">
									<c:if test="${provience.nodeRank ==1 }">
										<option value="${provience.id }">${provience.geogDesignation }
									</c:if>
								</c:forEach>
					</select>
					<input type="hidden" name="provienceText" id="provienceText" value="-1">
					</td>
					<td><select name="city" class="select"
						onchange="checkDistrict(this)" id="city" onblur="forCityText(this)">
							<option value="-1">----地市----
					</select>
					<input type="hidden" name="cityText" id="cityText"  value="-1">
					</td>
					<td><select name="district" onchange="checkStreet(this)"
						id="district" class="select" onblur="forDistrictText(this)">
							<option value="-1">----区县----
					</select>
					<input type="hidden" name="districtText" id="districtText" value="-1">
					</td>
					<td><select name="street" id="street" class="select" onblur="forStreetText(this)">
							<option value="-1">----街道----
					</select>
					<input type="hidden" name="streetText" id="streetText" value="-1">
					</td>
					<td>
					<button type="submit" class="btn btn-default" onClick="return closeAndRefresh();">删除</button>
					</td>
				</tr>
			</table>
			</form>
			<script type="text/javascript">
			 function forStreetText(sel){
					var street = document.getElementById("streetText");
					street.value = sel.options[sel.selectedIndex].value;
			    }
			    function forDistrictText(sel){
					var district = document.getElementById("districtText");
					district.value = sel.options[sel.selectedIndex].value;
			    }
			    function forCityText(sel){
					var cityText = document.getElementById("cityText");
					cityText.value = sel.options[sel.selectedIndex].value;
			    }
			    function forProvienceText(sel){
					var provienceText = document.getElementById("provienceText");
					provienceText.value = sel.options[sel.selectedIndex].value;
			    }
				function checkCity(obj) {
					var Code = obj.value;
					var citySelect = document.getElementById('city');
					var cityText = document.getElementById('cityText');
					cityText.value = -1;
					var districtText = document.getElementById('districtText');
					districtText.value = -1;
					var streetText = document.getElementById('streetText');
					streetText.value = -1;
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
					if ('${city.parentNode }' == Code
							&& '${city.nodeRank}' == 2) {
						var objOption = new Option("${city.geogDesignation }",
								'${city.id}');
						citySelect.options[citySelect.options.length] = objOption;
					}
					</c:forEach>
				}
				function checkDistrict(obj) {
					var Code = obj.value;
					var districtText = document.getElementById('districtText');
					districtText.value = -1;
					var streetText = document.getElementById('streetText');
					streetText.value = -1;
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
					var streetText = document.getElementById('streetText');
					streetText.value = -1;
					var streetSelect = document.getElementById('street');
					var num = streetSelect.options.length;
					for (i = num - 1; i >= 0; i--) {
						streetSelect.remove(i);
					}
					var objOption = new Option("----街道----", -1);
					streetSelect.options[streetSelect.options.length] = objOption;
					<c:forEach items="${list }" var="street">
					if ('${street.parentNode }' == Code
							&& '${street.nodeRank}' == 4) {
						var objOption = new Option("${street.geogDesignation }",
								'${street.id}');
						streetSelect.options[streetSelect.options.length] = objOption;
					}
					</c:forEach>
				}
			</script>
</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />