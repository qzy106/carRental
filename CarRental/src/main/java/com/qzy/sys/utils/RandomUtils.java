package com.qzy.sys.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

//随机工具类
public class RandomUtils {
	
	
	private static SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat sdf2=new SimpleDateFormat("yyyyMMddHHmmssSSS");
	private static SimpleDateFormat sdf3=new SimpleDateFormat("yyyyMMdd_HHmmss_SSS");
	private static Random random=new Random();
	
	//得到当日日期作为图片保存文件的文件夹
	public static String getCurrentDateForString() {
		return sdf1.format(new Date());
	}
	
	
	//使用时间生成随机文件名
	public static String createFileNameUseTime(String fileName) {
		String fileSuffix=fileName.substring(fileName.lastIndexOf("."),fileName.length());
		String time=sdf2.format(new Date());
		Integer num=random.nextInt(9000)+1000;
		return time+num+fileSuffix;
	}

	//使用时间生成随机文件名，并添加临时文件后缀
	public static String createFileNameUseTime(String fileName,String suffix) {
		String fileSuffix=fileName.substring(fileName.lastIndexOf("."),fileName.length());
		String time=sdf2.format(new Date());
		Integer num=random.nextInt(9000)+1000;
		return time+num+fileSuffix+suffix;
	}


	//使用时间
	public static String createStringUseTime(String prefix) {
		return prefix+"_"+sdf3.format(new Date())+"_"+(random.nextInt(90000)+10000);

	}
}
