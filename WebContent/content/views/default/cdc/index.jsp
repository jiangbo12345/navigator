<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page='../common/header.jsp' />
<jsp:include page='../cdc/noticeNav.jsp' />
<div class="row clearfix">
	<div class="col-md-12 column">&nbsp;</div>
</div>
<div class="row clearfix">
	<div class="col-md-6 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">辖区统计</h3>
			</div>
			<div class="panel-body">
				昨天辖区内共有结核病人18人<br /> 辖区内使用药盒8人<br /> 使用药盒病人漏服人数为6人,漏服率75.0%<br />
				辖区内医生随访0次<br />
			</div>
		</div>
	</div>
	<div class="col-md-6 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">全疆统计</h3>
			</div>
			<div class="panel-body">
				昨天全疆结核病人共有 18 人 <br />其中使用药盒 8 人 <br /> 使用药盒病人的漏服人数为 6 人,漏服率 75.0%
				<br />今日全疆医生随访 0 次
			</div>
		</div>
	</div>
	<c:if test="${list != null || fn:length(notices) > 0}">
		<div class="col-md-12 column">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">公告与消息</h3>
				</div>
				<div class="panel-body">
					<table class="table table-striped">
							<tr>
								<th>消息类型</th>
								<th>发送日期</th>
								<th>消息内容</th>
							</tr>
							<c:forEach var="notice" items="${notices }" varStatus="loop">
								<c:choose>
									<c:when test="${loop.index%2==0 }">
										<tr>
									</c:when>
									<c:otherwise>
										<tr class="success">
									</c:otherwise>
								</c:choose>
								<td><c:if test="${notice.noticeType=='text' }">文字</c:if> <c:if
										test="${notice.noticeType=='voice' }">语音</c:if> <c:if
										test="${notice.noticeType=='news' }">图文</c:if></td>
								<td>${notice.noticeDate }</td>
								<td><c:if test="${notice.noticeType=='text' }">
										<a
											href="../cdc/getNotice?id=${notice.noticeId }&noticeType=text">
										<c:if test="${!fn:contains(notice.content,'<') }">
										<c:if test="${fn:length(notice.content)<=10}">${notice.content }</c:if>
											<c:if test="${fn:length(notice.content )>10}">${fn:substring(notice.content, 0, 8)}.....</c:if>
										</c:if>
											<c:if test="${fn:contains(notice.content,'<') }">${notice.content }</c:if>
										</a>
									</c:if> <c:if test="${notice.noticeType=='voice' }">
										<a
											href="../cdc/getNotice?id=${notice.noticeId }&noticeType=voice"><c:if
												test="${fn:length(notice.path )<=10}">${fn:substringAfter(notice.path,'/content/static/img/cdc/dddd/') }</c:if>
											<c:if test="${fn:length(notice.path )>10}">${fn:substring(fn:substringAfter(fn:substringAfter(notice.path,"/content/static/img/cdc/"),'/' ), 0, 12)}.....</c:if></a>
									</c:if> <c:if test="${notice.noticeType=='news' }">
										<c:forEach items="${articles }" var="article">
											<c:if test="${article.notice.noticeId==notice.noticeId}">
												<a
													href="../cdc/getNotice?id=${notice.noticeId }&noticeType=news">
													<c:if test="${fn:length(article.title )<=10}">${article.title }</c:if>
													<c:if test="${fn:length(article.title)>10}">${fn:substring(article.title, 0, 11)}.....</c:if>
												</a>
											</c:if>
										</c:forEach>
									</c:if></td>
								</tr>
							</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</c:if>
</div>
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="list-group">
			<a href="#" class="list-group-item active">漏服督导排名</a>
			<div class="list-group-item">
				<p class="list-group-item-text">
				<table class="table">
					<thead>
						<tr>
							<th>地区</th>
							<th>漏服率</th>
							<th>漏服人数</th>
							<th>医生随访次数</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>喀什</td>
							<td>75.0%</td>
							<td>3</td>
							<td>0次</td>
						</tr>
						<tr class="active">
							<td>乌鲁木齐</td>
							<td>50.0%</td>
							<td>1</td>
							<td>0次</td>
						</tr>
						<tr class="success">
							<td>昌吉</td>
							<td>50.0%</td>
							<td>1</td>
							<td>0次</td>
						</tr>
						<tr class="warning">
							<td>和田</td>
							<td>0.0%</td>
							<td>0</td>
							<td>0次</td>
						</tr>
						<tr class="danger">
							<td>阿勒泰</td>
							<td>0.0%</td>
							<td>0</td>
							<td>0次</td>
						</tr>
					</tbody>
				</table>
				</p>
			</div>
			<a class="list-group-item active"></a>
		</div>

	</div>
</div>
<jsp:include page='../common/footer.jsp' />