package com.yjg.service;

import java.util.List;

import com.yjg.entity.Wiki;

public interface WikiService {

	// 查询
	List<Wiki> selectAll(Integer userId,String appName, Integer page, Integer rows) throws Exception;
	
	// 插入
	void insert(Wiki wiki) throws Exception;

	// 修改
	void update(Wiki wiki) throws Exception;

	// 删除
	void delete(Integer id) throws Exception;

	//查找总数
	Integer count(Integer userId, String appName, Integer page, Integer rows)throws Exception;

	//返回公众号列表，给群发时选择
	List<Wiki> selectList(Integer userId) throws Exception;
}
