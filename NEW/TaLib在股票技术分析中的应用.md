# TaLib在股票技术分析中的应用

46 人赞同了该文章
1、TaLib与技术分析
技术分析是股票分析十分有效直接的手段，在实际投资中我们常常需要计算各种简单或复杂的技术指标来分析参考

对于技术指标的定义基本都大同小异，很多都是通用的且模块化的东西

对于不会写代码或者不想自己写函数计算这些技术指标的人而言，强大的Talib给我们带来了福音

只需要调用Talib的函数，输入简单的参数就可以得到自己想要的结果

2、初看Talib
先简单看看Talib都给我们提供了那些计算技术指标的函数，按技术指标的类型列示如下：

Overlap Studies Functions

BBANDS - Bollinger Bands
upperband, middleband, lowerband = BBANDS(close, timeperiod=5, nbdevup=2, nbdevdn=2, matype=0)

DEMA - Double Exponential Moving Average
real = DEMA(close, timeperiod=30)

EMA - Exponential Moving Average
real = EMA(close, timeperiod=30)

HT_TRENDLINE - Hilbert Transform - Instantaneous Trendline
real = HT_TRENDLINE(close)

KAMA - Kaufman Adaptive Moving Average
real = KAMA(close, timeperiod=30)

MA - Moving average
real = MA(close, timeperiod=30, matype=0)

MAMA - MESA Adaptive Moving Average
mama, fama = MAMA(close, fastlimit=0, slowlimit=0)

MAVP - Moving average with variable period
real = MAVP(close, periods, minperiod=2, maxperiod=30, matype=0)

MIDPOINT - MidPoint over period
real = MIDPOINT(close, timeperiod=14)

MIDPRICE - Midpoint Price over period
real = MIDPRICE(high, low, timeperiod=14)

SAR - Parabolic SAR
real = SAR(high, low, acceleration=0, maximum=0)

SAREXT - Parabolic SAR - Extended
real = SAREXT(high, low, startvalue=0, offsetonreverse=0, accelerationinitlong=0, 
accelerationlong=0, accelerationmaxlong=0, accelerationinitshort=0, accelerationshort=0, accelerationmaxshort=0)

SMA - Simple Moving Average
real = SMA(close, timeperiod=30)

T3 - Triple Exponential Moving Average (T3)
real = T3(close, timeperiod=5, vfactor=0)

TEMA - Triple Exponential Moving Average
real = TEMA(close, timeperiod=30)

TRIMA - Triangular Moving Average
real = TRIMA(close, timeperiod=30)

WMA - Weighted Moving Average
real = WMA(close, timeperiod=30) 
Momentum Indicator Functions

ADX - Average Directional Movement Index
real = ADX(high, low, close, timeperiod=14)

ADXR - Average Directional Movement Index Rating
real = ADXR(high, low, close, timeperiod=14)

APO - Absolute Price Oscillator
real = APO(close, fastperiod=12, slowperiod=26, matype=0)

AROON - Aroon
aroondown, aroonup = AROON(high, low, timeperiod=14)

AROONOSC - Aroon Oscillator
real = AROONOSC(high, low, timeperiod=14)

BOP - Balance Of Power
real = BOP(open, high, low, close)

CCI - Commodity Channel Index
real = CCI(high, low, close, timeperiod=14)

CMO - Chande Momentum Oscillator
real = CMO(close, timeperiod=14)

DX - Directional Movement Index
real = DX(high, low, close, timeperiod=14)

MACD - Moving Average Convergence/Divergence
macd, macdsignal, macdhist = MACD(close, fastperiod=12, slowperiod=26, signalperiod=9)

MACDEXT - MACD with controllable MA type
macd, macdsignal, macdhist = MACDEXT(close, fastperiod=12, fastmatype=0, slowperiod=26, 
slowmatype=0, signalperiod=9, signalmatype=0)

MACDFIX - Moving Average Convergence/Divergence Fix 12/26
macd, macdsignal, macdhist = MACDFIX(close, signalperiod=9)

MFI - Money Flow Index
real = MFI(high, low, close, volume, timeperiod=14)

MINUS_DI - Minus Directional Indicator
real = MINUS_DI(high, low, close, timeperiod=14)

MINUS_DM - Minus Directional Movement
real = MINUS_DM(high, low, timeperiod=14)

MOM - Momentum
real = MOM(close, timeperiod=10)

RSI - Relative Strength Index
real = RSI(close, timeperiod=14)
Volume Indicator Functions

