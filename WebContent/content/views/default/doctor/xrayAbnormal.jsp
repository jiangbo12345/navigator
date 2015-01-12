<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<script type="text/javascript">
    function popupwindow(url) {
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
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><a href="../doctor/${page }">胸片异常病人列表<span
								class="badge navbar-right">返回</span></a></h3>
			</div>
			<div class="panel-body">
				<p class="list-group-item-text">
				<table class="table table-striped">
					<tr class="">
						<th>姓名</th>
						<th>检测日期</th>
						<th>胸片</th>
						<th></th>
					</tr>
					<c:forEach var="xrayAbnormal" items="${xrayAbnormalList }" varStatus="loop">
						<c:choose>
							<c:when test="${loop.index%2==0 }">
								<tr>
							</c:when>
							<c:otherwise>
								<tr class="success">
							</c:otherwise>
						</c:choose>
						<td>${xrayAbnormal.patient.userName }</td>
						<td>${xrayAbnormal.checkDate }</td>
						<td>
							<h3 class="panel-title">
								<a href="../patientcheck/imageView?id=${xrayAbnormal.id }"><font style="font-size: 13px;">${xrayAbnormal.fileName }</font></a>
							</h3>
						</td>
						<td>
						<a href="../patientcheck/deletePatientCheck?id=${xrayAbnormal.id }" onclick=" return confirm('确定不再查看检查结果？')"><span class="badge">－</span></a></td>
						</tr>
					</c:forEach>
				</table>
				</p>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />