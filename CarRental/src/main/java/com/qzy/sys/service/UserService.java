package com.qzy.sys.service;

import com.qzy.sys.domain.User;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.vo.UserVo;

//用户管理的服务接口
public interface UserService {

    User login(UserVo userVo);

    DataGridView queryAllUser(UserVo userVo);

    void addUser(UserVo userVo);

    void updateUser(UserVo userVo);

    void deleteUser(Integer userid);

    void deleteBatchUser(Integer[] ids);

    void resetUserPwd(Integer userid);

    DataGridView queryUserRole(Integer userid);

    void saveUserRole(UserVo userVo);


    User queryUserByUserId(Integer userid);
}
