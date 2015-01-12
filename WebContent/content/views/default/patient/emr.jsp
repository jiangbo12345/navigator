<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	// Popup window code
	function popupWindow(url) {
		 var w = 700;
	        var h = 560;
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
<jsp:include page='../common/header.jsp' />
<div class="row clearfix">
	<div class="col-md-10 column">
		<jsp:include page='patientNav.jsp' />
		<div class="row clearfix">
			<hr />
			<div class="col-md-6 column">
				<div class="list-group">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<a href="#">病史<span class="badge navbar-right">＋</span></a>
							</h3>
						</div>
						<div class="list-group-item">
							<table class="table table-striped">
								<tbody>
									<tr class="">
										<td>鼻窦炎/慢性</td>
										<td align="right">2014-07-15</td>
									</tr>
									<tr class="success">
										<td>无并发症的高血压</td>
										<td align="right">2014-08-04</td>
									</tr>
									<tr class="">
										<td>糖尿病胰岛素依赖</td>
										<td align="right">2014-10-15</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="list-group">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<a href="#">过敏史<span class="badge navbar-right">＋</span></a>
							</h3>
						</div>
						<div class="list-group-item">
							<table class="table table-striped">
								<tbody>
									<tr class="">
										<td>青霉素</td>
										<td align="right">打喷嚏</td>
									</tr>
									<tr class="success">
										<td>阿司匹林</td>
										<td align="right">荨麻疹</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="list-group">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<a href="#">免疫史<span class="badge navbar-right">＋</span></a>
							</h3>
						</div>
						<div class="list-group-item">
							<table class="table table-striped">
								<tbody>
									<tr class="">
										<td>流感</td>
										<td align="right">2011-11-17</td>
									</tr>
									<tr class="success">
										<td>破伤风</td>
										<td align="right">2013-09-13</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="list-group">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<a href="#">用药史<span class="badge navbar-right">＋</span></a>
							</h3>
						</div>
						<div class="panel-body">
							<table class="table table-striped">
								<tbody>
									<tr class="">
										<td>优泌乐Mix25 PEN 100 U / ml悬液注射二甲双胍 1克的薄膜包衣片剂</td>
									</tr>
									<tr class="success">
										<td>感冒药剂500g</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-6 column">
				<div class="list-group">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<a href="#">体检报告<span class="badge navbar-right">＋</span></a>
							</h3>
						</div>
						<div class="panel-body">
							<table class="table table-striped">
								<tbody>
									<tr class="">
										<td>新医大一附院体检中心</td>
										<td align="right">2011-11-17</td>
									</tr>
									<tr class="success">
										<td>新医大一附院体检中心</td>
										<td align="right">2013-09-13</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="list-group">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<a href="#">监测记录<span class="badge navbar-right">＋</span></a>
							</h3>
						</div>
						<div class="panel-body">
							<table class="table table-striped">
								<tbody>
									<tr class="">
										<td>血压</td>
										<td align="right">2013-11-17</td>
									</tr>
									<tr class="success">
										<td>心率</td>
										<td align="right">2014-09-13</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="list-group">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<a href="#">病理报告<span class="badge navbar-right">＋</span></a>
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${patientChecks !=null }">
								<table class="table table-striped">
									<tbody>
										<c:forEach var="patientCheck" items="${patientChecks }" varStatus="loop">
											<c:if test="${patientCheck.checkType =='XRay' }">
												<c:choose>
													<c:when test="${loop.index%2==0 }">
														<tr>
													</c:when>
													<c:otherwise>
														<tr class="success">
													</c:otherwise>
												</c:choose>
												<td><c:if test="${patientCheck.filePath !=null }">
														<h3 class="panel-title">
															<a onclick="popupWindow('../patientcheck/imageView?id=${patientCheck.id }')" href="#">胸片(${patientCheck.fileName })</a>
														</h3>
													</c:if></td>
												<td>${patientCheck.checkDate }</td>
												<td><c:if test="${patientCheck.result =='NEGATIVE' }">阴性</c:if>
										<c:if test="${patientCheck.result =='POSITIVE' }">阳性</c:if></td>
												<td><a href="../patient/deletePatientCheck?id=${patientCheck.id }" onclick=" return confirm('确定删除该检查结果？')"><span class="badge">－</span></a></td>
												</tr>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page='patientInfo.jsp' />
</div>
<jsp:include page='../common/footer.jsp' />
