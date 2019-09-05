var grab = function() {
    var date = new Date();
    if (date.getHours() >= 12) {
        // 此处为相应页面的抢票按钮，请自行获取dom元素
        var button = document.getElementsByClassName('J-gotoAuth')[0];
        if (!button.disabled) {
            // 可抢票，点击抢票
            button.click();
        } else {
            // 不可抢票，刷新页面
            setTimeout(function() {
                window.location.reload();
            }, 500);
        }
    } else {
        // 未到设定抢票时间，进入下一轮循环
        setTimeout('grab()', 1000);
    }
}
