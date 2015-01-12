<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page='../common/header.jsp' />
<jsp:include page='../cdc/noticeNav.jsp' />
<link
	href="../content/static/css/bootstrap/bootstrap-combined.no-icons.min.css"
	rel="stylesheet">
<link
	href="../content/static/css/bootstrap/bootstrap-responsive.min.css"
	rel="stylesheet">
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css"
	rel="stylesheet">
<link href="../content/static/css/bootstrap/index.css" rel="stylesheet">
<script src="../content/static/js/lib/bootstrap-wysiwyg.js"
	type="text/javascript"></script>
<script src="../content/static/js/lib/jquery.hotkeys.js"
	type="text/javascript"></script>
<link rel="stylesheet" href="index.css" type="text/css">
</link>
<div class="row clearfix">
	<div class="col-md-12 column">&nbsp;</div>
</div>
<style type="text/css">
.select {
	width: 20%;
	height: 34px;
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.428571429;
	color: #555555;
	vertical-align: middle;
	background-color: #ffffff;
	background-image: none;
	border: 1px solid #cccccc;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	-webkit-transition: border-color ease-in-out 0.15s, box-shadow
		ease-in-out 0.15s;
	transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
}

div {
	padding: 0px;
	font-size: 12px;
}

#mainbox {
	width: 20%;
}

#box0 {
	width: 100%;
	height: 34px;
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.428571429;
	color: #555555;
	vertical-align: middle;
	background-color: #ffffff;
	background-image: none;
	border: 1px solid #cccccc;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	-webkit-transition: border-color ease-in-out 0.15s, box-shadow
		ease-in-out 0.15s;
	transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
	overflow-y: scroll;
}

#box01 {
	width: 100%;
	height: 34px;
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.428571429;
	color: #555555;
	vertical-align: middle;
	background-color: #ffffff;
	background-image: none;
	border: 1px solid #cccccc;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	-webkit-transition: border-color ease-in-out 0.15s, box-shadow
		ease-in-out 0.15s;
	transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
	overflow-y: scroll;
}

#box1 {
	width: 20px;
	height: 20px;
	cursor: pointer;
	border: 1px solid green;
	float: left;
	text-align: center;
	padding-top: 2px;
}

#items {
	border: 1px solid black;
	width: 208px;
	display: none;
	height: 100px;
	overflow-y: scroll;
}

#items1 {
	border: 1px solid black;
	width: 208px;
	display: none;
	height: 100px;
	overflow-y: scroll;
}

#box3 {
	width: 218px;
	/*border-bottom:1px solid green;
                                border-left:1px solid green;
                                border-right:1px solid green;        
                        */
	padding-left: 4px;
}

.over {
	background-color: #11586E;
	font-weight: bold;
	color: #FFF;
	/*border-top:1px dotted black;
                                border-bottom:1px dotted black;*/
	cursor: pointer;
}

