package com.qzy.bus.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.qzy.bus.domain.Car;
import com.qzy.bus.domain.Check;
import com.qzy.bus.domain.Customer;
import com.qzy.bus.domain.Rent;
import com.qzy.bus.mapper.CarMapper;
import com.qzy.bus.mapper.CheckMapper;
import com.qzy.bus.mapper.CustomerMapper;
import com.qzy.bus.mapper.RentMapper;
import com.qzy.bus.service.CheckService;
import com.qzy.bus.vo.CheckVo;
import com.qzy.sys.constast.SysConstast;
import com.qzy.sys.domain.User;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.utils.RandomUtils;
import com.qzy.sys.utils.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.annotation.WebFilter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class CheckServiceImpl implements CheckService {

    @Autowired
    private CheckMapper checkMapper;

    @Autowired
    private RentMapper rentMapper;

    @Autowired
    private CarMapper carMapper;

    @Autowired
    private CustomerMapper customerMapper;



    //初始化页面数据
    @Override
    public Map<String, Object> initCheckFormData(String rentid) {
        //检查单
        Check check = new Check();
        check.setCheckid(RandomUtils.createStringUseTime(SysConstast.CHECK_CAR_PREFIX));
        check.setRentid(rentid);
        check.setCheckdate(new Date());
        check.setOpername(((User) WebUtils.getHttpSession().getAttribute("user")).getRealname());
        //出租单
        Rent rent = rentMapper.selectByPrimaryKey(rentid);
        //根据出租单可以得到用户身份证号跟汽车的车牌号
        //客户
        Customer customer = customerMapper.selectByPrimaryKey(rent.getIdentity());
        //汽车
        Car car = carMapper.selectByPrimaryKey(rent.getCarnumber());
        
        //添加到map中
        Map<String,Object> map=new HashMap<>();
        map.put("check",check);
        map.put("rent",rent);
        map.put("car",car);
        map.put("customer",customer);
        return map;
    }


    //添加检查单
    @Override
    public void addCheck(CheckVo checkVo) {
        //修改出租单状态为已经归还
        Rent rent = rentMapper.selectByPrimaryKey(checkVo.getRentid());
        rent.setRentid(checkVo.getRentid());
        rent.setRentflag(SysConstast.CAR_RENT_BACK_TRUE);
        rentMapper.updateByPrimaryKeySelective(rent);
        //修改车辆出租状态为未出租
        Car car = new Car();
        car.setCarnumber(rent.getCarnumber());
        car.setIsrenting(SysConstast.CAR_RENT_FALSE);
        carMapper.updateByPrimaryKeySelective(car);
        //添加检查单
        checkMapper.insertSelective(checkVo);

    }
    
     @Override
    public DataGridView queryAllCheck(CheckVo checkVo) {
        //自动的对PageHelper.startPage 方法下的第一个sql 查询进行分页
        Page<Object> page = PageHelper.startPage(checkVo.getPage(), checkVo.getLimit());
        //紧跟着的第一个select 方法会被分页
        List<Check> Checks = checkMapper.queryAllCheck(checkVo);
        return new DataGridView(page.getTotal(), Checks);
    }


    @Override
    public void updateCheck(CheckVo checkVo) {
        checkMapper.updateByPrimaryKeySelective(checkVo);
    }


}
