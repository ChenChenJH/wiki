package com.yjg.entity;

/*
 * 管理员
 */
public class Admin {
	private Integer id;   //自增id
	private String adminName;   //管理员名称，作为唯一标识符
	private String pwd;   //密码

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

}
