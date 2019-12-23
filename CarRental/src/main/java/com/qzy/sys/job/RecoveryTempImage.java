package com.qzy.sys.job;

import com.qzy.sys.constast.SysConstast;
import com.qzy.sys.utils.AppFileUtils;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.File;

@Component
@EnableScheduling
public class RecoveryTempImage {

    //每天晚上12点执行
    @Scheduled(cron = "0 0 0 * * ? ")
    public void recoveryTempImage(){
        File file = new File(AppFileUtils.PATH);
        deleteFile(file);

    }

    //删除文件
    private void deleteFile(File file) {
        if(file!=null){
            File[] files = file.listFiles();
            if(files!=null&&files.length>0){
                for(File f:files){
                    if(f.isFile()){
                        if(f.getName().endsWith(SysConstast.FILE_UPLOAD_TEMP)){
                            f.delete();
                        }
                    }else {
                        deleteFile(f);
                    }
                }
            }
        }
    }


}
