# 振镜建模 


A = (0,0) # 第一个镜面中心的坐标
L = 10 # 两个镜面中心距离
H = -20 # 镜面中心平面和投影面的距离
B = (L,0) # 第二个镜面中心的坐标
P = (0,0) # 第二个镜面的交点 
Q = (0,0) # 投影点 ， OQ=OP + PQ*t, |OQ* cos| = |H|

# 1
# theta = 12
# assert theta != 0
# assert theta < 90
# assert theta > 0 and theta < 180
# fai = 90 - 2*theta

#
theta = -10
theta2 = 30


def get_fai(theta):
    return 90 + 2 * theta

def get_fai2(theta, fai):

    if theta < 0:
        assert abs(theta) > abs(fai)
        (180+theta)-(-theta+fai)
        fai2 = 2*theta-fai
        # 使用正弦定理，计算 P 坐标
    elif theta > 0:
        2
    else:
        3

assert get_fai(45) == 180
assert get_fai(-45) == 0 
assert get_fai(0) == 90  # 直射镜面，原路返回
assert get_fai(-90) == -90 

assert theta < 0 and theta > -90
fai = get_fai(theta)
fai2 = get_fai2(theta2, fai)


