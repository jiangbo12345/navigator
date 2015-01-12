<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style type="text/css">
.round {
	-moz-border-radius: 12px;
	border-radius: 15px;
	padding: 5px;
	border: 2px solid #000;
	color: #FFFFFF;
}
</style>
<table width="350" align="center" cellspacing="1" border="0">
	<tr height="40">
		<td colspan="1" align="center" style="border: 0 solid"><a href="./index?showMonth=${previousMonth }">&lt;</a></td>
		<td colspan="5" align="center" style="border: 0 solid">${showMonth }</td>
		<td colspan="1" align="center" style="border: 0 solid"><a href="./index?showMonth=${nextMonth }">&gt;</a></td>
	</tr>
	<tr height="30" bgcolor="#F0F0F0" align="center">
		<td style="border: 1 solid;" width="50">日</td>
		<td style="border: 1 solid;" width="50">一</td>
		<td style="border: 1 solid;" width="50">二</td>
		<td style="border: 1 solid;" width="50">三</td>
		<td style="border: 1 solid;" width="50">四</td>
		<td style="border: 1 solid;" width="50">五</td>
		<td style="border: 1 solid;" width="50">六</td>
	</tr>
	<c:forEach var="i" begin="0" end="5">
		<tr height="30" align="center">
			<c:forEach var="j" begin="0" end="6">
				<td height="25" width="50" align="center" bgcolor="${bjcolor[i*7+j] }" style="border: 1 solid"><font class="${ftclass[i*7+j] }"><b>${days[i*7+j] }</b></font></td>
			</c:forEach>
		</tr>
	</c:forEach>
</table>
<table width="350" align="center" cellspacing="1" border="0">
	<tr>
		<td>已服药天数: ${noOfTakeDays }</td>
	</tr>
	<tr>
		<td>未服药天数: ${noOfNonTakeDays }</td>
	</tr>
	<tr>
		<td>随访次数: ${noOfVisitDays }</td>
	</tr>
</table>