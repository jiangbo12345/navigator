<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
					<a href="../cdc/index">
					<c:if test="${noticeType=='text' }">
						文本
					</c:if>
					<c:if test="${noticeType=='voice' }">
						语音
					</c:if>
					<c:if test="${noticeType=='news' }">
						图文
					</c:if>
					<span class="badge navbar-right">返回</span></a>
				</h3>
			</div>
			<div class="panel-body">
					<c:if test="${noticeType=='text' }">
						<div class="form-group">
								<div class="col-sm-12">
									<p class="col-sm-12  control-p">
										${notice.content }
									</p>
								</div>
							</div>
					</c:if>
					<c:if test="${noticeType=='voice' }">
						<embed id='videowindow' width='200' height='50' name='videowindow'
							cache="true" src="/navigator/${notice.path }"
							mimeType="application/octet-stream" type="application/x-mplayer2"
							pluginspage="http://www.microsoft.com/windows/mediaPlayer/" />
					</c:if>
					<c:if test="${noticeType=='news' }">
						<c:forEach items="${list }" var="article">
							<div class="form-group">
								<label for="inputIdentifier" class="col-sm-12 control-label" style="text-align: center;">
								<font style="font-size: 26px;">${article.title }</font></label>
							</div>
							<div class="form-group">
								<label for="inputIdentifier" class="col-sm-12 control-label" style="text-align: center;">
									<img src="..${article.path }" alt="数据正在加载中。。。。。" >
								</label>
							</div>
							<div class="form-group">
								<label for="inputIdentifier" class="col-sm-2 control-label">摘要</label>
								<div class="col-sm-9">
									<label for="inputIdentifier" class="col-sm-9 control-label">${article.description }</label>
								</div>
							</div>
							<div class="form-group">
								<label for="inputIdentifier" class="col-sm-2 control-label">原文链接</label>
								<div class="col-sm-9">
									<label for="inputIdentifier" class="col-sm-9 control-label">
									<a href="${article.url }">${article.url }</a>
									</label>
								</div>
							</div>
						</c:forEach>
						<div class="form-group">
								<div class="col-sm-12">
									<p class="col-sm-12  control-p">
										${notice.content }
									</p>
								</div>
							</div>
					</c:if>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />