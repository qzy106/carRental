package com.qzy.sys.vo;

import com.qzy.sys.domain.LogInfo;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class LogInfoVo extends LogInfo {

    //对应layui的请求形式：?page=1&limit=30（该参数可通过 request 自定义）
    //page 代表当前页码、limit 代表每页数据量
    private Integer page;
    private Integer limit;

    //接收多个id
    private Integer[] ids;

    //事件范围查询的字段
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Integer[] getIds() {
        return ids;
    }

    public void setIds(Integer[] ids) {
        this.ids = ids;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
}
