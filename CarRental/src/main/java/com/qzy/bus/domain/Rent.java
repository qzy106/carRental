package com.qzy.bus.domain;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class Rent {
    private String rentid;

    private Double price;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date begindate;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date returndate;

    private Integer rentflag;

    private String identity;

    private String carnumber;

    private String opername;


    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createtime;

}