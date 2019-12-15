package com.qzy.sys.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("sys")
public class SysController {


    @RequestMapping("toMenuManager")
    public String toMenuManager() {
        return "system/menu/menuManager";
    }

    @RequestMapping("toMenuLeft")
    public String toMenuLeft() {
        return "system/menu/menuLeft";
    }


    @RequestMapping("toMenuRight")
    public String toMenuRight() {
        return "system/menu/menuRight";
    }

    @RequestMapping("toRoleManager")
    public String toRoleManager() {
        return "system/role/roleManager";
    }

    @RequestMapping("toUserManager")
    public String toUserManager() {
        return "system/user/userManager";
    }

    @RequestMapping("toLogInfoManager")
    public String toLogInfoManager() {
        return "system/logInfo/logInfoManager";
    }

    @RequestMapping("toNewsManager")
    public String toNewsManager() {
        return "system/news/newsManager";
    }
}
