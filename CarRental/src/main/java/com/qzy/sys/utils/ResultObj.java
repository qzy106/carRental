package com.qzy.sys.utils;

import com.qzy.sys.constast.SysConstast;
import lombok.Data;

@Data
public class ResultObj {


    private Integer code=0;
    private String msg;


    //添加
	public static final ResultObj ADD_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS, SysConstast.ADD_SUCCESS);
	public static final ResultObj ADD_ERROR=new ResultObj(SysConstast.CODE_ERROR, SysConstast.ADD_ERROR);

	//更新
	public static final ResultObj UPDATE_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS, SysConstast.UPDATE_SUCCESS);
	public static final ResultObj UPDATE_ERROR=new ResultObj(SysConstast.CODE_ERROR, SysConstast.UPDATE_ERROR);
	public static final ResultObj WRONG_OLD_PWD = new ResultObj(SysConstast.CODE_ERROR,SysConstast.WRONG_OLD_PWD);

	//删除
	public static final ResultObj DELETE_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS, SysConstast.DELETE_SUCCESS);
	public static final ResultObj DELETE_ERROR=new ResultObj(SysConstast.CODE_ERROR, SysConstast.DELETE_ERROR);

    //重置
	public static final ResultObj RESET_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS, SysConstast.RESET_SUCCESS);
	public static final ResultObj RESET_ERROR=new ResultObj(SysConstast.CODE_ERROR, SysConstast.RESET_ERROR);

	//分配
	public static final ResultObj DISPATCH_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS, SysConstast.DISPATCH_SUCCESS);
	public static final ResultObj DISPATCH_ERROR=new ResultObj(SysConstast.CODE_ERROR, SysConstast.DISPATCH_ERROR);


	//code0,-1
    public static final ResultObj CODE_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS);
	public static final ResultObj CODE_FAILED=new ResultObj(SysConstast.CODE_ERROR);


    public ResultObj(Integer code) {
        this.code = code;
    }

    private ResultObj(Integer code, String msg) {
        this.code = code;
        this.msg = msg;


    }
}
