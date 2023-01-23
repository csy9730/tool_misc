# Deepo

 一个包含几乎所有主流机器学习框架环境的 Docker 镜像

[Deepo](https://github.com/ufoym/deepo)

[![deepo](https://user-images.githubusercontent.com/2270240/32102393-aecf573c-bb4e-11e7-811c-dc673cae7b9c.png)](https://user-images.githubusercontent.com/2270240/32102393-aecf573c-bb4e-11e7-811c-dc673cae7b9c.png)

[![workflows](https://github.com/ufoym/deepo/workflows/deepo%20CI/badge.svg)](https://github.com/ufoym/deepo/workflows/deepo CI/badge.svg) [![docker](https://camo.githubusercontent.com/5eac2eca01b37e5afef62516cfb33f189e5db6231dd1035f1f9c7725862b9473/68747470733a2f2f696d672e736869656c64732e696f2f646f636b65722f70756c6c732f75666f796d2f646565706f2e737667)](https://hub.docker.com/r/ufoym/deepo) [![build](https://camo.githubusercontent.com/d69b4c2637e2f9cd4a91831c75fa57fe66fe6e04ab5ab878a01f0b15fc258fea/68747470733a2f2f696d672e736869656c64732e696f2f646f636b65722f6175746f6d617465642f75666f796d2f646565706f2e737667)](https://camo.githubusercontent.com/d69b4c2637e2f9cd4a91831c75fa57fe66fe6e04ab5ab878a01f0b15fc258fea/68747470733a2f2f696d672e736869656c64732e696f2f646f636b65722f6175746f6d617465642f75666f796d2f646565706f2e737667) [![license](https://camo.githubusercontent.com/70c873f8c5d8c74e6ff690bfa06aa6ace8a13ff91d7c9bfa362bab0a158b5738/68747470733a2f2f696d672e736869656c64732e696f2f6769746875622f6c6963656e73652f75666f796d2f646565706f2e737667)](https://camo.githubusercontent.com/70c873f8c5d8c74e6ff690bfa06aa6ace8a13ff91d7c9bfa362bab0a158b5738/68747470733a2f2f696d672e736869656c64732e696f2f6769746875622f6c6963656e73652f75666f796d2f646565706f2e737667)

***Deepo*** is an open framework to assemble specialized [*docker*](http://www.docker.com/) images for deep learning research without pain. It provides a “lego set” of dozens of standard components for preparing deep learning tools and a framework for assembling them into custom docker images.

At the core of Deepo is a Dockerfile generator that

- allows you to

   

  customize your deep learning environment

   

  with Lego-like modules

  - define your environment in a single command line,
  - then deepo will generate Dockerfiles with best practices
  - and do all the configuration for you

- automatically resolves the dependencies for you

  - deepo knows which combos (CUDA/cuDNN/Python/PyTorch/Tensorflow, ..., tons of dependancies) are compatible
  - and will pick the right versions for you
  - and arrange sequence of installation procedures using [topological sorting](https://en.wikipedia.org/wiki/Topological_sorting)

We also prepare a series of pre-built docker images that

- allows you to instantly set up common deep learning research environment
- supports almost all [commonly used deep learning frameworks](https://github.com/ufoym/deepo#Available-tags)
- supports [GPU acceleration](https://github.com/ufoym/deepo#GPU) (CUDA and cuDNN included), also works in [CPU-only mode](https://github.com/ufoym/deepo#CPU)
- works on Linux ([CPU version](https://github.com/ufoym/deepo#CPU)/[GPU version](https://github.com/ufoym/deepo#GPU)), Windows ([CPU version](https://github.com/ufoym/deepo#CPU)) and OS X ([CPU version](https://github.com/ufoym/deepo#CPU))