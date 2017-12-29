package com.yjg.mapper;

import java.util.List;
import java.util.Map;

import com.yjg.entity.Draft;

public interface DraftMapper {
	
	//查询
	public List<Draft> getDraftList(Map<String, Object> queryMap) throws Exception;

	//删除
	public void delete(Integer id) throws Exception;
	
	// 按userId删除，消除关联关系
	public void deleteByUserId(Integer userId) throws Exception;
	
	//查询总数
	public Integer count(Map<String, Object> queryMap) throws Exception;

	//按id查询
	public Draft getDraft(Integer id) throws Exception;
	
	// 插入
	public void insertDraft(Draft draft)throws Exception;

	//修改
	public void updateDraft(Draft draft) throws Exception;

}
