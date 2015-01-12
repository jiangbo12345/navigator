<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String[] weeks = { "", "日", "一", "二", "三", "四", "五", "六" };
    String[] days = new String[42];
    for (int i = 0; i < 42; i++) {
        days[i] = "";
    }
    //标准日历系统的当前时间
    GregorianCalendar currentDay = new GregorianCalendar();
    //年
    int year = currentDay.get(Calendar.YEAR);
    //月，由于取值范围为0-11，实际月份需+1
    int month = currentDay.get(Calendar.MONTH);
    //日
    int today = currentDay.get(Calendar.DAY_OF_MONTH);
    //星期，取值范围为1-7，且以星期日为每周第一天的美国标准
    int weekday = currentDay.get(Calendar.DAY_OF_WEEK);
    //得到标准日历系统的当前时间输出字符串
    String now = year + "年" + (month + 1) + "月" + today + "日" + " 星期" + weeks[weekday];
    //创建日历
    Calendar calendar = Calendar.getInstance();
    //月份为当前月
    calendar.set(Calendar.MONTH, month);
    //年份为当前年
    calendar.set(Calendar.YEAR, year);
    //每周第一天为星期日
    calendar.setFirstDayOfWeek(Calendar.MONDAY);
    //该月的第一天
    calendar.set(Calendar.DAY_OF_MONTH, 1);
    //第一天的星期
    int firstIndex = calendar.get(Calendar.DAY_OF_WEEK) - 1;
    //这个月最大天数
    int maxIndex = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
    //得到该月日数字符串
    for (int i = 0; i < maxIndex; i++) {
        //int需转换为字符串
        days[firstIndex + i] = String.valueOf(i + 1);
    }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>简易年历表</title>
</head>
<body>
	<table width="245" align="center" cellspacing="1" border="0">
		<tr height="40">
			<td colspan="7" align="center" style="border: 0 solid"><%=now%></td>
		</tr>
		<tr height="30" bgcolor="#F0F0F0" align="center">
			<td style="border: 1 solid;">日</td>
			<td style="border: 1 solid;">一</td>
			<td style="border: 1 solid;">二</td>
			<td style="border: 1 solid;">三</td>
			<td style="border: 1 solid;">四</td>
			<td style="border: 1 solid;">五</td>
			<td style="border: 1 solid;">六</td>
		</tr>
		<%
		    for (int i = 0; i < 6; i++) {
		%>
		<tr height="30" align="center">
			<%
			    for (int j = i * 7; j < (i + 1) * 7; j++) {
			            if ((j - firstIndex + 1) == today) {
			%>
			<td height="25" align="center" bgcolor="gray" style="border: 1 solid"><font color="#FFFFFF"><b><%=days[j]%></b></font></td>
			<%
			    } else {
			%>
			<td height="25" align="center" style="border: 1 solid"><%=days[j]%></td>
			<%
			    }
			        }
			%>
		</tr>
		<%
		    }
		%>
	</table>
</body>
</html>