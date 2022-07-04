# 1


def find_square_sum(S=2019):
    """
    a^2+b^2+c^2 = 2019

    k*(k+1)+m*(m+1)+n*(n+1)= 504


        1 13 43
        5 25 37
        7 11 43
        7 17 41
        11 23 37
        13 25 35
        17 19 37
        23 23 31
        13 13 41
    """
    from math import sqrt, ceil
    N = ceil(sqrt(S))
    for i in range(1,N):
        for j in range(i,N):
            for k in range(j,N):
                if i*i + j*j + k*k == S:
                    print(i, j, k)

def main():
    find_square_sum(2021)
        
if __name__ == "__main__":
    main()