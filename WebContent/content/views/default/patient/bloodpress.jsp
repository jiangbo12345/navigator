<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<div class="row clearfix">
	<div class="col-md-10 column">
		<jsp:include page='patientNav.jsp' />
		<div class="row clearfix">
			<hr />
			<div class="col-md-12 column">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">血压趋势</h3>
					</div>
					<div class="panel-body">
						<img height="400" width="650" src="../content/static/img/bloodpress.png" class="img-rounded">
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							血压纪录<span class="badge navbar-right">＋</span>
						</h3>
					</div>
					<div class="panel-body">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>测量日期</th>
									<th>高压</th>
									<th>低压</th>
									<th>备注</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>2014-10-23</td>
									<td>115</td>
									<td>88</td>
									<td>正常</td>
								</tr>
								<tr class="success">
									<td>2014-10-21</td>
									<td>120</td>
									<td>86</td>
									<td>正常</td>
								</tr>
								<tr>
									<td>2014-10-19</td>
									<td>123</td>
									<td>92</td>
									<td>正常</td>
								</tr>
								<tr class="success">
									<td>2014-10-17</td>
									<td>120</td>
									<td>91</td>
									<td>正常</td>
								</tr>
								<tr>
									<td>2014-10-15</td>
									<td>118</td>
									<td>86</td>
									<td>正常</td>
								</tr>
								<tr class="success">
									<td>2014-10-13</td>
									<td>115</td>
									<td>85</td>
									<td>正常</td>
								</tr>
								<tr>
									<td>2014-10-11</td>
									<td>135</td>
									<td>83</td>
									<td><font color="red">高压偏高</font></td>
								</tr>
								<tr class="success">
									<td>2014-10-09</td>
									<td>138</td>
									<td>84</td>
									<td><font color="red">高压偏高</font></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page='patientInfo.jsp' />
</div>
<jsp:include page='../common/footer.jsp' />
