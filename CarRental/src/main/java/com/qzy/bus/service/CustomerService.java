package com.qzy.bus.service;

import com.qzy.bus.domain.Customer;
import com.qzy.bus.vo.CustomerVo;
import com.qzy.sys.utils.DataGridView;

//用户管理的服务接口
public interface CustomerService {


    DataGridView queryAllCustomer(CustomerVo customerVo);

    void deleteCustomer(String identity);

    void deleteBatchCustomer(String[] identities);

    void addCustomer(CustomerVo customerVo);

    void updateCustomer(CustomerVo customerVo);

}
