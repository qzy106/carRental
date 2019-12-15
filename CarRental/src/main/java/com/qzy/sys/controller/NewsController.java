package com.qzy.sys.controller;
import com.qzy.sys.domain.News;
import com.qzy.sys.domain.User;
import com.qzy.sys.service.NewsService;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.utils.ResultObj;
import com.qzy.sys.utils.WebUtils;
import com.qzy.sys.vo.NewsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
@RequestMapping("news")
public class NewsController {

    @Autowired
    private NewsService newsService;


    //加载公告列表返回DataGridView

    @RequestMapping("loadAllNews")
    public DataGridView loadAllNews(NewsVo newsVo) {
        return newsService.queryAllNews(newsVo);

    }



    //删除公告
    @RequestMapping("DeleteNews")
    public ResultObj DeleteNews(NewsVo newsVo) {
        try {
            newsService.deleteNews(newsVo.getId());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

     //添加公告
    @RequestMapping("addNews")
    public ResultObj addNews(NewsVo newsVo) {
        try {
            User user= (User) WebUtils.getHttpSession().getAttribute("user");
            newsVo.setCreatetime(new Date());
            newsVo.setOpername(user.getRealname());
            newsService.addNews(newsVo);
            return ResultObj.ADD_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }

    }

      //修改公告
    @RequestMapping("updateNews")
    public ResultObj updateNews(NewsVo newsVo) {
        try {
            newsService.updateNews(newsVo);
            return ResultObj.UPDATE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }

    }




    //批量删除公告
    @RequestMapping("deleteBatchNews")
    public ResultObj deleteBatchNews(NewsVo newsVo) {
        try {
            newsService.deleteBatchNews(newsVo.getIds());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }

    }

    //根据id查询公告
	@RequestMapping("loadNewsById")
	public News loadNewsById(Integer id) {
		return this.newsService.queryNewsById(id);
	}


}
