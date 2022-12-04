# pm
**pm命令:**

pm全称package manager，你能使用pm命令去模拟android行为或者查询设备上的应用等，当你在adb shell命令下执行pm命令：

pm <command>
你也可以在adb shell前执行pm命令：
`adb shell pm uninstall com.example.MyApp`
关于一些pm命令的介绍：
list packages [options] <FILTER> ：打印所有包，选择性的查询包列表。

参数选项：-f：查看关联文件，即应用apk的位置跟对应的包名（如：package:/system/app /MusicPlayer.apk=com.sec.android.app.music）；

​       -d：查看disabled packages；

​       -e：查看enable package；

​       -s：查看系统package；

​       -3：查看第三方package；

​       -i：查看package的对应安装者（如：1、 package:com.tencent.qqmusic installer=null 2、package:com.tencent.qqpim installer=com.android.vending）；

​      -u：查看曾被卸载过的package。（卸载后又重新安装依然会被列 入）；

​      --user<USER_ID>：The user space to query。
```
list permission-groups ：打印所有已知的权限群组。

list permissions [options] <GROUP> ：选择性的打印权限。参数选项：

 

list features ：设备特性。硬件之类的性能。

list libraries ：当前设备支持的libs。

list users ：系统上所有的users。（上面提到的USER_ID查询方式，如：UserInfo{0:Primary:3}那么USER_ID为0）

path <PACKAGE> ：查询package的安装位置。

install [options] <PATH> ：安装命令。

uninstall [options] <PACKAGE> ：卸载命令。

clear <PACKAGE> ：对指定的package删除所有数据。

enable <PACKAGE_OR_COMPONENT> ：使package或component可用。（如：pm enable "package/class"）

disable <PACKAGE_OR_COMPONENT> ：使package或component不可用。（如：pm disable "package/class"）

disable-user [options] <PACKAGE_OR_COMPONENT> ：参数选项：--user <USER_ID>: The user to disable.
grant <PACKAGE_PERMISSION> ：授权给应用。

revoke <PACKAGE_PERMISSION> ：撤销权限。

set-install-location <LOCATION> ：设置默认的安装位置。其中0：让系统自动选择最佳的安装位置。1：安装到内部的设备存储空间。2：安装到外部的设备存储空间。（这只用于调试应用程序， 使用该命令可能导致应用程序退出或者其他不适的后果）。

get-install-location ：返回当前的安装位置。返回结果同上参数选项。

set-permission-enforced <PERMISSION> [true|false] ：使指定权限生效或者失效。

create-user <USER_NAME> ：增加一个新的USER。

remove-user <USER_ID> ：删除一个USER。

get-max-users ：该设备所支持的最大USER数。（某些设备不支持该命令）
```
分类: [appium](https://www.cnblogs.com/wangcp-2014/category/855741.html)

标签: [adb](https://www.cnblogs.com/wangcp-2014/tag/adb/)


## misc

```
rubens:/ $ pm
Package manager (package) commands:
  help
    Print this help text.

  path [--user USER_ID] PACKAGE
    Print the path to the .apk of the given PACKAGE.

  dump PACKAGE
    Print various system state associated with the given PACKAGE.

  has-feature FEATURE_NAME [version]
    Prints true and returns exit status 0 when system has a FEATURE_NAME,
    otherwise prints false and returns exit status 1

  list features
    Prints all features of the system.

  list instrumentation [-f] [TARGET-PACKAGE]
    Prints all test packages; optionally only those targeting TARGET-PACKAGE
    Options:
      -f: dump the name of the .apk file containing the test package

  list libraries
    Prints all system libraries.

  list packages [-f] [-d] [-e] [-s] [-3] [-i] [-l] [-u] [-U]
      [--show-versioncode] [--apex-only] [--uid UID] [--user USER_ID] [FILTER]
    Prints all packages; optionally only those whose name contains
    the text in FILTER.  Options are:
      -f: see their associated file
      -a: all known packages (but excluding APEXes)
      -d: filter to only show disabled packages
      -e: filter to only show enabled packages
      -s: filter to only show system packages
      -3: filter to only show third party packages
      -i: see the installer for the packages
      -l: ignored (used for compatibility with older releases)
      -U: also show the package UID
      -u: also include uninstalled packages
      --show-versioncode: also show the version code
      --apex-only: only show APEX packages
      --uid UID: filter to only show packages with the given UID
      --user USER_ID: only list packages belonging to the given user

  list permission-groups
    Prints all known permission groups.

  list permissions [-g] [-f] [-d] [-u] [GROUP]
    Prints all known permissions; optionally only those in GROUP.  Options are:
      -g: organize by group
      -f: print all information
      -s: short summary
      -d: only list dangerous permissions
      -u: list only the permissions users will see

  list staged-sessions [--only-ready] [--only-sessionid] [--only-parent]
    Prints all staged sessions.
      --only-ready: show only staged sessions that are ready
      --only-sessionid: show only sessionId of each session
      --only-parent: hide all children sessions

  list users
    Prints all users.

  resolve-activity [--brief] [--components] [--query-flags FLAGS]
       [--user USER_ID] INTENT
    Prints the activity that resolves to the given INTENT.

  query-activities [--brief] [--components] [--query-flags FLAGS]
       [--user USER_ID] INTENT
    Prints all activities that can handle the given INTENT.

  query-services [--brief] [--components] [--query-flags FLAGS]
       [--user USER_ID] INTENT
    Prints all services that can handle the given INTENT.

  query-receivers [--brief] [--components] [--query-flags FLAGS]
       [--user USER_ID] INTENT
    Prints all broadcast receivers that can handle the given INTENT.

  install [-rtfdgw] [-i PACKAGE] [--user USER_ID|all|current]
       [-p INHERIT_PACKAGE] [--install-location 0/1/2]
       [--install-reason 0/1/2/3/4] [--originating-uri URI]
       [--referrer URI] [--abi ABI_NAME] [--force-sdk]
       [--preload] [--instant] [--full] [--dont-kill]
       [--enable-rollback]
       [--force-uuid internal|UUID] [--pkg PACKAGE] [-S BYTES]
       [--apex] [--staged-ready-timeout TIMEOUT]
       [PATH [SPLIT...]|-]
    Install an application.  Must provide the apk data to install, either as
    file path(s) or '-' to read from stdin.  Options are:
      -R: disallow replacement of existing application
      -t: allow test packages
      -i: specify package name of installer owning the app
      -f: install application on internal flash
      -d: allow version code downgrade (debuggable packages only)
      -p: partial application install (new split on top of existing pkg)
      -g: grant all runtime permissions
      -S: size in bytes of package, required for stdin
      --user: install under the given user.
      --dont-kill: installing a new feature split, don't kill running app
      --restrict-permissions: don't whitelist restricted permissions at install
      --originating-uri: set URI where app was downloaded from
      --referrer: set URI that instigated the install of the app
      --pkg: specify expected package name of app being installed
      --abi: override the default ABI of the platform
      --instant: cause the app to be installed as an ephemeral install app
      --full: cause the app to be installed as a non-ephemeral full app
      --install-location: force the install location:
          0=auto, 1=internal only, 2=prefer external
      --install-reason: indicates why the app is being installed:
          0=unknown, 1=admin policy, 2=device restore,
          3=device setup, 4=user request
      --force-uuid: force install on to disk volume with given UUID
      --apex: install an .apex file, not an .apk
      --staged-ready-timeout: By default, staged sessions wait 60000
          milliseconds for pre-reboot verification to complete when
          performing staged install. This flag is used to alter the waiting
          time. You can skip the waiting time by specifying a TIMEOUT of '0'

  install-existing [--user USER_ID|all|current]
       [--instant] [--full] [--wait] [--restrict-permissions] PACKAGE
    Installs an existing application for a new user.  Options are:
      --user: install for the given user.
      --instant: install as an instant app
      --full: install as a full app
      --wait: wait until the package is installed
      --restrict-permissions: don't whitelist restricted permissions

  install-create [-lrtsfdg] [-i PACKAGE] [--user USER_ID|all|current]
       [-p INHERIT_PACKAGE] [--install-location 0/1/2]
       [--install-reason 0/1/2/3/4] [--originating-uri URI]
       [--referrer URI] [--abi ABI_NAME] [--force-sdk]
       [--preload] [--instant] [--full] [--dont-kill]
       [--force-uuid internal|UUID] [--pkg PACKAGE] [--apex] [-S BYTES]
       [--multi-package] [--staged]
    Like "install", but starts an install session.  Use "install-write"
    to push data into the session, and "install-commit" to finish.

  install-write [-S BYTES] SESSION_ID SPLIT_NAME [PATH|-]
    Write an apk into the given install session.  If the path is '-', data
    will be read from stdin.  Options are:
      -S: size in bytes of package, required for stdin

  install-remove SESSION_ID SPLIT...
    Mark SPLIT(s) as removed in the given install session.

  install-add-session MULTI_PACKAGE_SESSION_ID CHILD_SESSION_IDs
    Add one or more session IDs to a multi-package session.

  install-commit SESSION_ID
    Commit the given active install session, installing the app.

  install-abandon SESSION_ID
    Delete the given active install session.

  set-install-location LOCATION
    Changes the default install location.  NOTE this is only intended for debugging;
    using this can cause applications to break and other undersireable behavior.
    LOCATION is one of:
    0 [auto]: Let system decide the best location
    1 [internal]: Install on internal device storage
    2 [external]: Install on external media

  get-install-location
    Returns the current install location: 0, 1 or 2 as per set-install-location.

  move-package PACKAGE [internal|UUID]

  move-primary-storage [internal|UUID]

  uninstall [-k] [--user USER_ID] [--versionCode VERSION_CODE]
       PACKAGE [SPLIT...]
    Remove the given package name from the system.  May remove an entire app
    if no SPLIT names specified, otherwise will remove only the splits of the
    given app.  Options are:
      -k: keep the data and cache directories around after package removal.
      --user: remove the app from the given user.
      --versionCode: only uninstall if the app has the given version code.

  clear [--user USER_ID] PACKAGE
    Deletes all data associated with a package.

  enable [--user USER_ID] PACKAGE_OR_COMPONENT
  disable [--user USER_ID] PACKAGE_OR_COMPONENT
  disable-user [--user USER_ID] PACKAGE_OR_COMPONENT
  disable-until-used [--user USER_ID] PACKAGE_OR_COMPONENT
  default-state [--user USER_ID] PACKAGE_OR_COMPONENT
    These commands change the enabled state of a given package or
    component (written as "package/class").

  hide [--user USER_ID] PACKAGE_OR_COMPONENT
  unhide [--user USER_ID] PACKAGE_OR_COMPONENT

  suspend [--user USER_ID] PACKAGE [PACKAGE...]
    Suspends the specified package(s) (as user).

  unsuspend [--user USER_ID] PACKAGE [PACKAGE...]
    Unsuspends the specified package(s) (as user).

  set-distracting-restriction [--user USER_ID] [--flag FLAG ...]
      PACKAGE [PACKAGE...]
    Sets the specified restriction flags to given package(s) (for user).
    Flags are:
      hide-notifications: Hides notifications from this package
      hide-from-suggestions: Hides this package from suggestions
        (by the launcher, etc.)
    Any existing flags are overwritten, which also means that if no flags are
    specified then all existing flags will be cleared.

  grant [--user USER_ID] PACKAGE PERMISSION
  revoke [--user USER_ID] PACKAGE PERMISSION
    These commands either grant or revoke permissions to apps.  The permissions
    must be declared as used in the app's manifest, be runtime permissions
    (protection level dangerous), and the app targeting SDK greater than Lollipop MR1.

  reset-permissions
    Revert all runtime permissions to their default state.

  set-permission-enforced PERMISSION [true|false]

  get-privapp-permissions TARGET-PACKAGE
    Prints all privileged permissions for a package.

  get-privapp-deny-permissions TARGET-PACKAGE
    Prints all privileged permissions that are denied for a package.

  get-oem-permissions TARGET-PACKAGE
    Prints all OEM permissions for a package.

  trim-caches DESIRED_FREE_SPACE [internal|UUID]
    Trim cache files to reach the given free space.

  list users
    Lists the current users.

  create-user [--profileOf USER_ID] [--managed] [--restricted] [--ephemeral]
      [--guest] [--pre-create-only] [--user-type USER_TYPE] USER_NAME
    Create a new user with the given USER_NAME, printing the new user identifier
    of the user.
    USER_TYPE is the name of a user type, e.g. android.os.usertype.profile.MANAGED.
      If not specified, the default user type is android.os.usertype.full.SECONDARY.
      --managed is shorthand for '--user-type android.os.usertype.profile.MANAGED'.
      --restricted is shorthand for '--user-type android.os.usertype.full.RESTRICTED'.
      --guest is shorthand for '--user-type android.os.usertype.full.GUEST'.

  remove-user [--set-ephemeral-if-in-use] USER_ID
    Remove the user with the given USER_IDENTIFIER, deleting all data
    associated with that user.
      --set-ephemeral-if-in-use: If the user is currently running and
        therefore cannot be removed immediately, mark the user as ephemeral
        so that it will be automatically removed when possible (after user
        switch or reboot)

  set-user-restriction [--user USER_ID] RESTRICTION VALUE

  get-max-users

  get-max-running-users

  compile [-m MODE | -r REASON] [-f] [-c] [--split SPLIT_NAME]
          [--reset] [--check-prof (true | false)] (-a | TARGET-PACKAGE)
    Trigger compilation of TARGET-PACKAGE or all packages if "-a".  Options are:
      -a: compile all packages
      -c: clear profile data before compiling
      -f: force compilation even if not needed
      -m: select compilation mode
          MODE is one of the dex2oat compiler filters:
            assume-verified
            extract
            verify
            quicken
            space-profile
            space
            speed-profile
            speed
            everything
      -r: select compilation reason
          REASON is one of:
            first-boot
            boot-after-ota
            post-boot
            install
            install-fast
            install-bulk
            install-bulk-secondary
            install-bulk-downgraded
            install-bulk-secondary-downgraded
            bg-dexopt
            ab-ota
            inactive
            cmdline
            shared
            first-use
      --reset: restore package to its post-install state
      --check-prof (true | false): look at profiles when doing dexopt?
      --secondary-dex: compile app secondary dex files
      --split SPLIT: compile only the given split name
      --compile-layouts: compile layout resources for faster inflation

  force-dex-opt PACKAGE
    Force immediate execution of dex opt for the given PACKAGE.

  bg-dexopt-job
    Execute the background optimizations immediately.
    Note that the command only runs the background optimizer logic. It may
    overlap with the actual job but the job scheduler will not be able to
    cancel it. It will also run even if the device is not in the idle
    maintenance mode.

  reconcile-secondary-dex-files TARGET-PACKAGE
    Reconciles the package secondary dex files with the generated oat files.

  dump-profiles TARGET-PACKAGE
    Dumps method/class profile files to
    /data/misc/profman/TARGET-PACKAGE.txt

  snapshot-profile TARGET-PACKAGE [--code-path path]
    Take a snapshot of the package profiles to
    /data/misc/profman/TARGET-PACKAGE[-code-path].prof
    If TARGET-PACKAGE=android it will take a snapshot of the boot image

  set-home-activity [--user USER_ID] TARGET-COMPONENT
    Set the default home activity (aka launcher).
    TARGET-COMPONENT can be a package name (com.package.my) or a full
    component (com.package.my/component.name). However, only the package name
    matters: the actual component used will be determined automatically from
    the package.

  set-installer PACKAGE INSTALLER
    Set installer package name

  get-instantapp-resolver
    Return the name of the component that is the current instant app installer.

  set-harmful-app-warning [--user <USER_ID>] <PACKAGE> [<WARNING>]
    Mark the app as harmful with the given warning message.

  get-harmful-app-warning [--user <USER_ID>] <PACKAGE>
    Return the harmful app warning message for the given app, if present

  uninstall-system-updates [<PACKAGE>]
    Removes updates to the given system application and falls back to its
    /system version. Does nothing if the given package is not a system app.
    If no package is specified, removes updates to all system applications.

  get-moduleinfo [--all | --installed] [module-name]
    Displays module info. If module-name is specified only that info is shown
    By default, without any argument only installed modules are shown.
      --all: show all module info
      --installed: show only installed modules

  log-visibility [--enable|--disable] <PACKAGE>
    Turns on debug logging when visibility is blocked for the given package.
      --enable: turn on debug logging (default)
      --disable: turn off debug logging

  set-silent-updates-policy [--allow-unlimited-silent-updates <INSTALLER>]
                            [--throttle-time <SECONDS>] [--reset]
    Sets the policies of the silent updates.
      --allow-unlimited-silent-updates: allows unlimited silent updated
        installation requests from the installer without the throttle time.
      --throttle-time: update the silent updates throttle time in seconds.
      --reset: restore the installer and throttle time to the default, and
        clear tracks of silent updates in the system.

  get-app-links [--user <USER_ID>] [<PACKAGE>]
    Prints the domain verification state for the given package, or for all
    packages if none is specified. State codes are defined as follows:
        - none: nothing has been recorded for this domain
        - verified: the domain has been successfully verified
        - approved: force approved, usually through shell
        - denied: force denied, usually through shell
        - migrated: preserved verification from a legacy response
        - restored: preserved verification from a user data restore
        - legacy_failure: rejected by a legacy verifier, unknown reason
        - system_configured: automatically approved by the device config
        - >= 1024: Custom error code which is specific to the device verifier
      --user <USER_ID>: include user selections (includes all domains, not
        just autoVerify ones)
  reset-app-links [--user <USER_ID>] [<PACKAGE>]
    Resets domain verification state for the given package, or for all
    packages if none is specified.
      --user <USER_ID>: clear user selection state instead; note this means
        domain verification state will NOT be cleared
      <PACKAGE>: the package to reset, or "all" to reset all packages
  verify-app-links [--re-verify] [<PACKAGE>]
    Broadcasts a verification request for the given package, or for all
    packages if none is specified. Only sends if the package has previously
    not recorded a response.
      --re-verify: send even if the package has recorded a response
  set-app-links [--package <PACKAGE>] <STATE> <DOMAINS>...
    Manually set the state of a domain for a package. The domain must be
    declared by the package as autoVerify for this to work. This command
    will not report a failure for domains that could not be applied.
      --package <PACKAGE>: the package to set, or "all" to set all packages
      <STATE>: the code to set the domains to, valid values are:
        STATE_NO_RESPONSE (0): reset as if no response was ever recorded.
        STATE_SUCCESS (1): treat domain as successfully verified by domain.
          verification agent. Note that the domain verification agent can
          override this.
        STATE_APPROVED (2): treat domain as always approved, preventing the
           domain verification agent from changing it.
        STATE_DENIED (3): treat domain as always denied, preveting the domain
          verification agent from changing it.
      <DOMAINS>: space separated list of domains to change, or "all" to
        change every domain.
  set-app-links-user-selection --user <USER_ID> [--package <PACKAGE>]
      <ENABLED> <DOMAINS>...
    Manually set the state of a host user selection for a package. The domain
    must be declared by the package for this to work. This command will not
    report a failure for domains that could not be applied.
      --user <USER_ID>: the user to change selections for
      --package <PACKAGE>: the package to set
      <ENABLED>: whether or not to approve the domain
      <DOMAINS>: space separated list of domains to change, or "all" to
        change every domain.
  set-app-links-allowed --user <USER_ID> [--package <PACKAGE>] <ALLOWED>
      <ENABLED> <DOMAINS>...
    Toggle the auto verified link handling setting for a package.
      --user <USER_ID>: the user to change selections for
      --package <PACKAGE>: the package to set, or "all" to set all packages
        packages will be reset if no one package is specified.
      <ALLOWED>: true to allow the package to open auto verified links, false
        to disable
  get-app-link-owners [--user <USER_ID>] [--package <PACKAGE>] [<DOMAINS>]
    Print the owners for a specific domain for a given user in low to high
    priority order.
      --user <USER_ID>: the user to query for
      --package <PACKAGE>: optionally also print for all web domains declared
        by a package, or "all" to print all packages
      --<DOMAINS>: space separated list of domains to query for

<INTENT> specifications include these flags and arguments:
    [-a <ACTION>] [-d <DATA_URI>] [-t <MIME_TYPE>] [-i <IDENTIFIER>]
    [-c <CATEGORY> [-c <CATEGORY>] ...]
    [-n <COMPONENT_NAME>]
    [-e|--es <EXTRA_KEY> <EXTRA_STRING_VALUE> ...]
    [--esn <EXTRA_KEY> ...]
    [--ez <EXTRA_KEY> <EXTRA_BOOLEAN_VALUE> ...]
    [--ei <EXTRA_KEY> <EXTRA_INT_VALUE> ...]
    [--el <EXTRA_KEY> <EXTRA_LONG_VALUE> ...]
    [--ef <EXTRA_KEY> <EXTRA_FLOAT_VALUE> ...]
    [--eu <EXTRA_KEY> <EXTRA_URI_VALUE> ...]
    [--ecn <EXTRA_KEY> <EXTRA_COMPONENT_NAME_VALUE>]
    [--eia <EXTRA_KEY> <EXTRA_INT_VALUE>[,<EXTRA_INT_VALUE...]]
        (mutiple extras passed as Integer[])
    [--eial <EXTRA_KEY> <EXTRA_INT_VALUE>[,<EXTRA_INT_VALUE...]]
        (mutiple extras passed as List<Integer>)
    [--ela <EXTRA_KEY> <EXTRA_LONG_VALUE>[,<EXTRA_LONG_VALUE...]]
        (mutiple extras passed as Long[])
    [--elal <EXTRA_KEY> <EXTRA_LONG_VALUE>[,<EXTRA_LONG_VALUE...]]
        (mutiple extras passed as List<Long>)
    [--efa <EXTRA_KEY> <EXTRA_FLOAT_VALUE>[,<EXTRA_FLOAT_VALUE...]]
        (mutiple extras passed as Float[])
    [--efal <EXTRA_KEY> <EXTRA_FLOAT_VALUE>[,<EXTRA_FLOAT_VALUE...]]
        (mutiple extras passed as List<Float>)
    [--esa <EXTRA_KEY> <EXTRA_STRING_VALUE>[,<EXTRA_STRING_VALUE...]]
        (mutiple extras passed as String[]; to embed a comma into a string,
         escape it using "\,")
    [--esal <EXTRA_KEY> <EXTRA_STRING_VALUE>[,<EXTRA_STRING_VALUE...]]
        (mutiple extras passed as List<String>; to embed a comma into a string,
         escape it using "\,")
    [-f <FLAG>]
    [--grant-read-uri-permission] [--grant-write-uri-permission]
    [--grant-persistable-uri-permission] [--grant-prefix-uri-permission]
    [--debug-log-resolution] [--exclude-stopped-packages]
    [--include-stopped-packages]
    [--activity-brought-to-front] [--activity-clear-top]
    [--activity-clear-when-task-reset] [--activity-exclude-from-recents]
    [--activity-launched-from-history] [--activity-multiple-task]
    [--activity-no-animation] [--activity-no-history]
    [--activity-no-user-action] [--activity-previous-is-top]
    [--activity-reorder-to-front] [--activity-reset-task-if-needed]
    [--activity-single-top] [--activity-clear-task]
    [--activity-task-on-home] [--activity-match-external]
    [--receiver-registered-only] [--receiver-replace-pending]
    [--receiver-foreground] [--receiver-no-abort]
    [--receiver-include-background]
    [--selector]
    [<URI> | <PACKAGE> | <COMPONENT>]


```