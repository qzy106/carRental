package com.qzy.bus.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.qzy.bus.domain.Car;
import com.qzy.bus.domain.Rent;
import com.qzy.bus.mapper.CarMapper;
import com.qzy.bus.mapper.RentMapper;
import com.qzy.bus.service.RentService;
import com.qzy.bus.vo.RentVo;
import com.qzy.sys.constast.SysConstast;
import com.qzy.sys.utils.DataGridView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class RentServiceImpl implements RentService {

    @Autowired
    private RentMapper rentMapper;

    @Autowired
    private CarMapper carMapper;


    //添加出租单
    @Override
    public void addRent(RentVo rentVo) {
        //添加出租单
        rentMapper.insertSelective(rentVo);

        //修改汽车出租状态为已出租
        Car car = new Car();
        car.setCarnumber(rentVo.getCarnumber());
        car.setIsrenting(SysConstast.CAR_RENT_TRUE);
        carMapper.updateByPrimaryKeySelective(car);

    }


    @Override
    public DataGridView queryAllRent(RentVo rentVo) {
        //自动的对PageHelper.startPage 方法下的第一个sql 查询进行分页
        Page<Object> page = PageHelper.startPage(rentVo.getPage(), rentVo.getLimit());
        //紧跟着的第一个select 方法会被分页
        List<Rent> Rents = rentMapper.queryAllRent(rentVo);
        return new DataGridView(page.getTotal(), Rents);
    }


    @Override
    public void updateRent(RentVo rentVo) {
        rentMapper.updateByPrimaryKeySelective(rentVo);
    }


    //根据rentid查询出租单号
    @Override
    public Rent queryRentByRentId(String rentid) {
        return rentMapper.selectByPrimaryKey(rentid);
    }


    //删除出租单
    @Override
    public void deleteRent(String rentid) {
        //修改车辆状态为未出租
        Rent rent=rentMapper.selectByPrimaryKey(rentid);
        Car car = new Car();
        car.setCarnumber(rent.getCarnumber());
        car.setIsrenting(SysConstast.CAR_RENT_FALSE);
        carMapper.updateByPrimaryKeySelective(car);

        //删除出租单
        rentMapper.deleteByPrimaryKey(rentid);
    }
}
