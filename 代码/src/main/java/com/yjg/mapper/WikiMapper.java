package com.yjg.mapper;

import java.util.List;
import java.util.Map;

import com.yjg.entity.Wiki;

public interface WikiMapper {

	//根据userId和appName条件查询所有
	public List<Wiki> selectAll(Map<String,Object> queryMap) throws Exception;

	//按Id删除
	public void delete(Integer id) throws Exception;
	
	//按userId删除，消除关联关系
	public void deleteByUserId(Integer userId) throws Exception;

	//更新
	public void update(Wiki wiki) throws Exception;

	//插入
	public void insert(Wiki wiki) throws Exception;

	//查询所有条数
	public Integer selectCount(Map<String, Object> queryMap) throws Exception;
	
	//查询所有，用于群发消息时显示公众号选择
	public List<Wiki> selectList(Integer userId) throws Exception;
}
