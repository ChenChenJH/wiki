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
	function editDraft() {
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			location.href = 'draft/getDraft?id=' + row.id;
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
	function destroyDraft() {
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$.messager.confirm('Confirm', '确定要删除该草稿？', function(r) {
				if (r) {
					$.post('draft/delete', {
						id : row.id
					}, function(result) {
						//alert(result)
						if (result == true) {
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
		//alert("sadf");
		var from = $('#from').val();
		var to = $('#to').val();
		if (from == '' && to == '') {
			$('#dg').datagrid('load', {
				from : from.trim(),
				to : to.trim(),
			});

		} else {
			if (from != '' && to != '') {
				if (from < to) {
					$('#dg').datagrid('load', {
						from : from.trim(),
						to : to.trim(),
					});
				} else {
					alert('填写的日期格式错误');
				}
			} else {
				alert('请填写日期');
			}
		}
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
			<div id="content" region="center" title="草稿箱" style="padding: 5px;">
				<table id="dg" class="easyui-datagrid"
					style="width: 850px; height: 390px"
					data-options="rownumbers:true,pagination:true,pageSize:10,singleSelect:true,url:'draft/getDraftList',method:'get',toolbar:'#tb'">
					<thead>
						<tr>
							<th data-options="field:'appList',width:250,align:'center'">收信公众号</th>
							<th data-options="field:'title',width:250,align:'center'">主题</th>
							<th data-options="field:'date',width:300,align:'center'">时间</th>
						</tr>
					</thead>
				</table>
				<div id="tb" style="padding: 5px; height: auto">
					<div style="margin-bottom: 5px">
						<a class="easyui-linkbutton" iconCls="icon-edit" plain="true"
							onclick="editDraft()">编辑</a> <a class="easyui-linkbutton"
							iconCls="icon-cut" plain="true" onclick="destroyDraft()">删除</a>
					</div>
					<div>
						Date From: <input class="easyui-datebox" style="width: 100px"
							id="from" /> To: <input class="easyui-datebox"
							style="width: 100px" id="to" /> <a class="easyui-linkbutton"
							iconCls="icon-search" onclick="doSearch()">Search</a>
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