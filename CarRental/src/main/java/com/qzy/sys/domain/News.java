package com.qzy.sys.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

import java.util.Date;

@Data
public class News {
    private Integer id;

    private String title;

    private String content;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createtime;

    private String opername;


}