<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	var code = "";
	function change() {
		code = "";
		var codeLength = 4; //验证码的长度
		var checkCode = document.getElementById("change");
		var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c',
				'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
				'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A',
				'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
				'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，当然也可以用中文的
		for (var i = 0; i < codeLength; i++) {
			var charNum = Math.floor(Math.random() * 52);
			code += codeChars[charNum];
		}
		checkCode.innerHTML = '<font size="4px;">' + code + '</font>';
	}
	window.onload = function() {
		change();
	}
</script>
<body>
	<center>
		<h2>群发系统</h2>
		<div style="margin: 20px 0;"></div>
		<div class="easyui-panel" title="New Topic" style="width: 400px">
			<div style="padding: 10px 60px 20px 60px">
				<form id="ff" method="post">

					<table cellpadding="5">
						<tr>
							<td>用户名:</td>
							<td><input class="easyui-textbox" type="text" name="name"
								 data-options="required:true" /></td>
						</tr>
						<tr>
							<td>密码:</td>
							<td><input class="easyui-textbox" type="password" name="pwd"
								 data-options="required:true" /></td>
						</tr>
						<tr>
							<td>角色:</td>
							<td><select class="easyui-combobox"
								data-options="panaHeight:auto;" name="type">
									<option>普通用户</option>
									<option>管理员</option>
							</select></td>
						</tr>
						<tr>
							<td>验证码:</td>
							<td><input size="10px" class="easyui-textbox" type="text"
								id="yzm" /><a style="margin-left: 4px;"
								href="javascript:void(0)" class="easyui-linkbutton"
								onclick="change()" id="change"></a></td>
						</tr>
					</table>
				</form>
				<div style="text-align: center; padding: 5px">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="submitForm()">登录</a> <a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="clearForm()">重置</a>
				</div>
			</div>
		</div>
	</center>
	<script>
		function submitForm() {
			var checkCode = $('#yzm').val().trim();
			if(checkCode == null|| checkCode == ''){
				 alert('请输入验证码!');
				return;
			}
			if (checkCode.toUpperCase() == code.toUpperCase()) {

				$('#ff').form('submit', {
					url : 'user/login',
					success : function(data) {
						if(data == 'true'){
				    		  location.href ="index.jsp";
				    	  }else{
				    		 alert(data);
				    	 }
					}
				});
			} else {
				alert('验证码错误');
			}
		}
		function clearForm() {
			$('#ff').form('clear');
		}
	</script>
</body>