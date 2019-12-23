package com.qzy.bus.service;

import com.qzy.bus.domain.Rent;
import com.qzy.bus.vo.RentVo;
import com.qzy.sys.utils.DataGridView;

public interface RentService {
    void addRent(RentVo rentVo);

    DataGridView queryAllRent(RentVo rentVo);

    void deleteRent(String rentid);

    void updateRent(RentVo rentVo);

    Rent queryRentByRentId(String rentid);
}
