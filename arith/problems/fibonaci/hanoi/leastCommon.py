from functools import lru_cache

"""
有n个封闭区间[a1,b1],...[an,bn], ai<=bi,  要求找到一个最小集合{p1,...pk}
使S和每一个区间都有交集。

问题是经典的 动态规划， 区间分割问题。
首先按照a1 排序，
考虑 A1~An: A1(a1,b1),A2(a2,b2),...An(an,bn) ,
    如果A_1~A_n 的n=1， 显然f(A_1,A_1)=1
    如果A_1～A_n 都有交集，显然f(A_1,A_n)=1
    除此之外，说明f>=2, 至少可以分成两个集合。
    则有： f(A_1,A_n)= min { f(A_1,A_k)+ f(A_k+1,A_n) for k=1~n-1}
        这是经典的二阶动态规划，时间复杂度是 O(n^2)

实现方法有正向循环填表，递归填表法。
"""


def getLeastCommon(x):
    x.sort(key=lambda x:x[1])
    x.sort(key=lambda x:x[0])
    @lru_cache()
    def _getLeastCommon(i, j):
        if i == j:
            return 1
        if x[i][1] >= x[j][0]:
            # todo
            return 1
        lst = []
        for k in range(i, j):
            lst.append(_getLeastCommon(i, k) + _getLeastCommon(k+1, j))
        return min(lst)
    return _getLeastCommon(0, len(x)-1)


def getLeastCommon2(x):
    x.sort(key=lambda x:x[1])
    x.sort(key=lambda x:x[0])
    N = len(x)
    t = [[None for j in range(N)] for i in range(N)]
    for i in range(N):
        t[i][i] = 1

    for j in range(N):
        for i in range(N):
            if j+i >= N:
                continue
            if x[i][1] >= x[i+j][0]:
                v = 1
            else:
                lst = []
                for k in range(i, i+j):
                    lst.append(t[i][k] + t[k+1][i+j])
                v = min(lst)
            t[i][i+j] = v
    # print(t)
    return t[0][N-1]


if __name__ == "__main__":
    x = [[3,5],[5,7],[2,3]] # 2
    x = [[1,3],[2,4],[3,5],[4,6],[5,7],[7,8]]  # 3
    x2 = [[1,2],[2,3],[3,4],[4,5]]    
    x = [[1,2],[2,3],[3,5],[4,6], [5,7]]   # 2  

    import random
    x=[]
    N =random.randint(10, 80)
    for i in range(N):
        rd = random.randint(0, 80)
        x.append([rd, rd + random.randint(0, 10)])
    print(x, len(x))
    # print(getLeastCommon(x))
    print(getLeastCommon2(x))
    