<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<script type="text/javascript">     
function countDown(secs,surl){     
 //alert(surl);     
 var jumpTo = document.getElementById('jumpTo');
 jumpTo.innerHTML=secs;  
 if(--secs>0){     
     setTimeout("countDown("+secs+",'"+surl+"')",1000);     
     }     
 else{       
     location.href=surl;     
     }     
 }     
</script> 
</head>

<body>
<center>
<br><br>
<font style="font-size: 20px; color: red;">没有查询到需要下发的病人或者资料不存在!!</font>
<br><br>
<span id="jumpTo">5</span>秒后自动跳转到督导宣传页面
</center>
<script type="text/javascript">countDown(5,'../cdc/addIssued');</script>  
</body>