## 使用Docker安装配置Grafana

 发表于 2020-06-17 分类于 [专业](https://www.voidking.com/categories/%E4%B8%93%E4%B8%9A/) ， [运维](https://www.voidking.com/categories/%E4%B8%93%E4%B8%9A/%E8%BF%90%E7%BB%B4/) ， [docker](https://www.voidking.com/categories/%E4%B8%93%E4%B8%9A/%E8%BF%90%E7%BB%B4/docker/) ， [监控](https://www.voidking.com/categories/%E4%B8%93%E4%B8%9A/%E8%BF%90%E7%BB%B4/%E7%9B%91%E6%8E%A7/) 阅读次数：7185

# Grafana简介

> [Grafana](https://grafana.com/) allows you to query, visualize, alert on and understand your metrics no matter where they are stored.

本文中，我们会使用Docker来安装配置grafana，并且显示prometheus中的数据。
前置条件是安装配置好了docker环境，安装方法参考[《Docker入门》](https://www.voidking.com/dev-docker-start/)。已知docker宿主机IP为192.168.56.102。



# 安装Grafana

1、登录dockerhub查看需要的[grafana版本](https://hub.docker.com/r/grafana/grafana)。

2、下载grafana镜像（以grafana6.7.4为例）
`docker pull grafana/grafana:6.7.4`

3、启动grafana服务

```
docker run --name=vk-grafana -d \
-p 3000:3000 \
grafana/grafana:6.7.4
```



以上命令：

- 命名容器为vk-grafana，后台运行
- 映射宿主机3000端口到容器3000端口

grafana的配置文件为 /etc/grafana/grafana.ini ，可以进入容器进行修改，或者挂出到宿主机。

更高级的启动命令参考[How to use the container](https://grafana.com/docs/grafana/latest/installation/docker/)。

4、验证安装
`docker ps`
mysql启动正常的话就可以看到vk-grafana容器。
如果启动失败，可以使用`docker logs vk-grafana`查看失败原因并进行解决。

# 开放端口

```
firewall-cmd --add-port=3000/tcp --permanent
systemctl reload firewalld
# 或者
systemctl stop firewalld
```



# 测试服务

1、本机测试
`curl localhost:3000`

2、浏览器测试
访问 [http://192.168.56.102:3000](http://192.168.56.102:3000/)
用户名密码默认都是admin，第一次登录会提示修改。

# 配置Prometheus数据

假设我们已经安装配置好了prometheus，参考[《使用Docker安装配置Prometheus》](https://www.voidking.com/dev-docker-prometheus/)。

1、添加数据资源
![img](http://cdn.voidking.com/@/imgs/docker-grafana/welcome.jpg?imageView2/0/w/800)
![img](http://cdn.voidking.com/@/imgs/docker-grafana/adddata.jpg?imageView2/0/w/800)

2、配置Prometheus数据
Name填入 Prometheus ，URL填入 `http://192.168.56.102:9090`，其他不用变。Save&Test。
![img](http://cdn.voidking.com/@/imgs/docker-grafana/prometheus.jpg?imageView2/0/w/800)
![img](http://cdn.voidking.com/@/imgs/docker-grafana/savetest.jpg?imageView2/0/w/800)

3、选择dashboard
点击Dashboards，点击三个Import，引入三个dashboard。
![img](http://cdn.voidking.com/@/imgs/docker-grafana/dashboard.jpg?imageView2/0/w/800)

4、引入其他dashboard
![img](http://cdn.voidking.com/@/imgs/docker-grafana/import.jpg?imageView2/0/w/800)
比如可以填入URL <https://grafana.com/grafana/dashboards/405> ，点击Load，就可以下载Node Exporter的dashboard。
选择Folder，选择Prometheus数据源，Import。
![img](http://cdn.voidking.com/@/imgs/docker-grafana/nodeexporter.jpg?imageView2/0/w/800)
![img](http://cdn.voidking.com/@/imgs/docker-grafana/nodeexporter2.jpg?imageView2/0/w/800)

5、查看dashboard
左上角HOME，出现下拉框，即可选择dashboard。
![img](http://cdn.voidking.com/@/imgs/docker-grafana/select.jpg?imageView2/0/w/800)
![img](http://cdn.voidking.com/@/imgs/docker-grafana/promstats.jpg?imageView2/0/w/800)

- **本文作者：** 好好学习的郝
- **本文链接：** <https://www.voidking.com/dev-docker-grafana/>
- **版权声明：** 本博客所有文章除特别声明外，均采用[ BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh) 许可协议。转载请注明出处！源站会及时更新知识点及修正错误，阅读体验也更好。欢迎分享，欢迎收藏~

[# docker](https://www.voidking.com/tags/docker/) [# centos](https://www.voidking.com/tags/centos/) [# grafana](https://www.voidking.com/tags/grafana/) [# 监控](https://www.voidking.com/tags/%E7%9B%91%E6%8E%A7/) [# prometheus](https://www.voidking.com/tags/prometheus/)