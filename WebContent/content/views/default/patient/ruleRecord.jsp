<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<div class="row clearfix">
	<div class="col-md-10 column">
		<jsp:include page='patientNav.jsp' />
		<div class="row clearfix">
			<hr />
			<div class="col-md-12 column">
				<nav class="navbar navbar-default">
					<div class="navbar-header"></div>
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">
							<li class="active"><a href="./ruleRecord">预警记录</a></li>
							<li><a href="./reminderRecord">通知记录</a></li>
							<li><a href="./rule">预警规则</a></li>
							<li><a href="./reminder">通知设置</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><span class="badge">＋</span></a></li>
						</ul>
					</div>

				</nav>
				<table class="table table-striped">
					<tr class="">
						<th>项目</th>
						<th>规则</th>
						<th>预警时间</th>
						<th></th>
					</tr>

					<tr>
						<td><font style="font-size: 13px;">服药</font></td>
						<td><font style="font-size: 13px;">未按时服药</font></td>
						<td><font style="font-size: 13px;">2014-10-18</font></td>
						<td><span class="badge">－</span></td>
					</tr>
					<tr class="success">
						<td><font style="font-size: 13px;">血压</font></td>
						<td><font style="font-size: 13px;">低压低于80</font></td>
						<td><font style="font-size: 13px;">2014-10-16</font></td>
						<td><span class="badge">－</span></td>
					</tr>
					<tr>
						<td><font style="font-size: 13px;">血压</font></td>
						<td><font style="font-size: 13px;">高压高于130</font></td>
						<td><font style="font-size: 13px;">2014-10-16</font></td>
						<td><span class="badge">－</span></td>
					</tr>

					<tr class="success">
						<td><font style="font-size: 13px;">血糖</font></td>
						<td><font style="font-size: 13px;">血糖数低于70</font></td>
						<td><font style="font-size: 13px;">2014-10-15</font></td>
						<td><span class="badge">－</span></td>
					</tr>
					<tr>
						<td><font style="font-size: 13px;">血糖</font></td>
						<td><font style="font-size: 13px;">血糖数高于200</font></td>
						<td><font style="font-size: 13px;">2014-10-14</font></td>
						<td><span class="badge">－</span></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page='patientInfo.jsp' />
</div>
<jsp:include page='../common/footer.jsp' />
