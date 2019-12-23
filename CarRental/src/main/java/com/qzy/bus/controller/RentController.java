package com.qzy.bus.controller;

import com.qzy.bus.domain.Customer;
import com.qzy.bus.service.CustomerService;
import com.qzy.bus.service.RentService;
import com.qzy.bus.vo.RentVo;
import com.qzy.sys.constast.SysConstast;
import com.qzy.sys.domain.User;
import com.qzy.sys.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
@RequestMapping("rent")
public class RentController {

    @Autowired
    private RentService rentService;

    @Autowired
    private CustomerService customerService;


    //根据身份证号检查顾客是否存在
    @RequestMapping("checkCustomerIsExist")
    public ResultObj checkCustomerIsExist(RentVo rentVo) {
        Customer customer = customerService.queryCustomerByIdentity(rentVo.getIdentity());
        if (customer != null) {
            return ResultObj.CODE_SUCCESS;
        } else {
            return ResultObj.CODE_FAILED;
        }
    }

    //初始化添加出租单表单
    @RequestMapping("initAddRentForm")
    public RentVo initAddRentForm(RentVo rentVo){
        //生成出租单号
        rentVo.setRentid(RandomUtils.createStringUseTime(SysConstast.RENT_CAR_PREFIX));
        //生成开始时间
        rentVo.setBegindate(new Date());
        //生成操作员
        User user= (User) WebUtils.getHttpSession().getAttribute("user");
        rentVo.setOpername(user.getRealname());
        return rentVo;
    }

    //添加出租单
    @RequestMapping("addRent")
    public ResultObj addRent(RentVo rentVo){
        try{
            //设置创建时间
            rentVo.setCreatetime(new Date());
            //设置归还状态
            rentVo.setRentflag(SysConstast.CAR_RENT_BACK_FALSE);
            rentService.addRent(rentVo);
            return ResultObj.ADD_SUCCESS;

        }catch (Exception e){
            e.printStackTrace();
            return  ResultObj.ADD_ERROR;
        }
    }
    
    
    //加载出租单列表返回DataGridView
    @RequestMapping("loadAllRent")
    public DataGridView loadAllRent(RentVo rentVo) {
        return rentService.queryAllRent(rentVo);

    }



    //删除出租单
    @RequestMapping("deleteRent")
    public ResultObj deleteRent(RentVo rentVo) {
        try {
            rentService.deleteRent(rentVo.getRentid());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }


      //修改出租单
    @RequestMapping("updateRent")
    public ResultObj updateRent(RentVo rentVo) {
        try {
            rentService.updateRent(rentVo);
            return ResultObj.UPDATE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }

    }


}
