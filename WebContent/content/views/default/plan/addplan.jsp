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
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="row clearfix">
			<hr />
			<div class="list-group">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<a href="#">添加监测计划</a>
						</h3>
					</div>
					<div class="list-group-item">
						<p class="list-group-item-text">
						<form class="form-horizontal" action="savePlan" method="post">
							<input type="hidden" name="planId" value="${plan.id }" /> <input
								type="hidden" name="rolechange" value="${rolechange }" />
							<div class="form-group">
								<label class="col-sm-2 control-label">计划类型<font
									color="red">*</font></label>
								<div class="col-sm-3">
									<select name="type">
										<option value="Medicine"
											<c:if test='${plan.type =="Medicine" }'>selected</c:if>>服药</option>
										<option value="Followup"
											<c:if test='${plan.type =="Followup" }'>selected</c:if>>随访</option>
										<option value="Sputum"
											<c:if test='${plan.type =="Sputum" }'>selected</c:if>>痰检</option>
										<option value="XRay"
											<c:if test='${plan.type =="XRay" }'>selected</c:if>>胸透</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">标题<font
									color="red">*</font></label>
								<div class="col-sm-3">
									<input type="text" name="title" class="form-control"
										onblur="checkformname()">
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">开始日期<font
									color="red">*</font></label>
								<div class="col-sm-3">
									<input type="text" name="fromDate" class="form-control"
										placeholder="2014-11-16" id="fromDate">
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">周期</label>
								<div class="col-sm-5">
									<input type="checkbox" name="periods" value="MONDAY" />每周一&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="periods" value="TUESDAY">每周二
									&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" name="periods"
										value="WEDNESDAY">每周三&nbsp;&nbsp;&nbsp;&nbsp; <input
										type="checkbox" name="periods" value="THURSDAY" />每周四
									&nbsp;&nbsp;&nbsp;&nbsp;<br /> <input type="checkbox"
										name="periods" value="FRIDAY">每周五 &nbsp;&nbsp;&nbsp; <input
										type="checkbox" name="periods" value="SATURDAY" />每周六&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="periods" value="SUNDAY">每周日&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="periods" value="OTHERDAY" />隔天 <br />
									<input type="checkbox" name="periods" value="ONCE" />仅一次&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="periods" value="WEEK" />每周一次&nbsp;&nbsp;<input
										type="checkbox" name="periods" value="MONTH" />每月一次
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">频次</label>
								<div class="col-sm-5">
									每周期<input type="text" name="numberPerPeriod"
										style="border-radius: 4px; height: 34px; border: 1px solid #cccccc;"
										size="1" value="1" />次<br />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">结束日期</label>
								<div class="col-sm-3">
									<input type="text" name="toDate" class="form-control"
										id="toDate">
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">时间<font
									color="red">*</font></label>
								<div class="col-sm-5">
									<table id="talble1">
										<tr>
											<td>
												<div class="input-group clockpicker">
													<input type="text" id="times1" class="form-control"
														size="8" name="times" placeholder="10:00">
												</div>
											<td nowrap>提前 <input type="text" name="advtime"
												style="border-radius: 4px; height: 34px; border: 1px solid #cccccc;"
												size="1" value="0">小时提醒
											</td>
										</tr>
										<tr>
											<td><input type="text" class="form-control" id="times2"
												size="8" name="times" placeholder="18:00">
											<td nowrap>提前 <input type="text" name="advtime"
												style="border-radius: 4px; height: 34px; border: 1px solid #cccccc;"
												size="1" value="0">小时提醒
											</td>
										</tr>
									</table>
									<span class="badge navbar-left" onclick="addrow();">＋</span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">备注</label>
								<div class="col-sm-3">
									<textarea name="comments" class="form-control" id="inputEmail3"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label"></label>
								<div class="col-sm-3">
									<input type="submit" name="name" value="保存"
										class="btn btn-default" >
								</div>
							</div>
						</form>
						<script type="text/javascript">
						function reloadData() {
							setTimeout(function() {
								closeAndRefresh();
							}, 1000);
						}
// 						window.onunload = refreshParent;
// 						function refreshParent() {
// 							window.opener.location.reload();
// 						}
						function closeAndRefresh() {
							self.close();
							return true;
						}
							//添加行函数
							function addrow() {
								var newRow = "<tr><td><input type=\"text\"  class=\"form-control\"  id=\"times3\" size=\"8\" name=\"times\" placeholder=\"18:00\"> <td nowrap>提前 <input type=\"text\"  name=\"advtime\" style=\"border-radius: 4px; height: 34px; border: 1px solid #cccccc;\" size=\"1\" value=\"0\">小时提醒 </td></tr>";
								$("#talble1 tr:last").after(newRow);
								$("#talble1 tr:last  td:eq(0)").bind('click',function(){
									$(this).clockpicker({
										placement : 'bottom',
										align : 'left',
										autoclose : true,
										'default' : '00:00'
									});
								});
							}
							$('#fromDate').datetimepicker({
								lang : 'ch',
								timepicker : false,
								format : 'Y-m-d',
								formatDate : 'Y-m-d',
							});
							$('#toDate').datetimepicker({
								lang : 'ch',
								timepicker : false,
								format : 'Y-m-d',
								formatDate : 'Y-m-d',
							});
							$('#times1').clockpicker({
								placement : 'bottom',
								align : 'left',
								autoclose : true,
								'default' : '10:00'
							});
							$('#times2').clockpicker({
								placement : 'bottom',
								align : 'left',
								autoclose : true,
								'default' : '18:00'
							});
						</script>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />