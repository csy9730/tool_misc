# Scrapy


``` python
import scrapy
​class MySpider(scrapy.Spider):    
    name = 'myspider'​    
    def __init__(self, category=None, *args, **kwargs):        
        super(MySpider, self).__init__(*args, **kwargs)
        self.start_urls = ['http://www.example.com/categories/%s' % category]        
        # ...
    def start_requests(self):
        yield scrapy.Request('http://www.example.com/categories/%s' % self.category)

```


```
scrapy crawl myspider -a category=electronics

```
## misc

https://www.zhihu.com/question/58151047


https://github.com/sea1234/myyangzhengma