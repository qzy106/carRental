package com.qzy.stat.service.impl;

import com.qzy.stat.domain.BaseEntity;
import com.qzy.stat.mapper.StatMapper;
import com.qzy.stat.service.StatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StatServiceImpl implements StatService {
    @Autowired
    private StatMapper statMapper;


    @Override
    public List<BaseEntity> queryCustomerAreaStaticList() {
        return statMapper.queryAllCustomerArea();

    }

    @Override
    public List<BaseEntity> queryOpernameYearGradeStaticList(String year) {

        return statMapper.queryAllOpernameYearGrade(year);
    }

    @Override
    public List<Double> queryCompanyYearGradeStaticList(String year) {

        return statMapper.queryCompanyYearGrade(year);
    }
}
