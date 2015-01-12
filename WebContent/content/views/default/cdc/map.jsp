<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.xhr.entity.user.User"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<link href="../content/static/css/bootstrap/bootstrap.css" rel="stylesheet">

<!-- Fav and touch icons -->
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../content/static/img/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="../content/static/img/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="../content/static/img/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed" href="../content/static/img/apple-touch-icon-57-precomposed.png">
<link rel="shortcut icon" href="../content/static/img/favicon.png">

<script type="text/javascript" src="../content/static/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="../content/static/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="../content/static/js/lib/scripts.js"></script>

<script src="../content/static/js/echart/echarts.js"></script>
<script src="../content/static/js/map/codemirror.js"></script>
<script src="../content/static/js/map/javascript.js"></script>
</head>

<body>
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<nav class="navbar navbar-default">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
							<span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#">Hi-Ray</a>
					</div>

					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">
							<li class="active"></li>
							<li><c:if test="${loginUser.role eq 'PATIENT' }">
									<a href="../patient/index">首页</a>
								</c:if> <c:if test="${loginUser.role eq 'DOCTOR' }">
									<a href="../doctor/index">首页</a>
								</c:if> <c:if test="${loginUser.role eq 'ADMIN' }">
									<a href="../admin/index">首页</a>
								</c:if></li>
							<li><a href="#">知识库</a></li>
						</ul>
						<form class="navbar-form navbar-left" role="search">
							<div class="form-group">
								<input type="text" class="form-control">
							</div>
							<button type="submit" class="btn btn-default">搜索</button>
						</form>
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><%=((User) request.getSession().getAttribute("loginUser")).getLoginName()%></a></li>
							<li><a href="./message">消息</a></li>
							<li><a href="../user/logout">退出</a></li>
						</ul>
					</div>
				</nav>
				<jsp:include page='../cdc/noticeNav.jsp' />
				<div class="row clearfix">
					<div class="col-md-12 column">&nbsp;</div>
				</div>
				<div class="row clearfix">
					<div class="col-md-12 column">
						<div class="container-fluid">
							<div class="row-fluid example">
								<div id="sidebar-code" class="col-md-2" style="display: none">
									<div class="well sidebar-nav">
										<textarea id="code" name="code">
option = {
    timeline:{
        data:[
            '2005-01-01','2006-01-01','2007-01-01','2008-01-01','2009-01-01',
            '2010-01-01','2011-01-01','2012-01-01','2013-01-01','2014-01-01'
        ],
        label : {
            formatter : function(s) {
                return s.slice(0, 4);
            }
        },
        autoPlay : true,
        playInterval : 1000
    },
    options:[
        {
            title : {
                'text':'2005年结核疫情',
                'subtext':'测试数据'
            },
            tooltip : {'trigger':'item'},
            toolbox : {
                'show':true, 
                'feature':{
                    'mark':{'show':true},
                    'dataView':{'show':true,'readOnly':false},
                    'restore':{'show':true},
                    'saveAsImage':{'show':true}
                }
            },
            dataRange: {
                min: 0,
                max : 53000,
                text:['高','低'],           // 文本，默认为数值文本
                calculable : true,
                x: 'left',
                color: ['orangered','yellow','lightskyblue']
            },
            series : [
                {
                    'name':'患者人数',
                    'type':'map',
                    'data': dataMap.dataGDP['2002']
                }
            ]
        },
        {
            title : {'text':'2006年结核疫情'},
            series : [
                {'data': dataMap.dataGDP['2003']}
            ]
        },
        {
            title : {'text':'2007年结核疫情'},
            series : [
                {'data': dataMap.dataGDP['2004']}
            ]
        },
        {
            title : {'text':'2008年结核疫情'},
            series : [
                {'data': dataMap.dataGDP['2005']}
            ]
        },
        {
            title : {'text':'2009年结核疫情'},
            series : [
                {'data': dataMap.dataGDP['2006']}
            ]
        },
        {
            title : {'text':'2010年结核疫情'},
            series : [
                {'data': dataMap.dataGDP['2007']}
            ]
        },
        {
            title : {'text':'2011年结核疫情'},
            series : [
                {'data': dataMap.dataGDP['2008']}
            ]
        },
        {
            title : {'text':'2012年结核疫情'},
            series : [
                {'data': dataMap.dataGDP['2009']}
            ]
        },
        {
            title : {'text':'2013年结核疫情'},
            series : [
                {'data': dataMap.dataGDP['2010']}
            ]
        },
        {
            title : {'text':'2014年结核疫情'},
            series : [
                {'data': dataMap.dataGDP['2011']}
            ]
        }
    ]
};
                    </textarea>
									</div>
									<!--/.well -->
								</div>
								<!--/span-->
								<div id="graphic" class="col-md-10">
									<div id="main" class="main" style="height: 530px;"></div>
									<div></div>
								</div>
								<!--/span-->
							</div>
							<!--/row-->

						</div>
						<!--/.fluid-container-->
						<!-- Placed at the end of the document so the pages load faster -->
						<script src="../content/static/js/map/timelineOption.js"></script>
						<script src="../content/static/js/map/echartsExample.js"></script>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
