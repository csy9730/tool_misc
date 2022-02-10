# zxing

[https://github.com/zxing/zxing/](https://github.com/zxing/zxing/)

## Project in Maintenance Mode Only

The project is in maintenance mode, meaning, changes are driven by contributed patches. Only bug fixes and minor enhancements will be considered. The Barcode Scanner app can no longer be published, so it's unlikely any changes will be accepted for it. There is otherwise no active development or roadmap for this project. It is "DIY".

## Get Started Developing

To get started, please visit: https://github.com/zxing/zxing/wiki/Getting-Started-Developing

ZXing ("zebra crossing") is an open-source, multi-format 1D/2D barcode image processing library implemented in Java, with ports to other languages.


## Supported Formats

| 1D product            | 1D industrial | 2D           |
| --------------------- | ------------- | ------------ |
| UPC-A                 | Code 39       | QR Code      |
| UPC-E                 | Code 93       | Data Matrix  |
| EAN-8                 | Code 128      | Aztec        |
| EAN-13                | Codabar       | PDF 417      |
| UPC/EAN Extension 2/5 | ITF           | MaxiCode     |
|                       |               | RSS-14       |
|                       |               | RSS-Expanded |


## Components



### Active

| Module              | Description                                                  |
| ------------------- | ------------------------------------------------------------ |
| core                | The core image decoding library, and test code               |
| javase              | JavaSE-specific client code                                  |
| android             | Android client Barcode Scanner [![img](https://camo.githubusercontent.com/2149f526e69167218eb7eea8f21cb74a756aa43495f7acfeccfe995d40f62028/68747470733a2f2f706c61792e676f6f676c652e636f6d2f696e746c2f656e5f75732f6261646765732f696d616765732f67656e657269632f656e5f62616467655f7765625f67656e657269632e706e67)](https://play.google.com/store/apps/details?id=com.google.zxing.client.android) |
| android-integration | Supports integration with Barcode Scanner via `Intent`       |
| android-core        | Android-related code shared among `android`, other Android apps |
| zxingorg            | The source behind `zxing.org`                                |
| zxing.appspot.com   | The source behind web-based barcode generator at `zxing.appspot.com` |


### Available in previous releases

| Module                                                       | Description               |
| ------------------------------------------------------------ | ------------------------- |
| [cpp](https://github.com/zxing/zxing/tree/00f634024ceeee591f54e6984ea7dd666fab22ae/cpp) | C++ port                  |
| [iphone](https://github.com/zxing/zxing/tree/00f634024ceeee591f54e6984ea7dd666fab22ae/iphone) | iPhone client             |
| [objc](https://github.com/zxing/zxing/tree/00f634024ceeee591f54e6984ea7dd666fab22ae/objc) | Objective C port          |
| [actionscript](https://github.com/zxing/zxing/tree/c1df162b95e07928afbd4830798cc1408af1ac67/actionscript) | Partial ActionScript port |
| [jruby](https://github.com/zxing/zxing/tree/a95a8fee842f67fb43799a8e0e70e4c68b509c43/jruby) | JRuby wrapper             |


### ZXing-based third-party open source projects

| Module                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [QZXing](https://github.com/ftylitak/qzxing)                 | port to Qt framework                                         |
| [glassechidna/zxing-cpp](https://github.com/glassechidna/zxing-cpp) | port to C++ (forked from the [deprecated official C++ port](https://github.com/zxing/zxing/tree/00f634024ceeee591f54e6984ea7dd666fab22ae/cpp)) |
| [nu-book/zxing-cpp](https://github.com/nu-book/zxing-cpp)    | recent port to C++                                           |
| [zxing_cpp.rb](https://github.com/glassechidna/zxing_cpp.rb) | bindings for Ruby (not just JRuby), powered by [zxing-cpp](https://github.com/glassechidna/zxing-cpp) |
| [jsqrcode](https://github.com/LazarSoft/jsqrcode)            | port to JavaScript                                           |
| [python-zxing](https://github.com/oostendo/python-zxing)     | bindings for Python                                          |
| [ZXing .NET](https://github.com/micjahn/ZXing.Net)           | port to .NET and C#, and related Windows platform            |
| [php-qrcode-detector-decoder](https://github.com/khanamiryan/php-qrcode-detector-decoder) | port to PHP                                                  |
| [ZXing Delphi](https://github.com/Spelt/ZXing.Delphi)        | Port to native Delphi object pascal, targeted at Firemonkey compatible devices (IOS/Android/Win/OSX) and VCL. |
| [ZXingObjC](https://github.com/TheLevelUp/ZXingObjC)         | Port to Objective-C                                          |
| [php-zxing](https://github.com/dsiddharth2/php-zxing)        | PHP wrapper to Zxing Java library                            |
| [zxing-js/library](https://github.com/zxing-js/library)      | TypeScript port of ZXing library                             |
| [pyzxing](https://github.com/ChenjieXu/pyzxing)              | Python wrapper to ZXing library                              |


### Other related third-party open source projects

| Module                                                | Description               |
| ----------------------------------------------------- | ------------------------- |
| [Barcode4J](http://barcode4j.sourceforge.net/)        | Generator library in Java |
| [ZBar](http://zbar.sourceforge.net/)                  | Reader library in C99     |
| [OkapiBarcode](https://github.com/woo-j/OkapiBarcode) |                           |



## Links

- [Online Decoder](https://zxing.org/w/decode.jspx)
- [QR Code Generator](https://zxing.appspot.com/generator)
- [Javadoc](https://zxing.github.io/zxing/apidocs/)
- [Documentation Site](https://zxing.github.io/zxing/)


## Contacting

Post to the [discussion forum](https://groups.google.com/group/zxing) or tag a question with [`zxing` on StackOverflow](https://stackoverflow.com/questions/tagged/zxing).


## Etcetera

[![Build Status](https://camo.githubusercontent.com/435f30a15a2f39cb48357ede4c98c9700af2ccc6e2044e4a2844101a5612d867/68747470733a2f2f7472617669732d63692e6f72672f7a78696e672f7a78696e672e7376673f6272616e63683d6d6173746572)](https://travis-ci.org/zxing/zxing) [![Coverity Status](https://camo.githubusercontent.com/c223e895a1e38e4eb2686bdd089f357e19c6c4514299e43e894d83bdcb4ae9d7/68747470733a2f2f7363616e2e636f7665726974792e636f6d2f70726f6a656374732f313932342f62616467652e737667)](https://scan.coverity.com/projects/1924) [![codecov.io](https://camo.githubusercontent.com/63f4ee4fa934f107deb3880d83cc4c34dafa5647360bb0351a15f7c0c93f8fbc/68747470733a2f2f636f6465636f762e696f2f6769746875622f7a78696e672f7a78696e672f636f7665726167652e7376673f6272616e63683d6d6173746572)](https://codecov.io/github/zxing/zxing?branch=master) [![Codacy Badge](https://camo.githubusercontent.com/30cb36d9dbe8843f31ad7edc5551b0af99144ed9d56dd2bb10af8c9efcf30568/68747470733a2f2f6170692e636f646163792e636f6d2f70726f6a6563742f62616467652f47726164652f3732373065346235376335303438333639393434386266333237323161623130)](https://www.codacy.com/app/srowen/zxing?utm_source=github.com&utm_medium=referral&utm_content=zxing/zxing&utm_campaign=Badge_Grade)

QR code is trademarked by Denso Wave, inc. Thanks to Haase & Martin OHG for contributing the logo.

Optimized with [![JProfiler](https://camo.githubusercontent.com/334b024c75d2df7d31359bd9514ac699cddfb92cc75d7d2bc4548c0a152bba78/68747470733a2f2f7777772e656a2d746563686e6f6c6f676965732e636f6d2f696d616765732f62616e6e6572732f6a70726f66696c65725f736d616c6c2e706e67)](https://www.ej-technologies.com/products/jprofiler/overview.html)

