package com.qzy.bus.controller;
import com.qzy.bus.service.CustomerService;
import com.qzy.bus.vo.CustomerVo;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.utils.ResultObj;
import com.qzy.sys.utils.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
@RequestMapping("customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;


    //加载客户列表返回DataGridView

    @RequestMapping("loadAllCustomer")
    public DataGridView loadAllCustomer(CustomerVo customerVo) {
        return customerService.queryAllCustomer(customerVo);

    }



    //删除客户
    @RequestMapping("deleteCustomer")
    public ResultObj deleteCustomer(CustomerVo customerVo) {
        try {
            customerService.deleteCustomer(customerVo.getIdentity());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

     //添加客户
    @RequestMapping("addCustomer")
    public ResultObj addCustomer(CustomerVo customerVo) {
        try {
            customerVo.setCreatetime(new Date());
            customerService.addCustomer(customerVo);
            return ResultObj.ADD_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }

    }

      //修改客户
    @RequestMapping("updateCustomer")
    public ResultObj updateCustomer(CustomerVo customerVo) {
        try {
            customerService.updateCustomer(customerVo);
            return ResultObj.UPDATE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }

    }




    //批量删除客户
    @RequestMapping("deleteBatchCustomer")
    public ResultObj deleteBatchCustomer(CustomerVo customerVo) {
        try {
            customerService.deleteBatchCustomer(customerVo.getIds());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

}
