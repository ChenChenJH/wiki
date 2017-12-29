package com.yjg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yjg.entity.Wiki;
import com.yjg.service.WikiService;
import com.yjg.tools.LogMonitor;
import com.yjg.tools.LogMonitor.Logger;

@Controller
@RequestMapping("/wiki")
public class WikiController {
	@Autowired
	private WikiService wikiService;

	//显示列表(get)
	@RequestMapping("/select_list")
	@ResponseBody
	public List<Wiki> selectList(HttpSession session) throws Exception{
		Integer userId = (Integer) session.getAttribute("userId");
		List<Wiki> wikiList = wikiService.selectList(userId);
		return wikiList;
	}
	
	//显示列表
	@RequestMapping("/list")
	@ResponseBody
	public Map<String, Object> list(String appName, Model model,
			@RequestParam(value = "page", defaultValue = "1") Integer page,
			Integer rows, HttpSession session) throws Exception {

		Integer userId = (Integer) session.getAttribute("userId");
		Integer count = wikiService.count(userId,appName,page,rows);
		List<Wiki> wikiList = wikiService.selectAll(userId,appName,page,rows);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rows", wikiList);
		map.put("total", count);
		return map;
	}
	
	//插入
	@RequestMapping(value="/insert", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String insert(Wiki wiki,HttpSession session) throws Exception{
		String result = "true";
		try{
			//从session中获取userId的值
			Integer userId = (Integer) session.getAttribute("userId");
			wiki.setUserId(userId);
			wikiService.insert(wiki);
			// 记录到日志
			LogMonitor.dataInsert("(" + session.getAttribute("type") + ")"
					+ session.getAttribute("name"), Logger.Wiki);
		} catch (Exception e) {
			result = "该公众号已经存在！";
		}
		return result;
	}
	
	//更新
	@RequestMapping(value="/update",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String update(Wiki wiki,HttpSession session) throws Exception{
		String result = "true";
		try {
			wikiService.update(wiki);
			// 记录到日志
			LogMonitor.dataUpdate("(" + session.getAttribute("type") + ")"
					+ session.getAttribute("name"), Logger.Wiki);
		} catch (Exception e) {
			result = "该公众号已经存在！";
		}
		return result;
	}
	
	//删除
	@RequestMapping("/delete")
	@ResponseBody
	public boolean delete(Integer id,Model model,HttpSession session) throws Exception{
		boolean result = false;
		wikiService.delete(id);
		//记录到日志
		LogMonitor.dataDelete("(" + session.getAttribute("type") + ")"
				+ session.getAttribute("name"), Logger.Wiki);
		result = true;
		return result;
	}
	
	
}
