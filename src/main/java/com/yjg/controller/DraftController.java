package com.yjg.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.yjg.entity.Draft;
import com.yjg.service.DraftService;
import com.yjg.tools.LogMonitor;
import com.yjg.tools.LogMonitor.Logger;

@Controller
@RequestMapping("/draft")
public class DraftController{
	@Autowired
	private DraftService draftService;

	//存为草稿
	@RequestMapping("/storageDraft")
	@ResponseBody
	public boolean storageDraft(
			@RequestParam(value = "sourceFile", required = false) CommonsMultipartFile file,
			Draft draft, HttpSession session) throws Exception {

		Integer userId = (Integer) session.getAttribute("userId");
		boolean result = false;
		//如果文件不为空，则进行上传
		if(file != null){
			String path = session.getServletContext().getRealPath("/upload/");  //获取本地存储路径
			String fileName =  new Date().getTime()+userId+".jpg";
			path = path + "\\"+ fileName;
			File newFile = new File(path); 
			file.transferTo(newFile);
			draft.setCover("upload/"+fileName);
		}
		
		draft.setUserId(userId);
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		draft.setDate(df.format(new Date()));
		draftService.insertDraft(draft);		//把数据插入草稿箱	
		// 记录到日志
		LogMonitor.dataInsert("(" + session.getAttribute("type") + ")"
				+ session.getAttribute("name"), Logger.Draft);
		result = true;
		return result;
	}	
	
	//修改草稿箱记录
	@RequestMapping(value = "/updateDraft")
	@ResponseBody
	public boolean updateDraft(
			@RequestParam(value = "sourceFile", required = false) CommonsMultipartFile file,
			Draft draft, HttpSession session) throws Exception {

		Integer userId = (Integer) session.getAttribute("userId");
		boolean result = false;
		// 如果文件不为空，则进行上传
		if (file != null) {
			String path = session.getServletContext().getRealPath("/upload/"); // 获取本地存储路径
			String fileName = new Date().getTime() + userId + ".jpg";
			path = path + "\\" + fileName;
			File newFile = new File(path);
			file.transferTo(newFile);
			draft.setCover("upload/" + fileName);
		}

		draft.setUserId(userId);
		// 获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		draft.setDate(df.format(new Date()));
		draftService.updateDraft(draft); // 把数据插入草稿箱
		// 记录到日志
		LogMonitor.dataUpdate("(" + session.getAttribute("type") + ")"
				+ session.getAttribute("name"), Logger.Draft);
		result = true;
		return result;
	}
		
	//获取草稿箱记录列表
	@RequestMapping("/getDraftList")
	@ResponseBody
	public Map<String, Object> getDraftList(String from, String to,
			Integer page, Integer rows, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		String myFrom = (from==null||from.equals("")) ? null : from + " 00:00:00";
		String myTo = (to==null||to.equals("")) ? null : to + " 00:00:00";
		Integer userId = (Integer) session.getAttribute("userId");
		int count = draftService.count(userId,myFrom,myTo);
		Integer myRows = (rows==null) ? 1 : rows;
		Integer myPage = (page==null) ? 10 : page;
		List<Draft> ls = draftService.getDraftList(userId,myPage,myRows,myFrom,myTo);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("total", count);
		map.put("rows", ls);
		return map;
	}
	
	
	//获取草稿箱的一条记录
	@RequestMapping("/getDraft")
	public String getDraft(Model model, Integer id, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		Draft draft = draftService.getDraft(id);
		model.addAttribute("draft",draft);
		return "draft/draft_edit";
	}
	
	
	//删除草稿箱记录
	@RequestMapping("/delete")
	@ResponseBody
	public boolean delete(Integer id, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		boolean ret = true;
		try{
			draftService.delete(id);
		}catch(Exception e){
			ret = false;
		}
		// 记录到日志
		LogMonitor.dataDelete("(" + session.getAttribute("type") + ")"
				+ session.getAttribute("name"), Logger.Draft);
		return ret;
		
	}
	

}
