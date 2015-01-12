<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
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
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="row clearfix">
			<hr />

			<div class="col-md-6 column">
				<div class="form-group">
					<label class="col-sm-2 control-label">标题 </label>
					<div class="col-sm-10">
						<label class="col-sm-10 control-label">${plan.title } </label>
					</div>
				</div>
				<input type="hidden" name="id" value="${plan.id }" />
				<div class="form-group">
					<label class="col-sm-2 control-label">计划类型</label>
					<div class="col-sm-10">
						<c:if test='${plan.type =="Medicine" }'>
							<label class="col-sm-2 control-label"> 服药</label>
						</c:if>
						<c:if test='${plan.type =="Sputum" }'>
							<label class="col-sm-2 control-label"> 痰检</label>
						</c:if>
						<c:if test='${plan.type =="Followup" }'>
							<label class="col-sm-2 control-label"> 随访</label>
						</c:if>
						<c:if test='${plan.type =="XRay" }'>
							<label class="col-sm-2 control-label"> 胸透</label>
						</c:if>
						<c:if test='${plan.type =="Hypertension" }'>
							<label class="col-sm-2 control-label"> 血压</label>
						</c:if>
						<c:if test='${plan.type =="Glucose" }'>
							<label class="col-sm-2 control-label"> 血糖</label>
						</c:if>
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">开始日期</label>
					<div class="col-sm-10">
						<label class="col-sm-10 control-label">${plan.fromDate }</label>
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">周期</label>
					<div class="col-sm-10">
						<label class="col-sm-10 control-label" id="zhouqi"></label> <br>
						<br>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">频次</label>
					<div class="col-sm-10">
						<label class="col-sm-10 control-label">${plan.numberPerPeriod }次</label>
					</div>
				</div>
				<c:if test="${plan.toDate !=null }">
					<div class="form-group">
						<label class="col-sm-2 control-label">结束日期</label>
						<div class="col-sm-10">
							<label class="col-sm-10 control-label">${plan.toDate }</label>
						</div>
					</div>
				</c:if>
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">时间</label>
					<div class="col-sm-10">
						<table>
							<c:forEach var="time" items="${plan.times }" varStatus="loop">
								<tr>
									<td><label class="col-sm-10 control-label">${time }</label>
										<c:if test="${plan.advtime[loop.count-1] !=null }">
											<td nowrap>提前${plan.advtime[loop.count-1] }小时提醒</td>
										</c:if>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<c:if test="${plan.comments !=null}">
					<div class="form-group">
						<label class="col-sm-2 control-label">备注</label>
						<div class="col-sm-10">
							<label class="col-sm-10 control-label">${plan.comments }</label>
						</div>
					</div>
				</c:if>
				<h3 class="panel-title">
					<a href="javascript:history.go(-1);"><span
						class="badge navbar-right">返回</span></a>
				</h3>
			</div>
		</div>

	</div>
	<script type="text/javascript">
		window.onload = function() {
			var str = "";
			<c:forEach items="${plan.periods }" var="period">
			if ('MONDAY' == '${period}') {
				str += "每周一,";
			} else if ('TUESDAY' == '${period}') {
				str += "每周二,";
			} else if ('WEDNESDAY' == '${period}') {
				str += "每周三,";
			} else if ('THURSDAY' == '${period}') {
				str += "每周四,";
			} else if ('FRIDAY' == '${period}') {
				str += "每周五,";
			} else if ('SATURDAY' == '${period}') {
				str += "每周六,";
			} else if ('SUNDAY' == '${period}') {
				str += "每周日,";
			} else if ('OTHERDAY' == '${period}') {
				str += "隔天,";
			} else if ('ONCE' == '${period}') {
				str += "仅一次,";
			} else if ('WEEK' == '${period}') {
				str += "每周一次,";
			} else if ('MONTH' == '${period}') {
				str += "每月一次,";
			}
			</c:forEach>
			str = str.substring(0, str.length - 1);
			document.getElementById("zhouqi").innerHTML = str;
		}
	</script>
</div>
<jsp:include page='../common/footer.jsp' />
