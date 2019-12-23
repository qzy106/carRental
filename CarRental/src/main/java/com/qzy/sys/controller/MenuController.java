package com.qzy.sys.controller;


import com.qzy.sys.domain.Menu;
import com.qzy.sys.domain.User;
import com.qzy.sys.service.MenuService;
import com.qzy.sys.utils.*;
import com.qzy.sys.vo.MenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @RequestMapping("loadIndexLeftMenuJson")
    public List<TreeNode> loadIndexLeftMenuJson(MenuVo menuVo) {
        User user = (User) WebUtils.getHttpSession().getAttribute("user");
        List<Menu> list = null;
        menuVo.setAvailable(1);
        if (user.getType() == 1) {
            list = menuService.queryAllMenuForList(menuVo);
        } else {
            list = menuService.queryMenuByUserIdForList(menuVo, user.getUserid());
        }

        //没有层级关系的节点列表
        ArrayList<TreeNode> nodes = new ArrayList<>();
        for (Menu menu : list) {
            Integer id = menu.getId();
            Integer pid = menu.getPid();
            String icon = menu.getIcon();
            String title = menu.getTitle();
            String href = menu.getHref();
            Boolean spread = (menu.getSpread() == 1);

            nodes.add(new TreeNode(id, pid, icon, title, href, spread));
        }

        //设置菜单的第一层节点
        Integer pid=1;

        //将没有层级关系的菜单列表转化为有层级关系的(根据要求的json格式)
        return TreeBuilder.build(nodes,pid);
    }


    //加载菜单管理左边的菜单树
    @RequestMapping("loadMenuManagerLeftTreeJson")
    public DataGridView loadMenuManagerLeftTreeJson(MenuVo menuVo){
        menuVo.setAvailable(1);
        List<Menu> list = menuService.queryAllMenuForList(menuVo);
        ArrayList<TreeNode> nodes = new ArrayList<>();
        for (Menu menu : list) {
            Integer id = menu.getId();
            Integer pid = menu.getPid();
            String icon = menu.getIcon();
            String title = menu.getTitle();
            String href = menu.getHref();
            Boolean spread = (menu.getSpread() == 1);

            nodes.add(new TreeNode(id, pid, icon, title, href, spread));
        }
        return new DataGridView(nodes);

    }

    //加载菜单列表返回DataGridView

    @RequestMapping("loadAllMenu")
    public DataGridView loadAllMenu(MenuVo menuVo){
        return menuService.queryAllMenu(menuVo);

    }


    //添加菜单
    @RequestMapping("addMenu")
    public ResultObj addMenu(MenuVo menuVo){
        try{
            menuService.addMenu(menuVo);
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }

    }

    //修改菜单
    @RequestMapping("updateMenu")
    public ResultObj updateMenu(MenuVo menuVo){
        try{
            menuService.updateMenu(menuVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }

    }


    //检查菜单是否有子菜单
    @RequestMapping("checkMenuHasChildren")
    public ResultObj checkMenuHasChildren(MenuVo menuVo){
        Integer menuChildren = menuService.selectMenuByPid(menuVo.getId());
        if(menuChildren>0){
            return ResultObj.CODE_SUCCESS;
        }else{
            return ResultObj.CODE_FAILED;
        }

    }

    //删除菜单
    @RequestMapping("DeleteMenu")
    public ResultObj DeleteMenu(MenuVo menuVo){
        try{
            menuService.deleteMenu(menuVo);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

}
