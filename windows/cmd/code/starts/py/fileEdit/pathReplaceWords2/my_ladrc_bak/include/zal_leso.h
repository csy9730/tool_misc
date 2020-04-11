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
**Description:          �������Ź۲����㷨
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
    float zz[3];    // �۲���λ�������ٶ������Ŷ���
    float eA[9];    //   
    float eB[6];    //
}ZalLeso;

/**                             ��ʼ���۲����ṹ
 *  @param[in]      pEso        ����ṹ
 *  @param[in]      wo          �۲�������
 *  @param[in]      b0          ��������������
 *  @param[in]      hh          ��ɢ��ʱ����,΢�ֹ۲���(zz[1])��hh��С�ɷ��ȡ�
 */
void zalLesoInit(ZalLeso* pEso,float wo,float hh,float b0);

/**                             �۲����ṹ����
 *  @param[in]      pEso        ����ṹ
 *  @param[in]      u           ����������
 *  @param[in]      y           �۲���
 */
void zalLesoStep(ZalLeso* pEso,float u,float y);

/**                             ��ȡ�۲����ṹ��״̬
 *  @param[in]      pEso        ����ṹ
 *  @param[out]     pOut        ����۲���
 */
void zalLesoGetState(ZalLeso* pEso,float * pOut);


#ifdef __cplusplus
}
#endif

#endif

