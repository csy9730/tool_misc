# import qrcode

def demo():
    qr = qrcode.make('hello world')
    qr.save('a.png')


def demo_seg():
    SEG = 13
    N = 92 # 91
    r = N % SEG
    for i in range(0, N-r, SEG):
        print(list(range(i, i+SEG)))
    if r:
        print(list(range(N-r,N)))

def demo_seg2():
    SEG = 13
    N = 91
    r = N % SEG
    lst = [i for i in range(N)]
    for i in range(0, N-r, SEG):
        print(lst[i:i+SEG])
    if r:
        print(lst[N-r:N])

def main():
    demo_seg2()
    # demo()
if __name__ == "__main__":
    main()