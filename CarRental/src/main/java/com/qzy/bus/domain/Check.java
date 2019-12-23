package com.qzy.bus.domain;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;


@Data
public class Check {
    private String checkid;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date checkdate;

    private String checkdesc;

    private String problem;

    private Double paymoney;

    private String opername;

    private String rentid;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createtime;


}