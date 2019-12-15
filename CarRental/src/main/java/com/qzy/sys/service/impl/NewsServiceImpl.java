package com.qzy.sys.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.qzy.sys.domain.News;
import com.qzy.sys.mapper.NewsMapper;
import com.qzy.sys.service.NewsService;
import com.qzy.sys.utils.DataGridView;
import com.qzy.sys.vo.NewsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class NewsServiceImpl implements NewsService {

    @Autowired
    private NewsMapper newsMapper;

    @Override
    public DataGridView queryAllNews(NewsVo newsVo) {
        //自动的对PageHelper.startPage 方法下的第一个sql 查询进行分页
        Page<Object> page = PageHelper.startPage(newsVo.getPage(), newsVo.getLimit());
        //紧跟着的第一个select 方法会被分页
        List<News> Newss = newsMapper.queryAllNews(newsVo);
        return new DataGridView(page.getTotal(), Newss);
    }

    @Override
    public void addNews(NewsVo newsVo) {
        newsMapper.insertSelective(newsVo);
    }

    @Override
    public void updateNews(NewsVo newsVo) {
        newsMapper.updateByPrimaryKeySelective(newsVo);
    }

    //根据id查询公告
    @Override
    public News queryNewsById(Integer id) {
        return newsMapper.selectByPrimaryKey(id);
    }

    @Override
    public void deleteNews(Integer newsId) {
        newsMapper.deleteByPrimaryKey(newsId);
    }

    //批量删除
    @Override
    public void deleteBatchNews(Integer[] ids) {
        for (Integer newsid : ids) {
            deleteNews(newsid);
        }
    }





}
