<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="CDC" style="display: block;">
									<div class="form-group">
										<label for="inputCDCName" class="col-sm-2 control-label">姓名</label>
										<div class="col-sm-10">
											<input type="tel" id="inputCDCName" name="userName"
												class="form-control" value="${user.userName }">
										</div>
									</div>
									<div class="form-group">
									<label for="inputPhone" class="col-sm-2 control-label">隶属机构</label>
									<div class="col-sm-10">
										<select name="org" id="org"  class="form-control">
											<c:forEach items="${cdcorgs }" var="cdcOrg">
												<option value="${cdcOrg.id }" <c:if test="${user.cdcOrg.id ==cdcOrg.id }"></c:if> >${cdcOrg.cdcOrgDesignation }
											</c:forEach>
										</select>
									</div>
								</div>
									<div class="form-group">
										<label for="inputPhone" class="col-sm-2 control-label">电话</label>
										<div class="col-sm-10">
											<input type="tel" id="inputPhone" name="phone"
												class="form-control" value="${user.phone }">
										</div>
									</div>
									<div class="form-group">
										<label for="inputSex" class="col-sm-2 control-label">性别</label>
										<div class="col-sm-10">
											<input type="radio" id="inputSex" name="sex" value="m"
												<c:if test="${user.sex=='m' }">checked</c:if>  class="audio">男&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio"
												id="inputSex" name="sex" value="w" class="audio" <c:if test="${user.sex=='w' }">checked</c:if> >女
										</div>
									</div>
									<div class="form-group">
										<label for="inputAddress" class="col-sm-2 control-label">地址</label>
										<div class="col-sm-10">
											<div class="form-group">
												<label for="inputSex" class="col-sm-2 control-label">省份</label>
												<div class="col-sm-10">
													<select id="inputProvience" name="provience"
														class="form-control">
														<option value="0" <c:if test="${user.address.provience=='0' }">selected</c:if>>新疆维吾尔自治区
														<option value="1" <c:if test="${user.address.provience=='1' }">selected</c:if>>北京
														<option value="2" <c:if test="${user.address.provience=='2' }">selected</c:if>>天津
													</select>
												</div>
											</div>
											<div class="form-group">
												<label for="inputSex" class="col-sm-2 control-label">地市</label>
												<div class="col-sm-10">
													<select id="inputCity" name="city" class="form-control">
														<option value="0" <c:if test="${user.address.city=='0' }">selected</c:if>>乌鲁木齐
														<option value="1" <c:if test="${user.address.city=='1' }">selected</c:if>>北京
														<option value="2" <c:if test="${user.address.city=='2' }">selected</c:if>>天津
													</select>
												</div>
											</div>
											<div class="form-group">
												<label for="inputSex" class="col-sm-2 control-label">区县</label>
												<div class="col-sm-10">
													<select id="inputDistrict" name="district"
														class="form-control">
														<option value="0" <c:if test="${user.address.district=='0' }">selected</c:if>>新市区
														<option value="1" <c:if test="${user.address.district=='1' }">selected</c:if>>开发区
														<option value="2" <c:if test="${user.address.district=='2' }">selected</c:if>>天山区
													</select>
												</div>
											</div>
										</div>
									</div>
								</div>