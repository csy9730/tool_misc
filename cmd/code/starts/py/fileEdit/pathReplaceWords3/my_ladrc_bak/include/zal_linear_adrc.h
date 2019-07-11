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
**Description:          ����ADRC�㷨
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
    float m_u;                  // ���������
    float m_u0;                 // ���������,δ�޷�
    float upper;                // ���������������
    float lower;                // ���������������
    ZalLeso m_observer;         // ���Ź۲���
}ZalLinearAdrc;

/**                             ��ʼ���ṹ
 *  @param[in]      pAdrc       ����ṹ
 *  @param[in]      wo          �۲�������
 *  @param[in]      wc          ���ƴ���
 *  @param[in]      b0          ��������������
 *  @param[in]      dt          ��ɢ��ʱ����
 */
void zalLinearAdrcInit(ZalLinearAdrc *pAdrc,float wo, float wc, float b0, float dt) ;

/**                             ������������
 *  @param[in]      pAdrc       ����ṹ
 *  @param[in]      y           ����
 *  @param[in]      ref         ����
 *  @ret                        ���ؿ��������
 */
float zalLinearAdrcStep(ZalLinearAdrc *pAdrc,float ref,float y ) ;

/**                             ���ÿ�����������޷�
 *  @param[in]      pAdrc       ����ṹ
 *  @param[in]      lower       �������
 *  @param[in]      upper       �������
 */
void zalLinearAdrcSetBound(ZalLinearAdrc *pAdrc,float lower, float upper) ;


#ifdef __cplusplus
}
#endif

#endif

/** @}  # end of grp_zal_numeric_calculation */
