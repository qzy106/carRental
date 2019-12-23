package com.qzy.sys.controller;


import com.qzy.sys.domain.Role;
import com.qzy.sys.domain.User;
import com.qzy.sys.service.UserService;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.utils.ResultObj;
import com.qzy.sys.utils.WebUtils;
import com.qzy.sys.vo.RoleVo;
import com.qzy.sys.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;


    //加载用户列表返回DataGridView

    @RequestMapping("loadAllUser")
    public DataGridView loadAllUser(UserVo userVo) {
        return userService.queryAllUser(userVo);

    }


    //添加用户
    @RequestMapping("addUser")
    public ResultObj addUser(UserVo userVo) {
        try {
            userService.addUser(userVo);
            return ResultObj.ADD_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }

    }

    //修改用户
    @RequestMapping("updateUser")
    public ResultObj updateUser(UserVo userVo) {
        try {
            userService.updateUser(userVo);
            return ResultObj.UPDATE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }

    }


    //删除用户
    @RequestMapping("deleteUser")
    public ResultObj deleteUser(UserVo userVo) {
        try {
            userService.deleteUser(userVo.getUserid());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

    //批量删除用户
    @RequestMapping("deleteBatchUser")
    public ResultObj deleteBatchUser(UserVo userVo) {
        try {
            userService.deleteBatchUser(userVo.getIds());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

    //重置密码
    @RequestMapping("resetUserPwd")
    public ResultObj resetUserPwd(UserVo userVo) {
        try {
            userService.resetUserPwd(userVo.getUserid());
            return ResultObj.RESET_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.RESET_ERROR;
        }

    }

    //根据用户id返回角色分配表需要的数据
    @RequestMapping("loadUserRole")
    public DataGridView loadUserRole(UserVo userVo) {
        return userService.queryUserRole(userVo.getUserid());
    }


    //给用户分配角色
    @RequestMapping("saveUserRole")
    public ResultObj saveUserRole(UserVo userVo) {
        try {
            userService.saveUserRole(userVo);
            return ResultObj.DISPATCH_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DISPATCH_ERROR;
        }
    }

    //修改密码
    @RequestMapping("changePassword")
    public ResultObj changePassword(String oldPassword, String newPassword) {
        User user = (User) WebUtils.getHttpSession().getAttribute("user");
        if (!DigestUtils.md5DigestAsHex(oldPassword.getBytes()).equals(user.getPwd())) {
            return ResultObj.WRONG_OLD_PWD;
        } else {
            try {
                UserVo userVo = new UserVo();
                userVo.setPwd(DigestUtils.md5DigestAsHex(newPassword.getBytes()));
                userVo.setUserid(user.getUserid());
                userService.updateUser(userVo);
                WebUtils.getHttpSession().invalidate();
                return ResultObj.RESET_SUCCESS;
            } catch (Exception e) {
                e.printStackTrace();
                return ResultObj.UPDATE_ERROR;
            }
        }
    }


    //获取个人资料
    @RequestMapping("loadProfile")
    public User loadProfile(){
        User user = (User) WebUtils.getHttpSession().getAttribute("user");
        user=userService.queryUserByUserId(user.getUserid());
        return user;
    }


}
