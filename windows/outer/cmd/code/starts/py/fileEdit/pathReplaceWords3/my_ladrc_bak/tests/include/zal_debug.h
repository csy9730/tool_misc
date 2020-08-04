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


/*��������ĺ� _DEBUG,��ʾ���������ڵ��԰汾, ����Ϊ���а汾*/
#ifdef _DEBUG

#define ZAL_DEBUG_PLOT system("if exist  ePlotDat.py  (python ePlotDat.py  debugmsg.txt  )else ( if exist  debug\\ePlotDat.py  (python debug\\ePlotDat.py  debug\\debugmsg.txt ))");

#include "stdio.h"
#include "zal_common.h"

/* ѡ��ִ�е������*/
#define ZAL_DEBUG_EVAL(abc) abc
/*������Ϣ�Ļ��峤��*/
#define ZAL_DEBUG_BUFFER_MAX 4096

extern int g_debugChangeFlag;
/**  �仯��־λ���� */
#define ZAL_DEBUG_CHANGEINIT  g_debugChangeFlag=0
/**  �仯��־λ��ֵ */
#define ZAL_DEBUG_CHANGESET(x)  g_debugChangeFlag|=(1<<(x))
/**  �仯��־λȡֵ */
#define ZAL_DEBUG_CHANGEGET  g_debugChangeFlag

/*��������ĺ�Ͱѵ�����Ϣ������ļ��նˣ������������Ļ�ն�*/
/*�����ն�Ϊд�ļ�*/
#define ZAL_DEBUG_TO_FILE

#ifdef ZAL_DEBUG_TO_FILE

/*������Ϣ����������ļ�·��*/
#define ZAL_TEST_PATH "//test"
#define ZAL_DEBUG_PATH ""

#define ZAL_DEBUG_FILENAME "debugmsg.txt"   ///< ���ݻ���
#define ZAL_DEBUG_FILENAME2 ZAL_CONNECT(ZAL_DEBUG_PATH,"debugmsg2.txt") ///< ʱ����������ȡ
#define ZAL_DEBUG_FILENAME3 "debugmsg3.txt" ///< ������ͳ��ʶ����
#define ZAL_DEBUG_FILENAME4 "debugmsg4.txt" ///< ������ͳ��ʶ����
#define ZAL_TEST_FILENAME "testMsg.log"     ///< ���Լ�¼

/*��������ĺ�Ͱѵ�����Ϣ������ļ���ע�ͼ�������ն�*/
#define ZAL_DEBUG_PRINT(DISPLAY,...)  ZAL_DEBUG_PRINTF(DISPLAY,ZAL_DEBUG_FILENAME,__VA_ARGS__)

/*��������Ϣ������ļ���*/
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
// �ļ����
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
/*����Ĭ���նˣ���Ļ*/
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