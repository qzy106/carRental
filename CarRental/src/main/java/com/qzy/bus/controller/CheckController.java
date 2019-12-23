package com.qzy.bus.controller;

import com.qzy.bus.domain.Rent;
import com.qzy.bus.service.CheckService;
import com.qzy.bus.service.RentService;
import com.qzy.bus.vo.CheckVo;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.utils.ResultObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.Map;

@RestController
@RequestMapping("check")
public class CheckController {

    @Autowired
    private RentService rentService;

    @Autowired
    private CheckService checkService;


    //根据rentid检查出租单是否存在
    @RequestMapping("checkRentIsExist")
    public Rent checkRentIsExist(String rentid) {
        return rentService.queryRentByRentId(rentid);
    }


    //初始化页面数据
    @RequestMapping("initCheckFormData")
    public Map<String,Object> initCheckFormData(String rentid){
         return checkService.initCheckFormData(rentid);
    }

    //初始化页面数据
    @RequestMapping("addCheck")
    public ResultObj addCheck(CheckVo checkVo){
         try{
             checkVo.setCreatetime(new Date());
             checkService.addCheck(checkVo);
             return ResultObj.ADD_SUCCESS;
         }catch (Exception e){
             e.printStackTrace();
             return ResultObj.ADD_ERROR;

         }

    }
    
    //加载检查单列表返回DataGridView
    @RequestMapping("loadAllCheck")
    public DataGridView loadAllCheck(CheckVo checkVo) {
        return checkService.queryAllCheck(checkVo);

    }

    //修改检查单
    @RequestMapping("updateCheck")
    public ResultObj updateCheck(CheckVo checkVo) {
        try {
            checkService.updateCheck(checkVo);
            return ResultObj.UPDATE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }

    }

}
