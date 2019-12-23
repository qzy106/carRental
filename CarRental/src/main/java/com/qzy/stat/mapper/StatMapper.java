package com.qzy.stat.mapper;

import com.qzy.stat.domain.BaseEntity;

import java.util.List;

public interface StatMapper {
    List<BaseEntity> queryAllCustomerArea();

    List<BaseEntity> queryAllOpernameYearGrade(String year);

    List<Double> queryCompanyYearGrade(String year);
}
