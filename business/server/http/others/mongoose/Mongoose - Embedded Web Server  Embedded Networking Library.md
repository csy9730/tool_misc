# Mongoose - Embedded Web Server / Embedded Networking Library

[![License: GPLv2/Commercial](https://camo.githubusercontent.com/c42f06a2d68eb7e82a0a3fadf98406e9076821f251267892f7172bd182bb8d38/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4c6963656e73652d47504c76322532306f72253230436f6d6d65726369616c2d677265656e2e737667)](https://opensource.org/licenses/gpl-2.0.php) [![Build Status](https://github.com/cesanta/mongoose/workflows/build/badge.svg)](https://github.com/cesanta/mongoose/actions) [![Code Coverage](https://camo.githubusercontent.com/83838c7fb60d344616c193c998854b002c89eafa6067aae29c05bf75e35eb5bd/68747470733a2f2f636f6465636f762e696f2f67682f636573616e74612f6d6f6e676f6f73652f6272616e63682f6d61737465722f67726170682f62616467652e737667)](https://codecov.io/gh/cesanta/mongoose) [![Fuzzing Status](https://camo.githubusercontent.com/0b76eca2d394e0fee1520c94b3151b783a713aa2ec0ddb218eba19372e805826/68747470733a2f2f6f73732d66757a7a2d6275696c642d6c6f67732e73746f726167652e676f6f676c65617069732e636f6d2f6261646765732f6d6f6e676f6f73652e737667)](https://bugs.chromium.org/p/oss-fuzz/issues/list?sort=-opened&can=1&q=proj:mongoose) [![Gitter Chat](https://camo.githubusercontent.com/baabefa2dd2f9020ee61864da672817670f8c4ed8ab9bf57eb1255091cc8c99e/68747470733a2f2f6261646765732e6769747465722e696d2f636573616e74612f6d6f6e676f6f73652e706e67)](https://gitter.im/cesanta/mongoose)

Mongoose is a networking library for C/C++. It implements event-driven non-blocking APIs for TCP, UDP, HTTP, WebSocket, MQTT. It is designed for connecting devices and bringing them online. On the market since 2004, used by vast number of open source and commercial products - it even runs on the International Space Station! Mongoose makes embedded network programming fast, robust, and easy. Features include:

- Cross-platform: works on Linux/UNIX, MacOS, Windows, Android, FreeRTOS, etc.
- Supported embedded architectures: ESP32, NRF52, STM32, NXP, and more
- Built-in protocols: plain TCP/UDP, HTTP, MQTT, Websocket
- SSL/TLS support: mbedTLS, OpenSSL or custom (via API)
- Asynchronous DNS resolver
- Tiny static and run-time footprint
- Source code is both ISO C and ISO C++ compliant
- Works with any network stack with socket API, like LwIP or FreeRTOS-Plus-TCP
- Very easy to integrate: just copy `mongoose.c` and `mongoose.h` files to your build tree
- Detailed [documentation](https://mongoose.ws/documentation/) and [tutorials](https://mongoose.ws/tutorials/)

# Commercial use

- Mongoose is used by hundreds of businesses, from Fortune500 giants like Siemens, Schneider Electric, Broadcom, Bosch, Google, Samsung, Qualcomm, Caterpillar to the small businesses
- Used to solve a wide range of business needs, like implementing Web UI interface on devices, RESTful API services, telemetry data exchange, remote control for a product, remote software updates, remote monitoring, and others
- Deployed to hundreds of millions devices in production environment worldwide
- See [Case Studies](https://mongoose.ws/case-studies/) from our respected customers like [Schneider Electric](https://mongoose.ws/case-studies/schneider-electric/) (industrial automation), [Broadcom](https://mongoose.ws/case-studies/broadcom/) (semiconductors), [Pilz](https://mongoose.ws/case-studies/pilz/) (industrial automation), and others
- See [Testimonials](https://mongoose.ws/testimonials/) from engineers that integrated Mongoose in their commercial products
- We provide [commercial licensing](https://mongoose.ws/licensing/), [support](https://mongoose.ws/support/), consultancy and integration assistance - don't hesitate to [contact us](https://mongoose.ws/contact/)

# Security

We take security seriously:

1. Mongoose repository runs a [continuous integration test powered by GitHub](https://github.com/cesanta/mongoose/actions), which runs through hundreds of unit tests on every commit to the repository. Our [unit tests](https://github.com/cesanta/mongoose/tree/master/test) are built with modern address sanitizer technologies, which help to find security vulnerabilities early
2. Mongoose repository is integrated into Google's [oss-fuzz continuous fuzzer](https://bugs.chromium.org/p/oss-fuzz/issues/list?sort=-opened&can=1&q=proj:mongoose) which scans for potential vulnerabilities continuously
3. We receive periodic vulnerability reports from the independent security groups like [Cisco Talos](https://www.cisco.com/c/en/us/products/security/talos.html), [Microsoft Security Response Center](https://www.microsoft.com/en-us/msrc), [MITRE Corporation](https://www.mitre.org/), [Compass Security](https://www.compass-security.com/en/) and others. In case of the vulnerability found, we act according to the industry best practice: hold on to the publication, fix the software and notify all our customers that have an appropriate subscription
4. Some of our customers (for example NASA) have specific security requirements and run independent security audits, of which we get notified and in case of any issue, act similar to (3).

# Supplement software

This software is often used together with Mongoose:

- [mjson](https://github.com/cesanta/mjson) - a JSON parser, emitter and JSON-RPC engine. Used to implement RESTful APIs that use JSON, or implement data exchange (e.g. over MQTT or Websocket) that use JSON for data encapsulation
- [elk](https://github.com/cesanta/elk) - a tiny JavaScript engine. Used to implement scripting support

# Contributions

Contributions are welcome! Please follow the guidelines below:

- Sign [Cesanta CLA](https://cesanta.com/cla.html) and send GitHub pull request
- Make sure that PRs have only one commit, and deal with one issue only