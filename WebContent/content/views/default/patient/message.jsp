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
							<li class="active"><a href="./message">私信</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><span class="badge">＋</span></a></li>
						</ul>
					</div>

				</nav>
				<table class="table table-striped">
					<tr class="">
						<th>发送人</th>
						<th>接收人</th>
						<th>发送时间</th>
						<th>处理时限</th>
						<th>标题</th>
					</tr>

					<tr>
						<td>张三</td>
						<td>李医生</td>
						<td>2014-10-03 12:30:25</td>
						<td>2小时</td>
						<td><a href="#">我今天出现多次头晕</a></td>
					</tr>
					<tr class="success">
						<td>李医生</td>
						<td>张三</td>
						<td>2014-10-03 13:40:00</td>
						<td>-</td>
						<td><a href="#">回复：我今天出现多次头晕</a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page='patientInfo.jsp' />
</div>
<jsp:include page='../common/footer.jsp' />
