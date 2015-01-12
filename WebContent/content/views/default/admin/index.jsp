<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<div class="row clearfix">
	<jsp:include page='menu.jsp' />
	<div class="col-md-10 column">
		<div class="list-group">
			<a href="#" class="list-group-item active">待办事项</a>
			<div class="list-group-item">
				<form action="addToDoMessage" method="POST">
					<input name="todoMessage" type="text" class="form-control"> 例：9月20号9点去医院开会<br /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;每天/每周/每周日9点随访患者
				</form>
				<p class="list-group-item-text">
				<table class="table table-striped">
					<tr class="">
						<td>每天20:00点随访病人</td>
						<td><span class="badge">－</span></td>
					</tr>
					<tr class="success">
						<td>每天9:00点随访病人</td>
						<td><span class="badge">－</span></td>
					</tr>
				</table>
				</p>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />