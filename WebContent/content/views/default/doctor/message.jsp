<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					收件箱&nbsp;&nbsp;&nbsp;&nbsp; 发件箱&nbsp;&nbsp;&nbsp;&nbsp; 草稿箱(1)&nbsp;&nbsp;&nbsp;&nbsp; <span class="badge navbar-right">＋</span>
				</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<tr class="">
						<th>发送人</th>
						<th>接收人</th>
						<th>发送时间</th>
						<th>处理时限</th>
						<th>回复时间</th>
						<th>标题</th>
					</tr>
					<tr>
						<td>张三</td>
						<td>李医生</td>
						<td>2014-10-03 12:30:25</td>
						<td>2小时</td>
						<td>2014-10-03 13:03:21</td>
						<td><a href="#">我今天出现多次头晕</a></td>
					</tr>
					<tr class="success">
						<td>李四</td>
						<td>李医生</td>
						<td>2014-10-03 13:09:21</td>
						<td>1小时</td>
						<td>2014-10-03 13:33:21</td>
						<td><a href="#">今天腰疼的厉害</a></td>
					</tr>
				</table>

			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />