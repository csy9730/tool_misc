
# 等额本金计算公式
# 每月还款额=每月本金+每月本息
# 每月本息=（本金-累计还款总额）X月利率

# 等额本息还款法

# 日利率(0/000)=年利率(%)÷360=月利率(‰)÷30
# 2.月利率(‰)=年利率(%)÷12

def get_pays(debt, month_ratio, num_month, method=0):
    if method == 2:
        return 1
    elif method == 1:
        # 等额本金计算公式：每月还款金额 =（贷款本金 ÷ 还款月数）+（本金 — 已归还本金累计额）×每月利率
        return [debt/num_month + (debt- debt*i/num_month)* month_ratio for i in range(num_month)]

    else:
        # 等额本息计算公式：〔贷款本金×月利率×(1＋月利率)^还款月数〕÷〔(1＋月利率)^还款月数 - 1)
        return [debt * month_ratio * (1+ month_ratio)**num_month / ((1+month_ratio)**num_month - 1) for i in range(num_month)]

def demo():
    debt = 10000
    year_ratio = 0.0665
    month_ratio = year_ratio / 12
    # 月利率：月利率=年利率/12
    num_month = 10*12
    debt/num_month # 每月本金=本金/还款月数

    month_pay = get_pays(debt, month_ratio, num_month)[0]
    print("月供", month_pay)
    print("合计还款", month_pay * num_month)
    print("合计利息", month_pay * num_month - debt)

    """
    10000元为本金、在银行贷款10年、基准利率是6.65％：

    月利率=年利率÷12=0.0665÷12=0.005541667
    每月还款本息=〔10000×0.005541667×（1＋0.005541667）＾120〕÷〔（1＋0.005541667）＾120－1〕=114.3127元
    合计还款 13717.52元
    合计利息 3717.52元
    """
    month_pay = get_pays(debt, month_ratio, num_month, 1)
    print("月供", month_pay[0])
    print("合计还款", sum(month_pay))
    print("合计利息", sum(month_pay) - debt)

def demo2():
    debt = 200000
    year_ratio = 0.0558
    split = 4
    # split 越大，总利息越高
    month_ratio = year_ratio / split
    num_month = 10 * split
    debt/num_month # 每月本金=本金/还款月数

    month_pay = get_pays(debt, month_ratio, num_month)[0]
    print("月供", month_pay)
    print("合计还款", month_pay * num_month)
    print("合计利息", month_pay * num_month - debt)

    """
    如：以贷款20万元，贷款期为10年，为例：

    每季等额归还本金：200000÷（10×4）=5000元

    第一个季度利息：200000×（5.58%÷4）=2790元

    则第一个季度还款额为5000+2790=7790元；

    第二个季度利息：（200000-5000×1）×（5.58%÷4）=2720元

    则第二个季度还款额为5000+2720=7720元

    第40个季度利息：（200000-5000×39）×（5.58%÷4）=69.75元

    则第40个季度（最后一期）的还款额为5000+69.75=5069.75元
    """
    month_pay = get_pays(debt, month_ratio, num_month, 1)
    print("月供", month_pay[0:3], month_pay[-1])
    print("合计还款", sum(month_pay))
    print("合计利息", sum(month_pay) - debt)


def demo3():
    """
    例如：2009年利率表

基础年利率：5.94%

85折年利率：5.05%

7折年利率：4.16%

公积金年利率：3.87%

举例说明

王先生向银行贷款40万用于买房，分20年还清。银行给予王先生7折的利率优惠。

把年利率换成月利率 ，则月利率=4.16%/12=0.00347

等额本金还款方式：

每月本金=400000/240=1666.67

每月本息=400000X0.00347=1388

第一个月还款额=1666.67+1388=3054.67（元）
"""
    debt = 400000
    year_ratio = 0.0594*0.701010101
    split = 12
    month_ratio = year_ratio / split
    num_month = 20 * split
    debt/num_month # 每月本金=本金/还款月数

    month_pay = get_pays(debt, month_ratio, num_month, 1)
    print("月供", month_pay[0:3], month_pay[-1])
    print("合计还款", sum(month_pay))
    print("合计利息", sum(month_pay) - debt)


def demo4():
    debt = 370000
    year_ratio = 0.0539
    split = 12
    month_ratio = year_ratio / split
    num_month = 20 * split
    debt/num_month # 每月本金=本金/还款月数

    month_pay = get_pays(debt, month_ratio, num_month, 1)
    print("月供", month_pay[0:3], month_pay)
    print("合计还款", sum(month_pay))
    print("合计利息", sum(month_pay) - debt)

def main():
    demo4()

if __name__ == "__main__":
    main()