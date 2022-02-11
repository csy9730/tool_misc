# [Linux 用C语言判断文件和文件夹](https://www.cnblogs.com/xingyunblog/p/7003588.html)



Linux 用C语言判断文件和文件夹


``` cpp
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <dirent.h>
int access(const char *pathname, int mode);
int is_file_exist(const char*file_path){
   if(file_path==NULL){
     return -1;
   }
   if(access(file_path,F_OK)==0){
    return 0;
   }
   return -1;
}
int is_dir_exist(const char*dir_path){
    if(dir_path==NULL){
        return -1;
    }
    if(opendir(dir_path)==NULL){
        return -1;
    }
    return 0;
}
int main(int argc,char** argv)
{
    char *myFileBasePath="/usr/bin/.bin/bin";
    
    int judgeFileResultCode=is_file_exist(myFileBasePath);
    if(judgeFileResultCode==0){
         printf("文件存在\n");
    }else if(judgeFileResultCode==-1){
         printf("文件不存在\n");
    }
    int judgeDirResultCode=is_dir_exist(myFileBasePath);
    if(judgeDirResultCode==0){
        printf("打开文件夹成功，这是个文件夹\n");
    }else if(judgeDirResultCode==-1){
        printf("打开文件夹失败，这不是个文件夹或者文件夹路径错误\n");
    }
    return 0;
}
```

分类: [C](https://www.cnblogs.com/xingyunblog/category/568872.html)
