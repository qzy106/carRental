package com.qzy.stat.service;

import com.qzy.stat.domain.BaseEntity;

import java.util.List;

public interface StatService {
    //查询客户地区
    List<BaseEntity> queryCustomerAreaStaticList();

    //查询业务员年度业绩
    List<BaseEntity> queryOpernameYearGradeStaticList(String year);

    List<Double> queryCompanyYearGradeStaticList(String year);
}
