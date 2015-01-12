<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">血压统计报告</h3>
			</div>
			<div class="panel-body">
				<div class="form-group">
					<label class="col-sm-1 control-label">周期：</label> <label class="col-sm-3 control-label">2013-10-01 到 2014-10-01</label> <label class="col-sm-1 control-label">病人数：</label> <label
						class="col-sm-3 control-label">28</label>
				</div>


				<table class="table table-striped">
					<tr class="">
						<th>血压</th>
						<th>1周内</th>
						<th>90天</th>
						<th>180天</th>
						<th>365天</th>
					</tr>
					<tr>
						<td>&gt;=160/100</td>
						<td>3</td>
						<td>22</td>
						<td>30</td>
						<td>73</td>
					</tr>
					<tr class="success">
						<td>140/90 - 159/99</td>
						<td>12</td>
						<td>42</td>
						<td>76</td>
						<td>98</td>
					</tr>
					<tr>
						<td>120/80 - 139/89</td>
						<td>23</td>
						<td>51</td>
						<td>64</td>
						<td>109</td>
					</tr>
					<tr class="success">
						<td>&lt;=120/80</td>
						<td>8</td>
						<td>33</td>
						<td>56</td>
						<td>89</td>
					</tr>
					<tr>
						<td>汇总</td>
						<td>46</td>
						<td>148</td>
						<td>226</td>
						<td>369</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />