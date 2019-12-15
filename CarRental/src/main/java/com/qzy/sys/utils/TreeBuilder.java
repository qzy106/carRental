package com.qzy.sys.utils;
import com.qzy.sys.utils.TreeNode;

import java.util.ArrayList;
import java.util.List;


//将没有层级关系的菜单列表转化为有层级关系的
public class TreeBuilder{



    public static List<TreeNode> build(List<TreeNode> nodes,Integer pid){
        //有层级关系的节点列表
        ArrayList<TreeNode> treeNodes = new ArrayList<>();

        for (TreeNode n1 : nodes) {
            if(n1.getPid()==pid){
                treeNodes.add(n1);
            }

            for (TreeNode n2 : nodes) {
                if (n2.getPid()==n1.getId()){
                    n1.getChildren().add(n2);
                }
            }
        }

        return treeNodes;
    }


}
