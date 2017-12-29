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
<script charset="utf-8" src="kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="kindeditor/lang/zh_CN.js"></script>
</head>
<script type="text/javascript">
	function back(){
		location.href="message_list.jsp";
	}
	
	function deletes(my_id){
			$.messager.confirm('Confirm', '确定要删除该记录？', function(r) {
				if (r) {
					$.post('message/delete', {
						id : my_id
					}, function(result) {
						//alert(result)
						if (result == true) {
							location.href="message_list.jsp";
						} else {
							$.messager.show({ // show error message
								title : 'Error',
								msg : '删除失败'
							});
						}
					}, 'json');
				}
			});
	}
	
	function againEdit(my_id){
		//alert();
		location.href='message/getMessageEdit?id='+my_id;
	}
</script>
<body>
	<center>
		<h1>群发系统</h1>
	</center>
	<p style="margin-left: 10%;">
		欢迎你，${sessionScope.type}：${sessionScope.name}&nbsp;&nbsp;<a
			href="user/louginout" onclick="return loginout()">注销</a>
	<p>
	<div class="easyui-layout"
		style="width: 1100px; height: 800px; margin: 0 auto;">
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
		<div id="content" region="center" title="已发信息">
			<div
				style="padding: 5px; background: #fafafa; width: 810px; border: 1px solid #ccc">
				<a class="easyui-linkbutton" iconCls="icon-back" onclick="back()">返回</a>&nbsp;||
				<a class="easyui-linkbutton" iconCls="icon-reload"
					onclick="window.location.reload();">刷新</a> <a
					class="easyui-linkbutton" iconCls="icon-edit"
					onclick="againEdit(${message.id})">再次编辑</a> <a
					class="easyui-linkbutton" iconCls="icon-cut"
					onclick="deletes(${message.id})">删除</a>

			</div>
			<div class="easyui-panel" style="width: 820px; height: 800px;">
				<div style="padding: 10px 60px 20px px;">
					<table cellpadding="5">
						<input type="hidden" value="" name="appList" id="wikiIds" />
						<tr>
							<td>群发公众号:</td>
							<td>${message.appList}</td>
						</tr>
						<tr>
							<td>标题:</td>
							<td>${message.title}</td>
						</tr>
						<tr>
							<td>作者:</td>
							<td>${message.author}</td>
						</tr>
						<tr>
							<td>原文url:</td>
							<td>${message.articleUrl}</td>
						</tr>
						<tr>
							<td>内容简介</td>
							<td>${message.summary}</td>
						</tr>
						<tr>
							<td>发送时间</td>
							<td>${message.date}</td>
						</tr>
						<tr>
							<td>内容:</td>
							<td><textarea name="content" readonly="readonly"
									style="width: 700px; height: 400px;">${message.content}</textarea></td>
						</tr>
						<tr>
							<td>封面图</td>
							<td><img id="imageview" width="300px" height="300px"
								src="${message.cover}" /></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function loginout(){
			var con=confirm("确定要注销吗?"); 
			if(con){
				return true;
			}else{
				return false;
			}
		}
	</script>
</body>
</html>