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
	<div class="col-md-12 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<a href="addNotice">公告与消息<span class="badge navbar-right">添加&nbsp;+</span></a>
				</h3>
			</div>
			<div class="list-group">
				<div class="list-group-item">
					<p class="list-group-item-text">
					<table class="table table-striped" id="talble1">
							<tr>
								<th>发送给</th>
								<th>类型</th>
								<th>内容</th>
								<th></th>
							</tr>
							<c:forEach var="notice" items="${list }" varStatus="loop">
								<c:choose>
									<c:when test="${loop.index%2==0 }">
										<tr >
									</c:when>
									<c:otherwise>
										<tr >
									</c:otherwise>
								</c:choose>
								<c:if test="${notice.noticeType=='text' }">
									<td >${notice.touser }</td>
									<td>文字</td>
									<td>
									<a
										href="../cdc/getNotice?id=${notice.noticeId }&noticeType=text">
										<c:if test="${!fn:contains(notice.content,'<') }">
										<c:if test="${fn:length(notice.content)<=10}">${notice.content }</c:if>
											<c:if test="${fn:length(notice.content )>10}">${fn:substring(notice.content, 0, 8)}.....</c:if>
										</c:if>
											<c:if test="${fn:contains(notice.content,'<') }">${notice.content }</c:if>
										</a>
									</td>
								</c:if>
								<c:if test="${notice.noticeType=='voice' }">
									<td>${notice.touser }</td>
									<td>语音</td>
									<td><a
										href="../cdc/getNotice?id=${notice.noticeId }&noticeType=voice"><c:if
												test="${fn:length(notice.path )<=10}">${fn:substringAfter(notice.path,'/content/static/img/cdc/dddd/') }</c:if>
											<c:if test="${fn:length(notice.path )>10}">${fn:substring(fn:substringAfter(fn:substringAfter(notice.path,"/content/static/img/cdc/"),'/' ), 0, 12)}.....</c:if></a>
									</td>
								</c:if>
								<c:if test="${notice.noticeType=='news' }">
									<td>${notice.touser }</td>
									<td>图文</td>
									<td><c:forEach items="${articles }" var="article">
											<c:if test="${article.notice.noticeId==notice.noticeId}">
												<a
													href="../cdc/getNotice?id=${notice.noticeId }&noticeType=news">
													<c:if test="${fn:length(article.title )<=10}">${article.title }</c:if>
													<c:if test="${fn:length(article.title)>10}">${fn:substring(article.title, 0, 11)}.....</c:if>
												</a>
											</c:if>
										</c:forEach>
								</c:if>
								</td>
								<td><a onclick="return confirm('确定不再查看检查结果？')"
									href="../cdc/deleteNotice?id=${notice.noticeId }"><span
										class="badge">删除</span></a></td>
								</tr>
							</c:forEach>
					</table>
					</p>
					<script type="text/javascript">
					
						$(document).ready(function(){
							$("#talble1 tr").each(function(){
								$(this).find('td:eq(0)').each(function(){
									var ss="";
									var obj = $(this);
									jQuery
									.ajax({
										type : 'GET',
										contentType : 'application/json',
										url : './getWho?ids='+$(this).text(),
										dataType : 'json',
										success : function(data) {
												if (data
														&& data.success == "true") {
													ss= data.names.userNames;
													if (ss.length>10) {
														ss = ss.substring(0, 9)+".....";
													}
													obj.text(ss);
												}
											}
										});
								});
							});
						});
					</script>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />