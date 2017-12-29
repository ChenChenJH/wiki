package com.yjg.tools;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/*
 * 日志监控
 */
public class LogMonitor {
	//用枚举指定日志监控的对象
	public enum Logger{
		User,Wiki,Draft,Message
	}
	
	public static void login(String username) throws Exception{
		addLog(username,"登录了");
	}
	
	public static void dataDelete(String username,Logger logger) throws Exception{
		addLog(username,"删除了一个"+logger);
	}

	public static void dataUpdate(String username,Logger logger) throws Exception{
		addLog(username,"修改了一个"+logger);
	}

	public static void dataInsert(String username,Logger logger) throws Exception{
		addLog(username,"增加了一个"+logger);
	}
	
	public static void addLog(String username,String log) throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
		PrintWriter pw = new PrintWriter(new FileWriter(new File(
				"D:/workspace/eclipseJ2ee/wiki/logging/logging.txt"), true));
		pw.println("------------------------");
		pw.println(username+"\t"+log+"\t"+sdf.format(new Date()));
		pw.flush();
		pw.close();
	}
}
