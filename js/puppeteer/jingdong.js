const puppeteer = require('puppeteer');
(async () => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto('https://www.jd.com/');
    const hrefArr = await page.evaluate(() => {
        let arr = [];
        const aNodes = document.querySelectorAll('.cate_menu_lk');
        aNodes.forEach(function (item) {
            arr.push(item.href)
        })
        return arr
    });
    let arr = [];
    for (let i = 0; i < hrefArr.length; i++) {
        const url = hrefArr[i];
        console.log(url) //这里可以打印 
        await page.goto(url);
        const result = await page.evaluate(() => { //这个方法内部console.log无效 
            
              return  $('title').text();  //返回每个界面的title文字内容
        });
        arr.push(result)  //每次循环给数组中添加对应的值
    }
    console.log(arr)  //得到对应的数据  可以通过Node.js的 fs 模块保存到本地
    await browser.close()
})()