const puppeteer = require('puppeteer');
// const browser =  puppeteer.launch({headless:false });
//var page =  browser.newPage();

(async () => {
    const browser = await puppeteer.launch({headless:false });
    const page = await browser.newPage();
    await page.goto('https://www.jd.com/');
})();