AD - Chaikin A/D Line
real = AD(high, low, close, volume)

ADOSC - Chaikin A/D Oscillator
real = ADOSC(high, low, close, volume, fastperiod=3, slowperiod=10)

OBV - On Balance Volume
real = OBV(close, volume) 
Volatility Indicator Functions

ATR - Average True Range
real = ATR(high, low, close, timeperiod=14)

NATR - Normalized Average True Range
real = NATR(high, low, close, timeperiod=14)

TRANGE - True Range
real = TRANGE(high, low, close) 
Price Transform Functions
AVGPRICE - Average Price
real = AVGPRICE(open, high, low, close)

MEDPRICE - Median Price
real = MEDPRICE(high, low)

TYPPRICE - Typical Price
real = TYPPRICE(high, low, close)

WCLPRICE - Weighted Close Price
real = WCLPRICE(high, low, close) 
Cycle Indicator Functions

HT_DCPERIOD - Hilbert Transform - Dominant Cycle Period
real = HT_DCPERIOD(close)

HT_DCPHASE - Hilbert Transform - Dominant Cycle Phase
real = HT_DCPHASE(close)

HT_PHASOR - Hilbert Transform - Phasor Components
inphase, quadrature = HT_PHASOR(close)

HT_SINE - Hilbert Transform - SineWave
sine, leadsine = HT_SINE(close)

HT_TRENDMODE - Hilbert Transform - Trend vs Cycle Mode
integer = HT_TRENDMODE(close) 
Statistic Functions

BETA - Beta
real = BETA(high, low, timeperiod=5)

CORREL - Pearson's Correlation Coefficient (r)
real = CORREL(high, low, timeperiod=30)

LINEARREG - Linear Regression
real = LINEARREG(close, timeperiod=14)

LINEARREG_ANGLE - Linear Regression Angle
real = LINEARREG_ANGLE(close, timeperiod=14)

LINEARREG_INTERCEPT - Linear Regression Intercept
real = LINEARREG_INTERCEPT(close, timeperiod=14)

LINEARREG_SLOPE - Linear Regression Slope
real = LINEARREG_SLOPE(close, timeperiod=14)

STDDEV - Standard Deviation
real = STDDEV(close, timeperiod=5, nbdev=1)

TSF - Time Series Forecast
real = TSF(close, timeperiod=14)

VAR - Variance
real = VAR(close, timeperiod=5, nbdev=1) 
Math Transform Functions

ACOS - Vector Trigonometric ACos
real = ACOS(close)

ASIN - Vector Trigonometric ASin
real = ASIN(close)

ATAN - Vector Trigonometric ATan
real = ATAN(close)

CEIL - Vector Ceil
real = CEIL(close)

COS - Vector Trigonometric Cos
real = COS(close)

COSH - Vector Trigonometric Cosh
real = COSH(close)

EXP - Vector Arithmetic Exp
real = EXP(close)

FLOOR - Vector Floor
real = FLOOR(close)

LN - Vector Log Natural
real = LN(close)

LOG10 - Vector Log10
real = LOG10(close)

SIN - Vector Trigonometric Sin
real = SIN(close)

SINH - Vector Trigonometric Sinh
real = SINH(close)

SQRT - Vector Square Root
real = SQRT(close)

TAN - Vector Trigonometric Tan
real = TAN(close)

TANH - Vector Trigonometric Tanh
real = TANH(close) 
Math Operator Functions

ADD - Vector Arithmetic Add
real = ADD(high, low)

DIV - Vector Arithmetic Div
real = DIV(high, low)

MAX - Highest value over a specified period
real = MAX(close, timeperiod=30)

MAXINDEX - Index of highest value over a specified period
integer = MAXINDEX(close, timeperiod=30)

MIN - Lowest value over a specified period
real = MIN(close, timeperiod=30)

MININDEX - Index of lowest value over a specified period
integer = MININDEX(close, timeperiod=30)

MINMAX - Lowest and highest values over a specified period
min, max = MINMAX(close, timeperiod=30)

MINMAXINDEX - Indexes of lowest and highest values over a specified period
minidx, maxidx = MINMAXINDEX(close, timeperiod=30)

MULT - Vector Arithmetic Mult
real = MULT(high, low)

SUB - Vector Arithmetic Substraction
real = SUB(high, low)

SUM - Summation
real = SUM(close, timeperiod=30) 
上面只是列举了一部分，更多函数可以参见官网，点击链接

