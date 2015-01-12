<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<div class="form-group">
									<label for="inputEmail3" class="col-sm-2 control-label"><a
										class="frred">*</a>用户名</label>
									<div class="col-sm-10">
										<input type="text" name="loginName" class="form-control"
											id="inputEmail3" value="${user.loginName }"
											readonly="readonly">
									</div>
								</div>
								<div class="form-group">
									<label for="inputPassword3" class="col-sm-2 control-label"><a
										class="frred">*</a>密码 </label>
									<div class="col-sm-10">
										<input type="password" name="password1" class="form-control"
											id="inputPassword3" onblur="checkpwd()"><span
											id="spwd" class="frbule"> 请输入至少6为密码</span>
									</div>
								</div>
								<div class="form-group">
									<label for="inputPassword4" class="col-sm-2 control-label"><a
										class="frred">*</a>确认密码</label>
									<div class="col-sm-10">
										<input type="password" name="password" class="form-control"
											id="inputPassword4" onblur="rcheckpwd()"><span
											id="srpwd" class="frbule"> 请输入重复密码</span>
									</div>
								</div>
