package com.qzy.sys.utils;

import lombok.Data;
import lombok.NoArgsConstructor;

//封装layui数据表格的数据对象
@Data
@NoArgsConstructor
public class DataGridView {

    private Integer code=0;
    private String msg="";
    private Long count;
    private Object data;

    public DataGridView(Object data) {
        this.data = data;
    }

    public DataGridView(Long count, Object data) {
        this.count = count;
        this.data = data;
    }
}
