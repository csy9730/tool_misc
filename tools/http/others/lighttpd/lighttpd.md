# lighttpd
[http://www.lighttpd.net/](http://www.lighttpd.net/)

Security, speed, compliance, and flexibility -- all of these describe lighttpd (*pron.* **lighty**) which is rapidly redefining efficiency of a webserver; as it is designed and optimized for high performance environments. With a small memory footprint compared to other web-servers, effective management of the cpu-load, and advanced feature set (FastCGI, SCGI, Auth, Output-Compression, URL-Rewriting and many more) lighttpd is the perfect solution for every server that is suffering load problems. And best of all it's Open Source licensed under the [revised BSD license](http://www.lighttpd.net/assets/COPYING).

## Web 2.0

lighttpd [powers](http://redmine.lighttpd.net/projects/lighttpd/wiki/PoweredByLighttpd) several popular Web 2.0 sites. Its high speed io-infrastructure allows them to [scale several times better](http://www.lighttpd.net/benchmark) with the same hardware than with alternative web-servers.

This fast web server and its [development team](http://redmine.lighttpd.net/projects/lighttpd/wiki/DevelopersList) create a web-server with the needs of the future web in mind:

- [Faster FastCGI](http://blog.lighttpd.net/articles/2006/11/29/faster-fastcgi)
- [COMET meets mod_mailbox](http://blog.lighttpd.net/articles/2006/11/27/comet-meets-mod_mailbox)
- [Async IO](http://blog.lighttpd.net/articles/2006/11/12/lighty-1-5-0-and-linux-aio)

Its event-driven architecture is optimized for a large number of parallel connections (keep-alive) which is important for high performance AJAX applications.