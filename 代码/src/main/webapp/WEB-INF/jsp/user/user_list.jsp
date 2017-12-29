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
</head>
<script type="text/javascript">
	var url;
	//新增用户界面
	function newUser() {
		$('#dlg').dialog('open').dialog('setTitle', '新增用户');
		$('#fm').form('clear');
	}

	function submitAddUser() {
		$.post("user/addUser", $('#fm').serialize(), function(data) {
			if (data.status == 200) {
				$.messager.alert("提示", "新增成功！");
				$('#dlg').dialog('close'); // close the dialog
				$('#dg').datagrid('reload'); // reload the user data
			} else {
				$.messager.alert("提示", data.msg);
			}

		});
	}

	//编辑用户界面
	function editUser() {
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$('#editUser').dialog('open').dialog('setTitle', '编辑用户');
			$('#edit').form('load', row);
			// alert(row.home_admin_id);
		}
	}

	function submiteditUser() {
		$.post("user/updateUser", $('#edit').serialize(),
				function(data) {
					if (data.status == 200) {
						$.messager.alert("提示", "修改成功！");
						$('#editUser').dialog('close'); // close the dialog
						$('#dg').datagrid('reload'); // reload the user data
					} else {
						$.messager.alert("提示", data.msg);
					}
				});
	}

	//新增和编辑用户操作
	function saveUser() {
		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(result) {
				if (result == '') {
					$.messager.show({
						title : 'Error',
						msg : '该用户名已存在'
					});
				} else {
					$('#dlg').dialog('close'); // close the dialog
					$('#dg').datagrid('reload'); // reload the user data
				}
			}
		});
	}

	//删除一个用户
	function destroyUser() {
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$.messager.confirm('提示', '确定要删除该用户？', function(r) {
				if (r) {
					$.post('user/deleteUser', {
						"userId" : row.id
					}, function(result) {
						// alert(result);
						if (result.status == 200) {
							$.messager.alert("提示", "删除成功！");
							$('#dg').datagrid('reload'); // 重新加载数据

						} else {
							$.messager.show({ // show error message
								title : 'Error',
								msg : result.msg
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
			"userName" : $("#userName").val().trim()
		})
	}
</script>
<body>
	<?php
session_start();
if(!isset($_SESSION['user'])){
	header("Location: index");
}
?>
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
			<!--右边主要内容模块-->
			<div id="content" region="center" title="用户列表" style="padding: 5px;">
				<!--搜索框-->
				<div id="tb" style="padding: 3px">
					<span>用户名称:</span> <input id="userName"
						style="line-height: 26px; border: 1px solid #ccc"> <a
						href="javascript:void(0)" class="easyui-linkbutton" plain="true"
						onclick="doSearch()">搜索</a>
				</div>
				<!--数据表-->
				<table id="dg" class="easyui-datagrid"
					style="width: 850px; height: 350px" url="user/userList"
					toolbar="#toolbar" rownumbers="true" fitColumns="true"
					singleSelect="true" pagination="true">
					<thead>
						<tr>
							<th field="id" width="50">用户编号</th>
							<th field="userName" width="50">用户名称</th>
							<th field="pwd" width="50">用户密码</th>
						</tr>
					</thead>
				</table>

				<!--编辑列表-->
				<div id="toolbar">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-add" plain="true" onclick="newUser()">添加用户</a> <a
						href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-edit" plain="true" onclick="editUser()">编辑用户</a> <a
						href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-remove" plain="true" onclick="destroyUser()">删除用户</a>
				</div>

				<!--新增用户界面-->
				<div id="dlg" class="easyui-dialog"
					style="width: 400px; height: 280px; padding: 10px 20px"
					closed="true" buttons="#dlg-buttons">
					<div class="ftitle">用户信息</div>
					<br />
					<form id="fm" method="post">

						<div class="fitem">
							<label>名称:</label>&nbsp;&nbsp;&nbsp; <input name="userName"
								class="easyui-validatebox" required="true">
						</div>
						<br />
						<div class="fitem">
							<label>密码:</label>&nbsp;&nbsp;&nbsp; <input name="pwd"
								class="easyui-validatebox" required="true">
						</div>
						<div style="padding: 10px;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								onclick="submitAddUser()">提交</a>
						</div>
					</form>
				</div>

				<!--修改用户界面-->
				<div id="editUser" class="easyui-dialog"
					style="width: 400px; height: 280px; padding: 10px 20px"
					closed="true" buttons="#dlg-buttons">
					<div class="ftitle">用户信息</div>
					<br />
					<form id="edit" method="post">
						<input type="hidden" name="id" />
						<div class="fitem">
							<label>名称:</label>&nbsp;&nbsp;&nbsp; <input name="userName"
								class="easyui-validatebox" required="true">
						</div>
						<br />
						<div class="fitem">
							<label>密码:</label>&nbsp;&nbsp;&nbsp; <input name="pwd"
								class="easyui-validatebox" required="true">
						</div>
					</form>
				</div>
				<div id="dlg-buttons">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-ok" onclick="submiteditUser()">保存</a> <a
						href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-cancel"
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