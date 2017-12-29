package com.yjg.entity;

/*
 * 公众号
 */
public class Wiki {
	private Integer id;  //自增id
	private String appName;  //公众号名称，用来辨别公众号
	private String appId;   //公众号开发者id
	private String appSecret;   //公众号开发者密码
	private Integer userId;  //被托管的用户id,多对一关系
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getAppSecret() {
		return appSecret;
	}

	public void setAppSecret(String appSecret) {
		this.appSecret = appSecret;
	}

}
