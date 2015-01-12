<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<script type="text/javascript">
	function reloadData() {
		setTimeout(function() {
			window.location.reload();
		}, 1000);
	}
	// Popup window code
	function popupWindow(url) {
		 var w = 700;
	        var h = 480;
	        var title = "";
	        var left = (screen.width / 2) - (w / 2);
	        var top = (screen.height / 2) - (h / 2);
	        return window
	                .open(
	                        url,
	                        title,
	                        'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='
	                                + w
	                                + ', height='
	                                + h
	                                + ', top='
	                                + top
	                                + ', left=' + left);
	}
</script>
<div class="row clearfix">
	<div class="col-md-10 column">
		<jsp:include page='patientNav.jsp' />
		<div class="row clearfix">
			<hr />
			<div class="col-md-6 column">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							服药记录(<a href="../medicine/add">+</a>)
						</h3>
					</div>
					<div class="panel-body">
						<jsp:include page='./calendar.jsp' />
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							监测结果
							 (<a href="../patientcheck/add">+</a>)
						</h3>
					</div>
					<div class="panel-body">
						<c:if test="${patientChecks !=null}">
							<table class="table table-striped">
								<tbody>
									<c:forEach var="patientCheck" items="${patientChecks }" varStatus="loop">
										<c:choose>
											<c:when test="${loop.index%2==0 }">
												<tr>
											</c:when>
											<c:otherwise>
												<tr class="success">
											</c:otherwise>
										</c:choose>
										<td><c:choose>
												<c:when test="${patientCheck.checkType =='Sputum' }">
                                           痰检
                                        </c:when>
												<c:otherwise>
													<c:if test="${patientCheck.filePath !=null }">
														<h3 class="panel-title">
															胸片
														</h3>
													</c:if>
												</c:otherwise>
											</c:choose></td>
										<td>${patientCheck.checkDate }</td>
										<td>
										<c:if test="${patientCheck.checkType == 'Sputum' }">
											<c:if test="${patientCheck.result =='NEGATIVE' }">涂阴</c:if>
											<c:if test="${patientCheck.result =='POSITIVE' }">涂阳</c:if>
										</c:if>
										<c:if test="${patientCheck.checkType == 'XRay' }">
											<a href="../patientcheck/imageView?id=${patientCheck.id }"><font style="font-size: 13px;">${patientCheck.fileName }</font></a>
										</c:if>
										</td>
										<td><a href="deletePatientCheck?id=${patientCheck.id }" onclick=" return confirm('确定删除该检查结果？')"><span class="badge">－</span></a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							</c:if>
					</div>
				</div>
			</div>
			<div class="col-md-6 column">
				<div class="list-group">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">医嘱&nbsp;&nbsp;预约</h3>
						</div>
						<div class="panel-body">
							<form action="addToDoMessage" method="POST">
								<textarea rows="2" cols="10" name="todoMessage" class="form-control"></textarea>
								例：9月20号随访病人的饮食状况<br />
								<button type="submit" class="btn btn-default">添加</button>
							</form>
							<table class="table table-striped">
								<tr>
									<th>事项</th>
									<th>预约</th>
									<th></th>
								</tr>
								<c:forEach var="todoMessage" items="${toDoMessages }" varStatus="loop">
									<c:choose>
										<c:when test="${loop.index%2==0 }">
											<tr>
										</c:when>
										<c:otherwise>
											<tr class="success">
										</c:otherwise>
									</c:choose>
									<td>${todoMessage.content }<c:if test="${todoMessage.from.id != loginUser.id }">(${todoMessage.from.userName}<c:if test="${empty todoMessage.from }">系统</c:if>)</c:if></td>
									<td nowrap><a href="#">预约</a></td>
									<td><c:if test="${todoMessage.from.id == loginUser.id }">
											<a href="deleteToDoMessage?id=${todoMessage.id }" onclick=" return confirm('确定删除该待办事项？')"><span class="badge">－</span></a>
										</c:if></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page='patientInfo.jsp' />
</div>
<jsp:include page='../common/footer.jsp' />
