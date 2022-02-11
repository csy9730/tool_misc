# [c/c++ linux/windows 读取目录下的所有文件名](https://www.cnblogs.com/exciting/p/11039711.html)

参考博客：

[Linux和Windows系统下C++读取文件夹下文件名](https://blog.csdn.net/yanrong1095/article/details/78680566)

[C++中string、char *、char[\]的转换](https://www.cnblogs.com/Pillar/p/4206452.html)

 
linux的c语言版，稍加修改，能够遍历LFW子目录所有图片：

``` cpp
#include <stdio.h>
#include <string.h>
#include <dirent.h>

int main(int argc, char **argv){
    struct dirent *ptr, *ptr1;
    DIR *dir, *dir1;
    dir = opendir("./lfw_arcface_crop/");
    // printf("lists of files:\n");
    int num = 0;
    while((ptr = readdir(dir)) != NULL){
        if(ptr->d_name[0] == '.')
            continue;

        //search subdirectory
        char sub_dir[50] = "lfw_arcface_crop/";
        strcat(sub_dir, ptr->d_name);
        printf("%s\n", sub_dir);
        dir1 = opendir(sub_dir);
        while((ptr1 = readdir(dir1)) != NULL){
            if(ptr1->d_name[0] == '.')
                continue;
            printf("%s   %d\n", ptr1->d_name, num);
            ++num;
            //just choose one img of each sub_dir
            // break;
        }
        printf("\n");
        closedir(dir1);

    }
    printf("the num of imgs in all subdir is:%d\n", num);
    closedir(dir);
    return 0;
}
```

![img](https://img2018.cnblogs.com/blog/864195/201906/864195-20190617150040290-1460009002.png)

 



分类: [C/C++ 杂记](https://www.cnblogs.com/exciting/category/1476614.html)