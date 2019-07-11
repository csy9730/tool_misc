/***************************Copyright(c)***********************************
**                Guangzhou ZHIYUAN electronics Co.,LTD.                   
**                                                                         
**                      http://www.zlg.cn/                          
**                                                                         
**-------------File Info---------------------------------------------------
**File Name:            zal_linear_adrc.h
**Latest modified Date: 
**Latest Version:       
**Description:          
**                      
**-------------------------------------------------------------------------
**Created By:           Chen Shengyong
**Created Date:         2018-12-4
**Version:              v1.0.0
**Description:          线性ADRC算法
**                      
**-------------------------------------------------------------------------
**Modified By:          
**Modified Date:        
**Version:              
**Description:          
**                      
**************************************************************************/

/**
* @addtogroup grp_zal_numeric_calculation
* @{
*/
#ifndef _ZAL_LINEAR_ADRC_H_
#define _ZAL_LINEAR_ADRC_H_

#include "zal_leso.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct  ZalLinearAdrc {
	float m_kp;                 // kp
	float m_kd;                 // kd
	float m_b;                  // b0
    float m_u;                  // 控制输出量
    float m_u0;                 // 控制输出量,未限幅
    float upper;                // 控制输出量的上限
    float lower;                // 控制输出量的下限
    ZalLeso m_observer;         // 扩张观测器
}ZalLinearAdrc;

/**                             初始化结构
 *  @param[in]      pAdrc       输入结构
 *  @param[in]      wo          观测器带宽
 *  @param[in]      wc          控制带宽
 *  @param[in]      b0          控制输入量比例
 *  @param[in]      dt          离散化时间间隔
 */
void zalLinearAdrcInit(ZalLinearAdrc *pAdrc,float wo, float wc, float b0, float dt) ;

/**                             计算控制量输出
 *  @param[in]      pAdrc       输入结构
 *  @param[in]      y           反馈
 *  @param[in]      ref         期望
 *  @ret                        返回控制量输出
 */
float zalLinearAdrcStep(ZalLinearAdrc *pAdrc,float ref,float y ) ;

/**                             设置控制量输出的限幅
 *  @param[in]      pAdrc       输入结构
 *  @param[in]      lower       输出下限
 *  @param[in]      upper       输出上限
 */
void zalLinearAdrcSetBound(ZalLinearAdrc *pAdrc,float lower, float upper) ;


#ifdef __cplusplus
}
#endif

#endif

/** @}  # end of grp_zal_numeric_calculation */
