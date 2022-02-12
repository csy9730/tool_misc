# 维特比算法(viterbi)原理以及简单实现

[![轩辕浩](https://pic3.zhimg.com/v2-a76cc9d1e2a1197940c104cfd0e45ef5_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/huanghao-678)

[轩辕浩](https://www.zhihu.com/people/huanghao-678)

IT打工人



27 人赞同了该文章

## 维特比算法

看一下维基百科的解释，[维特比算法](https://link.zhihu.com/?target=https%3A//zh.wikipedia.org/wiki/%E7%BB%B4%E7%89%B9%E6%AF%94%E7%AE%97%E6%B3%95)（Viterbi algorithm）是一种动态规划算法。它用于寻找最有可能产生观测事件序列的维特比路径——隐含状态序列，特别是在马尔可夫信息源上下文和隐马尔可夫模型中。

通俗易懂的解释知乎有很多，如：[如何通俗地讲解 viterbi 算法？](https://www.zhihu.com/question/20136144)，我我这里重点是如何用python代码实现这个算法。

## 算法原理

维特比算法就是求所有观测序列中的最优，如下图所示，我们要求从S到E的最优序列，中间有3个时刻，每个时刻都有对应的不同观察的概率，下图中每个时刻不同的观测标签有3个。

![img](https://pic1.zhimg.com/80/v2-1db26a47352b4f248416119dc2a08738_1440w.jpg)

求所有路径中最优路径，最容易想到的就是暴力解法，直接把所有路径全部计算出来，然后找出最优的。这方法理论上是可行，但当序列很长时，时间复杂夫很高。而且进行了大量的重复计算，viterbi算法就是用动态规划的方法就减少这些重复计算。

viterbi算法是每次记录到当前时刻，每个观察标签的最优序列，如下图，假设在t时刻已经保存了从0到t时刻的最优路径，那么t+1时刻只需要计算从t到t+1的最优就可以了，图中红箭头表示从t时刻到t+1时刻，观测标签为1，2，3的最优。

![img](https://pic2.zhimg.com/80/v2-8efc44beb289faaa8d23db9eef4b4b21_1440w.jpg)

每次只需要保存到当前位置最优路径，之后循环向后走。到结束时，从最后一个时刻的最优值回溯到开始位置，回溯完成后，这个从开始到结束的路径就是最优的。

![img](https://pic4.zhimg.com/80/v2-92bb90aea7888d4ba0f473693a2cb687_1440w.jpg)

## 代码实现

下面用python简单实现一下viterbi算法

```python3
import numpy as np

def viterbi_decode(nodes, trans):
    """
    Viterbi算法求最优路径
    其中 nodes.shape=[seq_len, num_labels],
        trans.shape=[num_labels, num_labels].
    """
    # 获得输入状态序列的长度，以及观察标签的个数
    seq_len, num_labels = len(nodes), len(trans)
    # 简单起见，先不考虑发射概率，直接用起始0时刻的分数
    scores = nodes[0].reshape((-1, 1))
    
    paths = []
    # 递推求解上一时刻t-1到当前时刻t的最优
    for t in range(1, seq_len):
        # scores 表示起始0到t-1时刻的每个标签的最优分数
        scores_repeat = np.repeat(scores, num_labels, axis=1)
        # observe当前时刻t的每个标签的观测分数
        observe = nodes[t].reshape((1, -1))
        observe_repeat = np.repeat(observe, num_labels, axis=0)
        # 从t-1时刻到t时刻最优分数的计算，这里需要考虑转移分数trans
        M = scores_repeat + trans + observe_repeat
        # 寻找到t时刻的最优路径
        scores = np.max(M, axis=0).reshape((-1, 1))
        idxs = np.argmax(M, axis=0)
        # 路径保存
        paths.append(idxs.tolist())
        
    best_path = [0] * seq_len
    best_path[-1] = np.argmax(scores)
    # 最优路径回溯
    for i in range(seq_len-2, -1, -1):
        idx = best_path[i+1]
        best_path[i] = paths[i][idx]
    
    return best_path
```

代码中整队scores和observe的repeat复制操作，是为了方便矩阵运算，减少循环的操作。

如果将M = scores_repeat + trans + observe_repeat，展开用for循环写，在t时刻M[i][j] = scores[i] + trans[i][j] + observe[j]，M[i][j]表示从t-1时刻为i-1状态，t时刻为j-1状态的分数。

![img](https://pic3.zhimg.com/80/v2-ed9115348850104c3912e4ba09f99d36_1440w.jpg)

下面就是展开用for训练一步一步求解的伪码。

```text
# 每个时刻scores更新的伪码
for t in range(1, seq_len):
	tmp_scores = scores
	for j in range(nums_labels):
		for i in range(nums_labels):
			M[i][j] = scores[i] + trans[i][j] + observe[t][j]
		tmp_scores[j] = max(M[i][j]) (0 <= i < nums_labels)
	scores = tmp_scores 
```

可以利用矩阵计算的原理，合并一些步骤。

```text
for t in range(1, seq_len):
    scores_repeat = np.repeat(scores, num_labels, axis=1)
    observe = nodes[t].reshape((1, -1))
    observe_repeat = np.repeat(observe, num_labels, axis=0)
    M = scores_repeat + trans + observe_repeat
    scores = np.max(M, axis=0).reshape((-1, 1))
```

这里还有对scores和observe进行复制的操作，numpy运算中还可以在简化。

```text
for t in range(1, seq_len):
     observe = nodes[t].reshape((1, -1))
     M = scores + trans + observe
     scores = np.max(M, axis=0).reshape((-1, 1))
```

numpy在相加时可以自动扩充维度，横向和纵向都可以。

![img](https://pic1.zhimg.com/80/v2-40c078e895c890bfe16b97af0baa6f60_1440w.jpg)

经过简化的viterbi算法完整版。

```python3
def viterbi_decode_v2(nodes, trans):
    """
    Viterbi算法求最优路径v2
    其中 nodes.shape=[seq_len, num_labels],
        trans.shape=[num_labels, num_labels].
    """
    seq_len, num_labels = len(nodes), len(trans)
    scores = nodes[0].reshape((-1, 1))
    paths = []
    # # 递推求解上一时刻t-1到当前时刻t的最优
    for t in range(1, seq_len):
        observe = nodes[t].reshape((1, -1))
        M = scores + trans + observe
        scores = np.max(M, axis=0).reshape((-1, 1))
        idxs = np.argmax(M, axis=0)
        paths.append(idxs.tolist())

    best_path = [0] * seq_len
    best_path[-1] = np.argmax(scores)
    # 最优路径回溯
    for i in range(seq_len-2, -1, -1):
        idx = best_path[i+1]
        best_path[i] = paths[i][idx]
        
    return best_path
```

还有一种写法，最后不用回溯，每次把最优路径的索引都保存起来，并添加一个正常的路径，最后直接按索引找出最优路径，这个代码很少，但是不太好理解。

```python3
def viterbi_decode_v3(nodes, trans):
    """
    Viterbi算法求最优路径
    其中 nodes.shape=[seq_len, num_labels],
        trans.shape=[num_labels, num_labels].
    """
    seq_len, num_labels = len(nodes), len(trans)
    labels = np.arange(num_labels).reshape((1, -1))
    scores = nodes[0].reshape((-1, 1))
    paths = labels
    for t in range(1, seq_len):
        observe = nodes[t].reshape((1, -1))
        M = scores + trans + observe
        scores = np.max(M, axis=0).reshape((-1, 1))
        idxs = np.argmax(M, axis=0)
        paths = np.concatenate([paths[:, idxs], labels], 0)
    best_path = paths[:, scores.argmax()]
    return best_path
```

## 参考文档

[1].[https://zh.wikipedia.org/wiki/%E7%BB%B4%E7%89%B9%E6%AF%94%E7%AE%97%E6%B3%95](https://link.zhihu.com/?target=https%3A//zh.wikipedia.org/wiki/%E7%BB%B4%E7%89%B9%E6%AF%94%E7%AE%97%E6%B3%95)

[2].<https://www.zhihu.com/question/20136144>

编辑于 2020-07-18 10:45

维特比算法