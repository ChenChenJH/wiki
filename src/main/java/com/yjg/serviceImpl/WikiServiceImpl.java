package com.yjg.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yjg.entity.Wiki;
import com.yjg.mapper.WikiMapper;
import com.yjg.service.WikiService;

@Service
public class WikiServiceImpl implements WikiService {
	@Autowired
	private WikiMapper wikiMapper;

	// 查询
	public List<Wiki> selectAll(Integer userId, String appName, Integer page,
			Integer rows) throws Exception {
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("userId", userId);
		queryMap.put("appName", appName);
		int start=(page-1)*rows;
		queryMap.put("start", start);
		queryMap.put("rows", rows);
		return wikiMapper.selectAll(queryMap);
	}
	
	//查询选择列表
	public List<Wiki> selectList(Integer userId) throws Exception {
		
		return wikiMapper.selectList(userId);
	}
	
	// 插入
	public void insert(Wiki wiki) throws Exception {
		wikiMapper.insert(wiki);
	}

	// 修改
	public void update(Wiki wiki) throws Exception {
		wikiMapper.update(wiki);
	}

	// 删除
	public void delete(Integer id) throws Exception {
		wikiMapper.delete(id);
	}

	//查找总数
	public Integer count(Integer userId, String appName, Integer page,
			Integer rows) throws Exception {
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("userId", userId);
		queryMap.put("appName", appName);
		return wikiMapper.selectCount(queryMap);
		
	}

	


}
