package com.yjg.controller;

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

import com.yjg.entity.Message;
import com.yjg.service.MessageService;



@Controller
@RequestMapping("/message")
public class MessageController {
	@Autowired
	private MessageService messageService;

	//群发信息
	@RequestMapping("/send")
	@ResponseBody
	public boolean insert(
			@RequestParam(value = "sourceFile", required = false) CommonsMultipartFile file,
	Message message,HttpSession session) throws Exception{
		
		/*Integer userId = (Integer) session.getAttribute("userId");
		boolean result = false;
		//如果文件不为空，则进行上传
		if(!file.isEmpty()){
			String path = session.getServletContext().getRealPath("/upload/");  //获取本地存储路径
			String fileName =  new Date().getTime()+userId+".jpg";
			path = path + "\\"+ fileName;
			File newFile = new File(path); 
			file.transferTo(newFile);
			message.setCover("upload/"+fileName);
		}
		
		message.setUserId(userId);
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		message.setDate(df.format(new Date()));
		System.out.println(message.getAppList());
		System.out.println(message.getContent());
		System.out.println(message.getDate());
		messageService.insert(message);		//把数据插入草稿箱	
		result = true;
		return result;*/
		return false;
	}
	
	//获取群发记录
	@RequestMapping("/getMessageList")
	@ResponseBody
	public Map<String, Object> getMessageList(String from, String to,
			Integer page, Integer rows, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		String myFrom = (from==null||from.equals("")) ? null : from + " 00:00:00";
		String myTo = (to==null||to.equals("")) ? null : to + " 00:00:00";
		Integer userId = (Integer) session.getAttribute("userId");
		Integer count = messageService.count(userId,myFrom,myTo);
		Integer myRows = (rows==null) ? 1 : rows;
		Integer myPage = (page==null) ? 10 : page;
		List<Message> ls = messageService.getMessageList(userId,myPage,myRows,myFrom,myTo);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("total", count);
		map.put("rows", ls);
		return map;
	}
		
	//获取已发记录中的一条记录(只显示)
	@RequestMapping("/getMessage")
	public String  getMessage(Model model,Integer id,HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		Message message = messageService.getMessage(id);
		model.addAttribute("message",message);
		return "message/message_detail";
	}
		
	//获取已发记录中的一条记录(到编辑页面)
	@RequestMapping("/getMessageEdit")
	public String  getMessageEdit(Model model,Integer id,HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		Message message = messageService.getMessage(id);
		model.addAttribute("message",message);
		return "message/message_edit";
	}
		
	//删除群发记录
	@RequestMapping("/delete")
	@ResponseBody
	public boolean  delete(Integer id,HttpServletRequest request,HttpServletResponse response,
			HttpSession session) throws Exception {
		boolean ret = true;
		try{
			messageService.delete(id);
		}catch(Exception e){
			ret = false;
		}
		return ret;
	}
	
}
