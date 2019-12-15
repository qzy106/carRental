package com.qzy.sys.service;

import com.qzy.sys.domain.LogInfo;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.vo.LogInfoVo;

import java.util.List;

//日志管理的服务接口
public interface LogInfoService {


    DataGridView queryAllLogInfo(LogInfoVo logInfoVo);

    void deleteLogInfo(Integer logInfoId);

    void deleteBatchLogInfo(Integer[] ids);


    void addLogInfo(LogInfoVo logInfoVo);
}
