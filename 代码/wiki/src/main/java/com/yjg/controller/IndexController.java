package com.yjg.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/*
 * 负责jsp页面跳转
 * 所有jsp放到WEB-INF下安全性更高，不能通过链接直接访问
 */
@Controller
public class IndexController {

	@RequestMapping("/user_list")
	public String userList(){
		return "user/user_list";
	}
	
	@RequestMapping("/wiki_list")
	public String wikiList(){
		return "wiki/wiki_list";
	}
	
	@RequestMapping("/draft_list")
	public String draftList(){
		return "draft/draft_list";
	}
	
	@RequestMapping("/message_send")
	public String messageSend(){
		return "message/message_send";
	}
	
	@RequestMapping("/message_list")
	public String messageList(){
		return "message/message_list";
	}
}
