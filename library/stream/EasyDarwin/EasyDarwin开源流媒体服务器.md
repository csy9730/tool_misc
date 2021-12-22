# EasyDarwin开源流媒体服务器

## 主要功能特点

- 基于Golang开发维护；
- 支持Windows、Linux、macOS平台；
- 支持RTSP推流分发（推模式转发）；
- 支持RTSP拉流分发（拉模式转发）；
- 服务端录像 参考:<https://blog.csdn.net/jyt0551/article/details/84189498>
- 服务端录像检索与回放 参考:<https://blog.csdn.net/jyt0551/article/details/84189498>
- 关键帧缓存；
- 秒开画面；
- Web后台管理；
- 分布式负载均衡；

## 安装部署

- [下载解压 release 包](https://github.com/EasyDarwin/EasyDarwin/releases)

- 直接运行(Windows)

  EasyDarwin.exe

  以 `Ctrl + C` 停止服务

- 以服务启动(Windows)

  ServiceInstall-EasyDarwin.exe

  以 ServiceUninstall-EasyDarwin.exe 卸载 EasyDarwin 服务

- 直接运行(Linux/macOS)

  ```
    cd EasyDarwin
    ./easydarwin
    # Ctrl + C
  ```

- 以服务启动(Linux/macOS)

  ```
    cd EasyDarwin
    ./start.sh
    # ./stop.sh
  ```

- 查看界面

  打开浏览器输入 [http://localhost:10008](http://localhost:10008/), 进入控制页面,默认用户名密码是admin/admin

- 测试推流

  ffmpeg -re -i C:\Users\Administrator\Videos\test.mkv -rtsp_transport tcp -vcodec h264 -f rtsp rtsp://localhost/test

  ffmpeg -re -i C:\Users\Administrator\Videos\test.mkv -rtsp_transport udp -vcodec h264 -f rtsp rtsp://localhost/test

- 测试播放

  ffplay -rtsp_transport tcp rtsp://localhost/test

  ffplay rtsp://localhost/test

## 效果图

[![snapshot](https://camo.githubusercontent.com/ed7d8a3b4af0ab6dd7daa733bc7be5e194e385c68fea06c07c2938676f31bee4/687474703a2f2f7777312e73696e61696d672e636e2f6c617267652f37393431346130356c793166777a716462693865666a32307730306d726e30632e6a7067)](https://camo.githubusercontent.com/ed7d8a3b4af0ab6dd7daa733bc7be5e194e385c68fea06c07c2938676f31bee4/687474703a2f2f7777312e73696e61696d672e636e2f6c617267652f37393431346130356c793166777a716462693865666a32307730306d726e30632e6a7067)

## 二次开发