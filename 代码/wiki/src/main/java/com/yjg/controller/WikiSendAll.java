package com.yjg.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.yjg.entity.Message;
import com.yjg.tools.FileUpload;
import com.yjg.tools.HttpUtils;
import com.yjg.tools.JsonUtils;
import com.yjg.toolsDTO.Articles;
import com.yjg.toolsDTO.ResultType;
import com.yjg.wikiReturn.AccessToken;
import com.yjg.wikiReturn.SendAllReturn;
import com.yjg.wikiReturn.UploadImage;
import com.yjg.wikiReturn.WikiSendTools;

@Controller
public class WikiSendAll {
	
	//上传素材接口
	@Value("${WIKI_UPLOADNEWS}")
	public String WIKI_UPLOADNEWS;
	//上传临时图片
	@Value("${WIKI_UPLOAD}")
	public String WIKI_UPLOAD;
	//上传永久图片
	@Value("${WIKI_ADDMATERIAL}")
	public String WIKI_ADDMATERIAL;
	//获取token
	@Value("${WIKI_ACCESSTOKEN}")
	public String WIKI_ACCESSTOKEN;
	//群发
	@Value("${WIKI_SENDALL}")
	public String WIKI_SENDALL;
	
	//TOKEN属性
	@Value("${WIKI_APPID}")
	private String WIKI_APPID;
	@Value("${WIKI_SECRET}")
	private String WIKI_SECRET;
	@Value("${WIKI_GRANT_TYPE}")
	private String WIKI_GRANT_TYPE;
	
	//token
	@Value("${WIKI_TOKEN}")
	private String WIKI_TOKEN;
	
	
	@RequestMapping("wiki/sendAll")
	@ResponseBody
	public ResultType sendAll(Message message, String ids,
			MultipartFile sourceFile) throws IOException {
		// 调用上传图片的接口，获取media_id
		String media_id = UploadImage(sourceFile);
		//调用上传素材的接口，获取素材media_id
		UploadImage material = UploadMaterial(message,media_id);
		//上传成功，准备群发
		ResultType resultType = postAll(material);
		return resultType;
	}
	
	
	
	
	
	//获取token
	@SuppressWarnings("unused")
	private String getAccessToken() throws Exception{
		Map<String, String> params = new HashMap<>();
		params.put("appid", WIKI_APPID);
		params.put("secret", WIKI_SECRET);
		params.put("grant_type", WIKI_GRANT_TYPE);
		String string  = HttpUtils.sendGet(WIKI_ACCESSTOKEN, params);
		System.out.println(string);
		AccessToken access_token = JsonUtils.jsonToPojo(string, AccessToken.class);
		return access_token.getAccess_token();
	}
	
	//上传图片
	@SuppressWarnings("static-access")
	public String UploadImage(MultipartFile sourceFile) throws IOException{
		
		FileUpload upload = new FileUpload();
		//String access_token = getAccessToken();WIKI_ADDMATERIAL
		String sendUrl = WIKI_UPLOAD + WIKI_TOKEN + "&type=image";
		String mStrings = upload.send(sendUrl, sourceFile.getOriginalFilename(), sourceFile.getInputStream());
		System.out.println(mStrings);
		//UploadFoverImage uploadImage = JsonUtils.jsonToPojo(mString, UploadFoverImage.class);
		UploadImage uploadImage = JsonUtils.jsonToPojo(mStrings, UploadImage.class);
		System.out.println(uploadImage.getMedia_id());
		return uploadImage.getMedia_id();
	}
	
	//上传图文素材 获取media_id
	public UploadImage UploadMaterial(Message message,String media_id) throws IOException{
		
		System.out.println(message.toString());
		Articles articles1 = new Articles();
		articles1.setContent_source_url(message.getArticleUrl());
		articles1.setDigest(message.getSummary());
		articles1.setShow_cover_pic(1);
		articles1.setAuthor(message.getAuthor());
		articles1.setContent(message.getContent());
		articles1.setThumb_media_id(media_id);
		Map<String, List<Articles>> articles = new HashMap<>();
		List<Articles> articles2 = new ArrayList<>();
		articles2.add(articles1);
		articles.put("articles", articles2);
		String mString = JsonUtils.objectToJson(articles);
		String results = HttpUtils.sendPostBuffer(WIKI_UPLOADNEWS + WIKI_TOKEN, mString);
		System.out.println(mString);
		System.out.println(results);
		UploadImage material  = JsonUtils.jsonToPojo(results, UploadImage.class);
		return material;
	}
	
	//群发json打包发送
	@SuppressWarnings("static-access")
	public ResultType postAll(UploadImage material) throws IOException{
		SendAllReturn articleResult = null;
		if(material.getMedia_id() != null && !material.getMedia_id().equals("")){
			WikiSendTools sendArticle = new WikiSendTools();
			String mpnews = sendArticle.sendMpnews(material.getMedia_id());
			String result = HttpUtils.sendPostBuffer(WIKI_SENDALL + WIKI_TOKEN , mpnews);
			System.out.println(result);
			if(result!=null){
				articleResult = JsonUtils.jsonToPojo(result, SendAllReturn.class);
				if(articleResult.getErrcode().equals("0")){
					return ResultType.ok();
				}
			}
		}
		return ResultType.build(500,articleResult.getErrmsg());
	}
	
}