p {
	font-size: 12px;
	color: activeCaption;
	font-weight: bold;
}
</style>
<div class="row clearfix">
	<div class="col-md-12 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<a href="./notice">公告与消息添加<span class="badge navbar-right">返回</span></a>
				</h3>
			</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form" action="sendNotice"
					method="post" id="noticeForm" enctype="multipart/form-data">
					<input name="noticeType" id="noticeType" type="hidden">
					<div class="form-group">
						<label for="inputPatientName" class="col-sm-2 control-label">发送给</label>
						<div class="col-sm-10">
							<button type="button" name="doctor" id="doctor" class="btn">医生
							</button>
							<div id="mainbox" style="display: none; display: inline-table;">
								<div id="box0">------请选择-------</div>
								<div id="items">
									<table border="0" width="100%" bgcolor="#000000">
										<table border="0" width="100%" cellpadding="0" cellspacing="1"
											id="table1">
											<tr>
												<td><input value="-1" id="test" name="test"
													type=checkbox>------请选择-------</td>
											</tr>
										</table>
									</table>
								</div>
							</div>
							<input type="hidden" id="docIDs" name="docIDs">
							<button type="button" value="" name="cdc" class="btn" id="cdc">
								cdc</button>
							<div id="mainbox1"
								style="display: none; display: inline-table; width: 20%">
								<div id="box01">------请选择-------</div>
								<div id="items1">
									<table border="0" width="100%" bgcolor="#000000">
										<table border="0" width="100%" cellpadding="0" cellspacing="1"
											id="table2">
											<tr>
												<td><input value="-1" id="test" name="test"
													type=checkbox>------请选择-------</td>
											</tr>
										</table>
									</table>
								</div>
							</div>
						</div>
						<input id="cdcIDS" type="hidden" name="cdcIDS">
					</div>
					<script type="text/javascript">
						$(function() {
							$("#mainbox1").hide();
							$("#mainbox").hide();
						});
						var isok = false;
						var all = 0;
						$("#doctor")
								.click(
										function() {
											jQuery
													.ajax({
														type : 'GET',
														contentType : 'application/json',
														url : './getTo?who=doctor',
														dataType : 'json',
														success : function(data) {
															if (isok) {
																$("table tr")
																		.empty();
																var newRow = "<tr><td><input type=\"checkbox\"  id=\"allDoc\" value=\"-1\">------全选------</td></tr>";
																$(
																		"#table1 tr:last")
																		.after(
																				newRow);
																$("#allDoc")
																		.bind(
																				'click',
																				function() {
																					if (all == 0) {
																						$(
																								"[name=doc]:checkbox")
																								.each(
																										function() {
																											$(
																													this)
																													.attr(
																															"checked",
																															true);
																										});
																						all = 1;
																					} else {
																						all = 0;
																						$(
																								"[name=doc]:checkbox")
																								.each(
																										function() {
																											$(
																													this)
																													.attr(
																															"checked",
																															false);
																										});
																					}
																				});
																if (data
																		&& data.success == "true") {
																	$
																			.each(
																					data.doctors,
																					function(
																							i,
																							item) {
																						var newRow = "<tr><td><input type=\"checkbox\"  id=\"doc\"  name=\"doc\" value='" + item.id + "'>"
																								+ item.userName
																								+ "</td></tr>";
																						$(
																								"#table1 tr:last")
																								.after(
																										newRow);
																					});
																}
															}
														},
														error : function() {
															alert("error");
														}
													});
											if (isok) {
												$('#mainbox').hide();
												$('#doctor').val('');
												isok = false;
											} else {
												$('#mainbox').show();
												$('#doctor').css(
														"background-color",
														"#ebebeb");
												$('#doctor').val('doctor');
												isok = true;
											}
										});
						var okis = false;
						var all1 = 0;
						$("#cdc")
								.click(
										function() {
											jQuery
													.ajax({
														type : 'GET',
														contentType : 'application/json',
														url : './getTo?who=cdc',
														dataType : 'json',
														success : function(data) {
															if (okis) {
																$("table tr")
																		.empty();
																var newRow = "<tr><td><input type=\"checkbox\"  id=\"allCdc\" value=\"-1\">------全选------</td></tr>";
																$(
																		"#table2 tr:last")
																		.after(
																				newRow);
																$("#allCdc")
																		.bind(
																				'click',
																				function() {
																					if (all1 == 0) {
																						$(
																								"[name=cdc]:checkbox")
																								.each(
																										function() {
																											$(
																													this)
																													.attr(
																															"checked",
																															true);
																										});
																						all1 = 1;
																					} else {
																						all1 = 0;
																						$(
																								"[name=cdc]:checkbox")
																								.each(
																										function() {
																											$(
																													this)
																													.attr(
																															"checked",
																															false);
																										});
																					}
																				});
																if (data
																		&& data.success == "true") {
																	$
																			.each(
																					data.cdcs,
																					function(
																							i,
																							item) {
																						var newRow = "<tr><td><input type=\"checkbox\"  id=\"cdc\"  name=\"cdc\" value='" + item.id + "'>"
																								+ item.userName
																								+ "</td></tr>";
																						$(
																								"#table2 tr:last")
																								.after(
																										newRow);
																					});
																}
															}
														},
														error : function() {
															alert("error")
														}
													});
											if (okis) {
												$('#mainbox1').hide();
												$('#cdc').val('');
												okis = false;
											} else {
												$('#mainbox1').show();
												$('#cdc').val('cdc');
												okis = true;
											}
										});
					</script>
					<script type="text/javascript">
						var flag = 0;
						var oDiv0 = document.getElementById("box0");
						var oDiv1 = document.getElementById("box1");
						var oDiv = document.getElementById("items");
						oDiv0.onclick = function() {
							if (flag == 0) {
								oDiv.style.display = "block";
								flag = 1;
							} else {
								flag = 0;
								oDiv.style.display = "none";
								getCheckedValues();
							}

						}
						oDiv.onmouseleave = function() {
							flag = 0;
							this.style.display = "none";
							getCheckedValues();
						}
						var selectValue = "";
						function getCheckedValues() {
							var values = document.getElementsByName("doc");
							for (var i = 0; i < values.length; i++) {
								if (values[i].checked) {
									selectValue += values[i].value + " , ";
								}
							}
							selectValue = selectValue.substring(0,
									selectValue.length - 1);
							if (selectValue.length > 0) {
								document.getElementById("box0").innerHTML = "已选择！";
								$("#docIDs").val(selectValue);
								selectValue = "";
							} else {
								document.getElementById("box0").innerHTML = "-------请选择----------";
								selectValue = "";
							}
						}
						var flag1 = 0;
						var oDiv01 = document.getElementById("box01");
						var oDiv1 = document.getElementById("items1");
						oDiv01.onclick = function() {
							if (flag1 == 0) {
								oDiv1.style.display = "block";
								flag1 = 1;
							} else {
								flag1 = 0;
								oDiv1.style.display = "none";
								getCheckedValues1();
							}

						}
						oDiv1.onmouseleave = function() {
							flag1 = 0;
							this.style.display = "none";
							getCheckedValues1();
						}
						var selectValue = "";
						function getCheckedValues1() {

							var values = document.getElementsByName("cdc");

							for (var i = 0; i < values.length; i++) {
								if (values[i].checked) {
									selectValue += values[i].value + " , ";
								}
							}
							selectValue = selectValue.substring(0,
									selectValue.length - 1);
							if (selectValue.length > 0) {
								document.getElementById("box01").innerHTML = "已选择！";
								$("#cdcIDS").val(selectValue);
								selectValue = "";
							} else {
								document.getElementById("box01").innerHTML = "-------请选择----------";
								selectValue = "";
							}
						}
					</script>
					<div class="form-group">
						<label for="inputPatientName" class="col-sm-2 control-label">类型</label>
						<div class="col-sm-10">
							<button type="button" class="btn" onclick="types(this);"
								value="text">文字</button>
							<button type="button" class="btn" onclick="types(this);"
								value="news">图文</button>
							<button type="button" class="btn" onclick="types(this);"
								value="voice">语音</button>
						</div>
					</div>
					<script type="text/javascript">
						var ty;
						var typesText;
						function types(types) {
							$('#text').hide();
							$('#voice').hide();
							$('#news').hide();
							types.style.background = "#428bca";
							types.style.color = "white";
							if (ty == null) {
								this.ty = types;
							} else {
								this.ty.style.background = "#ebebeb";
								this.ty.style.color = "black";
								this.ty = types;
							}
							typesText = types.value;
							$('#noticeType').val(typesText);
							if (typesText != null) {
								if (typesText == 'text') {
									$('#editors').val('输入内容....');
									$('#contentNews').val('');
									$('#text').show();
								}
								if (typesText == 'voice') {
									$('#voice').show();
								}
								if (typesText == 'news') {
									$('#editor').val('输入内容....');
									$('#contentText').val('');
									$('#news').show();
								}
							}
						}
					</script>
					<div class="form-group" id="text" style="display: none;">
						<label for="inputIdentifier" class="col-sm-2 control-label">文本</label>
						<div class="col-sm-10">
						<div style="display: none;"><textarea id="contentText" name="contentText"></textarea></div>
							<DIV class="btn-toolbar" DATA-role="editor-toolbar"
									DATA-target="#editor">
									<DIV class="btn-group">
										<a class="btn dropdown-toggle" DATA-toggle="dropdown"
											title="Font"><i class="icon-font"></i><b class="caret"></b></a>
										<ul class="dropdown-menu">
										</ul>
									</DIV>
									<DIV class="btn-group">
										<a class="btn dropdown-toggle" DATA-toggle="dropdown"
											title="Font Size"><i class="icon-text-height"></i>&nbsp;<b
											class="caret"></b></a>
										<ul class="dropdown-menu">
											<li><a DATA-edit="fontSize 5"><font size="5">Huge</font></a></li>
											<li><a DATA-edit="fontSize 3"><font size="3">Normal</font></a></li>
											<li><a DATA-edit="fontSize 1"><font size="1">Small</font></a></li>
										</ul>
									</DIV>
									<DIV class="btn-group">
										<a class="btn" DATA-edit="bold" title="Bold (Ctrl/Cmd+B)"><i
											class="icon-bold"></i></a> <a class="btn" DATA-edit="italic"
											title="Italic (Ctrl/Cmd+I)"><i class="icon-italic"></i></a> <a
											class="btn" DATA-edit="strikethrough" title="Strikethrough"><i
											class="icon-strikethrough"></i></a> <a class="btn"
											DATA-edit="underline" title="Underline (Ctrl/Cmd+U)"><i
											class="icon-underline"></i></a>
									</DIV>
									<DIV class="btn-group">
										<a class="btn" DATA-edit="insertunorderedlist"
											title="Bullet list"><i class="icon-list-ul"></i></a> <a
											class="btn" DATA-edit="insertorderedlist" title="Number list"><i
											class="icon-list-ol"></i></a> <a class="btn" DATA-edit="outdent"
											title="Reduce indent (Shift+Tab)"><i
											class="icon-indent-left"></i></a> <a class="btn"
											DATA-edit="indent" title="Indent (Tab)"><i
											class="icon-indent-right"></i></a>
									</DIV>
									<DIV class="btn-group">
										<a class="btn" DATA-edit="justifyleft"
											title="Align Left (Ctrl/Cmd+L)"><i
											class="icon-align-left"></i></a> <a class="btn"
											DATA-edit="justifycenter" title="Center (Ctrl/Cmd+E)"><i
											class="icon-align-center"></i></a> <a class="btn"
											DATA-edit="justifyright" title="Align Right (Ctrl/Cmd+R)"><i
											class="icon-align-right"></i></a> <a class="btn"
											DATA-edit="justifyfull" title="Justify (Ctrl/Cmd+J)"><i
											class="icon-align-justify"></i></a>
									</DIV>
									<DIV class="btn-group">
										<a class="btn dropdown-toggle" DATA-toggle="dropdown"
											title="Hyperlink"><i class="icon-link"></i></a> <a
											class="btn" DATA-edit="unlink" title="Remove Hyperlink"><i
											class="icon-cut"></i></a>
									</DIV>

									<DIV class="btn-group">
										<a class="btn" DATA-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i
											class="icon-undo"></i></a> <a class="btn" DATA-edit="redo"
											title="Redo (Ctrl/Cmd+Y)"><i class="icon-repeat"></i></a>
									</DIV>
									<input TYPE="text" DATA-edit="inserttext" id="voiceBtn"
										X-webkit-speech="">
								</DIV>
								<DIV id="editor" >输入内容&hellip;</DIV>
						</div>
					</div>
					<div class="form-group" id="voice" style="display: none;">
						<label for="inputIdentifier" class="col-sm-2 control-label">语音</label>
						<div class="col-sm-10">
							<input type="file" name="sendFile" class="form-control">
						</div>
					</div>
					<div id="news" style="display: none;">
						<div class="form-group">
							<label for="inputIdentifier" class="col-sm-2 control-label">标题</label>
							<div class="col-sm-10">
								<input type="text" name="title" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label for="inputIdentifier" class="col-sm-2 control-label">封面图片</label>
							<div class="col-sm-10">
								<input type="file" name="sendFile2" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label for="inputIdentifier" class="col-sm-2 control-label">摘要</label>
							<div class="col-sm-10">
								<input type="text" name="description" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label for="inputIdentifier" class="col-sm-2 control-label">原文链接</label>
							<div class="col-sm-10">
								<input type="text" name="url" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label for="inputIdentifier" class="col-sm-2 control-label">文本</label>
							<div class="col-sm-10">
							<div style="display: none;"><textarea id="contentNews" name="contentNews"></textarea></div>
								<DIV class="btn-toolbar" DATA-role="editor-toolbar"
									DATA-target="#editor">
									<DIV class="btn-group">
										<a class="btn dropdown-toggle" DATA-toggle="dropdown"
											title="Font"><i class="icon-font"></i><b class="caret"></b></a>
										<ul class="dropdown-menu">
										</ul>
									</DIV>
									<DIV class="btn-group">
										<a class="btn dropdown-toggle" DATA-toggle="dropdown"
											title="Font Size"><i class="icon-text-height"></i>&nbsp;<b
											class="caret"></b></a>
										<ul class="dropdown-menu">
											<li><a DATA-edit="fontSize 5"><font size="5">Huge</font></a></li>
											<li><a DATA-edit="fontSize 3"><font size="3">Normal</font></a></li>
											<li><a DATA-edit="fontSize 1"><font size="1">Small</font></a></li>
										</ul>
									</DIV>
									<DIV class="btn-group">
										<a class="btn" DATA-edit="bold" title="Bold (Ctrl/Cmd+B)"><i
											class="icon-bold"></i></a> <a class="btn" DATA-edit="italic"
											title="Italic (Ctrl/Cmd+I)"><i class="icon-italic"></i></a> <a
											class="btn" DATA-edit="strikethrough" title="Strikethrough"><i
											class="icon-strikethrough"></i></a> <a class="btn"
											DATA-edit="underline" title="Underline (Ctrl/Cmd+U)"><i
											class="icon-underline"></i></a>
									</DIV>
									<DIV class="btn-group">
										<a class="btn" DATA-edit="insertunorderedlist"
											title="Bullet list"><i class="icon-list-ul"></i></a> <a
											class="btn" DATA-edit="insertorderedlist" title="Number list"><i
											class="icon-list-ol"></i></a> <a class="btn" DATA-edit="outdent"
											title="Reduce indent (Shift+Tab)"><i
											class="icon-indent-left"></i></a> <a class="btn"
											DATA-edit="indent" title="Indent (Tab)"><i
											class="icon-indent-right"></i></a>
									</DIV>
									<DIV class="btn-group">
										<a class="btn" DATA-edit="justifyleft"
											title="Align Left (Ctrl/Cmd+L)"><i
											class="icon-align-left"></i></a> <a class="btn"
											DATA-edit="justifycenter" title="Center (Ctrl/Cmd+E)"><i
											class="icon-align-center"></i></a> <a class="btn"
											DATA-edit="justifyright" title="Align Right (Ctrl/Cmd+R)"><i
											class="icon-align-right"></i></a> <a class="btn"
											DATA-edit="justifyfull" title="Justify (Ctrl/Cmd+J)"><i
											class="icon-align-justify"></i></a>
									</DIV>
									<DIV class="btn-group">
										<a class="btn dropdown-toggle" DATA-toggle="dropdown"
											title="Hyperlink"><i class="icon-link"></i></a> <a
											class="btn" DATA-edit="unlink" title="Remove Hyperlink"><i
											class="icon-cut"></i></a>
									</DIV>

									<DIV class="btn-group">
										<a class="btn" DATA-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i
											class="icon-undo"></i></a> <a class="btn" DATA-edit="redo"
											title="Redo (Ctrl/Cmd+Y)"><i class="icon-repeat"></i></a>
									</DIV>
									<input TYPE="text" DATA-edit="inserttext" id="voiceBtn"
										X-webkit-speech="">
								</DIV>
								<DIV id="editors" style="overflow:scroll; height: 300px; border: 2px solid #D8D8D8; ">输入内容&hellip;</DIV>
								
							</div>
						</div>
					</div>
					<script>
  $(function(){
    function initToolbarBootstrapBindings() {
      var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier', 
            'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
            'Times New Roman', 'Verdana'],
            fontTarget = $('[title=Font]').siblings('.dropdown-menu');
      $.each(fonts, function (idx, fontName) {
          fontTarget.append($('<li><a data-edit="fontName ' + fontName +'" style="font-family:\''+ fontName +'\'">'+fontName + '</a></li>'));
      });
      $('a[title]').tooltip({container:'body'});
    	$('.dropdown-menu input').click(function() {return false;})
		    .change(function () {$(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');})
        .keydown('esc', function () {this.value='';$(this).change();});

      $('[data-role=magic-overlay]').each(function () { 
        var overlay = $(this), target = $(overlay.data('target')); 
        overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
      });
      if ("onwebkitspeechchange"  in document.createElement("input")) {
        var editorOffset = $('#editor').offset();
        $('#voiceBtn').css('position','absolute').offset({top: editorOffset.top, left: editorOffset.left+$('#editors').innerWidth()-35});
      } else {
        $('#voiceBtn').hide();
      }
	};
	function showErrorAlert (reason, detail) {
		var msg='';
		if (reason==='unsupported-file-type') { msg = "Unsupported format " +detail; }
		else {
			console.log("error uploading file", reason, detail);
		}
		$('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'+ 
		 '<strong>File upload error</strong> '+msg+' </div>').prependTo('#alerts');
	};
    initToolbarBootstrapBindings(); 
	$('#editors').wysiwyg({ fileUploadError: showErrorAlert} );
	$('#editor').wysiwyg({ fileUploadError: showErrorAlert} );
	$('#noticeForm').submit(function() {
		  $('#contentNews').val($('#editors').html());
		  $('#contentText').val($('#editor').html());
		});
  });
</script>
					<div class="form-group">
						<label for="inputIdentifier" class="col-sm-2 control-label">发送微信</label>
						<div class="col-sm-10">
							<input type="checkbox" value="true" name="toWeChat" class="audio">
							&nbsp;&nbsp;是&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-12">
							<button type="submit" class="btn btn-default">发送</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<jsp:include page='../common/footer.jsp' />