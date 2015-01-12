<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-md-2 column">
	<img alt="140x140" src="../content/static/img/zhangsan.jpeg" class="img-thumbnail">
	<h2 align="center">${patient.userName}</h2>
	<p>
		<font style="font-weight: 700;">登记日期:${patient.registrationDate}</font>
	</p>
	<p>
		<font style="font-weight: 700;">就诊卡号:</font>123456
	</p>
	<p>
		<font style="font-weight: 700;">电话:</font>${patient.phone}</p>
	<table class="table table-striped">
		<tbody>
			<tr>
				<td><a href="./index">服药</a></td>
			</tr>
			<tr class="success">
				<td><a href="../patient/getXraysByPatient?id=${patient.id }">胸片</a></td>
			</tr>
			<tr>
				<td><a href="../patient/getSputumsByPatient?id=${patient.id }">痰检</a></td>
			</tr>
		</tbody>
	</table>
	<hr />
	<c:forEach var="hospital" items="${hospital }">
		<p>
			<font style="font-weight: 700;"><h4>
					<c:out value="${hospital.key }" />
				</h4></font>
		</p>
		<hr />
		<c:forEach var="doctors" items="${hospital.value }">
			<p>
				<font style="font-weight: 700;">科室：</font>&nbsp;${doctors.key }
			</p>
			<p>
				<font style="font-weight: 700;">医生：</font>
				<c:forEach var="doctor" items="${doctors.value }" varStatus="loop">
					<c:choose>
						<c:when test="${loop.index%2==0 }">
								${doctor.userName }
							</c:when>
						<c:otherwise>
							<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								${doctor.userName }
							</c:otherwise>
					</c:choose>
				</c:forEach>
			</p>
		</c:forEach>
		<hr />
	</c:forEach>
</div>