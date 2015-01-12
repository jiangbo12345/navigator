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
							<li><a href="./rule">预警记录</a></li>
							<li><a href="./rule">通知记录</a></li>
							<li class="active"><a href="./rule">预警规则</a></li>
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
						<th>告警方式</th>
						<th>接收人</th>
						<th></th>
					</tr>

					<tr>
						<td>服药</td>
						<td>未按时服药</td>
						<td>微信</td>
						<td>李医生</td>
						<td><span class="badge">－</span></td>
					</tr>
					<tr class="success">
						<td>血压</td>
						<td>低压低于80</td>
						<td>短信,微信</td>
						<td>李医生</td>
						<td><span class="badge">－</span></td>
					</tr>
					<tr>
						<td>血压</td>
						<td>高压高于130</td>
						<td>短信,微信</td>
						<td>李医生</td>
						<td><span class="badge">－</span></td>
					</tr>

					<tr class="success">
						<td>血糖</td>
						<td>血糖数低于70</td>
						<td>电话</td>
						<td>医学院护理中心</td>
						<td><span class="badge">－</span></td>
					</tr>
					<tr>
						<td>血糖</td>
						<td>血糖数高于200</td>
						<td>电话</td>
						<td>医学院护理中心</td>
						<td><span class="badge">－</span></td>
					</tr>

				</table>

			</div>
		</div>
	</div>
	<jsp:include page='patientInfo.jsp' />
</div>
<jsp:include page='../common/footer.jsp' />
