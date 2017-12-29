package com.yjg.wikiReturn;

public class UploadImage {
	/**
	 * 接收上传图片返回的参数和上传素材成功返回的参数
	 * 1.类型
	 * 2.媒体ID
	 * 3.创建时间
	 * */
	
	private String type;
	private String media_id;
	private String created_at;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getMedia_id() {
		return media_id;
	}
	public void setMedia_id(String media_id) {
		this.media_id = media_id;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	
	
}
