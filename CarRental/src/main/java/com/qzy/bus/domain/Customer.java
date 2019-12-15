package com.qzy.bus.domain;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

@Data
public class Customer {
    private String identity;

    private String custname;

    private Integer sex;

    private String address;

    private String phone;

    private String career;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createtime;


}