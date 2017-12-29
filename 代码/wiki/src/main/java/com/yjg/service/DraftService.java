package com.yjg.service;

import java.util.List;

import com.yjg.entity.Draft;

public interface DraftService {

	//按条件显示列表
	public List<Draft> getDraftList(Integer userId, Integer myPage, Integer myRows, String myFrom, String myTo) throws Exception;

	//返回数目
	public int count(Integer userId, String from, String to)throws Exception;

	//删除
	public void delete(Integer id)throws Exception;

	//获得一条记录
	public Draft getDraft(Integer id)throws Exception;
	
	//插入
	void insertDraft(Draft draft)throws Exception;
	//更新一条草稿箱记录
	public void updateDraft(Draft draft)throws Exception;
	
}
