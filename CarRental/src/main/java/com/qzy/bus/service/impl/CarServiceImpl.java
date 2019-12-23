package com.qzy.bus.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.qzy.bus.domain.Car;
import com.qzy.bus.mapper.CarMapper;
import com.qzy.bus.service.CarService;
import com.qzy.bus.vo.CarVo;
import com.qzy.sys.constast.SysConstast;
import com.qzy.sys.utils.AppFileUtils;
import com.qzy.sys.utils.DataGridView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CarServiceImpl implements CarService {

    @Autowired
    private CarMapper carMapper;

    @Override
    public DataGridView queryAllCar(CarVo carVo) {
        //自动的对PageHelper.startPage 方法下的第一个sql 查询进行分页
        Page<Object> page = PageHelper.startPage(carVo.getPage(), carVo.getLimit());
        //紧跟着的第一个select 方法会被分页
        List<Car> Cars = carMapper.queryAllCar(carVo);
        return new DataGridView(page.getTotal(), Cars);
    }

    @Override
    public void addCar(CarVo carVo) {
        carMapper.insertSelective(carVo);
    }

    @Override
    public void updateCar(CarVo carVo) {
        carMapper.updateByPrimaryKeySelective(carVo);
    }

    @Override
    public Car queryCarByNumber(String carnumber) {
        return carMapper.selectByPrimaryKey(carnumber);
    }


    @Override
    public void deleteCar(String carnumber) {
        //先删除图片
        Car car = carMapper.selectByPrimaryKey(carnumber);
        if(!car.getCarimg().equals(SysConstast.DEFAULT_CAR_IMG)){
            AppFileUtils.deleteFile(car.getCarimg());
        }
        //删除数据库数据
        carMapper.deleteByPrimaryKey(carnumber);
    }

    //批量删除
    @Override
    public void deleteBatchCar(String[] identities) {
        for (String identity : identities) {
            deleteCar(identity);
        }
    }
}
