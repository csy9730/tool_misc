/***************************Copyright(c)***********************************
**                Guangzhou ZHIYUAN electronics Co.,LTD.                   
**                                                                         
**                      http://www.zlg.cn/                          
**                                                                         
**-------------File Info---------------------------------------------------
**File Name:            zal_leso.cpp
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
#include "zal_leso.h"
#include "math.h"



// 3*3矩阵加法，数组排列按先行后列，
void mat33Add(const float * pLeftIn,const float *pRightIn,float * pOut)
{
    int i,j;
    for (i=0;i<3;i++) // row
    {
        for (j =0;j<3;j++) // column
        {
            pOut[j+i*3] =  pLeftIn[j+i*3] + pRightIn[j+i*3];            
        }
    }
}
// 3*3矩阵减法
void mat33Minus(const float * pLeftIn,const float *pRightIn,float * pOut)
{
    int i,j;
    for (i=0;i<3;i++) 
    {
        for (j =0;j<3;j++) 
        {
            pOut[j+i*3] =  pLeftIn[j+i*3] -pRightIn[j+i*3];            
        }
    }
}
// 3*3矩阵乘法
void mat33Mupliply(const float * pLeftIn,const float *pRightIn,float * pOut)
{
    int i,j,k;
    for (i=0;i<3;i++)
    {
        for (j =0;j<3;j++)
        {
            pOut[j+i*3] = 0;
            for (k = 0;k<3;k++){
                pOut[j+i*3] +=  pLeftIn[k+i*3] *pRightIn[j+k*3];
            }
        }
    }
}
// 3*3矩阵乘 3*2矩阵
void mat33Mupliply32(const float * pLeftIn,const float *pRightIn,float * pOut)
{
    int i,j,k;
    for (i=0;i<3;i++)
    {
        for (j =0;j<2;j++)
        {
            pOut[j+i*2] = 0;
            for (k = 0;k<3;k++){
                pOut[j+i*2] +=  pLeftIn[k+i*3] *pRightIn[j+k*2];
            }
        }
    }
}
// 3*3矩阵乘 3*1向量
void mat33Mupliply31(const float * pLeftIn,const float *pRightIn,float * pOut)
{
    int i,j,k;
    for (i=0;i<3;i++)
    {
        pOut[i] = 0;
        for (k = 0;k<3;k++){
            pOut[i] +=  pLeftIn[k+i*3] *pRightIn[k];
        }
    }
}

// 3*2矩阵乘 2*1向量
void mat32Mupliply21(const float * pLeftIn,const float *pRightIn,float * pOut)
{
    int i,k;
    for (i=0;i<3;i++)
    {
        pOut[i] = 0;
        for (k = 0;k<2;k++){
            pOut[i] +=  pLeftIn[k+i*2] *pRightIn[k];
        }
    }
}
// 3*1向量+ 3*1向量
void mat31Add(const float * pLeftIn,const float *pRightIn,float * pOut)
{
    int i;
    for (i=0;i<3;i++)
    {
        pOut[i] =  pLeftIn[i] *pRightIn[i];
    }
}

//%%
//hh =2.5;
//wo = 0.85;
//AO = [-3*wo,1,0;-3*wo*wo ,0,1;-wo*wo*wo,0,0];
//V = [wo^2 -2*wo 1;2*wo^3 -3*wo^2 0; wo^4 -wo^3 0];
//IV = [0,0,1;-wo^-3,-wo^-2,-1/wo;3*wo^-4,2*wo^-3,wo^-2]';
//J = diag(-[wo ,wo wo]);J2(1,2)=1;J2(2,3)=1;
//EJ= expm(J*hh)
//EA =expm(AO*hh) 
//EA2= V*EJ*IV
//% zr97=norm(EA2-EA);
void zalWodt2Exmpm(float wo,float hh,float * pEa)
{
    float ewt = exp(-wo*hh) ,tewt = hh* exp(-wo*hh),ttewt = hh* hh* exp(-wo*hh) /2 ;
    float EJ[9] = { ewt,tewt,ttewt,     0,ewt,tewt,     0,0,ewt };
    float V[9] = {wo*wo,-2*wo,1,    2*wo*wo*wo,-3*wo*wo,0,  wo*wo*wo*wo, -wo*wo*wo,0};
    float IV[9] = {0,-1/wo/wo/wo,3/wo/wo/wo/wo,    0,-1/wo/wo,2/wo/wo/wo,  1, -1/wo,1/wo/wo};
    float tmp[9] ={0};
    mat33Mupliply(V,EJ,tmp);
    mat33Mupliply(tmp,IV,pEa);
}

/*
ABO = [ A , B; O,I]
W, H = eig(ABO)
EABO = H * diag(exp(W * hh)) * inv(H)
EA = EABO[0:3, 0:3]
EB = EABO[0:3, 3:5]
*/ 
void zalLesoInit(ZalLeso* pEso,float wo,float hh,float b0)
{
    float mB[6] ={0, 3*wo,b0  ,3*wo*wo,0, wo*wo*wo};
    float iA[9] ={0,0,-1/wo/wo/wo, 	1,0,-3/wo/wo,		0,1,-3/wo};
    float tmp[9] ={0},tmp2[9]={0};
    float mI[9] ={1,0,0,    0,1,0,  0,0,1};
    pEso->zz[0] = 0;
    pEso->zz[1] = 0;
    pEso->zz[2] = 0;
    zalWodt2Exmpm(wo,hh,pEso->eA);
    //  EB = inv(A) * (EA-eye(3)) *B;
    mat33Minus(pEso->eA,mI,tmp);
    mat33Mupliply(iA,tmp,tmp2); 
    mat33Mupliply32(tmp2,mB,pEso->eB); 
};

//zz = EA * zz + EB * uy
void zalLesoStep(ZalLeso* pEso,float u,float y)
{

    float tmp[3],tmp2[3];
    float uy[2] = { u,y};
    int i;
    mat33Mupliply31(pEso->eA,pEso->zz,tmp);
    mat32Mupliply21(pEso->eB,uy, tmp2);
    for (i=0;i<3;i++)
    {
        pEso->zz[i] =  tmp[i] + tmp2[i];
    }
};
void zalLesoGetState(ZalLeso* pEso,float * pOut)
{
    int i;
    for (i=0;i<3;i++)
    {
        pOut[i] = pEso->zz[i] ;
    }
};
