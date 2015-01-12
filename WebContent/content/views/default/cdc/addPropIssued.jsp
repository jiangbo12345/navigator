<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
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

<form action="saveIssued" method="post">
	<div class="form-group" style="text-align: center;">
		<label><font style="font-size: 40px;">宣教下发</font> </label> <br> <br>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"><a
			class="frred">*</a>督导语言</label>
		<div class="col-sm-10">
			<select name="language" id="language" class="form-control"
				onchange="seachDatum(this);">
				<option value="-1">----选择语言----
				<option value="Chinese">汉语
				<option value="Uighur">维语
				<option value="Azerbaijan">阿塞拜疆语
				<option value="Russian">俄语
				<option value="Kirgiz">柯尔克孜语
				<option value="Kazakh">哈萨克语
			</select><br>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"><a
			class="frred">*</a>督导资料</label>
		<div class="col-sm-10">
			<select name="datum" id="datum" class="form-control"
				onchange="comms(this);">
				<option value="-1">-----请选择-----
			</select><br>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"> 备注</label>
		<div class="col-sm-10">
			<textarea rows="2" name="comments" id="comments" class="form-control"></textarea>
			<br>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"><a
			class="frred">*</a>省份</label>
		<div class="col-sm-10">
			<select name="provience" class="form-control" id="provience">
				<option value="-1" selected="selected">----省份----
			</select><br>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"><a
			class="frred">*</a>地市</label>
		<div class="col-sm-10">
			<select name="city" class="form-control"  id="city">
				<option value="-1">----地市----
			</select><br>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"><a
			class="frred">*</a>区县</label>
		<div class="col-sm-10">
			<select name="district"  id="district" 
				class="form-control">
				<option value="-1">----区县----
			</select><br>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail3" class="col-sm-2 control-label"><a
			class="frred">*</a>街道</label>
		<div class="col-sm-10">
			<select name="street" id="street" class="form-control">
				<option value="-1">----街道----
			</select><br>
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10" style="text-align: center;">
			<button type="submit" class="btn btn-default">添加</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-default"
				onclick="closeAndRefresh()">取消</button>
		</div>
	</div>
