package com.qzy.bus.domain;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

@Data
public class Car {
    private String carnumber;

    private String cartype;

    private String color;

    private Double price;

    private Double rentprice;

    private Double deposit;

    private Integer isrenting;

    private String description;

    private String carimg;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createtime;


}