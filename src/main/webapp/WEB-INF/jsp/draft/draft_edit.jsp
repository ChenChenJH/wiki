<%@page import="com.yjg.entity.Draft"%>
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
<script type="text/javascript" src="js/jquery-form.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
<script charset="utf-8" src="kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="kindeditor/lang/zh_CN.js"></script>
</head>
<script type="text/javascript">  
$(function() {  
    /*原理是把本地图片路径："D(盘符):/image/..."转为"http://..."格式路径来进行显示图片*/  
    $("#uploadId").change(function() {  
        var $file = $(this);  
        var objUrl = $file[0].files[0];  
        //获得一个http格式的url路径:mozilla(firefox)||webkit or chrome  
        var windowURL = window.URL || window.webkitURL;  
        //createObjectURL创建一个指向该参数对象(图片)的URL  
        var dataURL;  
        dataURL = windowURL.createObjectURL(objUrl);  
        $("#imageview").attr("src",dataURL);  
    });  
});  
</script>
<script type="text/javascript">
$(document).ready(function(){
	//获取DIV
	var myDIV = $('#myDIV').html();
	var strs = myDIV.split("/"); //字符分割 
	for(var i=0;i<strs.length-1;i++){
		var addElement = "<input type='hidden' class='textbox-value' name='' value='"+strs[i]+"'/>";
		$('span.textbox.combo').append(addElement);
	}
});
</script>
<body>
	<center>
		<h1>群发系统</h1>
	</center>
	<div class="easyui-layout"
		style="width: 1100px; height: 1100px; margin: 0 auto;">
		<p>
			欢迎你，${sessionScope.type}：${sessionScope.name}&nbsp;&nbsp;<a
				href="user/louginout" onclick="return loginout()">注销</a>
		<p>
		<div class="easyui-layout"
			style="width: 1100px; height: 1000px; margin: 0 auto;">
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
			<div id="content" region="center" title="群发信息" style="padding: 5px;">
				<div id="myDIV" style="display: none;">${draft.appList}</div>
				<div style="margin: 20px 0;"></div>
				<div class="easyui-panel" title="发送消息"
					style="width: 820px; height:1000px;">
					<div style="padding: 10px 60px 20px px;">
						<form id="ff" enctype="multipart/form-data">
							<table cellpadding="5">
								<input type="hidden" value="${draft.appList}" name="appList"
									id="wikiIds" />
								<input type="hidden" value="${draft.id}" name="id" id="draftId" />
								<tr>
									<td>群发公众号:</td>
									<td><select class="easyui-combogrid" style="width: 500px"
										data-options="panelWidth: 500,
							multiple: true,idField: 'appName',textField: 'appName',url: 'wiki/select_list',method: 'get',
							columns: [[{field:'ck',checkbox:true},
							{field:'id',title:'ID',width:80},
							{field:'appName',title:'公众号名称',width:100},
							{field:'appId',title:'开发者ID',width:80,align:'right'},
							{field:'appSecret',title:'开发者秘钥',width:80,align:'right'},]],fitColumns: true">
									</select></td>
								</tr>
								<tr>
									<td>标题:</td>
									<td><input class="easyui-textbox" type="text" name="title"
										data-options="required:true" value="${draft.title}"></input></td>
								</tr>
								<tr>
									<td>作者:</td>
									<td><input class="easyui-textbox" type="text"
										name="author" data-options="required:true"
										value="${draft.author}"></input></td>
								</tr>
								<tr>
									<td>原文url:</td>
									<td><input class="easyui-textbox" type="text"
										name="articleUrl" data-options="required:true"
										value="${draft.articleUrl}"></input></td>
								</tr>
								<tr>
									<td>内容简介</td>
									<td><input class="easyui-textbox" type="text"
										name="summary" data-options="required:true"
										value="${draft.summary}"></input></td>
								</tr>
								<tr>
									<td>内容:</td>
									<td><textarea name="content" id="info"
											style="border: 1px; width: 700px; height: 400px; visibility: hidden;">${draft.content}</textarea></td>
								</tr>
								<tr>
									<td>封面图</td>
									<td><input type="file" id="uploadId" name="sourceFile"
										style="width: 200px"> <img id="imageview"
										width="300px" height="300px" src="${draft.cover}" /></td>
								</tr>
							</table>
						</form>
						<div style="padding: 5px">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								onclick="submitForm()">发送</a> <a href="javascript:void(0)"
								class="easyui-linkbutton" onclick="submitForm()">定时发送</a> <a
								href="javascript:void(0)" class="easyui-linkbutton"
								onclick="submitForm3(${draft.id})">存草稿</a> <a
								href="javascript:void(0)" class="easyui-linkbutton"
								onclick="clearForm()">重置</a>
						</div>
					</div>
				</div>
			</div>
			<script type="text/javascript">
				function getWiKi() {
					var temp = $('#_easyui_textbox_input5').nextAll();
					var result = "";
					temp.each(function() {
						result += $(this).val() + "/";
					});
					return result;
				}
				function submitForm() {
					var result = window.getWiKi();
					$("#wikiIds").attr("value", result);
					 if($("#wikiIds").val() == ""){
				          alert("请选择要群发的公众号！");
				          return ;
				     }
					 if($("#title").val() == ""){
				          alert("标题不能为空！");
				          return ;
				     }
					 if($("#author").val() == ""){
				          alert("作者不能为空！");
				          return ;
				     }
					 if($("#summary").val() == ""){
				          alert("内容简介不能为空！");
				          return ;
				     }
					 if($("#info").val() == ""){
				          alert("内容不能为空！");
				          return ;
				     }
					/*$("#ff").attr("action", "message/test.action");
					$("#ff").attr("method", "post");
					$('#ff').form('submit');*/
				}
				
				//存储为草稿
				function submitForm3(draftId){
					var result = window.getWiKi();
					$("#wikiIds").attr("value", result);
			            var options = {
			                	type: "post",
			                    url : "draft/updateDraft",
			                    dataType: "text",
			                    success : function(data) {
			                    	if(data == 'true'){
			                        	alert("存稿成功!");
			                    	}else{
			                    		alert("存稿失败!");
			                    	}
			                    }
			            };
			            //jquery-form用插件异步提交
			            $('#ff').ajaxSubmit(options); 
				}
				function clearForm() {
					$('#ff').form('clear');
				}
			</script>

		</div>
	</div>
	<script type="text/javascript">
		var photos ="";
		KindEditor.ready(function(K) {
			window.editor = K.create('#info', {
				resizeType : 1,
				allowPreviewEmoticons : false,
				allowImageUpload : true,//允许上传图片
				allowFileManager : true, //允许对上传图片进行管理
				uploadJson : 'kindeditor/jsp/upload_json.jsp', //上传图片的java代码，只不过放在jsp中
				fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',
				afterUpload : function(data) {
					var temp = data + '-';
					photos += temp;
					//alert(hotos);
					alert(data);
					this.sync();
				}, //图片上传后，将上传内容同步到textarea中
				afterBlur : function() {
					this.sync();
				}, ////失去焦点时，将上传内容同步到textarea中
				items : [ 'fontname', 'fontsize', '|', 'forecolor',
						'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter',
						'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'link',
						'media', '|', 'image' ]
			});
		});
		
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