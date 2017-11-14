package com.yjg.wikiReturn;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.yjg.tools.JsonUtils;

/**
 * 群发消息工具类
 * */
public class WikiSendTools {
	
	public static String sendMpnews(String media_id) throws IOException{
		Map<String, Object> filter = new HashMap<>();
		filter.put("is_to_all", true);
		Map<String, String> mpnews = new HashMap<>();
		mpnews.put("media_id", media_id);
		Map<Object, Object> params = new HashMap<>();
		params.put("filter", filter);
		params.put("mpnews", mpnews);
		params.put("msgtype", "mpnews");
		params.put("send_ignore_reprint", 0);
		String mpnewsJson = JsonUtils.objectToJson(params);
		System.out.println(mpnewsJson);
		return mpnewsJson;
	} 
	
}