</form>
<c:set var="typeText" value=""></c:set>
<script type="text/javascript">
	function comms(obj) {
		<c:forEach items="${propDatums }" var="aa">
		if ('${aa.propDatumID}' == obj.value) {
			$('#comments').val('${aa.remarks }');
			$('#comments').attr("readonly", "readonly");
		}
		if (obj.value == -1) {
			$('#comments').val(' ');
			$('#comments').removeAttr("readonly");
		}
		</c:forEach>
	}
	function seachDatum(obj) {
		var language = document.getElementById("language").value;
		var datums = document.getElementById('datum');
		var num = datums.options.length;
		for (i = num - 1; i >= 0; i--) {
			datums.remove(i);
		}
		var objOption = new Option("-----请选择-----", -1);
		datums.options[datums.options.length] = objOption;
		<c:forEach items="${propDatums }" var="datum">
		if ('${datum.language}' == language) {
			var objOption = new Option("${datum.title }",
					'${datum.propDatumID }');
			datums.options[datums.options.length] = objOption;
		}
		</c:forEach>
		$('#comments').val(' ');
		$('#comments').removeAttr("readonly");
	}
	$(document).ready(function(){
		jQuery
		.ajax({
			type : 'GET',
			contentType : 'application/json',
			url : '../getaddress/getAdd?id=2',
			dataType : 'json',
			success : function(data) {
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
					if (data
							&& data.success == "true") {
						$.each(data.address,function(i,item) {
							if ("${prov }"==item.geogDesignation) {
								$("#provience").append("<option value='"+item.id+"' selected='selected'>"+item.geogDesignation+"</option>"); 
								$("#provience").attr("readonly","readonly");
							}else{
								$("#provience").append("<option value='"+item.id+"'>"+item.geogDesignation+"</option>"); 
							}
						});
						checkCity($("#provience").val());
					}
				}
			});
	});
	$("#provience")
	.change(function(){
		jQuery
		.ajax({
			type : 'GET',
			contentType : 'application/json',
			url : '../getaddress/getAdd?id='+$(this).val(),
			dataType : 'json',
			success : function(data) {
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
					if (data
							&& data.success == "true") {
						$.each(data.address,function(i,item) {
							$("#city").append("<option value='"+item.id+"'>"+item.geogDesignation+"</option>"); 
						});
					}
				}
			});
	});
	$("#city")
	.change(function(){
		jQuery
		.ajax({
			type : 'GET',
			contentType : 'application/json',
			url : '../getaddress/getAdd?id='+$(this).val(),
			dataType : 'json',
			success : function(data) {
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
					if (data
							&& data.success == "true") {
						$.each(data.address,function(i,item) {
							$("#district").append("<option value='"+item.id+"'>"+item.geogDesignation+"</option>"); 
						});
					}
				}
			});
	});
	$("#district")
	.change(function(){
		jQuery
		.ajax({
			type : 'GET',
			contentType : 'application/json',
			url : '../getaddress/getAdd?id='+$(this).val(),
			dataType : 'json',
			success : function(data) {
		 		var streetSelect = document.getElementById('street');
		 		var num = streetSelect.options.length;
		 		for (i = num - 1; i >= 0; i--) {
		 			streetSelect.remove(i);
		 		}
		 		var objOption = new Option("----街道----", -1);
		 		streetSelect.options[streetSelect.options.length] = objOption;
		 		if (data
						&& data.success == "true") {
					$.each(data.address,function(i,item) {
						$("#street").append("<option value='"+item.id+"'>"+item.geogDesignation+"</option>"); 
						});
					}
				}
			});
	});
	function checkCity(obj) {
		var Code = obj;
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
		<c:forEach items="${list }" var="citys">
		if ('${citys.parentNode }' == Code && '${citys.nodeRank}' == 2) {
			if ("${city }"=="${citys.geogDesignation }") {
				$("#city").append("<option value='${citys.id}' selected='selected'> ${citys.geogDesignation }</option>"); 
				$("#city").attr("readonly","readonly");
			}else{
				$("#city").append("<option value='${citys.id}'> ${citys.geogDesignation }</option>");
			}
		}
		</c:forEach>
		checkDistrict($("#city").val());
	}
	function checkDistrict(obj) {
		var Code = obj;
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
		<c:forEach items="${list }" var="districts">
		if ('${districts.parentNode }' == Code && '${districts.nodeRank}' == 3) {
			if ("${district }"=="${districts.geogDesignation }") {
				alert("dd");
				$("#district").append("<option value='${districts.id}' selected='selected'> ${districts.geogDesignation }</option>"); 
				$("#district").attr("readonly","readonly");
			}else{
				$("#district").append("<option value='${districts.id}'> ${districts.geogDesignation }</option>");
			}
		}
		</c:forEach>
		checkStreet($("#district").val());
	}
	function checkStreet(obj) {
		var Code = obj;
		var streetSelect = document.getElementById('street');
		var num = streetSelect.options.length;
		for (i = num - 1; i >= 0; i--) {
			streetSelect.remove(i);
		}
		var objOption = new Option("----街道----", -1);
		streetSelect.options[streetSelect.options.length] = objOption;
		<c:forEach items="${list }" var="streets">
		if ('${streets.parentNode }' == Code && '${streets.nodeRank}' == 4) {
			if ("${street }"=="${streets.geogDesignation }") {
				alert("street");
				$("#street").append("<option value='${streets.id}' selected='selected'> ${streets.geogDesignation }</option>"); 
				$("#street").attr("readonly","readonly");
			}else{
				$("#street").append("<option value='${streets.id}'> ${streets.geogDesignation }</option>");
			}
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