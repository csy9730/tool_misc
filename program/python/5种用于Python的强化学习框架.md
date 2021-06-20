## 5种用于Python的强化学习框架

- 作者：闻数起舞来源：[今日头条](https://www.toutiao.com/i6834565204773175812/)|*2020-06-05 08:09*

  [ 收藏](javascript:favorBox('open');)[ 分享](javascript:;)

从头开始编写自己的Reinforcement Learning实施可能会花费很多工作，但是您不需要这样做。 有许多出色，简单和免费的框架可让您在几分钟之内开始学习。

![5种用于Python的强化学习框架](https://s1.51cto.com/oss/202006/05/01cb8f0d199e880ceaffb8051c814c86.jpeg-wh_651x-s_2958986818.jpeg)

有很多标准的库用于监督和无监督的机器学习，例如Scikit-learn，XGBoost甚至Tensorflow，这些库可以立即让您入门，并且可以在线找到支持的日志。 可悲的是，对于强化学习(RL)并非如此。

并不是说没有框架，事实上，有很多RL框架。 问题是尚无标准，因此很难找到在线开始，解决问题或定制解决方案的支持。 这可能是由于以下事实造成的：尽管RL是一个非常受欢迎的研究主题，但它仍处于行业实施和使用的初期。

但这并不意味着就没有强大的框架可以帮助您启动并使用RL解决您喜欢的任何问题。 我在这里列出了一些我逐渐了解和使用的框架，以及它们的优缺点。 我希望这能为您提供有关当前可用的RL框架的快速概述，以便您可以选择更适合您的需求的框架。

**1. Keras-RL**

![5种用于Python的强化学习框架](https://s3.51cto.com/oss/202006/05/2ec91c4e00ac6943948a83de16725bfe.gif)

我必须从整个列表中承认，这是我的最爱。 我认为，到目前为止，它是几种RL算法的代码实现的最简单的理解，包括深度Q学习(DQN)，双DQN，深度确定性策略梯度(DDPG)，连续DQN(CDQN或NAF)，交叉熵方法(CEM) ，决斗DQN)和SARSA。 当我说"最容易理解的代码"时，我指的不是使用它，而是对其进行自定义并将其用作您的项目的构建块*。 Keras-RL github还包含一些示例，您可以立即使用它们来入门。 它当然使用Keras，您可以将其与Tensorflow或PyTorch一起使用。

不幸的是，Keras-RL尚未得到很好的维护，其官方文档也不是最好的。 这为这个名为Keras-RL2的项目的分支提供了启发。

(*)我使用此框架的目的是什么? 好吧，很高兴您问-是我吗? 我已经使用此框架创建了定制的Tutored DQN代理，您可以在此处了解更多信息。

**2. Keras-RL2**

Keras-RL2是Keras-RL的一个分支，因此它与Keras-RL2共享对相同代理的支持，并且易于定制。 这里最大的变化是Keras-RL2得到了更好的维护，并使用了Tensorflow 2.1.0。 不幸的是，该库没有文档，即使Keras-RL的文档也可以轻松地用于此fork。

**3. OpenAI Baselines**

OpenAI Baselines是OpenAI的一组高质量RL算法实现，OpenAI是AI尤其是RL研究和开发的领先公司之一。 它的构想是使研究人员可以轻松地比较其RL算法，并以OpenAI的最新技术(即名称)为基准。 该框架包含许多流行代理的实现，例如A2C，DDPG，DQN，PPO2和TRPO。

![5种用于Python的强化学习框架](https://s4.51cto.com/oss/202006/05/4c2094adc496b9071e1733623277d931.jpeg)

\> [plots from Stable baselines benchmark.]

不利的一面是，尽管在代码上有很多有用的注释，但OpenAI Baselines的文档却不够完善。 另外，由于它被开发为用作基准而不是用作构建基块，因此如果您要为项目自定义或修改某些代理，则代码不是那么友好。 实际上，下一个框架是此基础上的一个分支，可以解决大多数这些问题。

**4. Stable Baselines**

![5种用于Python的强化学习框架](https://s1.51cto.com/oss/202006/05/74435527e33671d214dbafac3e4461b2.jpeg)

\> [image from Stable Baselines documentation.]

Stable Baselines 是OpenAI Baselines的一个分支，具有主要的结构重构和代码清除功能。 其官方文档站点中列出的更改如下：

- 所有算法的统一结构
- 符合PEP8(统一代码样式)
- 记录的功能和类
- 更多测试和更多代码覆盖率
- 附加算法：SAC和TD3(+对DQN，DDPG，SAC和TD3的HER支持)

我过去曾亲自使用过"Stable Baselines"，可以确认它确实有据可查且易于使用。 甚至可以使用一个班轮来训练OpenAI Gym环境的代理：

```
from stable_baselines import PPO2PPO2model = PPO2('MlpPolicy', 'CartPole-v1').learn(10000) 
```

**5. Acme**

![5种用于Python的强化学习框架](https://s3.51cto.com/oss/202006/05/39cf36e1ae11d7cd4e5dae236819079e.jpeg)

Acme来自DeepMind，它可能是研究RL的最著名公司。 这样，它已被开发用于构建可读的，高效的，面向研究的RL算法，并且包含几种最新代理的实现，例如D4PG，DQN，R2D2，R2D3等。 Acme使用Tensorflow作为后端，并且某些代理实现还使用JAX和Tensorflow的组合。

Acme的开发牢记要使其代码尽可能地可重用，因此其设计是模块化的，易于定制。 它的文档并不丰富，但是足以为您很好地介绍该库，并且还提供了一些示例来帮助您入门Jupyter笔记本。

**总结**

此处列出的所有框架都是任何RL项目的可靠选择。 根据您的喜好以及要使用的功能来决定使用哪个。 为了更好地可视化每个框架及其优缺点，我做了以下视觉摘要：

- Keras-RL — Github：RL算法的选择：☆☆☆文档：☆☆☆自定义：☆☆☆☆☆维护：☆后端：Keras和Tensorflow 1.14。
- Keras-RL2 — Github：RL算法的选择：☆☆☆文档：不可用自定义：☆☆☆☆☆维护：☆☆☆后端：Keras and Tensorflow 2.1.0。
- OpenAI基准— Github：RL算法的选择：☆☆☆文档：☆☆自定义：☆☆维护：☆☆☆后端：Tensorflow 1.14。
- 稳定的基线— Github：RL算法的选择：☆☆☆☆文档：☆☆☆☆☆自定义：☆☆☆维护：☆☆☆☆☆后端：Tensorflow 1.14。
- Acme-Github：RL算法的选择：☆☆☆☆文档：☆☆☆自定义：☆☆☆☆维护：☆☆☆☆☆后端：Tensorflow v2 +和JAX

如果您已经决定使用哪种框架，那么现在只需要一个环境即可。 您可以开始使用OpenAI Gym，在这些框架的大多数示例中已经使用了OpenAI Gym，但是如果您想在其他任务(例如交易股票，建立网络关系或提出建议)上尝试RL，则可以找到易于使用的清单。