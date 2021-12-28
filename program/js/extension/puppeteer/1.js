const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({headless:true});
  const page = await browser.newPage();
  await page.goto('http://www.baidu.com');
  await page.screenshot({path: 'scr_baidu.png'});
  await page.pdf({path: 'scr_baidu.pdf', format: 'A4'});// 目前只能在无头模式下生成pdf 
  await browser.close();
})();