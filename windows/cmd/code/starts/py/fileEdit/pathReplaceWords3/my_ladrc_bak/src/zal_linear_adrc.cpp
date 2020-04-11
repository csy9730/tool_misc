/***************************Copyright(c)***********************************
**                Guangzhou ZHIYUAN electronics Co.,LTD.                   
**                                                                         
**                      http://www.zlg.cn/                          
**                                                                         
**-------------File Info---------------------------------------------------
**File Name:            zal_linear_adrc.cpp
**Latest modified Date: 
**Latest Version:       
**Description:          
**                      
**-------------------------------------------------------------------------
**Created By:           Chen Shengyong
**Created Date:         2018-12-4
**Version:              v1.0.0
**Description:          ÏßÐÔADRCËã·¨
**                      
**-------------------------------------------------------------------------
**Modified By:          
**Modified Date:        
**Version:              
**Description:          
**                      
**************************************************************************/
#include "zal_linear_adrc.h"

#define ZAL_MAX(a,b) ((a)>=(b)?(a):(b))
#define ZAL_MIN(a,b) ((a)<=(b)?(a):(b))

void zalLinearAdrcInit(ZalLinearAdrc *pAdrc,float wo, float wc, float b0, float dt) 
{
    zalLesoInit(&pAdrc->m_observer, wo, dt,b0);
    pAdrc->m_b = b0;
	pAdrc->m_kp = wc * wc;
	pAdrc->m_kd = wc + wc;

	pAdrc->lower = -1;
	pAdrc->upper = 1;
}

void zalLinearAdrcSetBound(ZalLinearAdrc *pAdrc,float lower, float upper) 
{
	pAdrc->lower = lower;
	pAdrc->upper = upper;
}

float zalLinearAdrcCtrlCal(ZalLinearAdrc *pAdrc,const float* xhat, float ref) {
	float u0 = pAdrc->m_kp * (ref - xhat[0]) + pAdrc->m_kd * ( 0 - xhat[1] );
	return (u0 - xhat[2]) / pAdrc->m_b;
}

float zalLinearAdrcStep(ZalLinearAdrc *pAdrc,float ref,float y )
{
    zalLesoStep(&pAdrc->m_observer,pAdrc->m_u,y);
	pAdrc->m_u0 = zalLinearAdrcCtrlCal(pAdrc,pAdrc->m_observer.zz, ref);
    pAdrc->m_u = ZAL_MAX(pAdrc->m_u0, pAdrc->lower  );
    pAdrc->m_u = ZAL_MIN(pAdrc->m_u, pAdrc->upper  );
    return pAdrc->m_u;
}