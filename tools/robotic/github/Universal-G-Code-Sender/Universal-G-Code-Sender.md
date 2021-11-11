# Universal-G-Code-Sender
Universal G-Code Sender is a Java based, cross platform G-Code sender, compatible with [GRBL](https://github.com/gnea/grbl/), [TinyG](https://github.com/synthetos/TinyG), [g2core](https://github.com/synthetos/g2) and [Smoothieware](http://smoothieware.org/).

Online documentation and releases: <http://winder.github.io/ugs_website/>
Discussion forum: <https://groups.google.com/forum/#!forum/universal-gcode-sender>

Technical details:

- [JSSC](https://github.com/scream3r/java-simple-serial-connector) or [JSerialComm](https://github.com/Fazecast/jSerialComm) for serial communication
- [JogAmp](https://jogamp.org/) for OpenGL
- Built with [Netbeans Platform](https://netbeans.org/features/platform/)
- Developed with NetBeans 8.0.2 or later

## Downloads

Below you will find the latest release of UGS.
For older releases please visit the [releases page](https://github.com/winder/Universal-G-Code-Sender/releases).

**UGS Platform**
The next generation, feature packed variant based on the Netbeans Platform.
Unpack and start the program `bin/ugsplatform`

| Latest release (v2.0.8)                                      | Previous release (v2.0.7)                                    | Nightly build                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [![Windows](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_windows.png) Windows](https://ugs.jfrog.io/ugs/UGS/v2.0.8/ugs-platform-app-win.zip) | [![Windows](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_windows.png) Windows](https://ugs.jfrog.io/ugs/UGS/v2.0.7/ugs-platform-app-win.zip) | [![Windows](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_windows.png) Windows](https://ugs.jfrog.io/ugs/UGS/nightly/ugs-platform-app-win.zip) |
| [![Mac OSX](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_mac.png) Mac OSX](https://ugs.jfrog.io/ugs/UGS/v2.0.8/ugs-platform-app-ios.dmg) | [![Mac OSX](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_mac.png) Mac OSX](https://ugs.jfrog.io/ugs/UGS/v2.0.7/ugs-platform-app-ios.dmg) | [![Mac OSX](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_mac.png) Mac OSX](https://ugs.jfrog.io/ugs/UGS/nightly/ugs-platform-app-ios.dmg) |
| [![Linux x64](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_linux.png) Linux](https://ugs.jfrog.io/ugs/UGS/v2.0.8/ugs-platform-app-linux.tar.gz) | [![Linux x64](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_linux.png) Linux](https://ugs.jfrog.io/ugs/UGS/v2.0.7/ugs-platform-app-linux.tar.gz) | [![Linux x64](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_linux.png) Linux](https://ugs.jfrog.io/ugs/UGS/nightly/ugs-platform-app-linux.tar.gz) |
| [![Linux ARM](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_linux_arm.png) RaspberryPI](https://ugs.jfrog.io/ugs/UGS/v2.0.8/ugs-platform-app-pi.tar.gz) | [![Linux ARM](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_linux_arm.png) RaspberryPI](https://ugs.jfrog.io/ugs/UGS/v2.0.7/ugs-platform-app-pi.tar.gz) | [![Linux ARM](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/os_linux_arm.png) RaspberryPI](https://ugs.jfrog.io/ugs/UGS/nightly/ugs-platform-app-pi.tar.gz) |
| [![Zip](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/zip.png) All platforms](https://ugs.jfrog.io/ugs/UGS/v2.0.8/ugs-platform-app.zip) | [![Zip](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/zip.png) All platforms](https://ugs.jfrog.io/ugs/UGS/v2.0.7/ugs-platform-app.zip) | [![Zip](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/zip.png) All platforms](https://ugs.jfrog.io/ugs/UGS/nightly/ugs-platform-app.zip) |

**UGS Classic**
A clean and lightweight variant of UGS (requires [Java](https://java.com/en/download/manual.jsp)).
Unpack and start the program by double clicking the jar file. On some platforms you may need to run the included start script.

| Latest release (v2.0.8)                                      | Previous release (v2.0.7)                                    | Nightly build                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [![Zip](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/zip.png) All platforms](https://ugs.jfrog.io/ugs/UGS/v2.0.8/UniversalGcodeSender.zip) | [![Zip](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/zip.png) All platforms](https://ugs.jfrog.io/ugs/UGS/v2.0.7/UniversalGcodeSender.zip) | [![Zip](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/zip.png) All platforms](http://bit.ly/2HhJIir) |

## Screenshots

### UGS Platform

UGS Platform main window

[![UGS Platform](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_ugs_platform.png)](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_ugs_platform.png)

Customizable panel layout

[![Customizable panel layout](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_customizable_panels.png)](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_customizable_panels.png)

Menu actions with customizable keybindings

[![Actions](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_actions_menu.png)](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_actions_menu.png)

Menu with plugins

[![Plugins](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_plugins_menu.png)](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_plugins_menu.png)

One of many plugins

[![Dowel Maker](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_dowel_maker_plugin.png)](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_dowel_maker_plugin.png)

Basic gcode editor

[![Basic gcode editor](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_editor.png)](https://github.com/winder/Universal-G-Code-Sender/raw/master/pictures/2.0_platform_editor.png)

### UGS Classic

UGS Classic main window

[![Classic main window](https://camo.githubusercontent.com/bbe11ade9435cdcfd23d2b93d200d0521baccf633ee28d03082da0d32fdf31ef/68747470733a2f2f77696e6465722e6769746875622e696f2f7567735f776562736974652f696d672f73637265656e73686f74732f66696e69736865642e706e67)](https://camo.githubusercontent.com/bbe11ade9435cdcfd23d2b93d200d0521baccf633ee28d03082da0d32fdf31ef/68747470733a2f2f77696e6465722e6769746875622e696f2f7567735f776562736974652f696d672f73637265656e73686f74732f66696e69736865642e706e67)

UGS Classic with visualizer

[![Classic visualizer](https://camo.githubusercontent.com/9e943cfc4eea0543144eac60e5c549ebf22faec7351d53b8b7ea281a1b4a927d/68747470733a2f2f77696e6465722e6769746875622e696f2f7567735f776562736974652f696d672f73637265656e73686f74732f76697375616c697a65722e706e67)](https://camo.githubusercontent.com/9e943cfc4eea0543144eac60e5c549ebf22faec7351d53b8b7ea281a1b4a927d/68747470733a2f2f77696e6465722e6769746875622e696f2f7567735f776562736974652f696d672f73637265656e73686f74732f76697375616c697a65722e706e67)

## Development

For development the [Maven](http://maven.apache.org/) build tool is used.

#### Start the application

UGS Classic:

```
mvn install
mvn exec:java -Dexec.mainClass="com.willwinder.universalgcodesender.MainWindow" -pl ugs-core
```

UGS Platform:

```
mvn install
mvn nbm:run-platform -pl ugs-platform/application
```

#### Execute all tests

```
mvn test
```

#### Building the self-executing JAR

```
mvn install
mvn package -pl ugs-core
```

#### Build a UniversalGcodeSender.zip release file

```
mvn package assembly:assembly
```

#### Develop via IntelliJ

If you are more used to IntelliJ, you can also build, run and debug it there.

Before you start you need to change a setting for handling imports in Maven since we are using `jgitver`, [read more about it here](https://github.com/jgitver/jgitver-maven-plugin/wiki/Intellij-IDEA-configuration).

- Run `mvn nbm:run-platform -pl ugs-platform/application` once via terminal to build everything

- Import the Source, `File` -> `New` -> `Project from existing Sources`

- Setup a new "Run Configuration",

   

  ```
  Java Application
  ```

  , with following settings:

  - Main Class: `org.netbeans.Main`
  - VM Options: `-Dnetbeans.user=$ProjectFileDir$/ugs-platform/application/target/userdir -Dnetbeans.home=$ProjectFileDir$/ugs-platform/application/target/ugsplatform/platform -Dnetbeans.logger.console=true -Dnetbeans.indexing.noFileRefresh=true -Dnetbeans.dirs="$ProjectFileDir$/ugs-platform/application/target/ugsplatform/ugsplatform:$ProjectFileDir$/ugs-platform/application/target/ugsplatform/platform:$ProjectFileDir$/ugs-platform/application/target/ugsplatform/ide:$ProjectFileDir$/ugs-platform/application/target/ugsplatform/extra:$ProjectFileDir$/ugs-platform/application/target/ugsplatform/java"`
  - Program arguments: `--branding ugsplatform`
  - Working dir: `$ProjectFileDir$`
  - Use classpath of module: `ugs-platform-app`

- There is a [runConfiguration](https://github.com/winder/Universal-G-Code-Sender/blob/master/.idea/runConfigurations/UGS_Platform.xml) in the repository, which should be available after importing the project