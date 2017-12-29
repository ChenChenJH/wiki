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
<script type="text/javascript">
	var url;
	//新增公众号界面
	function newWiKi() {
		$('#dlg').dialog('open').dialog('setTitle', '新增公众号');
		$('#fm').form('clear');
		url = 'wiki/insert';
	}

	//编辑用户界面
	function editWiKi() {
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$('#dlg').dialog('open').dialog('setTitle', '编辑公众号');
			$('#fm').form('load', row);
			url = 'wiki/update?id=' + row.id;
		}
	}

	//新增和编辑公众号操作
	function saveUser() {
		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(result) {
				if (result == 'true') {
					$.messager.alert("提示", "操作成功！");
					$('#dlg').dialog('close'); // close the dialog
					$('#dg').datagrid('reload'); // reload the user data
				} else {
					$.messager.show({ // show error message
						title : 'Error',
						msg : result
					});
				}
			}
		});
	}

	//删除一个用户
	function destroyUser() {
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$.messager.confirm('Confirm', '确定要删除该公众号？', function(r) {
				if (r) {
					$.post('wiki/delete', {
						id : row.id
					}, function(result) {
						if (result == true) {
							$.messager.alert("提示", "删除成功！");
							$('#dg').datagrid('reload'); // 重新加载数据
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
	}

	//搜索用户
	function doSearch() {
		$('#dg').datagrid('load', {
			appName : $('#appName').val().trim(),
		});
	}
</script>
<body>
	<center>
		<h1>群发系统</h1>
	</center>
	<div class="easyui-layout"
		style="width: 1100px; height: 800px; margin: 0 auto;">
		<p>
			欢迎你，${sessionScope.type}：${sessionScope.name}&nbsp;&nbsp;<a
				href="user/louginout" onclick="return loginout()">注销</a>
		</p>
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
			<!--右边主要内容模块-->
			<div id="content" region="center" title="公众号列表" style="padding: 5px;">
				<!--搜索框-->
				<div id="tb" style="padding: 3px">
					<span>公众号名称:</span> <input id="appName"
						style="line-height: 26px; border: 1px solid #ccc"> <a
						class="easyui-linkbutton" plain="true" onclick="doSearch()">搜索</a>
				</div>
				<!--数据表-->
				<table id="dg" class="easyui-datagrid"
					style="width: 850px; height: 350px" url="wiki/list"
					toolbar="#toolbar" rownumbers="true" fitColumns="true"
					singleSelect="true" pagination="true">
					<thead>
						<tr>
							<th field="id" width="50">公众号编号</th>
							<th field="appName" width="50">公众号名称</th>
							<th field="appId" width="50">开发者ID</th>
							<th field="appSecret" width="50">开发者密码</th>
						</tr>
					</thead>

				</table>

				<!--编辑列表-->
				<div id="toolbar">
					<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
						onclick="newWiKi()">添加公众号</a> <a class="easyui-linkbutton"
						iconCls="icon-edit" plain="true" onclick="editWiKi()">编辑公众号</a> <a
						class="easyui-linkbutton" iconCls="icon-remove" plain="true"
						onclick="destroyUser()">删除公众号</a>
				</div>

				<!--新增公众号界面-->
				<div id="dlg" class="easyui-dialog"
					style="width: 400px; height: 280px; padding: 10px 20px"
					closed="true" buttons="#dlg-buttons">
					<div class="ftitle">公众号信息</div>
					<br />
					<form id="fm" method="post">
						<div class="fitem">
							<label>公众号名称:</label> <input name="appName"
								class="easyui-validatebox" required="true">
						</div>
						<br />
						<div class="fitem">
							<label>公众号开发者ID:</label>&nbsp;&nbsp;&nbsp; <input name="appId"
								class="easyui-validatebox" required="true">
						</div>
						<br />
						<div class="fitem">
							<label>公众号开发者密钥:</label>&nbsp;&nbsp;&nbsp; <input
								name="appSecret" class="easyui-validatebox" required="true">
						</div>
					</form>
				</div>
				<div id="dlg-buttons">
					<a class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel"
						onclick="javascript:$('#dlg').dialog('close')">取消</a>
				</div>
			</div>
		</div>
	</div>
	<script>
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