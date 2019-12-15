package com.qzy.sys.service;

import com.qzy.sys.domain.News;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.vo.NewsVo;

//公告管理的服务接口
public interface NewsService {


    DataGridView queryAllNews(NewsVo newsVo);

    void deleteNews(Integer newsId);

    void deleteBatchNews(Integer[] ids);

    void addNews(NewsVo newsVo);

    void updateNews(NewsVo newsVo);

    News queryNewsById(Integer id);
}
