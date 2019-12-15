package com.qzy.sys.controller;
import com.qzy.sys.service.LogInfoService;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.utils.ResultObj;
import com.qzy.sys.vo.LogInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("logInfo")
public class LogInfoController {

    @Autowired
    private LogInfoService logInfoService;


    //加载日志列表返回DataGridView

    @RequestMapping("loadAllLogInfo")
    public DataGridView loadAllLogInfo(LogInfoVo logInfoVo) {
        return logInfoService.queryAllLogInfo(logInfoVo);

    }



    //删除日志
    @RequestMapping("DeleteLogInfo")
    public ResultObj DeleteLogInfo(LogInfoVo logInfoVo) {
        try {
            logInfoService.deleteLogInfo(logInfoVo.getId());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

    //批量删除日志
    @RequestMapping("deleteBatchLogInfo")
    public ResultObj deleteBatchLogInfo(LogInfoVo logInfoVo) {
        try {
            logInfoService.deleteBatchLogInfo(logInfoVo.getIds());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }


}
