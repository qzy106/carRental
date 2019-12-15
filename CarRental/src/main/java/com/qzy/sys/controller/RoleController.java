package com.qzy.sys.controller;


import com.qzy.sys.domain.Role;
import com.qzy.sys.domain.Role;
import com.qzy.sys.domain.User;
import com.qzy.sys.service.RoleService;
import com.qzy.sys.utils.*;
import com.qzy.sys.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("role")
public class RoleController {

    @Autowired
    private RoleService roleService;


    //加载角色列表返回DataGridView

    @RequestMapping("loadAllRole")
    public DataGridView loadAllRole(RoleVo roleVo) {
        return roleService.queryAllRole(roleVo);

    }


    //添加角色
    @RequestMapping("addRole")
    public ResultObj addRole(RoleVo roleVo) {
        try {
            roleService.addRole(roleVo);
            return ResultObj.ADD_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }

    }

    //修改角色
    @RequestMapping("updateRole")
    public ResultObj updateRole(RoleVo roleVo) {
        try {
            roleService.updateRole(roleVo);
            return ResultObj.UPDATE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }

    }


    //删除角色
    @RequestMapping("DeleteRole")
    public ResultObj DeleteRole(RoleVo roleVo) {
        try {
            roleService.deleteRole(roleVo.getRoleid());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

    //批量删除角色
    @RequestMapping("deleteBatchRole")
    public ResultObj deleteBatchRole(RoleVo roleVo) {
        try {
            roleService.deleteBatchRole(roleVo.getIds());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

    //根据roleid加载菜单分发树
    @RequestMapping("loadMenuDispatchJson")
    public DataGridView loadMenuDispatchJson(Integer roleid) {
        return roleService.loadMenuDispatchJson(roleid);
    }

    //根据角色分配菜单
    @RequestMapping("saveRoleMenu")
    public ResultObj saveRoleMenu(Integer roleid, Integer[] ids) {
        try {
            roleService.saveRoleMenu(roleid,ids);
            return ResultObj.DISPATCH_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DISPATCH_SUCCESS;
        }
    }

}
