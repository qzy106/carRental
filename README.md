### 课设问题记录

------

[^时间]: 2019-12-10

#### 表单的reset方法不会重置隐藏域名

解决方法：将隐藏域改成如下格式

```jsp
 <input type="text" name="roleid" style="display: none">
```

太尼玛坑了。。。。。











------

[^时间]: 2019-12-11

#### druid数据源监控配置

```xml
 <!-- 声明dataSource -->
    <bean id="dataSource" class="com.alibaba.druid.pool.DruidDataSource">
        <property name="driverClassName" value="${driverClassName}"/>
        <property name="url" value="${url}?userSSL=true&amp;serverTimezone=UTC"/>
        <property name="username" value="${username}"/>
        <property name="password" value="${password}"/>
        <!--设置初始化连接池大小-->
        <property name="initialSize" value="5"/>
        <!--设置最大连接数-->
        <property name="maxActive" value="10"/>
        <!--设置等待时间-->
        <property name="maxWait" value="5000"/>
        <!-- 添加此处作用是为了在SQL监控页面显示sql执行语句，不配置不显示 -->
        <property name="filters" value="stat"/>
    </bean>
```



```xml
<!--  druid数据源监控配置开始-->

    <filter>
        <filter-name>DruidWebStatFilter</filter-name>
        <filter-class>com.alibaba.druid.support.http.WebStatFilter</filter-class>
        <init-param>
            <param-name>exclusions</param-name> <!-- 经常需要排除一些不必要的url -->
            <param-value>*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>DruidWebStatFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
    <servlet>
        <servlet-name>DruidStatView</servlet-name>
        <servlet-class>com.alibaba.druid.support.http.StatViewServlet
        </servlet-class><!-- 这个StatViewServlet的用途包括：提供监控信息展示的html页面;提供监控信息的JSON API -->
    </servlet>
    <servlet-mapping>
        <servlet-name>DruidStatView</servlet-name>
        <url-pattern>/druid/*</url-pattern>
    </servlet-mapping>

    <!--  druid数据源监控配置结束-->
```















------

[^时间]: 2019-12-11

#### 解决layui数据表格删除最后一条数据的问题

