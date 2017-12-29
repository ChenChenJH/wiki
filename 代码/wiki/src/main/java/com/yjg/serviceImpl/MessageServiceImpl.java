package com.yjg.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yjg.entity.Message;
import com.yjg.mapper.MessageMapper;
import com.yjg.service.MessageService;

@Service
public class MessageServiceImpl implements MessageService{
	@Autowired
	private  MessageMapper messageMapper;

	//群发信息
	public void insert(Message message)
			throws Exception {
		// TODO Auto-generated method stub
	}
	
	//查询已发记录条数
	public Integer count(Integer userId, String myFrom, String myTo)throws Exception {
		Map<String,Object> queryMap = new HashMap<String,Object>();
		queryMap.put("userId", userId);
		queryMap.put("from", myFrom);
		queryMap.put("to", myTo);
		return messageMapper.count(queryMap);
	}
	
	//获取已发记录
	public List<Message> getMessageList(Integer userId, Integer myPage,
			Integer myRows, String myFrom, String myTo) throws Exception {
		int start=(myPage-1)*myRows;
		Map<String,Object> queryMap = new HashMap<String,Object>();
		queryMap.put("userId", userId);
		queryMap.put("start", start);
		queryMap.put("rows", myRows);
		queryMap.put("from", myFrom);
		queryMap.put("to", myTo);
		return messageMapper.getMessageList(queryMap);
	}
	
	//获取一条已发记录
	public Message getMessage(Integer id) throws Exception {
		return messageMapper.getMessage(id);
	}
	
	//删除
	public void delete(Integer id) throws Exception {
		messageMapper.delete(id);
	}
}
