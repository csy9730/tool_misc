# python misc
### tqdm
``` python
import tqdm

def texts_gen(file_list,maxlen = 500):
    pbar = (file_list)
    for file in pbar:
        # pbar.set_description("Processing %s" % file)
        print(pbar)
        with open(file,'r',encoding='utf-8') as f:
            while True:
                text = (f.readline().rstrip('\n').split('\t')[-1])
                if not text:
                    break
                if len(text) > maxlen:
                    text = text[0:maxlen]
                yield text

```


### import
import 导入同级目录模块
导入 下级目录模块
导入上级目录模块
导入兄弟目录模块


### selenium
``` python
import selenium 
from selenium import webdriver 
from fake_useragent import UserAgent
ua = UserAgent() 
option = webdriver.ChromeOptions() 
option.add_argument('--headless') 
option.add_argument("window-size=1024,768") 
option.add_argument('--start-maximized') 
option.add_argument('user-agent="%s"'%ua.random) 
browser = webdriver.Chrome(executable_path=r'C:\selenium\chromedriver.exe',chrome_options=option)
browser.get('https://www.baidu.com') 
browser.save_screenshot(r'D:\websoft88.com.png')
```



### Chrome的时间基准
DOS的时间基准是1980年1月1日，
Unix的时间基准是1970年1月1日上午12 点，
Linux的时间基准是1970年1月1日凌晨0点。
Windows的时间基准是1601年1月1日。

Chrome的时间基准是1601年1月1日。
``` python
	datetime.datetime(1601, 1, 1) + datetime.timedelta(microseconds=13220383158057917)
```