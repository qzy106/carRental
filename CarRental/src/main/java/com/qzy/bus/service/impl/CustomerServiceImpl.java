package com.qzy.bus.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.qzy.bus.domain.Customer;
import com.qzy.bus.mapper.CustomerMapper;
import com.qzy.bus.service.CustomerService;
import com.qzy.bus.vo.CustomerVo;

import com.qzy.sys.utils.DataGridView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public DataGridView queryAllCustomer(CustomerVo customerVo) {
        //自动的对PageHelper.startPage 方法下的第一个sql 查询进行分页
        Page<Object> page = PageHelper.startPage(customerVo.getPage(), customerVo.getLimit());
        //紧跟着的第一个select 方法会被分页
        List<Customer> Customers = customerMapper.queryAllCustomer(customerVo);
        return new DataGridView(page.getTotal(), Customers);
    }

    @Override
    public void addCustomer(CustomerVo customerVo) {
        customerMapper.insertSelective(customerVo);
    }

    @Override
    public void updateCustomer(CustomerVo customerVo) {
        customerMapper.updateByPrimaryKeySelective(customerVo);
    }

    //通过身份证号查询顾客
    @Override
    public Customer queryCustomerByIdentity(String identity) {

        return customerMapper.selectByPrimaryKey(identity);
    }


    @Override
    public void deleteCustomer(String identity) {
        customerMapper.deleteByPrimaryKey(identity);
    }

    //批量删除
    @Override
    public void deleteBatchCustomer(String[] identities) {
        for (String identity : identities) {
            deleteCustomer(identity);
        }
    }
}
