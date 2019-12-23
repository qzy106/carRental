package com.qzy.stat.controller;


import com.qzy.stat.domain.BaseEntity;
import com.qzy.stat.service.StatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("stat")
@Controller
public class StatController {

    @Autowired
    private StatService statService;

    //跳转到客户地区统计页面
    @RequestMapping("toCustomerAreaStatManager")
    public String toCustomerAreaStatManager() {
        return "stat/customerAreaStat";
    }


    //查询客户地区
    @RequestMapping("loadCustomerAreaStaticJson")
    @ResponseBody
    public List<BaseEntity> loadCustomerAreaStaticJson() {
        return statService.queryCustomerAreaStaticList();
    }

    //跳转到业务员年度业绩统计页面
    @RequestMapping("toOpernameYearGradeStatManager")
    public String toOpernameYearGradeStatManager() {
        return "stat/opernameYearGradeStat";
    }

    //查询业务员年度业绩
    @RequestMapping("loadOpernameYearGradeStaticJson")
    @ResponseBody
    public Map<String,Object> loadOpernameYearGradeStaticJson(String year) {
        List<BaseEntity> list=statService.queryOpernameYearGradeStaticList(year);

        Map<String,Object> map=new HashMap<>();
        List<String> names=new ArrayList<>();
        List<Double> values=new ArrayList<>();
        for(BaseEntity base:list) {
            names.add(base.getName());
            values.add(Double.valueOf(base.getValue()));
        }
        map.put("name",names);
        map.put("value",values);
        return map;
    }


    //跳转到公司年度月份业绩统计页面
    @RequestMapping("toCompanyYearGradeStatManager")
    public String toCompanyYearGradeStatManager() {
        return "stat/companyYearGradeStat";
    }


    //查询公司年度月份业绩
    @RequestMapping("loadCompanyYearGradeStaticJson")
    @ResponseBody
    public List<Double> loadCompanyYearGradeStaticJson(String year) {
        List<Double> entities=statService.queryCompanyYearGradeStaticList(year);
        for (int i = 0; i < entities.size(); i++) {
			if(null==entities.get(i)) {
				entities.set(i, 0.0);
			}
		}
		return entities;

    }

}
