package com.yjg.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yjg.entity.LoginDTO;
import com.yjg.entity.User;
import com.yjg.service.UserService;
import com.yjg.tools.LogMonitor;
import com.yjg.tools.MD5Encryption;
import com.yjg.tools.LogMonitor.Logger;
import com.yjg.toolsDTO.DataGridResult;
import com.yjg.toolsDTO.ResultType;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;

	// 登录
	@RequestMapping(value="/login",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String isLogin(LoginDTO loginDTO, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		String result = "true";
		Subject currentUser = SecurityUtils.getSubject();
		//获取shiro的session，存数据
		Session shiroSession = currentUser.getSession();
		shiroSession.setAttribute("type", loginDTO.getType());
		//判断用户是否登录，如果未登录则进行登录
		if (!currentUser.isAuthenticated()) {
			// 把用户名和密码封装为 UsernamePasswordToken 对象
			UsernamePasswordToken token = new UsernamePasswordToken(
					loginDTO.getName(), loginDTO.getPwd());
			// 记住我
			// token.setRememberMe(true);
			try {
				// 执行登录.
				currentUser.login(token);
			} catch (UnknownAccountException e) {
				return "用户不存在";
			} catch (Exception e) {
				return "密码错误!";
			}
			
			// 开启session会话，保存登录信息
			session.setAttribute("name", loginDTO.getName());
			session.setAttribute("type", loginDTO.getType());
			if (loginDTO.getType().equals("普通用户")) {
				// 保存该用户的userId，用于添加公众号时可以关联
				session.setAttribute("userId", (int)shiroSession.getAttribute("userId")); 
			}
			// 记录到日志
			LogMonitor.login("(" + loginDTO.getType() + ")" + loginDTO.getName());
		}
		return result;
	}

	//按条件查询
	@RequestMapping("/userList")
	@ResponseBody
	public DataGridResult UserList(String userName, Model model,
			@RequestParam(value = "page", defaultValue = "1") Integer page,
			Integer rows) throws Exception {
		List<User> list = userService.listAll(userName, page, rows);
		Integer total = userService.count();
		DataGridResult result = new DataGridResult(total, list);
		model.addAttribute(result);
		return result;
	}
	
	//增加
	@RequestMapping("/addUser")
	@ResponseBody
	public ResultType addUser(User user, HttpSession session) throws Exception{
		user.setPwd(MD5Encryption.encrypt(user.getPwd()));
		ResultType resultType = userService.addUser(user);
		// 记录到日志
		LogMonitor.dataInsert("(" + session.getAttribute("type") + ")"
				+ session.getAttribute("name"), Logger.User);
		return resultType;
	}
	
	//修改
	@RequestMapping("/updateUser")
	@ResponseBody
	public ResultType updateUser(User user, HttpSession session)
			throws Exception {
		user.setPwd(MD5Encryption.encrypt(user.getPwd()));
		ResultType resultType = userService.updateUser(user);
		// 记录到日志
		LogMonitor.dataUpdate("(" + session.getAttribute("type") + ")"
				+ session.getAttribute("name"), Logger.User);
		return resultType;
	}
	
	//删除
	@RequestMapping("/deleteUser")
	@ResponseBody
	public ResultType deleteUser(Integer userId, HttpSession session)
			throws Exception {
		ResultType resultType = userService.deleteUser(userId);
		// 记录到日志
		LogMonitor.dataDelete("(" + session.getAttribute("type") + ")"
				+ session.getAttribute("name"), Logger.User);
		return resultType;
	}

}
