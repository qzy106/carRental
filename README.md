

### 课设问题记录

------

[^时间]: 2019-12-8

#### 1.查询时时间范围

**CDATA表达式**

```xml
and createtime <![CDATA[<=]]>#{endTime}
```



#### 2.关于@DateTimeFormat和@JsonFormat区别

有的时候由前台jsp页面填写一个日期，提交到后台spring mvc的时候，我们希望直接转换成一个Date类型，而不是由一个string 类型接收，然后再通过simpleDateFormat来进行转格式，这样太麻烦了，代码会显的很乱，spring为我们提供了类型转化器，写起来也是很麻烦，我们的需求很简单就是由框架帮我们去自动的转换类型而不是手动的转换，在这样的背景下，我们可以使用@DateTimeFormat注解。此外我们还有一个需求就是我们从数据库里面查询到了日期，然后我们想把这个日期自动的变成string类型，这时我们可以使用@JsonFormat注解。 



**fastJson使用@JsonField**

```java
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  @JSONField(format = "yyyy-MM-dd HH:mm:ss")
```



------

[^时间]: 2019-12-9

#### 3.RBAC权限管理

- 一个人可以有多个角色。
- 一个角色可以有多个人。
- 一个角色可以有多个权限。
- 一个权限可以分配给多个角色。

| 菜单表(sys_menu) |            |              |        |            |              |                |          |            |
| ---------------- | ---------- | ------------ | ------ | ---------- | ------------ | -------------- | -------- | ---------- |
| id               | pid        | name         | href   | open       | parent       | icon           | tabicon  | available  |
|                  | (父节点id) |              | (地址) | (是否展开) | (是否父节点) |                |          | (是否可用) |
| 1                | 0          | 汽车出租系统 |        |            |              | /resouce/1.png | icon-add |            |
| 2                | 1          | 基础管理     |        |            |              |                |          |            |
| 3                | 2          | 客户管理     |        |            |              |                |          |            |
| 4                | 2          | 车辆管理     |        |            |              |                |          |            |
| 5                | 1          | 业务管理     |        |            |              |                |          |            |
| 6                | 5          | 汽车出租     |        |            |              |                |          |            |
| 7                | 5          | 出租单管理   |        |            |              |                |          |            |

| 角色表sys_role |          |        |
| -------------- | -------- | ------ |
| id             | name     | remark |
| 1              | CEO      | CEO    |
| 2              | 部门经理 | 经理   |
| 3              | BA       | 保安   |

| 用户表(sys_user) |          |          |          |      |         |           |          |          |
| ---------------- | -------- | -------- | -------- | ---- | ------- | --------- | -------- | -------- |
| id               | loginame | identity | realname | sex  | address | phone     | pwd      | position |
| 1                | admin    | 12312    | 小明     | 1    | 武汉    | 134131313 | 123456   | CEO      |
| 2                | zs       | 12312312 | 张三     | 0    | 深圳    | 12313131  | 12345678 | BA       |

| 角色和菜单关系表（sys_role_menu） |               |
| --------------------------------- | ------------- |
| rid(角色编号)                     | mid(菜单编号) |
| 1                                 | 1             |
| 1                                 | 2             |
| 1                                 | 3             |
| 1                                 | 4             |
| 1                                 | 5             |
| 1                                 | 6             |
| 1                                 | 7             |
| 2                                 | 1             |
| 2                                 | 2             |
| 2                                 | 3             |
| 2                                 | 4             |
| 3                                 | 1             |
| 3                                 | 2             |
| 3                                 | 3             |

