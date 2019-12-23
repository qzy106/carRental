package com.qzy.bus.service;

import com.qzy.bus.domain.Check;
import com.qzy.bus.vo.CheckVo;
import com.qzy.sys.utils.DataGridView;

import java.util.Map;

public interface CheckService {

    Map<String, Object> initCheckFormData(String rentid);

    void addCheck(CheckVo checkVo);
    
    DataGridView queryAllCheck(CheckVo checkVo);

    void updateCheck(CheckVo checkVo);


}
