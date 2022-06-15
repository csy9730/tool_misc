# Hidden Markov Model

隐马尔可夫模型（Hidden Markov Model，HMM）是统计模型，它用来描述一个含有隐含未知参数的马尔可夫过程。其难点是从可观察的参数中确定该过程的隐含参数。然后利用这些参数来作进一步的分析，例如模式识别。
是在被建模的系统被认为是一个马尔可夫过程与未观测到的（隐藏的）的状态的统计马尔可夫模型。

针对以下三个问题，人们提出了相应的算法
*1 评估问题： 前向算法
*2 解码问题： Viterbi算法
*3 学习问题： Baum-Welch算法(向前向后算法)