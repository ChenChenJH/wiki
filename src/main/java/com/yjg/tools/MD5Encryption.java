package com.yjg.tools;

import org.apache.shiro.crypto.hash.SimpleHash;

/*
 * MD5加密密码
 */
public class MD5Encryption {
	public static String encrypt(Object credentials){
		String hashAlgorithmName = "MD5"; //加密类型
		Integer hashIterations = 100; //加密次数
		//Object salt = ByteSource.Util.bytes("user");
		Object salt = null;  //盐值
		Object result = new SimpleHash(hashAlgorithmName, credentials, salt, hashIterations);
		return result.toString();
	}
}
