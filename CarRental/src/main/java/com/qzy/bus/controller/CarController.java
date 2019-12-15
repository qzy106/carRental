package com.qzy.bus.controller;

import com.qzy.bus.service.CarService;
import com.qzy.bus.vo.CarVo;
import com.qzy.sys.constast.SysConstast;
import com.qzy.sys.utils.AppFileUtils;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.utils.ResultObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
@RequestMapping("car")
public class CarController {

    @Autowired
    private CarService carService;


    //加载汽车列表返回DataGridView

    @RequestMapping("loadAllCar")
    public DataGridView loadAllCar(CarVo carVo) {
        return carService.queryAllCar(carVo);

    }


    //删除汽车
    @RequestMapping("deleteCar")
    public ResultObj deleteCar(CarVo carVo) {
        try {
            carService.deleteCar(carVo.getCarnumber());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

    //添加汽车
    @RequestMapping("addCar")
    public ResultObj addCar(CarVo carVo) {
        try {
            carVo.setCreatetime(new Date());
            //上传成功之后去掉临时后缀
            if (!carVo.getCarimg().equals(SysConstast.DEFAULT_CAR_IMG)) {
                carVo.setCarimg(AppFileUtils.updateFileName(carVo.getCarimg(), SysConstast.FILE_UPLOAD_TEMP));
            }
            carService.addCar(carVo);
            return ResultObj.ADD_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }

    }

    //修改汽车
    @RequestMapping("updateCar")
    public ResultObj updateCar(CarVo carVo) {
        try {
            carService.updateCar(carVo);
            return ResultObj.UPDATE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }

    }


    //批量删除汽车
    @RequestMapping("deleteBatchCar")
    public ResultObj deleteBatchCar(CarVo carVo) {
        try {
            carService.deleteBatchCar(carVo.getIds());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

}
