# How to install the NVIDIA drivers on Ubuntu 20.04 Focal Fossa Linux

16 October 2020 by [Lubos Rendek](https://linuxconfig.org/author/lubos) 

<iframe id="google_ads_iframe_/71161633,180063765/LINUX_linuxconfig/home_header_1" srcdoc="<body></body>" style="position: absolute; z-index: -1; border: 0px none;"></iframe>

The objective is to install the NVIDIA drivers on [Ubuntu 20.04](https://linuxconfig.org/ubuntu-20-04-guide) Focal Fossa Linux and switch from a opensource Nouveau driver to the proprietary Nvidia driver.

To install Nvidia driver on other Linux distributions, follow our [Nvidia Linux Driver](https://linuxconfig.org/install-the-latest-nvidia-linux-driver) guide.

**In this tutorial you will learn:**

- Perform an automatic Nvidia driver installation using standard Ubuntu Repository
- Learn how to perform an Nvidia driver installation using PPA repository
- How to install the official Nvidia.com driver
- Uninstall/switch back from Nvidia to Nouveau opensource driver



[![Installed NVIDIA drivers on Ubuntu 20.04 Focal Fossa Linux](https://linuxconfig.org/wp-content/uploads/2019/12/01-how-to-install-the-nvidia-drivers-on-ubuntu-20-04-focal-fossa-linux.png)](https://linuxconfig.org/wp-content/uploads/2019/12/01-how-to-install-the-nvidia-drivers-on-ubuntu-20-04-focal-fossa-linux.png)

Installed NVIDIA drivers on Ubuntu  20.04 Focal Fossa Linux. After installation, optionally run Nvidia  graphic card test by following our [Benchmark Your Graphics Card On Linux](https://linuxconfig.org/benchmark-your-graphics-card-on-linux) guide.

## Software Requirements and Conventions Used

| Category    | Requirements, Conventions or Software Version Used           |
| ----------- | ------------------------------------------------------------ |
| System      | Installed or [upgraded Ubuntu 20.04 Focal Fossa](https://linuxconfig.org/how-to-upgrade-ubuntu-to-20-04-lts-focal-fossa) |
| Software    | N/A                                                          |
| Other       | Privileged access to your Linux system as root or via the `sudo` command. |
| Conventions | **#** – requires given [linux commands](https://linuxconfig.org/linux-commands) to be executed with root privileges either directly as a root user or by use of `sudo` command  **$** – requires given [linux commands](https://linuxconfig.org/linux-commands) to be executed as a regular non-privileged user |


- apt install from Ubuntu Repository 
- apt install from PPA Repository 
- bash NVIDIA-Linux-x86_64-440.44.run

## How to install Nvidia Drivers using a standard Ubuntu Repository step by step instructions

The first method is the easiest to perform and in most cases it is the recommended approach.

### GNOME GUI Nvidia Installation Method

[![Open the Software & Updates application window. Select TAB Additional Drivers and choose any proprietary NVIDIA driver.](https://linuxconfig.org/wp-content/uploads/2019/12/02-how-to-install-the-nvidia-drivers-on-ubuntu-20-04-focal-fossa-linux.png)](https://linuxconfig.org/wp-content/uploads/2019/12/02-how-to-install-the-nvidia-drivers-on-ubuntu-20-04-focal-fossa-linux.png)

Open the `Software & Updates` application window. Select TAB `Additional Drivers` and choose any proprietary NVIDIA driver. The higher the driver number the latest the version.

### Command Line Nvidia Installation Method

1. First, detect the model of your nvidia graphic card and the  recommended driver. To do so execute the following command. Please note  that your output and recommended driver will most likely be different:

   ```
   $ ubuntu-drivers devices
   == /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0 ==
   modalias : pci:v000010DEd00001C03sv00001043sd000085ABbc03sc00i00
   vendor   : NVIDIA Corporation
   model    : GP106 [GeForce GTX 1060 6GB]
   driver   : nvidia-driver-390 - distro non-free
   driver   : nvidia-driver-435 - distro non-free
   driver   : nvidia-driver-440 - distro non-free recommended
   driver   : xserver-xorg-video-nouveau - distro free builtin
   ```

   ------

   <iframe id="google_ads_iframe_/71161633,180063765/LINUX_linuxconfig/article_incontent_1_1" srcdoc="<body></body>" style="position: absolute; z-index: -1; border: 0px none;"></iframe>

   ------

   From the above output we can conclude that the current system has **NVIDIA GeForce GTX 1060 6GB** graphic card installed and the recommend driver to install is **nvidia-driver-440**.

2. Install driver.

   If you agree with the recommendation feel free to use the `ubuntu-drivers` command again to install all recommended drivers:

   ```
   $ sudo ubuntu-drivers autoinstall
   ```

   Alternatively, install desired driver selectively using the `apt` command. For example:

   ```
   $ sudo apt install nvidia-driver-440
   ```

3. Once the installation is concluded, reboot your system and you are done.

   ```
   $ sudo reboot
   ```

## Automatic Install using PPA repository to install Nvidia Beta drivers

1. Using 

   ```
   graphics-drivers
   ```

    PPA repository allows us to  install bleeding edge Nvidia beta drivers at the risk of an unstable  system. To proceed first add the 

   ```
   ppa:graphics-drivers/ppa
   ```

    repository into your system:

   ```
   $ sudo add-apt-repository ppa:graphics-drivers/ppa
   ```

2. Next, identify your graphic card model and recommended driver:

   ```
   $ ubuntu-drivers devices
   == /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0 ==
   modalias : pci:v000010DEd00001C03sv00001043sd000085ABbc03sc00i00
   vendor   : NVIDIA Corporation
   model    : GP106 [GeForce GTX 1060 6GB]
   driver   : nvidia-driver-440 - distro non-free recommended
   driver   : nvidia-driver-390 - distro non-free
   driver   : nvidia-driver-435 - distro non-free
   driver   : xserver-xorg-video-nouveau - distro free builtin
   ```

3. Install Nvidia Driver

   Same as with the above standard Ubuntu repository example, either install all recommended drivers automatically:

   ```
   $ sudo ubuntu-drivers autoinstall
   ```

   or selectively using the `apt` command. Example:

   ```
   $ sudo apt install nvidia-driver-440
   ```

4. All done.

   Reboot your computer:

   ```
   $ sudo reboot
   ```

   ------

   <iframe id="google_ads_iframe_/71161633,180063765/LINUX_linuxconfig/article_incontent_2_1" srcdoc="<body></body>" style="position: absolute; z-index: -1; border: 0px none;"></iframe>

   ------

## Manual Install using the Official Nvidia.com driver step by step instructions

1. 1. identify your NVIDIA VGA card.

      The below commands will allow you to identify your Nvidia card model:

      ```
      $  lshw -numeric -C display
      or
      $ lspci -vnn | grep VGA
      or
      $ ubuntu-drivers devices
      ```

   2. Download the Official Nvidia Driver.

      Using your web browser navigate to the [ official Nvidia ](http://www.nvidia.com/Download/index.aspx) website and download an appropriate driver for your Nvidia graphic card.

      Alternatively, if you know what you are doing you can download the driver directly from the [Nvidia Linux driver list](https://www.nvidia.com/object/unix.html). Once ready you should end up with a file similar to the one shown below:

      ```
      $ ls
      NVIDIA-Linux-x86_64-440.44.run
      ```

   3. Install Prerequisites

      The following prerequisites are required to compile and install Nvidia driver:

      ```
      $ sudo apt install build-essential libglvnd-dev pkg-config
      ```

------

<iframe id="google_ads_iframe_/71161633,180063765/LINUX_linuxconfig/article_incontent_3_1" srcdoc="<body></body>" style="position: absolute; z-index: -1; border: 0px none;"></iframe>

------

1. Disable Nouveau Nvidia driver.

   Next step is to disable the default nouveau Nvidia driver. Follow this guide [on how to disable the default Nouveau Nvidia driver](https://linuxconfig.org/how-to-disable-blacklist-nouveau-nvidia-driver-on-ubuntu-20-04-focal-fossa-linux).

   **WARNING**
    Depending on your Nvidia VGA model your system might misbehave. At this  stage be ready to get your hands dirty. After the reboot you may end up  without GUI at all. Be sure that you have the [SSH enabled ](https://linuxconfig.org/enable-ssh-on-ubuntu-18-04-bionic-beaver-linux) on your system to be able login remotely or use `CTRL+ALT+F2` to switch TTY console and continue with the installation.

   Make sure you reboot your system before you proceed to the next step.

2. Stop Desktop Manager.

   In order to install new Nvidia driver we need to stop the current  display server. The easiest way to do this is to change into runlevel 3  using the `telinit` command. After executing the following [linux command](https://linuxconfig.org/linux-commands) the display server will stop, therefore make sure you save all your current work ( if any ) before you proceed:

   ```
   $ sudo telinit 3
   ```

   Hit `CTRL+ALT+F1` and login with your username and password to open a new TTY1 session or login via SSH.

3. Install Nvidia Driver.

   To start installation of Nvidia driver execute the following [linux command](https://linuxconfig.org/linux-commands) and follow the wizard:

   ```
   $ sudo bash NVIDIA-Linux-x86_64-440.44.run
   ```

4. The Nvidia driver is now installed.

   Reboot your system:

   ```
   $ sudo reboot
   ```

5. Configure NVIDIA X Server Settings.

   After reboot your should be able to start NVIDIA X Server Settings app from the Activities menu.

## How to Uninstall Nvidia Driver

Follow our guide on [how to uninstall Nvidia Driver](https://linuxconfig.org/how-to-uninstall-the-nvidia-drivers-on-ubuntu-20-04-focal-fossa-linux) hence switch back from Nvidia to Nouveau opensource driver.

## Appendix

Error messages:

```
WARNING: Unable to find suitable destination to install 32-bit compatibility libraries
```

Depending on your needs, this can be safely ignored. However, if you  wish to install steam game platform this issue cannot be ignored. To  resolve execute:

```
$ sudo dpkg --add-architecture i386
$ sudo apt update
$ sudo apt install libc6:i386
```

and re-run the nvidia driver installation.

------

```
  An incomplete installation of libglvnd was found. All of the essential libglvnd libraries are present, but one or more optional    
  components are missing. Do you want to install a full copy of libglvnd? This will overwrite any existing libglvnd libraries.
```

You are missing the `libglvnd-dev` package. Execute the following command to resolve this issue:

```
$ sudo apt install libglvnd-dev
```

------

```
  Oct  9 10:36:20 linuxconfig gdm-password]: gkr-pam: unable to locate daemon control file
Oct  9 10:36:20 linuxconfig gdm-password]: pam_unix(gdm-password:session): session opened for user linuxconfig by (uid=0)
Oct  9 10:36:20 linuxconfig systemd-logind[725]: New session 8 of user linuxconfig.
Oct  9 10:36:20 linuxconfig systemd: pam_unix(systemd-user:session): session opened for user linuxconfig by (uid=0)
Oct  9 10:36:21 linuxconfig gdm-password]: pam_unix(gdm-password:session): session closed for user linuxconfig
Oct  9 10:36:21 linuxconfig systemd-logind[725]: Session 8 logged out. Waiting for processes to exit.
Oct  9 10:36:21 linuxconfig systemd-logind[725]: Removed session 8.
Oct  9 10:36:45 linuxconfig dbus-daemon[728]: [system] Failed to activate service 'org.bluez': timed out (service_start_timeout=25000ms)
```

To resolve do not overwrite any existing libglvnd libraries during the Nvidia driver installation.

------

```
  WARNING: Unable to determine the path to install the libglvnd EGL vendor library config files. Check that you have pkg-config and  
           the libglvnd development libraries installed, or specify a path with --glvnd-egl-config-path.
```

Make sure to install `pkg-config` package:

```
$ sudo apt install pkg-config
```

