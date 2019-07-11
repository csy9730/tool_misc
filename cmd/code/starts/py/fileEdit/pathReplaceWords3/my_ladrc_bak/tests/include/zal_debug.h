/** ***********************************************************************
 *  @file          
 *  @date               2017/09/12
 *  @version            v3.0.0 
 *  @author             Chen Shengyong
 *  @description 
 *  @brief             
 ** ***********************************************************************/
#ifndef __ZAL_DEBUG_H_
#define __ZAL_DEBUG_H_

#ifdef __cplusplus
extern "C" {
#endif


/*开启下面的宏 _DEBUG,表示程序运行在调试版本, 否则为发行版本*/
#ifdef _DEBUG

#define ZAL_DEBUG_PLOT system("if exist  ePlotDat.py  (python ePlotDat.py  debugmsg.txt  )else ( if exist  debug\\ePlotDat.py  (python debug\\ePlotDat.py  debug\\debugmsg.txt ))");

#include "stdio.h"
#include "zal_common.h"

/* 选择执行单行语句*/
#define ZAL_DEBUG_EVAL(abc) abc
/*调试信息的缓冲长度*/
#define ZAL_DEBUG_BUFFER_MAX 4096

extern int g_debugChangeFlag;
/**  变化标志位置零 */
#define ZAL_DEBUG_CHANGEINIT  g_debugChangeFlag=0
/**  变化标志位赋值 */
#define ZAL_DEBUG_CHANGESET(x)  g_debugChangeFlag|=(1<<(x))
/**  变化标志位取值 */
#define ZAL_DEBUG_CHANGEGET  g_debugChangeFlag

/*开启下面的宏就把调试信息输出到文件终端，否则输出到屏幕终端*/
/*定义终端为写文件*/
#define ZAL_DEBUG_TO_FILE

#ifdef ZAL_DEBUG_TO_FILE

/*调试信息输出到以下文件路径*/
#define ZAL_TEST_PATH "//test"
#define ZAL_DEBUG_PATH ""

#define ZAL_DEBUG_FILENAME "debugmsg.txt"   ///< 数据缓存
#define ZAL_DEBUG_FILENAME2 ZAL_CONNECT(ZAL_DEBUG_PATH,"debugmsg2.txt") ///< 时点与特征提取
#define ZAL_DEBUG_FILENAME3 "debugmsg3.txt" ///< 批处理统计识别率
#define ZAL_DEBUG_FILENAME4 "debugmsg4.txt" ///< 批处理统计识别率
#define ZAL_TEST_FILENAME "testMsg.log"     ///< 测试记录

/*开启下面的宏就把调试信息输出到文件，注释即输出到终端*/
#define ZAL_DEBUG_PRINT(DISPLAY,...)  ZAL_DEBUG_PRINTF(DISPLAY,ZAL_DEBUG_FILENAME,__VA_ARGS__)

/*将调试信息输出到文件中*/
#define ZAL_DEBUG_PRINTF(DISPLAY,FABC,...) \
		{\
			if ((DISPLAY )>0){\
				FILE* fd ;\
				char buffer[ZAL_DEBUG_BUFFER_MAX+1]={0};\
				fopen_s(&fd,FABC, "a");\
				sprintf( buffer,__VA_ARGS__);\
				printf(buffer) ;\
				if ( fd != NULL ) {\
					fprintf(fd,buffer  );\
					fflush( fd );\
					fclose( fd );\
				}; \
			}\
        }while(0)

#define ZAL_DEBUG_DISP(...) ZAL_DEBUG_PRINTF(1,ZAL_DEBUG_FILENAME,__VA_ARGS__)
#define ZAL_TEST_DISP(...) ZAL_DEBUG_PRINTF(1,ZAL_TEST_FILENAME,__VA_ARGS__)
// 文件清空
#define ZAL_DEBUG_CLEARF(FABC) \
		{\
			FILE* fd ;\
			fopen_s(&fd,FABC, "w+");\
			if ( fd != NULL ) {\
				fflush( fd );\
				fclose( fd );\
			}; \
        }while(0)

#else  /* else for ZAL_DEBUG_TO_FILE */
/*调试默认终端，屏幕*/
#define ZAL_DEBUG_PRINT(DISPLAY,...) if (DISPLAY >0)  printf(__VA_ARGS__)
#define ZAL_DEBUG_PRINTF(DISPLAY,FILE,...) if (DISPLAY >0)  printf(__VA_ARGS__)
#define ZAL_DEBUG_MSG(moduleName, format, ...) \
                  printf( "[%s] "format" File:%s, Line:%d\n", moduleName, ##__VA_ARGS__, __FILE__, __LINE__ );
#define ZAL_DEBUG_DISP(...) ZAL_DEBUG_PRINTF(1,ZAL_DEBUG_FILENAME,__VA_ARGS__)
#define ZAL_TEST_DISP(...) ZAL_DEBUG_PRINTF(1,ZAL_TEST_FILENAME,__VA_ARGS__)
#define ZAL_DEBUG_CLEARF(FABC) 
#endif  /* end for ZAL_DEBUG_TO_FILE */


#else /* else for _DEBUG*/
	#define ZAL_DEBUG_PRINT(DISPLAY,...) 
	#define ZAL_DEBUG_PRINTF(DISPLAY,FILE,...) 
	#define ZAL_DEBUG_MSG(moduleName, format, ...)
	#define ZAL_DEBUG_EVAL(abc) 
	#define ZAL_DEBUG_CLEARF(FABC) 
    #define ZAL_DEBUG_DISP(...) 
    #define ZAL_TEST_DISP(...) 

    #define ZAL_DEBUG_CHANGEINIT  
    #define ZAL_DEBUG_CHANGESET(x)
    #define ZAL_DEBUG_CHANGEGET 0
#endif  /*end for _DEBUG*/

#ifdef __cplusplus
}
#endif

#endif