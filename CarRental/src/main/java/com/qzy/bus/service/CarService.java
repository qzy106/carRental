package com.qzy.bus.service;

import com.qzy.bus.domain.Car;
import com.qzy.bus.vo.CarVo;
import com.qzy.sys.utils.DataGridView;

//汽车管理的服务接口
public interface CarService {


    DataGridView queryAllCar(CarVo carVo);

    void deleteCar(String identity);

    void deleteBatchCar(String[] identities);

    void addCar(CarVo carVo);

    void updateCar(CarVo carVo);

    Car queryCarByNumber(String carnumber);
}
