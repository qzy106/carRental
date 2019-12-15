package com.qzy.sys.controller;

import com.qzy.sys.constast.SysConstast;
import com.qzy.sys.domain.User;
import com.qzy.sys.service.LogInfoService;
import com.qzy.sys.service.UserService;
import com.qzy.sys.utils.WebUtils;
import com.qzy.sys.vo.LogInfoVo;
import com.qzy.sys.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
@RequestMapping("Login")
public class LoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private LogInfoService logInfoService;

    @RequestMapping("toLogin")
    public String toLogin(){
        return "system/main/login";
    }


    @RequestMapping("login")
    public String login(UserVo userVo, Model model){
        System.out.println("hello");
        User user = userService.login(userVo);
        if(user!=null){
            HttpSession httpSession = WebUtils.getHttpSession();
            httpSession.setAttribute("user",user);
            //记录登录日志
            LogInfoVo logInfoVo = new LogInfoVo();
            logInfoVo.setLogintime(new Date());
            logInfoVo.setLoginname(user.getRealname()+"-"+user.getLoginname());
            logInfoVo.setLoginip(WebUtils.getHttpServletRequest().getRemoteAddr());
            logInfoService.addLogInfo(logInfoVo);
            return "system/main/index";
        }else{
            model.addAttribute("errorMsg", SysConstast.USER_LOGIN_ERROR_MSG);
            return "system/main/login";
        }

    }



}
