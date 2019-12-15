package com.qzy.sys.service;

import java.util.List;
import com.qzy.sys.domain.Menu;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.vo.MenuVo;


//菜单管理的服务接口
public interface MenuService {

    public List<Menu> queryAllMenuForList(MenuVo menuVo);

    public List<Menu> queryMenuByUserIdForList(MenuVo menuVo,Integer id);


    DataGridView queryAllMenu(MenuVo menuVo);

    void addMenu(MenuVo menuVo);

    void updateMenu(MenuVo menuVo);

    Integer selectMenuByPid(Integer id);

    void deleteMenu(MenuVo menuVo);
}
