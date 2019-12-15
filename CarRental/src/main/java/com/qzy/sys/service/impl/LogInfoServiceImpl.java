package com.qzy.sys.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.qzy.sys.domain.Menu;
import com.qzy.sys.domain.LogInfo;
import com.qzy.sys.mapper.MenuMapper;
import com.qzy.sys.mapper.LogInfoMapper;
import com.qzy.sys.service.LogInfoService;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.utils.TreeNode;
import com.qzy.sys.vo.LogInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class LogInfoServiceImpl implements LogInfoService {

    @Autowired
    private LogInfoMapper logInfoMapper;

    @Override
    public DataGridView queryAllLogInfo(LogInfoVo logInfoVo) {
        //自动的对PageHelper.startPage 方法下的第一个sql 查询进行分页
        Page<Object> page = PageHelper.startPage(logInfoVo.getPage(), logInfoVo.getLimit());
        //紧跟着的第一个select 方法会被分页
        List<LogInfo> LogInfos = logInfoMapper.queryAllLogInfo(logInfoVo);
        return new DataGridView(page.getTotal(), LogInfos);
    }

    @Override
    public void addLogInfo(LogInfoVo logInfoVo) {
        logInfoMapper.insertSelective(logInfoVo);
    }


    @Override
    public void deleteLogInfo(Integer logInfoId) {
        logInfoMapper.deleteByPrimaryKey(logInfoId);
    }

    //批量删除
    @Override
    public void deleteBatchLogInfo(Integer[] ids) {
        for (Integer logInfoid : ids) {
            deleteLogInfo(logInfoid);
        }
    }





}