3、如何应用：MA实例
从上面可以看到，MA这个函数的参数为：real = MA(close, timeperiod=30, matype=0)

close表示收盘价序列，timeperiod指定义好均线的计算长度即几日均线，不输入的话，默认为30日，matype可以默认不用输入，然后就可以得到均线的值

所以简单来讲，只取获取收盘价序列，就可以轻松计算MA值

下面以万科A为例进行说明

data=DataAPI.MktEqudGet(ticker=u"000002",beginDate=u"20160601",endDate=u"20160804",field=u"secShortName,tradeDate,closePrice",pandas="1")  #取数据
data['MA5'] = talib.MA(data['closePrice'].values, timeperiod=5)  #调用talib计算5日均线的值
data.tail(10)  #后十行结果
就这样，我们便捷地计算出了均线，下面计算更复杂的EMA，MACD


有关EMA,MACD的基础知识，可以参考社区帖子『研究｜技术指标｜第一弹』MACD

关于EMA,MACD计算的函数的描述是：

real = EMA(close, timeperiod=30)
macd, macdsignal, macdhist = MACD(close, fastperiod=12, slowperiod=26, signalperiod=9)
输入参数：close是收盘价，timeperiod指的是指数移动平均线EMA的长度，fastperiod指更短时段的EMA的长度，slowperiod指更长时段的EMA的长度，signalperiod指DEA长度

返回值：注意有些地方的macdhist = 2(dif-dea)，但是talib中MACD的计算是macdhist = dif-dea
data['EMA12'] = talib.EMA(data['closePrice'].values, timeperiod=12)  #调用talib 计算12日移动移动平均线的值
data['EMA26'] = talib.EMA(data['closePrice'].values, timeperiod=26)
data['MACD'],data['MACDsignal'],data['MACDhist'] = talib.MACD(data['closePrice'].values)

在构建策略时也会更加方便。
4、策略实战：双均线策略
当5日均线上穿60日均线，买入

当5日均线下穿60日均线，卖出

我们不再需要自己写函数计算均线，只需要调用函数就可以方便的解决问题（对于更复杂的指标，talib的便捷就更加明显）

import pandas as pd
import numpy as np
import talib

start = '2013-01-01'                       # 回测起始时间
end = '2016-07-01'                         # 回测结束时间
benchmark = 'HS300'                        # 策略参考标准
universe = set_universe('HS300')           
capital_base = 1000000                      # 起始资金
freq = 'd'                                 # 策略类型，'d'表示日间策略使用日线回测，'m'表示日内策略使用分钟线回测
refresh_rate = 5                           # 调仓频率，表示执行handle_data的时间间隔，若freq = 'd'时间间隔的单位为交易日，若freq = 'm'时间间隔为分钟

def initialize(account):                   # 初始化虚拟账户状态
    pass

def handle_data(account):                  # 每个交易日的买入卖出指令

    period1 = 5 #取5日数据
    period2 = 60 #取60日数据
    all_close_prices = account.get_attribute_history('closePrice', period2)    # 获取历史closePrice数据
    buy_list = [] # 备选买入清单
    sell_list = [] # 卖出清单
    for stk in account.universe:
        prices = all_close_prices[stk]
        if prices is None:
            continue
        try:
            MA5 = talib.MA(prices, timeperiod=period1) # 计算5日均线
            MA60 = talib.MA(prices, timeperiod=period2) #计算60日均线
        except:
            continue   
        # 买入卖出判断
        if MA5[-1]-MA60[-1] > 0:    #talib计算返回的MA5是一个数组，对应于日期，最后一个元素就是当前交易日前一天的5日均线值
            buy_list.append(stk)   
        elif MA5[-1]-MA60[-1] < 0:  #当5日均线下穿60日均线，卖出
            sell_list.append(stk)
    hold = []
    buy = [] # 最终买入清单 
    # 买入卖出
    for stk in account.valid_secpos:
        # sell_list卖出
        if stk in sell_list:
            order_to(stk, 0) 
        # 其余继续持股
        else:
            hold.append(stk)         
    buy = hold
    for stk in buy_list:
        # 若buy_list中股票有未买入的，加入
        if stk not in hold:
            buy.append(stk)        
    if len(buy) > 0:
        # 等仓位买入
        amout = account.referencePortfolioValue/len(buy) # 每只股票买入数量
        for stk in buy:
            num = int(amout/account.referencePrice[stk] / 100.0) * 100
            order_to(stk, num)              
    return

原文链接：TaLib在股票技术分析中的应用