package com.qzy.sys.mapper;

import java.util.List;

import com.qzy.sys.domain.Menu;
import org.apache.ibatis.annotations.Param;

public interface MenuMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);
    
   //查询所有菜单
    List<Menu> queryAllMenu(Menu menu);

    Integer selectMenuByPid(@Param("id") Integer id);

    void deleteRolMenuByMid(@Param("mid") Integer id);

    List<Menu> queryMenuByRoleId(@Param("available")int i, @Param("rid")Integer roleid);

    //根据用户id查询菜单
    List<Menu> queryMenuByUid(@Param("available") Integer available, @Param("uid") Integer uid);
}