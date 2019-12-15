package com.qzy.bus.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("bus")
public class BusController {

    //跳转到客户管理页面
    @RequestMapping("toCustomerManager")
    public String toCustomerManager() {
        return "business/customer/customerManager";
    }

    //跳转到车辆管理页面
    @RequestMapping("toCarManager")
    public String toCarManager() {
        return "business/car/carManager";
    }
}
