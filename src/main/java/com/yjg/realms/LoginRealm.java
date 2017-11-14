package com.yjg.realms;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;

import com.yjg.entity.Admin;
import com.yjg.entity.User;
import com.yjg.service.UserService;



/*
 * 仅实现认证承继AuthenticatingRealm
 */
public class LoginRealm extends AuthenticatingRealm {
	
	@Autowired
	private UserService userService;
	
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		// 1. 把 AuthenticationToken 转换为 UsernamePasswordToken
		UsernamePasswordToken upToken = (UsernamePasswordToken) token;

		// 2. 从 UsernamePasswordToken 中来获取 username
		String username = upToken.getUsername();
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		String type = (String) session.getAttribute("type");
		// 3. 调用数据库的方法, 从数据库中查询 username 对应的用户记录
		if(type.equals("普通用户")){
			User user = null;
			try {
				user = userService.selectUser(username);
			} catch (MyBatisSystemException e) {
				System.out.println("数据库连接有误");
			} catch (Exception e) {
				System.out.println("service层出错了");
			}
			if(user == null){
				return null;
			}else{
				Object principal = username;
				Object credentials = user.getPwd();
				// realmName: 当前 realm 对象的 name. 调用父类的 getName() 方法即可
				String realmName = getName();
				SimpleAuthenticationInfo info = null; 
				info = new SimpleAuthenticationInfo(principal, credentials, realmName);
				//用shiro的session存从数据库查出来的userId,以便在UserController获取
				session.setAttribute("userId", user.getId());
				return info;
			}
		}else{
			Admin admin = null;
			try {
				admin = userService.selectAdmin(username);
			} catch (MyBatisSystemException e) {
				System.out.println("数据库连接有误");
			} catch (Exception e) {
				System.out.println("service层出错了");
			}
			if(admin == null){
				return null;
			}else{
				Object principal = username;
				Object credentials = admin.getPwd();
				// realmName: 当前 realm 对象的 name. 调用父类的 getName() 方法即可
				String realmName = getName();
				SimpleAuthenticationInfo info = null; 
				info = new SimpleAuthenticationInfo(principal, credentials, realmName);
				return info;
			}
		}
		
	}
	
}
