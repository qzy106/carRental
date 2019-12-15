package com.qzy.sys.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.qzy.sys.domain.Menu;
import com.qzy.sys.mapper.MenuMapper;
import com.qzy.sys.service.MenuService;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.vo.MenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Override
    public List<Menu> queryAllMenuForList(MenuVo menuVo) {
        return menuMapper.queryAllMenu(menuVo);
    }

    //这里后面还要改的
    //我来改了
    @Override
    public List<Menu> queryMenuByUserIdForList(MenuVo menuVo, Integer id) {

//        return menuMapper.queryAllMenu(menuVo);
        return menuMapper.queryMenuByUid(menuVo.getAvailable(),id);
    }

    //查询所有菜单
    @Override
    public DataGridView queryAllMenu(MenuVo menuVo) {
        //自动的对PageHelper.startPage 方法下的第一个sql 查询进行分页
        Page<Object> page = PageHelper.startPage(menuVo.getPage(), menuVo.getLimit());
        //紧跟着的第一个select 方法会被分页
        List<Menu> menus = menuMapper.queryAllMenu(menuVo);
        return new DataGridView(page.getTotal(),menus);
    }

    @Override
    public void addMenu(MenuVo menuVo) {
        menuMapper.insertSelective(menuVo);
    }

    @Override
    public void updateMenu(MenuVo menuVo) {
        menuMapper.updateByPrimaryKeySelective(menuVo);
    }

    @Override
    public Integer selectMenuByPid(Integer id) {
        return menuMapper.selectMenuByPid(id);

    }

    @Override
    public void deleteMenu(MenuVo menuVo) {
        //先删除菜单表
        menuMapper.deleteByPrimaryKey(menuVo.getId());
        //再删除角色菜单表
        menuMapper.deleteRolMenuByMid(menuVo.getId());
    }
}
