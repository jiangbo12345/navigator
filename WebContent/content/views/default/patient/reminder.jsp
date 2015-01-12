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
							<li><a href="./ruleRecord">预警记录</a></li>
							<li><a href="./reminderRecord">通知记录</a></li>
							<li><a href="./rule">预警规则</a></li>
							<li class="active"><a href="./reminder">通知设置</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><span class="badge">＋</span></a></li>
						</ul>
					</div>

				</nav>
				<table class="table table-striped">
					<tr class="">
						<th>项目</th>
						<th>接收人</th>
						<th>方式</th>
						<th>提醒周期</th>
						<th>下次提醒时间</th>
						<th></th>
					</tr>

					<tr>
						<td>服药数据未上传</td>
						<td>李医生</td>
						<td>微信,短信</td>
						<td>每天12点</td>
						<td>2014年10月25号12点</td>
						<td><span class="badge">－</span></td>
					</tr>
					<tr class="success">
						<td>服药数据上传</td>
						<td>李医生</td>
						<td>微信</td>
						<td>上传时</td>
						<td>－</td>
						<td><span class="badge">－</span></td>
					</tr>

					<tr>
						<td>血压数据未上传</td>
						<td>李医生</td>
						<td>微信,短信</td>
						<td>每周一中午12点</td>
						<td>2014年10月27号12点</td>
						<td><span class="badge">－</span></td>
					</tr>
					<tr class="success">
						<td>血压数据上传</td>
						<td>李医生</td>
						<td>微信</td>
						<td>上传时</td>
						<td>－</td>
						<td><span class="badge">－</span></td>
					</tr>

					<tr>
						<td>血糖数据未上传</td>
						<td>李医生</td>
						<td>微信,短信</td>
						<td>每天中午2点</td>
						<td>2014年10月24号中午2点</td>
						<td><span class="badge">－</span></td>
					</tr>
					<tr class="success">
						<td>血糖数据上传</td>
						<td>李医生</td>
						<td>微信</td>
						<td>上传时</td>
						<td>－</td>
						<td><span class="badge">－</span></td>
					</tr>


				</table>

			</div>
		</div>
	</div>
	<jsp:include page='patientInfo.jsp' />
</div>
<jsp:include page='../common/footer.jsp' />
