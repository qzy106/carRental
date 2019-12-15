package com.qzy.sys.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qzy.sys.domain.Role;
import org.springframework.web.bind.annotation.RequestParam;

public interface RoleMapper {
	int deleteByPrimaryKey(Integer roleid);

	int insert(Role record);

	int insertSelective(Role record);

	Role selectByPrimaryKey(Integer roleid);

	int updateByPrimaryKeySelective(Role record);

	int updateByPrimaryKey(Role record);

	//查询角色
	List<Role> queryAllRole(Role role);

	//根据角色id删除sys_role_menu里面的数据
	void deleteRolMenuByRid(Integer roleid);

	//根据角色id删除sys_role_user里面的数据
	void deleteRoleUserByRid(Integer roleid);

	//根据用户id删除sys_role_user里面的数据
	void deleteRoleUserByUid(Integer userid);

    //根据角色id以及mid往sys_role_menu里插入数据
	void saveRoleMenu(@Param("rid") Integer roleid, @Param("mid") Integer id);

	//根据用户id查询出该用户拥有的所有角色
    List<Role> queryUserRoleByUid(@Param("available") Integer available, @Param("uid") Integer userid);

    //根据用户id以及角色id往sys_role_user表中插入数据
	void insertUserRole(@Param("uid") Integer uid, @Param("rid") Integer rid);
}