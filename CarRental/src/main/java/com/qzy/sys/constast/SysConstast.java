package com.qzy.sys.constast;

public class SysConstast {
    public static final String USER_LOGIN_ERROR_MSG = "密码错误，请重试";


    //操作状态
    public static final String ADD_SUCCESS = "添加成功";
    public static final String ADD_ERROR = "添加失败";

    public static final String UPDATE_SUCCESS = "更新成功";
    public static final String UPDATE_ERROR = "更新失败";

    public static final String DELETE_SUCCESS = "删除成功";
    public static final String DELETE_ERROR = "删除失败";

    public static final String RESET_SUCCESS = "重置成功";
    public static final String RESET_ERROR = "重置失败";

    public static final String DISPATCH_SUCCESS = "分配成功";
    public static final String DISPATCH_ERROR = "分配失败";

    public static final Integer CODE_SUCCESS = 0; //操作成功
    public static final Integer CODE_ERROR = -1;//失败

    //默认密码
    public static final String USER_DEFAULT_PWD = "123456";
    //用户默认类型
	public static final Integer USER_DEFALUT_TYPE = 2;

	//临时文件后缀
    public static final String FILE_UPLOAD_TEMP ="_temp" ;
    //默认图片地址
    public static final String DEFAULT_CAR_IMG = "images/default";

    //出租单前缀
    public static final String RENT_CAR_PREFIX = "CZ";
    //检查单前缀
    public static final String CHECK_CAR_PREFIX = "CK";

    //车辆出租状态
    public static final Integer CAR_RENT_TRUE = 1;
    public static final Integer CAR_RENT_FALSE = 0;
    //车辆归还状态
    public static final Integer CAR_RENT_BACK_TRUE = 1;
    public static final Integer CAR_RENT_BACK_FALSE = 0;

    public static final String WRONG_OLD_PWD = "旧密码输入错误，请检查后重新修改";
}
