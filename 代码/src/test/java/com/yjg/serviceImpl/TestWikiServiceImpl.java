package com.yjg.serviceImpl;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.yjg.entity.Wiki;
import com.yjg.service.WikiService;


@ContextConfiguration("classpath:applicationContext.xml")
public class TestWikiServiceImpl extends AbstractJUnit4SpringContextTests{
	
	@Autowired
	private WikiService wikiService;
	
	@Test
	public void testDelete() throws Exception{
		wikiService.delete(5);
	}
	
	@Test
	public void testInsert() throws Exception{
		Wiki wiki = new Wiki();
		wiki.setAppName("测试");
		wiki.setAppId("156431");
		wiki.setAppSecret("564135");
		wiki.setUserId(1);
		wikiService.insert(wiki);
	}

}
