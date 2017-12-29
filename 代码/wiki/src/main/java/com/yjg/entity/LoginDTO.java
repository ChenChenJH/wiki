package com.yjg.entity;

/*
 * 数据传输对象,接收登录信息
 */
public class LoginDTO {
	private String name; //接收输入的用户名
	private String pwd;  //接收输入的密码
	private String type;  //接收输入的角色类型

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
