/** ***************************Copyright(c)***********************************
**                Guangzhou ZHIYUAN electronics Co.,LTD. 
** 
**                  http://www.zlg.cn       
** 
**-------------File Info---------------------------------------------------
**File Name:            zalCommon.h 
**Latest modified Date: 2017-08-07
**Latest Version:       
**Description:          通用宏    
**    
**-------------------------------------------------------------------------
**Created By:           Chen Shengyong
**Created Date:         2017-08-07
**Version:              v1.0.0
**Description:          
**    
**-------------------------------------------------------------------------
**Modified By:          
**Modified Date:           
**Version:                     
**Description:          
**    
**************************************************************************/
#ifndef __ZAL_COMMON_H_
#define __ZAL_COMMON_H_

//#include "zalCmakeCfg.h"

#ifdef __cplusplus
extern "C" {
#endif

/*  dll output */
#define ZAL_API 
#ifdef ZAL_LIB_SHARED
    #if ZAL_LIB_SHARED
	        #define ZAL_API  __declspec(dllimport)
    #endif
#endif


/*
 * 长度宏
 */
#define ZAL_LEN(x) (sizeof(x)/sizeof(*(x)))

#define ZAL_MAX(a,b) ((a)>=(b)?(a):(b))
#define ZAL_MIN(a,b) ((a)<=(b)?(a):(b))
#define ZAL_ABS(a) (((a)>=0)?(a):(-(a)))
#define ZAL_SAT(x,low,up) ((x)>=(low)?( ((x)<=(up)?(x):(up)) ):(low))  
#define ZAL_SGN(x) ((x)>=(0)?( ((x)==(0)?(0):(1)) ):(-1))  
//
/* 
 * 指针类型转换
 */
#define ZAL_PTR_CH(VAR,TYPE)  (*((TYPE*) (VAR)) )

/*
 * malloc语句
 */
#ifdef _ZAL_MALLOC
	#define ZAL_MALLOC(ZAL_LEN,TYPE) (TYPE*) malloc(ZAL_LEN*sizeof(TYPE))
	#define ZAL_FREE(PTR) (free(PTR))
#else
	#define ZAL_MALLOC(ZAL_LEN,TYPE) ((TYPE*) 0)
	#define ZAL_FREE(PTR) (0)
#endif

#define ZAL_CONNECT(TYPE, MEMBER )  TYPE ## MEMBER 
#define ZAL_CONNECT2(TYPE, MEMBER )  TYPE # MEMBER 

#define C_API extern "C" 

#ifdef __cplusplus
}
#endif

#endif