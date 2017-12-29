package com.yjg.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

/*
 * 全局异常处理
 */
public class ExceptionResolver implements HandlerExceptionResolver {
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		CustomException testException = null;
		if (ex instanceof CustomException) {
			testException = (CustomException) ex;
		} else {
			testException = new CustomException("未知错误!请和管理员联系");
		}
		// 跳转到错误页面
		String message = testException.getMessage();
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("message", message);
		modelAndView.setViewName("forward:/error.jsp");
		return modelAndView;
	}

}
