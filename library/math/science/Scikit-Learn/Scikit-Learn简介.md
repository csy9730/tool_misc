# Scikit-Learn简介

[SkTj](https://www.jianshu.com/u/92422fe74fa9)关注

0.0732019.09.23 11:56:04字数 1,178阅读 10,979

## 简介

对Python语言有所了解的科研人员可能都知道SciPy——一个开源的基于Python的科学计算工具包。基于SciPy，目前开发者们针对不同的应用领域已经发展出了为数众多的分支版本，它们被统一称为Scikits，即SciPy工具包的意思。而在这些分支版本中，最有名，也是专门面向机器学习的一个就是Scikit-learn。

Scikit-learn项目最早由数据科学家David Cournapeau 在2007 年发起，需要NumPy和SciPy等其他包的支持，是Python语言中专门针对机器学习应用而发展起来的一款开源框架。

它的维护也主要依靠开源社区。

## 特点

作为专门面向机器学习的Python开源框架，Scikit-learn可以在一定范围内为开发者提供非常好的帮助。它内部实现了各种各样成熟的算法，容易安装和使用，样例丰富，而且教程和文档也非常详细。

另一方面，Scikit-learn也有缺点。例如它不支持深度学习和强化学习，这在今天已经是应用非常广泛的技术。此外，它也不支持图模型和序列预测，不支持Python之外的语言，不支持PyPy，也不支持GPU加速。

看到这里可能会有人担心Scikit-learn的性能表现，这里需要指出的是：如果不考虑多层神经网络的相关应用，Scikit-learn的性能表现是非常不错的。究其原因，一方面是因为其内部算法的实现十分高效，另一方面或许可以归功于Cython编译器；通过Cython在Scikit-learn框架内部生成C语言代码的运行方式，Scikit-learn消除了大部分的性能瓶颈。

## 主要类或用过的类

Scikit-learn的基本功能主要被分为六大部分：分类，回归，聚类，数据降维，模型选择和数据预处理。

（1）Preprocessing 预处理

· 应用：转换输入数据，规范化、编码化

· 模块：preprocessing，feature_extraction，transformer（转换器）

（2）Dimensionality reduction 降维

· 应用：Visualization（可视化），Increased efficiency（提高效率）

· 算法：主成分分析(PCA)、非负矩阵分解（NMF），feature_selection(特征选择)等

（3）Classification 分类

· 应用：二元分类问题、多分类问题、Image recognition 图像识别等

· 算法：逻辑回归、SVM，最近邻，随机森林，Naïve Bayes，神经网络等

（4）Regression 回归

· 应用：Drug response 药物反应，Stock prices 股票价格

· 算法：线性回归、SVR，ridge regression，Lasso，最小角回归（LARS）等

（5）Clustering 聚类

· 应用：客户细分，分组实验结果

· 算法：k-Means，spectral clustering(谱聚类)，mean-shift（均值漂移）

（6）Model selection 模型选择

· 目标：通过参数调整提高精度

· 模块：pipeline(流水线)，grid_search（网格搜索），cross_validation( 交叉验证)，metrics（度量），learning_curve（学习曲线）

（7）、模型融合

· 模块：ensemble(集成学习)、

（8）、辅助工具

· 模块：exceptions(异常和警告)、dataset（自带数据集）、utils、sklearn.base

## Hello World

``` python

import matplotlib.pyplot as plt

from sklearn import datasets, svm, metrics

digits = datasets.load_digits()

images_and_labels = list(zip(digits.images,digits.target))

for index, (image, label) in enumerate(images_and_labels[:5]):

plt.subplot(2, 5, index + 1)

plt.axis('off')

plt.imshow(image, cmap=plt.cm.gray_r, interpolation='nearest')

plt.title('Training: %i' % label)

# To apply a classifier on this data, weneed to flatten the image, to

# turn the data in a (samples, feature)matrix:

n_samples = len(digits.images)

data = digits.images.reshape((n_samples,-1))

# Create a classifier: a support vectorclassifier

classifier = svm.SVC(gamma=0.001)

# We learn the digits on the first half ofthe digits

classifier.fit(data[:n_samples // 2],digits.target[:n_samples // 2])

# Now predict the value of the digit on thesecond half:

expected = digits.target[n_samples // 2:]

predicted =classifier.predict(data[n_samples // 2:])

print("Classification report forclassifier %s:\n%s\n" % (classifier, metrics.classification_report(expected, predicted)))


print("Confusion matrix:\n%s" %metrics.confusion_matrix(expected, predicted))

images_and_predictions =list(zip(digits.images[n_samples // 2:], predicted))

for index, (image, prediction) inenumerate(images_and_predictions[-5:]):

plt.subplot(2, 5, index + 6)

plt.axis('off')

plt.imshow(image, cmap=plt.cm.gray_r, interpolation='nearest')

plt.title('Prediction: %i' % prediction)

plt.show()
```

————————————————
版权声明：本文为CSDN博主「yoyofu007」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：[https://blog.csdn.net/yoyofu007/article/details/80924166](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fyoyofu007%2Farticle%2Fdetails%2F80924166)