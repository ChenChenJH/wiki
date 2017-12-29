package com.yjg.tools;

import org.springframework.core.convert.converter.Converter;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

/*
 * 文件转换器
 * 异步上传文件，如果文件为空会自动赋一个空字符串的值，这样会使程序错误而无法执行
 * 需要转换成null
 */
public class SpringMVCFileConverter implements Converter<String, CommonsMultipartFile>  {

    public SpringMVCFileConverter() {
        super();
    }

    @Override
    public CommonsMultipartFile convert(String source) {
        return null;
    }
}