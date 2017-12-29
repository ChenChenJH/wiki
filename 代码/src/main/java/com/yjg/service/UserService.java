package com.yjg.service;

import java.util.List;

import com.yjg.entity.Admin;
import com.yjg.entity.User;
import com.yjg.toolsDTO.ResultType;

public interface UserService {

	// 查询用户能否登录
	public User selectUser(String userName) throws Exception;

	// 查询管理员能否登录
	public Admin selectAdmin(String adminName) throws Exception;

	//按条件查询
	List<User> listAll(String userName, Integer page, Integer rows) throws Exception;

	//增加
	ResultType addUser(User user) throws Exception;

	//修改
	ResultType updateUser(User user) throws Exception;

	//删除
	ResultType deleteUser(Integer userId) throws Exception;

	//返回数目
	int count() throws Exception;
}
