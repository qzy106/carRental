package com.qzy.sys.vo;

import com.qzy.sys.domain.Menu;



public class MenuVo extends Menu {

    //对应layui的请求形式：?page=1&limit=30（该参数可通过 request 自定义）
    //page 代表当前页码、limit 代表每页数据量
    private Integer page;
    private Integer limit;

    public void setPage(Integer page) {
        this.page = page;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Integer getPage() {
        return page;
    }

    public Integer getLimit() {
        return limit;
    }
}
