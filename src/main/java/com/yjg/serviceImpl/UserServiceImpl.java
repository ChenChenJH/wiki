package com.yjg.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yjg.entity.Admin;
import com.yjg.entity.User;
import com.yjg.mapper.DraftMapper;
import com.yjg.mapper.MessageMapper;
import com.yjg.mapper.UserMapper;
import com.yjg.mapper.WikiMapper;
import com.yjg.service.UserService;
import com.yjg.toolsDTO.ResultType;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private WikiMapper wikiMapper;
	
	@Autowired
	private DraftMapper draftMapper;
	
	@Autowired
	private MessageMapper messageMapper;

	// 查询用户能否登录
	@Override
	public User selectUser(String name) throws Exception {
		User user = new User();
		user.setUserName(name);
		return userMapper.selectUser(user);
	}
	
	// 查询管理员能否登录
	@Override
	public Admin selectAdmin(String name) throws Exception {
		Admin admin = new Admin();
		admin.setAdminName(name);
		return userMapper.selectAdmin(admin);
	}
	
	// 查询全部用户
	@Override
	public List<User> listAll(String userName, Integer page, Integer rows) {
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("userName", userName);
		int start = (page - 1) * rows;
		queryMap.put("start", start);
		queryMap.put("rows", rows);
		return userMapper.selectAll(queryMap);
	}

	// 新增用户
	@Override
	public ResultType addUser(User user) throws Exception {
		User exituser = userMapper.findByUserName(user.getUserName());
		if (exituser != null) {
			return ResultType.build(500, "用户已存在！");
		}
		try {
			userMapper.insert(user);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ResultType.ok();
	}

	// 更新用户
	@Override
	public ResultType updateUser(User user) throws Exception {
		User exituser = userMapper.findByUserName(user.getUserName());
		if (exituser != null && exituser.getId() != user.getId()) {
			return ResultType.build(500, "用户已存在！");
		}
			userMapper.update(user);
		return ResultType.ok();
	}

	// 删除用户及其管理的公众号
	@Override
	public ResultType deleteUser(Integer userId) throws Exception {
			// 按id删除该用户
			userMapper.deleteById(userId);
			//关联删除其公众号
			wikiMapper.deleteByUserId(userId);
			//关联删除其草稿箱内容
			draftMapper.deleteByUserId(userId);
			//关联删除其群发过的信息
			messageMapper.deleteByUserId(userId);
		return ResultType.ok();
	}

	//返回数目
	@Override
	public int count() throws Exception {
		return userMapper.count();
	}

}