| 用户和角色关系表（sys_role_user） |               |
| --------------------------------- | ------------- |
| uid(用户编号）                    | rid(角色编号) |
| 1                                 | 1             |
| 2                                 | 2             |
| 2                                 | 3             |

**1.已知角色id=1 查询当前角色所拥有的菜单**

```sql
select t1.* from sys_menu t1 inner join sys_role_menu t2 on(t1.id=t2.mid) where t2.rid=1
```



**2.已知用户id=userid  查询当前用户拥有的所有角色**

```sql
select t1.* from sys_role t1 inner join sys_role_user t2 on(t1.id=t2.rid) where t2.uid=userid
```



3.已知用户id=userid 查询当前用户拥有的所有权限{菜单}**

```sql
select distinct t1.* from sys_menu t1 inner join sys_role_menu t2 inner join sys_role_user t3 on(t1.id=t2.mid and t2.rid=t3.rid)

where t3.uid=userid

```







------

[^时间]: 2019-12-10

#### 4.表单的reset方法不会重置隐藏域名

解决方法：将隐藏域改成如下格式

```jsp
 <input type="text" name="roleid" style="display: none">
```

太尼玛坑了。。。。。











------

[^时间]: 2019-12-11

#### 5.druid数据源监控配置

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



web.xml

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

#### 6.解决layui数据表格删除最后一条数据的问题（删除后停留在最后一页，显示没有数据）

![1576052681943](.\课设问题记录\1576052681943.png)











------

[^时间]: 2019-12-12

#### 7.文件的上传与下载

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

**controller**

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

**工具类**

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

#### 8.文件上传的一些处理思路

[^时间]: 2019-12-14

由于我们设置的文件上传是自动上传，而上传的图片不一定是最终需要的图片，因此我们在设置文件名时，可以在文件扩展名上加上_temp，以标识这是一个临时文件，在用户点击保存后，再将文件进行重命名去除后缀，并将最终的图片保存到数据库中。对于临时文件，我们可以设置一个定时任务将其清除。

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









------

#### 9.时间问题(相差八个小时)

[^时间]: 2019-12-18

![1576638403551](课设问题记录\1576638403551.png)







------

#### 10.url中的路径问题

- 以http:或者https:开头的。例如http:www.baidu.com，该类地址无需拼装即可直接访问。

- 以//（双斜杠）开头的。例如//g.csdnimg.cn/baidu-search/1.0.0/baidu-search.js，该类地址也可以直接访问的。意思是根据当前页面的请求协议在头部自动加上url协议。用来处理网站使用的协议和网页请求外网资源协议不一致。

- 以./开头，表示当前路径。假设当前网址为http://www.baidu.com/CRM/css/cool.css。那么当前路径为

  http://www.baidu.com/CRM/css。

- 以…/开头，表示上一级路径。还是上面的地址，那么上一级路径为http://www.baidu.com/CRM。

- 直接以路径开头，例如css/index.html。这类同等于./，即当前路径。

- 以/（斜杠）开头的，证明在根目录下面。例如有/index.html，那么他的地址为www.baidu.com/index.html。

  



------

#### 11.项目统计分析

[^时间]: 2019-12-19

**哪些数据有统计价值呢？**

客户：

- 客户性别
- 客户地区
- 客户职业
- 录入时间

车辆管理：

- 车辆类型
- 购买价格
- 出租状态（当前）

出租单:

- 车牌号（哪种车出租的多）
- 操作员（统计业绩）

检查单：

- 统计车辆违章修理支出





------

#### 12.按照日期在数据库中查询数据

[^时间]: 2019-12-19

- 从出租单表中查询操作员的年度销售额

  [^参考链接]: <https://www.w3school.com.cn/sql/func_date_format.asp> 

```sql
 select opername as name,sum(price) as value from bus_rent where DATE_FORMAT(createtime,"%Y")=#{year} group by opername  
```

- 查询公司年度十二个月份的销售额

  [^参考链接]: <https://www.w3school.com.cn/sql/sql_union.asp> 

```sql
select sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'01')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'02')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'03')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'04')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'05')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'06')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'07')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'08')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'09')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'10')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'11')
		UNION all
		select
		sum(price) from bus_rent where
		DATE_FORMAT(createtime,"%Y%m")=concat(#{value},'12')
    </select>
```









------

#### 13.解决页面超时跳转到登录页面被框架页面嵌套的问题

session失效后，刷新tab页跳转到登陆页面后，登陆页面会嵌套在主页框架中，解决方法如下：

在login.jsp中加入下面的js代码

```js

        if (window.top.location.href !== location.href) {
            window.top.location.href = location.href;
        }
```

完美解决！！！



------



#### 14.补充（log4j的配置）

log4j的配置

1. 导入依赖(同时使用sel4j和log4j)

   ```xml
   		   <dependency>
                   <groupId>log4j</groupId>
                   <artifactId>log4j</artifactId>
                   <version>1.2.17</version>
               </dependency>
   
               <dependency>
                   <groupId>org.slf4j</groupId>
                   <artifactId>slf4j-api</artifactId>
                   <version>1.7.26</version>
               </dependency>
   
               <dependency>
                   <groupId>org.slf4j</groupId>
                   <artifactId>slf4j-log4j12</artifactId>
                   <version>1.7.26</version>
               </dependency>
   ```

2. 类路径下添加log4j.properties

   ```properties
   # Global logging configuration
   log4j.rootLogger=DEBUG, stdout
   # MyBatis logging configuration...
   log4j.logger.org.mybatis.example.BlogMapper=TRACE
   # Console output...
   log4j.appender.stdout=org.apache.log4j.ConsoleAppender
   log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
   log4j.appender.stdout.layout.ConversionPattern=%5p [%t] - %m%n
   ```

3. 添加mybatis.cfg.xml(我看别人都要这么写，但我这个好象不写不行T_T...)

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE configuration
       PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
       "http://mybatis.org/dtd/mybatis-3-config.dtd">
   <configuration>
    <settings>
    <setting name="logImpl" value="LOG4J"/>
    </settings>
   </configuration>
   ```

4. 在dao层配置sqlSessionFactory时中导入该配置文件

   ```xml
    <!-- 声明sessionFactory  并注入mybatis.cfg.xml-->
       <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
           <!-- 注入数据源 -->
           <property name="dataSource" ref="dataSource"/>
           <!--日志-->
           <property name="configLocation" value="classpath:mybatis.cfg.xml"/>
           <!-- 注入mapper.xml -->
           <property name="mapperLocations">
               <array>
                   <value>classpath:mapper/*/*Mapper.xml</value>
               </array>
           </property>
           <!-- 插件 -->
           <property name="plugins">
               <array>
                   <bean class="com.github.pagehelper.PageInterceptor"></bean>
               </array>
           </property>
       </bean>
   ```

   