from itertools import permutations

def queen_check0(lst):
    N = len(lst)
    lst2 = []
    for i,j in enumerate(lst):
        s2 = i*N + j
        lst2.append(s2)

    for i,j in enumerate(lst):
        s2 = i*N + j
        r1 = min(i,j)
        r2 = min(N-i-1,N-j-1)
        r3 = min(i,N-j-1)
        r4 = min(N-i-1,j)
        for k in range(-r1,r2):
            s3 = s2+k*N+k
            if s3 in lst2 and k!= 0:
                return False
        for k in range(-r3,r4):
            s4 = s2+k*N-k
            if s4 in lst2 and k!= 0:
                return False
    return True

def queen_check(lst):
    N = len(lst)
    for i in range(N):
        for j in range(i+1,N): 
            if lst[j]==lst[i] or abs(i-j)==abs(lst[i]-lst[j]):
                return False
    return True


def N_queen(N=8):
    pms = permutations((i for i in range(N)))
    cnt = 0
    for pm in pms:
        # pm = [1,3,0,2]
        if queen_check(pm):
            # print(pm)
            cnt = cnt + 1
    return cnt

"""
    算法复杂度 :N*(N-1)*...*2*1
"""

def print_queens(lst):
    N = len(lst)
    for i,j in enumerate(lst):
        print('x'*(j)+'Q'+ 'x'*(N-j-1))

def main():
    cnt = N_queen(12)
    print(cnt)
    # print_queens([1,3,0,2])
    # print()
    # print_queens([2,0,3,1])

if __name__ == "__main__":
    main()