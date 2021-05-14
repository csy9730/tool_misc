#include <iostream>  
#include <stdlib.h>  
#include <stdio.h>  
#include <string.h>  
#ifdef linux  
#include <unistd.h>  
#include <dirent.h>  

int main(void)  
{  
DIR *dir;  
char basePath[100];
///get the current absoulte path  
memset(basePath, '\0', sizeof(basePath));  
getcwd(basePath, 999);  
printf("the current dir is : %s\n",basePath);
cout<<endl<<endl;  
vector<string> files=getFiles(basePath);  
for (int i=0; i<files.size(); i++)  
{  
cout<<files[i]<<endl;  
} 
cout<<"end..."<<endl<<endl;  
return 0;  
}