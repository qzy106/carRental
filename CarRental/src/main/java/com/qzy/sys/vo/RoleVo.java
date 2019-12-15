package com.qzy.sys.vo;

import com.qzy.sys.domain.Role;

public class RoleVo extends Role {


    //对应layui的请求形式：?page=1&limit=30（该参数可通过 request 自定义）
    //page 代表当前页码、limit 代表每页数据量
    private Integer page;
    private Integer limit;

    //接收多个id
    private Integer[] ids;

    public Integer[] getIds() {
        return ids;
    }

    public void setIds(Integer[] ids) {
        this.ids = ids;
    }

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

