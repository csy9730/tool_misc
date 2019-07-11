/***************************Copyright(c)***********************************
**                Guangzhou ZHIYUAN electronics Co.,LTD.                   
**                                                                         
**                      http://www.zlg.cn                         
**                                                                         
**-------------File Info---------------------------------------------------
**File Name:				zal_linear_adrc_test.c
**Latest modified Date: 
**Latest Version:       
**Description:				测试LADRC计算等  
**                      
**-------------------------------------------------------------------------
**Created By:				
**Created Date:				2018-12-03
**Version:					 v1.0.0
**Description:          
**                      
**-------------------------------------------------------------------------
**Modified By:          
**Modified Date:        
**Version:              
**Description:          
**                      
**************************************************************************/

/**
* @example zal_linear_adrc_test.cpp  
* @brief \b LADRC的算法使用示例程序
*/
#include "math.h"
#include "zal_debug.h"
#include "stdlib.h"
#include "zal_linear_adrc.h"

void main(void)
{
};

void zalLesoTest(void){
    ZalLeso eso;
    float y=0,dy=0,y0;
    float u = 0;
    int i=0;
    float zz[3]={0};
    float Ts = 0.001,f0 = 20;
    float hh =0.01,wo = 50, b0 = 1;
    ZAL_DEBUG_CLEARF(ZAL_DEBUG_FILENAME);
    zalLesoInit(&eso,wo,hh,b0);
#define ZAL_PI (3.1415926f)
    for (i=0;i<2000;i++){
        y0 = 100.0 +  ((i>500)&&(i<1000))*((i-500)/2.0)+ (i>1000)*220.0* sin(2*ZAL_PI * f0 *i * Ts) ;
        dy = ((i>500)&&(i<1000))*(1/2.0) +(i>1000)* 2*ZAL_PI * f0*220.0* Ts* cos(2*ZAL_PI * f0 *i * Ts) ;
        y= y0 + (rand()%100-50)/10.0;
        zalLesoStep(&eso,u, y);
        ZAL_DEBUG_DISP("%i,%f,%f,%f,%f,%f,%f\n",i,eso.zz[0],eso.zz[1],eso.zz[02],u,y0,dy);
    }
    ZAL_DEBUG_PLOT;
};



void zalLesoTest0(void)
{
    ZalLeso eso;
    float wo=0.85, hh =0.05, b0=10;
    zalLesoInit( &eso,wo, hh, b0);
    for (int i =0;i<9;i++)
    {
       ZAL_DEBUG_DISP( "%f,",eso.eA[i]);
    }
    ZAL_DEBUG_DISP( "\n");
    for (int i =0;i<6;i++)
    {
       ZAL_DEBUG_DISP( "%f,",eso.eB[i]);
    }
    ZAL_DEBUG_DISP( "\n");

    zalLesoStep( &eso,3,2);

};

// 3*3矩阵加法，数组排列按先行后列，
void mat33Add(const float * pLeftIn,const float *pRightIn,float * pOut);
// 3*3矩阵减法
void mat33Minus(const float * pLeftIn,const float *pRightIn,float * pOut);
// 3*3矩阵乘法
void mat33Mupliply(const float * pLeftIn,const float *pRightIn,float * pOut);
// 3*3矩阵乘 3*2矩阵
void mat33Mupliply32(const float * pLeftIn,const float *pRightIn,float * pOut);
// 3*3矩阵乘 3*1向量
void mat33Mupliply31(const float * pLeftIn,const float *pRightIn,float * pOut);
// 3*2矩阵乘 2*1向量
void mat32Mupliply21(const float * pLeftIn,const float *pRightIn,float * pOut);
// 3*1向量+ 3*1向量
void mat31Add(const float * pLeftIn,const float *pRightIn,float * pOut);

void mat33MupliplyTest(void)
{
    float a[9] ={1,2,3,4,5,6,7,8,9};
    float b[9] = {1,0,1,2,3,4,3,6,9};
    float c[9] ={0};
    float d[6] ={-1,0,  1,2,    2,3};
    float d2[6] ={0};
    int i;
    mat33Mupliply(a ,b, c);
    for (i =0;i<9;i++)
    {
       ZAL_DEBUG_DISP( "%f,",c[i]);
    }
    ZAL_DEBUG_DISP( "\n");

    mat33Mupliply(b ,a, c);
    for (i =0;i<9;i++)
    {
       ZAL_DEBUG_DISP( "%f,",c[i]);
    }
    ZAL_DEBUG_DISP( "\n");
//c = 14.000000,24.000000,36.000000,32.000000,51.000000,78.000000,50.000000,78.000000,120.000000,
// c =8.000000,10.000000,12.000000,42.000000,51.000000,60.000000,90.000000,108.000000,126.000000,
    mat33Mupliply32(a,d,d2); 
    for (i =0;i<6;i++)
    {
       ZAL_DEBUG_DISP( "%f,",d2[i]);
    }
    ZAL_DEBUG_DISP( "\n");
    // d2 = 7.000000,13.000000,13.000000,28.000000,19.000000,43.000000,
}