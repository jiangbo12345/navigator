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
							<li><a href="./message">私信</a></li>
							<li class="active"><a href="./todo">待办事项</a></li>
							<li><a href="./rule">告警规则</a></li>
							<li><a href="./reminder">提醒设置</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><span class="badge">＋</span></a></li>
						</ul>
					</div>

				</nav>
				<table class="table table-striped">
					<tr class="">
						<th>创建人</th>
						<th>时间</th>
						<th>内容</th>
						<th></th>
					</tr>
					<tr>
						<td>张三</td>
						<td>2014-10-03</td>
						<td>月底去医院进行痰检</td>
						<td><a href="#"><span class="badge">－</span></a></td>
					</tr>
					<tr class="success">
						<td>李医生</td>
						<td>2014-10-12</td>
						<td>20号到我这来领药</td>
						<td><a href="#"><span class="badge">－</span></a></td>
					</tr>

				</table>
			</div>
		</div>
	</div>
	<jsp:include page='patientInfo.jsp' />
</div>
<jsp:include page='../common/footer.jsp' />
