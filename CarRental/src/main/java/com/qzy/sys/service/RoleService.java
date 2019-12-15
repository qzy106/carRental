package com.qzy.sys.service;

import java.util.List;

import com.qzy.sys.domain.Role;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.vo.RoleVo;

//角色管理的服务接口
public interface RoleService {
	 public List<Role> queryAllRoleForList(RoleVo roleVo);

    public List<Role> queryRoleByUserIdForList(RoleVo roleVo,Integer id);


    DataGridView queryAllRole(RoleVo roleVo);

    void addRole(RoleVo roleVo);

    void updateRole(RoleVo roleVo);

    void deleteRole(Integer roleId);

     void deleteBatchRole(Integer[] ids);

    DataGridView loadMenuDispatchJson(Integer roleid);

    void saveRoleMenu(Integer roleid, Integer[] ids);
}
