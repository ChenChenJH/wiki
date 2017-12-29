开发人员有:陈金华、陈佛鑫、阮成斌、罗志祥

开发说明:
1.本项目基于jdk1.7 + mysql5.5 + tomcat7环境下开发
2.用maven部署项目,用Spring+Mybatis+Springmvc进行开发，所有编码格式均为utf-8
3.使用者分为管理员和普通用户两个角色，有用户管理、公众号管理、群发管理三个模块外加日志监控功能.

注意事项：
1.本项目用了shiro框架做登录认证，运行前确保eclipse在jre环境下，而不是jdk环境
2.修改com.yjg.tools.LogMonitor类中addLog方法用到的路径，logging.txt路径改为项目workspace的真实路径
3.数据库所有账号密码均为123