package com.yjg.service;

import java.util.List;

import com.yjg.entity.Message;

public interface MessageService {
	//发送消息
	void insert(Message message) throws Exception;

	//统计所有已发记录条数
	Integer count(Integer userId, String myFrom, String myTo)throws Exception;

	//获取所有已发记录
	List<Message> getMessageList(Integer userId, Integer myPage, Integer myRows,String myFrom, String myTo)throws Exception;

	//删除某条已发记录
	void delete(Integer id)throws Exception;

	//获取某条已发记录
	Message getMessage(Integer id) throws Exception;
}
