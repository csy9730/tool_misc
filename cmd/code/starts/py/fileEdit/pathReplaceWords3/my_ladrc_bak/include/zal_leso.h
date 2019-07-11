/***************************Copyright(c)***********************************
**                Guangzhou ZHIYUAN electronics Co.,LTD.                   
**                                                                         
**                      http://www.zlg.cn/                          
**                                                                         
**-------------File Info---------------------------------------------------
**File Name:            zal_leso.h
**Latest modified Date: 
**Latest Version:       
**Description:          
**                      
**-------------------------------------------------------------------------
**Created By:           Chen Shengyong
**Created Date:         2018-12-4
**Version:              v1.0.0
**Description:          线性扩张观测器算法
**                      
**-------------------------------------------------------------------------
**Modified By:          
**Modified Date:        
**Version:              
**Description:          
**                      
**************************************************************************/

#ifndef _ZAL_LESO_H_
#define _ZAL_LESO_H_

#ifdef __cplusplus
extern "C" {
#endif

typedef struct ZalLeso{
    float zz[3];    // 观测量位移量，速度量，扰动量
    float eA[9];    //   
    float eB[6];    //
}ZalLeso;

/**                             初始化观测器结构
 *  @param[in]      pEso        输入结构
 *  @param[in]      wo          观测器带宽
 *  @param[in]      b0          控制输入量比例
 *  @param[in]      hh          离散化时间间隔,微分观测量(zz[1])与hh大小成反比。
 */
void zalLesoInit(ZalLeso* pEso,float wo,float hh,float b0);

/**                             观测器结构更新
 *  @param[in]      pEso        输入结构
 *  @param[in]      u           控制输入量
 *  @param[in]      y           观测量
 */
void zalLesoStep(ZalLeso* pEso,float u,float y);

/**                             获取观测器结构的状态
 *  @param[in]      pEso        输入结构
 *  @param[out]     pOut        输出观测量
 */
void zalLesoGetState(ZalLeso* pEso,float * pOut);


#ifdef __cplusplus
}
#endif

#endif

