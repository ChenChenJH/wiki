package com.yjg.entity;

/*
 * 普通用户
 */
public class User {
	private Integer id; // 自增id
	private String userName; // 用户名称，作为唯一标识符
	private String pwd; // 密码

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

}
