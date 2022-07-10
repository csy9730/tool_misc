#  
import random
"""


堆需要满足的条件：

1. 必须是二叉树，且必须是完全二叉树

2. 各个父节点必须大于或小于左右结点， 其中最顶层的根结点必须是最大或者最小的

需要注意的是，二叉堆中只有父子结点之间有大小关系的限制，而兄弟结点之间并没有大小关系的限制。

堆可以使用list实现，就是按照层序遍历顺序将每个节点上的值存放在数组中。父节点和子节点之间存在如下的关系：
i 从0 开始
parent = (i-1) // 2; left = 2*i + 1 ; right = 2*(i+1)


堆 的性质，就像队列，只能尾部添加元素，首部出元素

- build 从零开始排序所有元素
- append 添加元素
- popleft 删除根元素
- 堆合并算法


PriorityQueue



"""
class MinHeap():
    def __init__(self, maxSize=None):
        self.maxSize = maxSize 
        self.array = [None] * maxSize 
        self._count = 0
    
    def length(self):
        return self._count 
    
    def show(self):
        if self._count <= 0:
            print('null')
        print(self.array[: self._count], end=', ')
    
    def append(self, value):
        # 增加元素
        if self._count >= self.maxSize:
            raise Exception('The array is Full')
        self.array[self._count] = value
        self._shift_up(self._count)
        self._count += 1
    
    def _shift_up(self, index):
        # 比较结点与根节点的大小， 较小的为根结点
        if index > 0:
            parent = (index - 1) // 2
            if self.array[parent] > self.array[index]:
                self.array[parent], self.array[index] = self.array[index], self.array[parent]
                self._shift_up(parent)
    
    def popleft(self):           
        # 获取最小值，并更新数组 
        # poll方法
        if self._count <= 0:
            raise Exception('The array is Empty')
        value = self.array[0]
        self._count -= 1 # 更新数组的长度
        self.array[0] = self.array[self._count] # 将最后一个结点放在前面
        self._shift_down(0)
        
        return value 
             
    def _shift_down(self, index):  
        # 此时index 是根结点
        # siftDown
        if index < self._count:
            left = 2 * index + 1
            right = 2 * index + 2
            # 判断左右结点是否越界，是否小于根结点，如果是这交换
            if left < self._count and right < self._count and self.array[left] < self.array[index] and self.array[left] < self.array[right]:
                self.array[index], self.array[left] = self.array[left], self.array[index] #交换得到较小的值
                self._shift_down(left)
            elif left < self._count and right < self._count and self.array[right] < self.array[left] and self.array[right] < self.array[index]:
                self.array[right], self.array[index] = self.array[index], self.array[right]
                self._shift_down(right)
            
            # 特殊情况： 如果只有做叶子结点
            if left < self._count and right >= self._count and self.array[left] < self.array[index]:
                self.array[left], self.array[index] = self.array[index], self.array[left]
                self._shift_down(left)

    @staticmethod
    def init(lst):
        """
            列表，二叉树调整为最小堆的方法 heapify
        """
        N = len(lst)
        def tune_node(i):
            left = 2*i + 1
            right = 2*i + 2
            if left > N-1:
                return
            elif lst[i] <= lst[left] and ((right <= N-1 and lst[i] <= lst[right]) or right > N-1):
                pass
            elif lst[left] <= lst[i] and ((right<=N-1 and lst[left] <= lst[right]) or right > N-1):
                tmp = lst[i]
                lst[i] = lst[left]
                lst[left] = tmp
                tune_node(left) # important!!!
            elif right<=N-1 and lst[right] <= lst[i] and  lst[right] <= lst[left]:
                tmp = lst[i]
                lst[i] = lst[right]
                lst[right] = tmp
                tune_node(right) # important!!!

        for i in range((N-2)//2, -1, -1):
            print(i, lst)
            tune_node(i)
        print((N-2)//2, lst)
        cls = MinHeap(N)
        cls.array = lst
        cls._count = N
        return cls

    def sort(self):
        N = self._count
        for i in range(N-1):
            v = self.array[0]
            print(i, N-1-i, self._count, self.array)
            self.array[0] = self.array[N-1-i] # 将最后一个结点放在前面
            self.array[N-1-i] = v
            self._count -= 1 # 更新数组的长度
            self._shift_down(0)

        # tmp = self.array[0]
        # self.array[0] = self.array[N-1-i]
        # self.array[N-1-i] = tmp
    
        print(i+1, self.array)
        self._count = N

    def check(self):
        N = self._count
        for i in range(N//2-1):
            assert self.array[i] <= self.array[2*i+1]
            if 2*i+2 <= N-1:
                assert self.array[i] <= self.array[2*i+2]

def demo_append():
    mh = MinHeap(10)
    print()
    print('-------小顶堆----------')
    num = [3,2,4,1,5]
    for i in num:
        mh.append(i)
    mh.show()
    print()

    for _ in range(len(num)):
        print(mh.popleft(), end=', ')
    print()


def demo_init():
    lst = [2,4,1,5,3]
    mh = MinHeap.init(lst)
    mh.show()
    mh.check()
    print()

def demo_sort():
    lst = [2,4,0,6,1,5,7,3]
    lst = [2,4,3,6,1,5,7,0]
    lst = [2,4,9,3,6,8,1,5,7,0]
    lst = [2,4,8,3,6,9,1,5,7,0]
    mh = MinHeap.init(lst)
    mh.show()
    mh.check()
    mh.sort()
    mh.show()
    # print(list(reversed(sorted(lst))))
    assert mh.array == list(reversed(sorted(lst)))
    # mh.check()
    """
           0
          2 3
        4 1 5 7
      6
           2
          4 3
        6 1 5 7
      0    

           2
          4 3
        0 1 5 7
      6
           2
          0 3
        4 1 5 7
      6  
           0
          1 3
        4 2 5 7
      6  

    """


def test_sort():
    import random
    for i in range(555):
        N = random.randint(2,35)
        lst = list(range(13))
        random.shuffle(lst)
        mh = MinHeap.init(lst)
        mh.sort()
        mh.show()
        print('lst=', list(reversed(sorted(lst))), mh.array)
        assert mh.array == list(reversed(sorted(lst)))

def main():
    # demo_init()
    demo_sort()
    test_sort()
if __name__ == "__main__":
    
    main()

"""


堆排序的基本思想就是：从最大（小）堆得顶部不断取走堆顶元素放到有序序列中，直到堆的元素被全部取完。堆排序完全依赖于最大（小）堆的相关操作。


（2）运行过程

堆排序算法的运作如下：


1、创建一个最大（小）堆H；

2、把堆首和堆尾元素互换；

3、把堆的大小减1，重新构造一个最大（小）堆；

4、重复步骤2、3，直到堆的大小减少为1。
"""

