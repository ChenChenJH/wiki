<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<title>Basic Form - jQuery EasyUI Demo</title>
<link rel="stylesheet" type="text/css"
	href="css/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="css/themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/demo.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
</head>
<body>
	<center>
		<h1>群发系统</h1>
	</center>
	<div class="easyui-layout"
		style="width: 1100px; height: 800px; margin: 0 auto;">
		<p >
			欢迎你，${sessionScope.type}：${sessionScope.name}&nbsp;&nbsp;<a
				href="user/louginout" onclick="return loginout()">注销</a>
		<p>
		<div class="easyui-layout"
			style="width: 1100px; height: 500px; margin: 0 auto;">
			<div region="west" split="true" title="导航栏" style="width: 200px;">
				<c:if test="${sessionScope.type =='管理员' }">
					<p style="padding: 5px; margin: 0;">
						<strong>用户管理</strong>
					</p>
					<ul>
						<li><a href="user_list">用户管理</a></li>
					</ul>
				</c:if>
				<c:if test="${sessionScope.type =='普通用户' }">
					<p style="padding: 5px; margin: 0;">
						<strong>公众号管理</strong>
					</p>
					<ul>
						<li><a href="wiki_list">管理公众号</a></li>
					</ul>
					<p style="padding: 5px; margin: 0;">
						<strong>群发管理</strong>
					</p>
					<ul>
						<li><a href="message_send">我要群发</a></li>
						<br />
						<li><a href="message_list">群发记录</a></li>
						<br />
						<li><a href="draft_list">草稿箱</a></li>
						<br />
					</ul>
				</c:if>
			</div>
			<div id="content" region="center" title="内容" style="padding: 5px;">
				<table style="height: 60%;">
					<tr>
						<td width="10%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">操作系统版本：</td>
						<td width="23%"><%=System.getProperty("os.name")%>&nbsp;&nbsp;<%=System.getProperty("os.version")%></td>

					</tr>
					<tr>
						<td width="10%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">操作系统类型：</td>
						<td width="23%"><%=System.getProperty("os.arch")%></td>

					</tr>
					<tr>
						<td width="10%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">JDK版本：</td>
						<td width="23%"><%=System.getProperty("java.version")%></td>

					</tr>
					<tr>
						<td width="10%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">开发者：</td>
						<td width="23%"><font color="blue" size="5px">陈佛鑫、罗志祥、阮成斌、陈金华</font></td>
					</tr>
					<tr>
						<td width="10%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">系统介绍：</td>
						<td width="23%"><font color="purple" size="3px">该系统旨在给用户添加多个微信公众号实现同时群发图文信息</font></td>
					</tr>
				</table>
			</div>

		</div>
	</div>
	<script>
		//判断是否真的注销
		function loginout() {
			var con = confirm("确定要注销吗?");
			if (con) {
				return true;
			} else {
				return false;
			}
		}
	</script>
</body>
</html>