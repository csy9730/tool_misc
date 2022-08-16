
# D = distance(center-center)
def calc_inter_circle_num0(D, R1, R2, R3):
# 两个圆，交点个数只有0，1，2三种情况
    s = 0
    # 外外切圆
    e = D - (R1+R2+2*R3)
    if e > 0:
        s += 0
    elif e == 0:
        s += 1	
    elif e < 0:
        s += 2
    # 内内切圆

    e = D+2*R3 - abs(R1-R2)
    if e < 0:
        s += 0
    elif e == 0:
        s += 1	
    elif e > 0:
        s += 2	
        
    # 内外切圆	
    e = D - (R1+R2)
    if e > 0:
        return 0
    elif e == 0:
        if R3 < R2:
            s += 1
        if R3 < R1:
            s += 1
    elif e < 0:
        if R3 < R2:
            s += 2
        if R3 < R1:
            s += 2
    return s
	

def fSgn(x):
    if x > 0:
        return 1
    elif x < 0:
        return -1
    else:
        return 0

def fSgn2(x):
    if x > 0:
        return 2
    elif x < 0:
        return 0
    else:
        return 1
    
def calc_inter_circle_num(D, R1, R2, R3):
    # 
    """
        两个圆，交点个数只有0，1，2三种情况

        计算两个圆的相切圆，包括外外切圆，内内切圆，外内切圆，内外切圆。

        D 圆心距
        R1 圆半径
        R2 圆半径
        R3 相切圆半径
    """
    if R3 == 0:
        return fSgn2(R1+R2 - D)
    assert R2 >0 and R1>0
    assert D > 0

    s = 0  
    # 外外切圆
    e = (R1+R2+2*R3) - D
    s += fSgn2(e)

    # 内内切圆
    e2 = D+2*R3 - abs(R1-R2)
    s += fSgn2(e2)

    e3 = (R1+R2) - D
    if R3 < R2:
        # 外内切圆
        s += fSgn2(e3)
    if R3 < R1:
        # 内外切圆
        s += fSgn2(e3)

    return s

def calc_inter_circle_center(center1, center2, R1, R2):
    D = sqrt((center1 - center2)**2)
    s = fSgn2(R1+R2 - D)
    if s==0:
        return []
    elif s == 1:
        return [(center1* R1 + center2 * R2)/(R1+R2)]
    else:
        # todo
        # solve( sqrt(R1^2-x^2) + sqrt(R2^2-x^2) = D)
        # solve( R1^2-u^2+ (D-u)^2 = R2^2)
        return [1,1]
