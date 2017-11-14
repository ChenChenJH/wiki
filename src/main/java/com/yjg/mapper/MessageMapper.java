package com.yjg.mapper;

import java.util.List;
import java.util.Map;

import com.yjg.entity.Message;

public interface MessageMapper {
	// 发送消息
	public void insert(Message message) throws Exception;

	// 按userId删除，消除关联关系
	public void deleteByUserId(Integer userId) throws Exception;

	// 统计已发记录
	public int count(Map<String, Object> queryMap) throws Exception;

	// 获取已发记录
	public List<Message> getMessageList(Map<String, Object> queryMap) throws Exception;

	// 删除一条已发记录
	public void delete(Integer id) throws Exception;

	// 获取一条已发记录
	public Message getMessage(Integer id) throws Exception;
}
