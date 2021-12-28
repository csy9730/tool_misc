/* play video twice as fast */
setInterval(function(){
	document.querySelector('video').defaultPlaybackRate = 4.0;//默认两倍速播放
	document.querySelector('video').play();
}, 5000);
