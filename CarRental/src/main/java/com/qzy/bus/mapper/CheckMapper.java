package com.qzy.bus.mapper;

import java.util.List;

import com.qzy.bus.domain.Check;

public interface CheckMapper {
    int deleteByPrimaryKey(String checkid);

    int insert(Check record);

    int insertSelective(Check record);

    Check selectByPrimaryKey(String checkid);

    int updateByPrimaryKeySelective(Check record);

    int updateByPrimaryKey(Check record);
    
    
    //查询
    List<Check> queryAllCheck(Check check);
}