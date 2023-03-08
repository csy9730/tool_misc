### **Linux 64-bit installation instructions for Java**    

------

​	This article applies to: 

- ​	**Platform(s):** Oracle Enterprise Linux, Oracle Linux, Red Hat Linux, SLES, SUSE Linux, Ubuntu Linux 	
- ​	**Java version(s):** 7.0, 8.0 	

------

Linux System Requirements See supported [System Configurations](https://java.com/en/download/help/sysreq.xml) for information about supported platforms, operating systems, desktop managers, and browsers. 

**Note**: For downloading Java other flavors of Linux see  

[Java for Ubuntu](https://help.ubuntu.com/community/Java) 

[Java for Fedora](http://openjdk.java.net/install/) 
 
Follow these steps to download and install Java for Linux. 

[**Download**](https://java.com/en/download/help/linux_x64_install.html#download) 

[**Install**](https://java.com/en/download/help/linux_x64_install.html#install) 

Download This procedure installs the Java Runtime Environment (JRE) for 64-bit Linux, using an archive binary file (.tar.gz).    	     Go to http://java.com and click on the [**Download**](https://java.com/en/download/linux_manual.jsp) button.  **Download and check the download file size** to  ensure that you have downloaded the full, uncorrupted software bundle.  Before you download the file, notice its byte size provided on the  download page on the web site. Once the download has completed, compare  that file size to the size of the downloaded file to make sure they are  equal. 

Install    	    ![img](https://java.com/content/published/api/v1.1/assets/CONT8FE87BAAA75A48AC821BC90E79933E90/native?cb=_cache_fb08&channelToken=1f7d2611846d4457b213dfc9048724dc)

The instructions below are for installing version Java 8 Update 73 (8u73).  If you are installing another version, make sure you change the version  number appropriately when you type the commands at the terminal. **Example**: For Java 8u79 replace **8u73** with **8u79**. Note that, as in the preceding example, the version number is sometimes preceded with the letter `u` and sometimes it is preceded with an underbar, for example, `jre1.8.0_73`. 

  **Note about root access:** *To install Java in a system-wide location such as /usr/local, you  must login as the root user to gain the necessary permissions. If you do not have root access, install Java in your home directory or a  subdirectory for which you have write permissions.* **Change to the directory in which you want to install.** Type:
 `cd ` *directory_path_name*
 For example, to install the software in the /usr/java/ directory, Type:
 `cd /usr/java/`
 
  Move the .tar.gz archive binary to the current directory. **Unpack the tarball and install Java**
 `tar zxvf jre-8u73-linux-x64.tar.gz`

 The Java files are installed in a directory called jre1.8.0_73 in the current directory.  In this example, it is installed in the `/usr/java/jre1.8.0_73` directory. When the installation has completed, you will see the word **Done**.
 **Delete the `.tar.gz` file** if you want to save disk space.
 