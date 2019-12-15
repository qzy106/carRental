package com.qzy.sys.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.qzy.sys.domain.Menu;
import com.qzy.sys.domain.Role;
import com.qzy.sys.mapper.MenuMapper;
import com.qzy.sys.mapper.RoleMapper;
import com.qzy.sys.service.RoleService;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.utils.TreeNode;
import com.qzy.sys.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private MenuMapper menuMapper;

    @Override
    public List<Role> queryAllRoleForList(RoleVo RoleVo) {
        return roleMapper.queryAllRole(RoleVo);
    }

    @Override
    public List<Role> queryRoleByUserIdForList(RoleVo roleVo, Integer id) {
        return null;
    }

    @Override
    public DataGridView queryAllRole(RoleVo roleVo) {
        //自动的对PageHelper.startPage 方法下的第一个sql 查询进行分页
        Page<Object> page = PageHelper.startPage(roleVo.getPage(), roleVo.getLimit());
        //紧跟着的第一个select 方法会被分页
        List<Role> Roles = roleMapper.queryAllRole(roleVo);
        return new DataGridView(page.getTotal(), Roles);
    }

    @Override
    public void addRole(RoleVo roleVo) {
        roleMapper.insertSelective(roleVo);
    }

    @Override
    public void updateRole(RoleVo roleVo) {
        roleMapper.updateByPrimaryKeySelective(roleVo);
    }


    @Override
    public void deleteRole(Integer roleId) {
        roleMapper.deleteByPrimaryKey(roleId);
        roleMapper.deleteRolMenuByRid(roleId);
        // 根据角色id删除sys_role_user里面的数据
        roleMapper.deleteRoleUserByRid(roleId);
    }

    //批量删除
    @Override
    public void deleteBatchRole(Integer[] ids) {
        for (Integer roleid : ids) {
            deleteRole(roleid);
        }
    }

    @Override
    public DataGridView loadMenuDispatchJson(Integer roleid) {
        // 查询所有的可用的菜单
        Menu menu = new Menu();
        menu.setAvailable(1);
        List<Menu> allMenu = menuMapper.queryAllMenu(menu);
        // 根据角色ID查询当前角色拥有的菜单
        List<Menu> roleMenu = menuMapper.queryMenuByRoleId(1, roleid);

        List<TreeNode> data = new ArrayList<>();
        for (Menu m1 : allMenu) {
            String checkArr = "0";
            for (Menu m2 : roleMenu) {
                if (m1.getId() == m2.getId()) {
                    checkArr = "1";
                    break;
                }
            }
            Integer id = m1.getId();
            Integer pid = m1.getPid();
            String title = m1.getTitle();
            Boolean spread = (m1.getSpread() == 1);
            data.add(new TreeNode(id, pid, title, spread, checkArr));
        }
        return new DataGridView(data);
    }


    //根据角色id分配菜单
    @Override
    public void saveRoleMenu(Integer roleid, Integer[] ids) {
//        删除角色原来拥有的菜单(从sys_role_menu表删除数据)
        roleMapper.deleteRolMenuByRid(roleid);
//        分配菜单(插入数据到sys_role_menu表)
        for (Integer id : ids) {
            roleMapper.saveRoleMenu(roleid, id);
        }
    }
}
