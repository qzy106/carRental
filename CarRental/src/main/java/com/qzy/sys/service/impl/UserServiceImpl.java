package com.qzy.sys.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.qzy.sys.constast.SysConstast;
import com.qzy.sys.domain.Role;
import com.qzy.sys.domain.User;
import com.qzy.sys.mapper.RoleMapper;
import com.qzy.sys.mapper.UserMapper;
import com.qzy.sys.service.UserService;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.beans.beancontext.BeanContextChild;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public User login(UserVo userVo) {
        String pwd = DigestUtils.md5DigestAsHex(userVo.getPwd().getBytes());
        userVo.setPwd(pwd);
        User user = this.userMapper.login(userVo);
        return user;
    }

    @Override
    public DataGridView queryAllUser(UserVo userVo) {
        Page<Object> page = PageHelper.startPage(userVo.getPage(), userVo.getLimit());
        List<User> data = userMapper.queryAllUser(userVo);
        return new DataGridView(page.getTotal(),data);

    }

    @Override
    public void addUser(UserVo userVo) {
        //设置默认密码
        userVo.setPwd(DigestUtils.md5DigestAsHex(SysConstast.USER_DEFAULT_PWD.getBytes()));
        //设置默认类型（普通用户)
        userVo.setType(SysConstast.USER_DEFALUT_TYPE);
        userMapper.insert(userVo);

    }

    @Override
    public void updateUser(UserVo userVo) {
        //这里是一个大坑，千万不要用另外一个 我qtmdqswl
        userMapper.updateByPrimaryKeySelective(userVo);
    }

    @Override
    public void deleteUser(Integer userid) {
        //删除 用户
        userMapper.deleteByPrimaryKey(userid);
        //根据用户id删除sys_role_user
        roleMapper.deleteRoleUserByUid(userid);

    }

    @Override
    public void deleteBatchUser(Integer[] ids) {
        for(Integer id:ids){
            deleteUser(id);
        }
    }

    @Override
    public void resetUserPwd(Integer userid) {
        User user = new User();
        user.setUserid(userid);
        user.setPwd(DigestUtils.md5DigestAsHex(SysConstast.USER_DEFAULT_PWD.getBytes()));
        userMapper.updateByPrimaryKeySelective(user);

    }

    //根据用户id返回角色分配表需要的数据
    @Override
    public DataGridView queryUserRole(Integer userid) {
        Role role = new Role();
        role.setAvailable(1);
        //首先查询出所有角色
        List<Role> allRoles = roleMapper.queryAllRole(role);
        //然后根据用户id查询出该用户拥有的所有角色
        List<Role> userRoles=roleMapper.queryUserRoleByUid(1,userid);
        List<Map<String,Object>> data= new ArrayList<>();
        for(Role r1:allRoles){
            //这里的这个字段根layui要求的字段一致
            Boolean LAY_CHECKED=false;
            for(Role r2:userRoles){
                if(r1.getRoleid()==r2.getRoleid()){
                    LAY_CHECKED=true;
                }
            }
            Map<String,Object> map= new HashMap<>();
            map.put("roleid",r1.getRoleid());
            map.put("rolename",r1.getRolename());
            map.put("roledesc",r1.getRoledesc());
            map.put("LAY_CHECKED",LAY_CHECKED);
            data.add(map);
        }
        return new DataGridView(data);
    }

    @Override
    public void saveUserRole(UserVo userVo) {
        //根据用户id删除sys_role_user里面的内容
        roleMapper.deleteRoleUserByUid(userVo.getUserid());
        //添加角色分配内容
        Integer []ids=userVo.getIds();
        if(ids!=null&&ids.length>0){
            for(Integer rid:ids){
                roleMapper.insertUserRole(userVo.getUserid(),rid);
            }
        }
    }
}
