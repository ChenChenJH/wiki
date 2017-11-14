package com.yjg.toolsDTO;
/**
 * 素材类，用来封装上次素材所需要的信息
 * */
public class Articles {
	private String title;
	private String thumb_media_id;
	private String author;
	private String content;
	private String digest;
	private String content_source_url;
	private Integer show_cover_pic;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getThumb_media_id() {
		return thumb_media_id;
	}

	public void setThumb_media_id(String thumb_media_id) {
		this.thumb_media_id = thumb_media_id;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDigest() {
		return digest;
	}

	public void setDigest(String digest) {
		this.digest = digest;
	}

	public String getContent_source_url() {
		return content_source_url;
	}

	public void setContent_source_url(String content_source_url) {
		this.content_source_url = content_source_url;
	}

	public Integer getShow_cover_pic() {
		return show_cover_pic;
	}

	public void setShow_cover_pic(Integer show_cover_pic) {
		this.show_cover_pic = show_cover_pic;
	}

	@Override
	public String toString() {
		return "Articles [title=" + title + ", thumb_media_id="
				+ thumb_media_id + ", author=" + author + ", content="
				+ content + ", digest=" + digest + ", content_source_url="
				+ content_source_url + ", show_cover_pic=" + show_cover_pic
				+ "]";
	}

}