![1576052681943](https://github.com/qzy106/carRental/blob/master/课设问题记录/1576052681943.png)











------

[^时间]: 2019-12-12

#### 文件的上传与下载

**layui要求返回的数据格式**

```html
{
  "code": 0
  ,"msg": ""
  ,"data": {
    "src": "http://cdn.layui.com/123.jpg"
  }
}       
```

**js**

```js
 upload.render({
            elem: '#carimgDiv',
            url: '${ctx}/file/uploadFile.action',
            method: "post",  //此处是为了演示之用，实际使用中请将此删除，默认用post方式提交
            acceptMime: 'images/*', //筛选文件为图片
            field: "mf",//对应后台接收的文件名
            done: function (res, index, upload) {
                //图片回显
                $('#showCarImg').attr('src', "${ctx}/file/downloadShowFile.action?path=" + res.data.src);
                //表单数据赋值
                $("#carimg").val(res.data.src);
                //这个是div
                $('#carimgDiv').css("background", "#fff");
            }
        });
```





##### controller

```java 
package com.qzy.sys.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.qzy.sys.constast.SysConstast;
import com.qzy.sys.utils.AppFileUtils;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.utils.RandomUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

//文件上传下载的控制器
@Controller
@RequestMapping("file")
public class FileController {

	//添加
	@RequestMapping("uploadFile")
	@ResponseBody
	public DataGridView uploadFile(MultipartFile mf) throws IllegalStateException, IOException {
		// 文件上传的父目录
		String parentPath = AppFileUtils.PATH;
		// 得到当前日期作为文件夹名称
		String dirName = RandomUtils.getCurrentDateForString();
		// 构造文件夹对象
		File dirFile = new File(parentPath, dirName);
		if (!dirFile.exists()) {
			dirFile.mkdirs();// 创建文件夹
		}
		// 得到文件原名
		String oldName = mf.getOriginalFilename();
		// 根据文件原名得到新名
		String newName = RandomUtils.createFileNameUseTime(oldName, SysConstast.FILE_UPLOAD_TEMP);
		File dest = new File(dirFile, newName);
		mf.transferTo(dest);
		//返回layui需要的数据格式
		Map<String,Object> map=new HashMap<>();
		map.put("src", dirName+"/"+newName);
		return new DataGridView(map);
		
	}

	//不下载只作显示
	@RequestMapping("downloadShowFile")
	public ResponseEntity<Object> downloadShowFile(String path, HttpServletResponse response) {
		return AppFileUtils.downloadFile(response, path, "");	
	}
	

	//下载图片
	@RequestMapping("downloadFile")
	public ResponseEntity<Object> downloadFile(String path, HttpServletResponse response) {
		String oldName="";
		return AppFileUtils.downloadFile(response, path, oldName);	
	}

}

```

##### 工具类

AppFileUtils（上传和下载的一些工具）

```java
package com.qzy.sys.utils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Properties;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

public class AppFileUtils {

    //得到文件上传的路径
    public static String PATH = "D:/upload/";

    static {
        InputStream stream = AppFileUtils.class.getClassLoader().getResourceAsStream("file.properties");
        Properties properties = new Properties();
        try {
            properties.load(stream);
            PATH = properties.getProperty("path");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    //文件下载
    public static ResponseEntity<Object> downloadFile(HttpServletResponse response, String path, String oldName) {
        //使用绝对路径+相对路径去找到文件对象
        File file = new File(AppFileUtils.PATH, path);
        //判断文件是否存在
        if (file.exists()) {
            try {
                try {
                    //如果名字有中文 要处理编码new String(oldName.getBytes(),"utf-8")
                    oldName = URLEncoder.encode(oldName, "UTF-8");
                } catch (Exception e) {
                    e.printStackTrace();
                }
                //把file转成一个bytes
                byte[] bytes = FileUtils.readFileToByteArray(file);
                HttpHeaders header = new HttpHeaders();
                //封装响应内容类型(APPLICATION_OCTET_STREAM 响应的内容不限定)
                header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
                //设置下载的文件的名称
                header.setContentDispositionFormData("attachment", oldName);
                //创建ResponseEntity对象
                ResponseEntity<Object> entity =
                        new ResponseEntity<Object>(bytes, header, HttpStatus.CREATED);
                return entity;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        } else {
            PrintWriter out;
            try {
                out = response.getWriter();
                out.write("文件不存在");
                out.flush();
                out.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            return null;
        }
    }
    
    //更新文件名字，去除临时文件后缀
    public static String updateFileName(String carimg, String suffix) {
        try {
            File file = new File(PATH, carimg);
            if (file.exists()) {
                file.renameTo(new File(PATH, carimg.replace(suffix, "")));
                return carimg.replace(suffix, "");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
```

RandomUtils(随即工具类，用来生成文件夹名字和图片名字)

```java 
package com.qzy.sys.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

//随机工具类
public class RandomUtils {
	
	
	private static SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat sdf2=new SimpleDateFormat("yyyyMMddHHmmssSSS");
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
}
```













------

#### 文件上传的一些处理思路

[^时间]: 2019-12-14

由于我们设置的文件上传是自动上传，而上传的图片不一定是最终需要的图片，因此我们在设置文件名是，可以在文件扩展名上加上_temp，以标识这是一个临时文件，在用户点击保存后，再将文件进行重命名去除后缀，并将最终的图片保存到数据库中。对于临时文件，我们可以设置一个定时任务将其清除。

**处理示例**：

```java
 //添加汽车
    @RequestMapping("addCar")
    public ResultObj addCar(CarVo carVo) {
        try {
            carVo.setCreatetime(new Date());
            //上传成功之后去掉临时后缀
            if (!carVo.getCarimg().equals(SysConstast.DEFAULT_CAR_IMG)) {
                carVo.setCarimg(AppFileUtils.updateFileName(carVo.getCarimg(), SysConstast.FILE_UPLOAD_TEMP));
            }
            carService.addCar(carVo);
            return ResultObj.ADD_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }

    }
```









