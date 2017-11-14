package com.yjg.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yjg.entity.Draft;
import com.yjg.mapper.DraftMapper;
import com.yjg.service.DraftService;

@Service
public class DraftServiceImpl implements DraftService {
	@Autowired
	private DraftMapper draftMapper;
	
	//插入
	public void insertDraft(Draft draft) throws Exception {
		draftMapper.insertDraft(draft);
	}

	// 统计总数
	public int count(Integer userId, String from, String to) throws Exception {
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("userId", userId);
		queryMap.put("from", from);
		queryMap.put("to", to);
		return draftMapper.count(queryMap);
	}

	// 获取所有草稿记录
	public List<Draft> getDraftList(Integer userId, Integer myPage,
			Integer myRows, String myFrom, String myTo) throws Exception {
		int start = (myPage - 1) * myRows;
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("userId", userId);
		queryMap.put("start", start);
		queryMap.put("rows", myRows);
		queryMap.put("from", myFrom);
		queryMap.put("to", myTo);
		return draftMapper.getDraftList(queryMap);
	}

	// 获取一条草稿
	public Draft getDraft(Integer id) throws Exception {
		return draftMapper.getDraft(id);
	}

	// 删除草稿
	public void delete(Integer id) throws Exception {
		draftMapper.delete(id);
	}

	//更新一条草稿箱记录
	public void updateDraft(Draft draft) throws Exception {
		draftMapper.updateDraft(draft);	
	}

}
