# termux-api

This addon exposes device functionality as API to command line programs in [Termux](https://github.com/termux/).


[https://wiki.termux.com/wiki/Termux:API](https://wiki.termux.com/wiki/Termux:API)

## install

需要安装两部分：
- termux-api.apk
- termux-api.deb


从[https://github.com/termux/termux-api/releases](https://github.com/termux/termux-api/releases)下载termux-api.apk


``` bash
# termux-api.deb
pkg install termux-api
```

apk和deb的版本必须一致

## Current API implementations

- [termux-battery-status](https://wiki.termux.com/wiki/Termux-battery-status)

  Get the status of the device battery.

- [termux-brightness](https://wiki.termux.com/wiki/Termux-brightness)

  Set the screen brightness between 0 and 255.

- [termux-call-log](https://wiki.termux.com/wiki/Termux-call-log)

  List call log history.

- [termux-camera-info](https://wiki.termux.com/wiki/Termux-camera-info)

  Get information about device camera(s).

- [termux-camera-photo](https://wiki.termux.com/wiki/Termux-camera-photo)

  Take a photo and save it to a file in JPEG format.

- [termux-clipboard-get](https://wiki.termux.com/wiki/Termux-clipboard-get)

  Get the system clipboard text.

- [termux-clipboard-set](https://wiki.termux.com/wiki/Termux-clipboard-set)

  Set the system clipboard text.

- [termux-contact-list](https://wiki.termux.com/wiki/Termux-contact-list)

  List all contacts.

- [termux-dialog](https://wiki.termux.com/wiki/Termux-dialog)

  Show a text entry dialog.

- [termux-download](https://wiki.termux.com/wiki/Termux-download)

  Download a resource using the system download manager.

- [termux-fingerprint](https://wiki.termux.com/wiki/Termux-fingerprint)

  Use fingerprint sensor on device to check for authentication.

- [termux-infrared-frequencies](https://wiki.termux.com/wiki/Termux-infrared-frequencies)

  Query the infrared transmitter's supported carrier frequencies.

- [termux-infrared-transmit](https://wiki.termux.com/wiki/Termux-infrared-transmit)

  Transmit an infrared pattern.

- [termux-job-scheduler](https://wiki.termux.com/index.php?title=Termux-job-scheduler&action=edit&redlink=1)

  Schedule a Termux script to run later, or periodically.

- [termux-location](https://wiki.termux.com/wiki/Termux-location)

  Get the device location.

- [termux-media-player](https://wiki.termux.com/wiki/Termux-media-player)

  Play media files.

- [termux-media-scan](https://wiki.termux.com/wiki/Termux-media-scan)

  MediaScanner interface, make file changes visible to Android Gallery

- [termux-microphone-record](https://wiki.termux.com/wiki/Termux-microphone-record)

  Recording using microphone on your device.

- [termux-notification](https://wiki.termux.com/wiki/Termux-notification)

  Display a system notification.

- [termux-notification-remove](https://wiki.termux.com/wiki/Termux-notification-remove)

  Remove a notification previously shown with termux-notification --id.

- [termux-sensor](https://wiki.termux.com/wiki/Termux-sensor)

  Get information about types of sensors as well as live data.

- [termux-share](https://wiki.termux.com/wiki/Termux-share)

  Share a file specified as argument or the text received on stdin.

- [termux-sms-list](https://wiki.termux.com/wiki/Termux-sms-list)

  List SMS messages.

- [termux-sms-send](https://wiki.termux.com/wiki/Termux-sms-send)

  Send a SMS message to the specified recipient number(s).

- [termux-storage-get](https://wiki.termux.com/wiki/Termux-storage-get)

  Request a file from the system and output it to the specified file.

- [termux-telephony-call](https://wiki.termux.com/wiki/Termux-telephony-call)

  Call a telephony number.

- [termux-telephony-cellinfo](https://wiki.termux.com/wiki/Termux-telephony-cellinfo)

  Get information about all observed cell information from all radios on the device including the primary and neighboring cells.

- [termux-telephony-deviceinfo](https://wiki.termux.com/wiki/Termux-telephony-deviceinfo)

  Get information about the telephony device.

- [termux-toast](https://wiki.termux.com/wiki/Termux-toast)

  Show a transient popup notification.

- [termux-torch](https://wiki.termux.com/wiki/Termux-torch)

  Toggle LED Torch on device.

- [termux-tts-engines](https://wiki.termux.com/wiki/Termux-tts-engines)

  Get information about the available text-to-speech engines.

- [termux-tts-speak](https://wiki.termux.com/wiki/Termux-tts-speak)

  Speak text with a system text-to-speech engine.

- [termux-usb](https://wiki.termux.com/wiki/Termux-usb)

  List or access USB devices.

- [termux-vibrate](https://wiki.termux.com/wiki/Termux-vibrate)

  Vibrate the device.

- [termux-volume](https://wiki.termux.com/wiki/Termux-volume)

  Change volume of audio stream.

- [termux-wallpaper](https://wiki.termux.com/wiki/Termux-wallpaper)

  Change wallpaper on your device.

- [termux-wifi-connectioninfo](https://wiki.termux.com/wiki/Termux-wifi-connectioninfo)

  Get information about the current wifi connection.

- [termux-wifi-enable](https://wiki.termux.com/wiki/Termux-wifi-enable)

  Toggle Wi-Fi On/Off.

- [termux-wifi-scaninfo](https://wiki.termux.com/wiki/Termux-wifi-scaninfo)

  Get information about the last wifi scan.


### usage
