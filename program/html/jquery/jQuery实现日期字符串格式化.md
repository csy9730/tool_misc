# [jQuery实现日期字符串格式化](https://www.cnblogs.com/jiyang2008/p/7730736.html)



**1. js仿后台的字符串的StringFormat方法**



```
function StringFormat() {
         if (arguments.length == 0)
             return null;
         var str = arguments[0];
         for (var i = 1; i < arguments.length; i++) {
             var re = new RegExp('\\{' + (i - 1) + '\\}', 'gm');
             str = str.replace(re, arguments[i]);
         }
         return str;
}
```



使用方法与后台的StringFormat方法一样，StringFormat("abc{0}def","123");输出结果为"abc123def"。

**2. js实现日期格式化**



```
function Format(now,mask)
    {
        var d = now;
        var zeroize = function (value, length)
        {
            if (!length) length = 2;
            value = String(value);
            for (var i = 0, zeros = ''; i < (length - value.length); i++)
            {
                zeros += '0';
            }
            return zeros + value;
        };
     
        return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0)
        {
            switch ($0)
            {
                case 'd': return d.getDate();
                case 'dd': return zeroize(d.getDate());
                case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
                case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
                case 'M': return d.getMonth() + 1;
                case 'MM': return zeroize(d.getMonth() + 1);
                case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
                case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
                case 'yy': return String(d.getFullYear()).substr(2);
                case 'yyyy': return d.getFullYear();
                case 'h': return d.getHours() % 12 || 12;
                case 'hh': return zeroize(d.getHours() % 12 || 12);
                case 'H': return d.getHours();
                case 'HH': return zeroize(d.getHours());
                case 'm': return d.getMinutes();
                case 'mm': return zeroize(d.getMinutes());
                case 's': return d.getSeconds();
                case 'ss': return zeroize(d.getSeconds());
                case 'l': return zeroize(d.getMilliseconds(), 3);
                case 'L': var m = d.getMilliseconds();
                    if (m > 99) m = Math.round(m / 10);
                    return zeroize(m);
                case 'tt': return d.getHours() < 12 ? 'am' : 'pm';
                case 'TT': return d.getHours() < 12 ? 'AM' : 'PM';
                case 'Z': return d.toUTCString().match(/[A-Z]+$/);
                // Return quoted strings with the surrounding quotes removed
                default: return $0.substr(1, $0.length - 2);
            }
        });
    };
```



使用时候直接调用方法 Format(date,"yyyy-MM-dd HH:mm");输出格式为 "2015-10-14 16:50"；第一个参数为时间，第二个参数为输出格式。

　　格式中代表的意义：

　　　　d:日期天数；dd:日期天数（2位，不够补0）；ddd:星期（英文简写）；dddd:星期（英文全拼）；

　　　　M:数字月份；MM:数字月份（2位，不够补0）；MMM:月份（英文简写）；MMMM:月份（英文全拼）；

　　　　yy:年份（2位）；yyyy:年份；

　　　　h:小时（12时计时法）；hh:小时（2位，不足补0；12时计时法）；

　　　　H:小时（24时计时法）；HH:小时（2位，不足补0；24时计时法）；

　　　　m:分钟；mm:分钟（2位，不足补0）；

　　　　s:秒；ss:秒（2位，不足补0）；

　　　　l:毫秒数（保留3位）；

　　　　tt: 小时（12时计时法，保留am、pm）；TT: 小时（12时计时法，保留AM、PM）；

 

原文出处：<http://www.cnblogs.com/xuyangblog/p/4878043.html>



分类: [前端](https://www.cnblogs.com/jiyang2008/category/753321.html)

标签: [时间](https://www.cnblogs.com/jiyang2008/tag/时间/), [日期](https://www.cnblogs.com/jiyang2008/tag/日期/), [格式化](https://www.cnblogs.com/jiyang2008/tag/格式化/), [jQuery](https://www.cnblogs.com/jiyang2008/tag/jQuery/)