package com.qzy.sys.domain;

import java.util.Date;


import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class LogInfo {
    private Integer id;

    private String loginname;

    private String loginip;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date logintime;

}