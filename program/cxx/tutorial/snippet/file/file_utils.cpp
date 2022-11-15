#include "file_utils.h"
#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#ifdef WIN32
    #include <direct.h>
    #include <io.h>
#else
    #include <unistd.h>
    #include <dirent.h>
#endif


#include <vector>
#include <string>

using namespace std;

/** 
 * 返回文件是否存在
 * 
 * file_path
 * 
*/
bool is_file_exist(const char* file_path);

/** 
 * 返回文件夹是否存在
 * 
 * file_path
 * 
*/
bool is_dir_exist(const char* file_path);

/** 获取文件夹下文件列表
 * 
 * 
 * 
*/
void getFiles(string path, vector<string>& files);

/** 获取文件内容，按行分割成字符串
 * 
 * fl   输入文件路径
 * 
*/
void getFileContent(const string fl, vector<string>& files);


bool is_file_exist(const char *file_path)
{
    if (file_path == NULL)
    {
        return false;
    }
    if (access(file_path, F_OK) == 0)
    {
        if (opendir(file_path) == NULL)
        {
            return true;
        }
        return false;
    }
    return false;
}

bool is_dir_exist(const char *dir_path)
{
    if (dir_path == NULL)
    {
        return false;
    }
    if (opendir(dir_path) == NULL)
    {
        return false;
    }
    return true;
}

#ifdef WIN32
void getFiles(string path, vector<string> &files)
{
    long hFile = 0;
    struct _finddata_t fileinfo;
    string p;
    if ((hFile = _findfirst(p.assign(path).append("\\*").c_str(), &fileinfo)) != -1)
    {
        do
        {
            if ((fileinfo.attrib & _A_SUBDIR))
            {
            }
            else
            {
                files.push_back(p.assign(path).append("\\").append(fileinfo.name));
            }
        } while (_findnext(hFile, &fileinfo) == 0);
        _findclose(hFile);
    }
}
#else

void getFiles(string path, vector<string> &files)
{
    DIR *dirs;
    dirs = opendir(path.c_str());
    if (!dirs)
    {
        return;
    }
    struct dirent *dirInfo;
    while ((dirInfo = readdir(dirs)) != 0)
    {
        if (dirInfo->d_name[0] == '.')
            continue;
        // cout << "Value test: " << dirInfo->d_name << endl;
        files.push_back(dirInfo->d_name);
    }
    // 3、最后关闭文件目录
    closedir(dirs);
}
#endif

bool isFile(string path)
{
    long hFile = 0;
    //文件信息
    /*
    struct _finddata_t fileinfo;
    string p;
    if((hFile = _findfirst(p.assign(path).c_str(), &fileinfo)) !=  -1){
        return !(fileinfo.attrib & _A_SUBDIR);
    }

    
    struct stat s;
    if (stat(path, &s) == 0)
    {
        if (s.st_mode & S_IFDIR)
        {
            return 0;
        }
        else if (s.st_mode & S_IFREG)
        {
            return 1;
        }
        else
        {
            std::cout << "not file not directory" << std::endl;
        }
    }
    else
    {
        std::cout << "error, doesn't exist" << std::endl;
        return 0;
    }
        */
    return 0;
}


void getFileContent(const string fl, vector<string>& files){
    ifstream fin(fl);
    string strline;
    while (getline(fin, strline))
    {
        files.push_back(strline);
    }
}