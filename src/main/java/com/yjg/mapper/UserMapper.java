package com.yjg.mapper;

import java.util.List;
import java.util.Map;

import com.yjg.entity.Admin;
import com.yjg.entity.User;

public interface UserMapper {
	// 查询用户能否登录
	public User selectUser(User user) throws Exception;

	// 查询管理员能否登录
	public Admin selectAdmin(Admin admin) throws Exception;

	// 根据userId和appName条件查询所有
	public List<User> selectAll(Map<String, Object> queryMap);

	// 按id删除
	int delete(Integer id) throws Exception;

	// 更新
	int update(User user) throws Exception;

	// 插入
	int insert(User user) throws Exception;

	// 删除用户
	int deleteById(Integer Id) throws Exception;

	// 根据用户名查询用户
	public User findByUserName(String userName) throws Exception;

	// 用户数量
	int count() throws Exception;
}
