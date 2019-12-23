package com.qzy.sys.controller;

import com.qzy.sys.domain.User;
import com.qzy.sys.service.UserService;
import com.qzy.sys.utils.WebUtils;
import com.qzy.sys.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("sys")
public class SysController {

    @Autowired
    private UserService userService;

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


    //跳转到修改密码页面
    @RequestMapping("toPasswordChangeManager")
    public String toPasswordChangeManager() {
        return "system/main/passwordChange";
    }

    //跳转到修改个人资料页面
    @RequestMapping("toProfileChangeManager")
    public String toProfileChangeManager(Model model) {
        return "system/main/profileChange";
    }
}
