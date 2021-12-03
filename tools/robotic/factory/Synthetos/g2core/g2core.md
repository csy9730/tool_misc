# g2core

[https://github.com/synthetos/g2](https://github.com/synthetos/g2)

- 

[![g2core](https://raw.githubusercontent.com/wiki/synthetos/g2/images/g2core.png)](https://raw.githubusercontent.com/wiki/synthetos/g2/images/g2core.png)

[![Build Status](https://camo.githubusercontent.com/ebbb63db57acccddbf7fc4ca2387450dc617aa827bf37920d6ddb9fd07984df4/68747470733a2f2f7472617669732d63692e6f72672f73796e746865746f732f67322e7376673f6272616e63683d65646765)](https://travis-ci.org/synthetos/g2) [![Issues in Ready](https://camo.githubusercontent.com/d90f44b590e334002062c08efd47161d565254c84e23b0491aa6f19807975afe/68747470733a2f2f62616467652e776166666c652e696f2f73796e746865746f732f67322e7376673f6c6162656c3d7265616479267469746c653d5265616479)](http://waffle.io/synthetos/g2) [![Issues in Progress](https://camo.githubusercontent.com/d484abf88e937efcfea25e159293a9f6c4e4099695fcdf89d46607f863ec100f/68747470733a2f2f62616467652e776166666c652e696f2f73796e746865746f732f67322e7376673f6c6162656c3d696e25323070726f6772657373267469746c653d496e25323050726f6772657373)](http://waffle.io/synthetos/g2)

# What it is

g2core is a 9 axes (XYZABC+UVW) motion control system designed for high-performance on small to mid-sized machines.

- CNC
- 3D printing
- Laser cutting
- Robotics

Our default target is the [Arduino Due](https://store.arduino.cc/arduino-due), though it can also be used with other boards.

Some features:

- 9 axis motion (XYZABC+UVW).
  - **Note** - UVW is only in the `edge` branch for now.
- Jerk controlled motion for acceleration planning (3rd order motion planning)
- Status displays ('?' character)
- XON/XOFF and RTS/CTS protocol over USB serial
- RESTful interface using JSON

# Mailing List

For both user and developer discussions of g2core, we recently created a mailing list:

- <https://lists.links.org/mailman/listinfo/g2core>

Please feel welcome to join in. 😄

# g2core - Edge Branch

G2 [Edge](https://github.com/synthetos/g2/tree/edge) is the branch for beta testing new features under development. New features are developed in feature branches and merged into the edge branch. Periodically edge is promoted to (stable) master.

Edge is for the adventurous. It is not guaranteed to be stable, but we do our best to achieve this. For production uses we recommend using the [Master branch](https://github.com/synthetos/g2/tree/master).

## Firmware Build 101 `{fb:101.xx}`

### Feature Enhancements

New features added. See linked issues and pull requests for details

- Added [UVW axes](https://github.com/synthetos/g2/wiki/9-Axis-UVW-Operation) for 9 axis control. [See also: Issue 304](https://github.com/synthetos/g2/issues/304)
- Added [Enhanced Feedhold Functions](https://github.com/synthetos/g2/wiki/Feedhold,-Resume,-and-Other-Simple-Commands)
- Added explicit [Job Kill ^d](https://github.com/synthetos/g2/wiki/Feedhold,-Resume,-and-Other-Simple-Commands#job-kill) - has the effect of an M30 (program end)
- Documented [Communications Startup Tests](https://github.com/synthetos/g2/wiki/g2core-Communications#enqack---checking-for-clean-startup)

### Internal Changes and Bug Fixes

Many things have changed in the internals for this very large pull request. The following list highlights some of these changes but is not meant to be comprehensive.

- Added explicit typing and type testing to JSON variables.
- As part of the above, 32bit integers are not float casts, and therefore retain full accuracy. Line numbers may now reliably go to 2,000,000,000
- Movement towards getters and setters as initial stage of refactoring the Big Table :)
- Bugfix: Fixed root finding problem in feedhold exit velocity calculation
- Bugfix: fixed bug in B and C axis assignment in coordinate rotation code
- PR #334 A, B, C axes radius defaults to use motors 4, 5, & 6
- PR #336, Issue #336 partial solution to coolant initialization
- PR #299, Issue #298 fix for reading nested JSON value errors

## Feature Enhancements

### Firmware Build 101 `{fb:101.xx}`

The fb:101 release is a mostly internal change from the fb:100 branches. Here are the highlights, more detailed on each item are further below:

- Updated motion execution at the segment (smallest) level to be linear velocity instead of constant velocity, resulting in notably smoother motion and more faithful execution of the jerk limitations. (Incidentally, the sound of the motors is also slightly quieter and more "natural.")
- Updated JT (Junction integration Time, a.k.a. "cornering") handling to be more optimized, and to treat the last move as a corner to a move with no active axes. This allows a non-zero stopping velocity based on the allowed jerk and active JT value.
- Probing enhancements.
- Added support for gQuintic (rev B) and fixed issues with gQuadratic board support. (This mostly happened in Motate.)
- Temperature control enhancements
  - Temperature inputs are configured differently at compile time. (Ongoing.)
  - PID control has been adjusted to PID+FF (Proportional, Integral, and Derivative, with Feed Forward). In this case, the feed forward is a multiplier of the difference between the current temperature and the ambient temperature. Since there is no temperature sensor for ambient temperature at the moment, it uses an idealized room temperature of 21ºC.
- More complete support for TMC2130 by adding more JSON controls for live feedback and configuration.
- Initial support for Core XY kinematics.
- Boards are in more control of the planner settings.
- Experimental setting to have traverse (G0) use the 'high jerk' axis settings.
- Outputs are now configured at board initialization (and later) to honor the settings more faithfully. This includes setting the pin high or low as soon as possible.

### Firmware Build 100 `{fb:100.xx}`

The fb:100 release is a major change from the fb:089 and earlier branches. It represents about a year of development and has many major feature enhancements summarized below. These are described in more detail in the rest of this readme and the linked wiki pages.

- New Gcode and CNC features
- 3d printing support, including [Marlin Compatibility](https://github.com/synthetos/g2/wiki/Marlin-Compatibility)
- GPIO system enhancements
- Planner enhancements and other operating improvements for high-speed operation
- Initial support for new processors, including the ARM M7

### Project Changes

The project is now called g2core (even if the repo remains g2). As of this release the g2core code base is split from the TinyG code base. TinyG will continue to be supported for the Xmega 8-bit platform, and new features will be added, specifically as related to continued support for CNC milling applications. The g2core project will focus on various ARM platforms, as it currently does, and add functions that are not possible in the 8-bit platform.

In this release the Motate hardware abstraction layer has been split into a separate project and is included in g2core as a git submodule. This release also provides better support for cross platform / cross target compilation. A summary of project changes is provided below, with details in this readme and linked wiki pages.

- Motate submodule
- Cross platform / cross target support
- Multiple processor support - ARM M3, M4, M7 cores
- Device tree / multiple motor types
- Simplified host-to-board communication protocol (line mode)
- NodeJS host module for host-to-board communications

### More To Come

The fb:100 release is the base for number of other enhancements in the works and planned, including:

- Further enhancements to GPIO system
- Additional JSON processing and UI support
- Enhancements to 3d printer support, including a simplified g2 printer dialect

## Changelog for Edge Branch

### Edge branch, Build 101.xx

This build is primarily focused on support for the new boards based on the Atmel SamS70 family, as well as refining the motion control and long awaited feature enhancements. This list will be added to as development proceed.s

### Edge branch, Build 100.xx

Build 100.xx has a number of changes, mostly related to extending Gcode support and supporting 3D printing using g2core. These include temperature controls, auto-bed leveling, planner performance improvements and active JSON comments in Gcode.

Communications has advanced to support a linemode protocol to greatly simplify host communications and flow control for very rapid Gcode streams. Please read the Communications pages for details. Also see the NodeJS communications module docs if you are building a UI or host controller.

Build 100.xx also significantly advances the project structure to support multiple processor architectures, hardware configurations and machine configurations in the same code base. Motate has been cleaved off into its own subproject. We recommend carefully reading the Dev pages if you are coding or compiling.

#### Functional Changes:

*Note: Click the header next to the arrow to expand and display the details.*

<details style="box-sizing: border-box; display: block; margin-top: 0px; margin-bottom: 16px;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer;"><strong style="box-sizing: border-box; font-weight: 600;">Linear-Velocity Segment Execution</strong></summary></details>

<details style="box-sizing: border-box; display: block; margin-top: 0px; margin-bottom: 16px;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer;"><strong style="box-sizing: border-box; font-weight: 600;">Probing enhancements</strong></summary></details>

<details style="box-sizing: border-box; display: block; margin-top: 0px; margin-bottom: 16px;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer;"><strong style="box-sizing: border-box; font-weight: 600;">gQuintic support</strong></summary></details>

<details style="box-sizing: border-box; display: block; margin-top: 0px; margin-bottom: 16px;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer;"><strong style="box-sizing: border-box; font-weight: 600;">Temperature control enhancements</strong></summary></details>

<details style="box-sizing: border-box; display: block; margin-top: 0px; margin-bottom: 16px;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer;"><strong style="box-sizing: border-box; font-weight: 600;">TMC2130 JSON controls</strong></summary></details>

<details style="box-sizing: border-box; display: block; margin-top: 0px; margin-bottom: 16px;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer;"><strong style="box-sizing: border-box; font-weight: 600;">Core XY Kinematics Support</strong></summary></details>

<details style="box-sizing: border-box; display: block; margin-top: 0px; margin-bottom: 16px;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer;"><strong style="box-sizing: border-box; font-weight: 600;">Planner settings control from board files</strong></summary></details>

<details style="box-sizing: border-box; display: block; margin-top: 0px; margin-bottom: 16px;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer;"><strong style="box-sizing: border-box; font-weight: 600;">Experimental traverse at high jerk</strong></summary></details>

<details style="box-sizing: border-box; display: block; margin-top: 0px; margin-bottom: 16px;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer;"><strong style="box-sizing: border-box; font-weight: 600;">PID+FF - added feed forward</strong></summary></details>

<details open="" style="box-sizing: border-box; display: block; margin-top: 0px; margin-bottom: 0px !important;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer;"><strong style="box-sizing: border-box; font-weight: 600;">Output setting as soon as possible</strong></summary><ul dir="auto" style="box-sizing: border-box; padding-left: 2em; margin-top: 0px; margin-bottom: 16px;"><li style="box-sizing: border-box;">At board initialization, the output value on each of the<span>&nbsp;</span><code style="box-sizing: border-box; font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, &quot;Liberation Mono&quot;, monospace; font-size: 13.6px; padding: 0.2em 0.4em; margin: 0px; background-color: var(--color-neutral-muted); border-radius: 6px;">out</code><span>&nbsp;</span>objects is set to whatever the pin is configured to be "inactive." This is based on the settings file<span>&nbsp;</span><code style="box-sizing: border-box; font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, &quot;Liberation Mono&quot;, monospace; font-size: 13.6px; padding: 0.2em 0.4em; margin: 0px; background-color: var(--color-neutral-muted); border-radius: 6px;">DO</code><em style="box-sizing: border-box;">n</em><code style="box-sizing: border-box; font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, &quot;Liberation Mono&quot;, monospace; font-size: 13.6px; padding: 0.2em 0.4em; margin: 0px; background-color: var(--color-neutral-muted); border-radius: 6px;">_MODE</code><span>&nbsp;</span>setting.</li><li style="box-sizing: border-box; margin-top: 0.25em;">For example, if<span>&nbsp;</span><code style="box-sizing: border-box; font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, &quot;Liberation Mono&quot;, monospace; font-size: 13.6px; padding: 0.2em 0.4em; margin: 0px; background-color: var(--color-neutral-muted); border-radius: 6px;">DO10_MODE == IO_ACTIVE_LOW</code><span>&nbsp;</span>then the pin at<span>&nbsp;</span><code style="box-sizing: border-box; font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, &quot;Liberation Mono&quot;, monospace; font-size: 13.6px; padding: 0.2em 0.4em; margin: 0px; background-color: var(--color-neutral-muted); border-radius: 6px;">DO10</code><span>&nbsp;</span>is initialized as<span>&nbsp;</span><code style="box-sizing: border-box; font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, &quot;Liberation Mono&quot;, monospace; font-size: 13.6px; padding: 0.2em 0.4em; margin: 0px; background-color: var(--color-neutral-muted); border-radius: 6px;">HIGH</code><span>&nbsp;</span>at board setup. This happen even before the<span>&nbsp;</span><code style="box-sizing: border-box; font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, &quot;Liberation Mono&quot;, monospace; font-size: 13.6px; padding: 0.2em 0.4em; margin: 0px; background-color: var(--color-neutral-muted); border-radius: 6px;">main()</code><span>&nbsp;</span>function starts, shortly after the GPIO clocks are enabled for each port.</li></ul></details>

## About

g2core - The Next Generation

### Topics

[motion-planning](https://github.com/topics/motion-planning) [cnc](https://github.com/topics/cnc) [gcode](https://github.com/topics/gcode) [cnc-controller](https://github.com/topics/cnc-controller) [3d-printing](https://github.com/topics/3d-printing) [lasercutter](https://github.com/topics/lasercutter) [plasma-cutter](https://github.com/topics/plasma-cutter)

### Resources

[ Readme](https://github.com/synthetos/g2#readme)

### License

[ View license](https://github.com/synthetos/g2/blob/edge-preview/LICENSE)



## [Releases](https://github.com/synthetos/g2/releases)

 57 tags

## [Packages](https://github.com/orgs/synthetos/packages?repo_name=g2)

No packages published

## [Contributors 16](https://github.com/synthetos/g2/graphs/contributors)

- [![@aldenhart](https://avatars.githubusercontent.com/u/232833?v=4)](https://github.com/aldenhart)
- [![@giseburt](https://avatars.githubusercontent.com/u/386001?v=4)](https://github.com/giseburt)
- [![@ryansturmer](https://avatars.githubusercontent.com/u/1383181?v=4)](https://github.com/ryansturmer)
- [![@msxconsulting](https://avatars.githubusercontent.com/u/21286401?v=4)](https://github.com/msxconsulting)
- [![@ril3y](https://avatars.githubusercontent.com/u/231731?v=4)](https://github.com/ril3y)
- [![@justinclift](https://avatars.githubusercontent.com/u/406299?v=4)](https://github.com/justinclift)
- [![@benlaurie](https://avatars.githubusercontent.com/u/40044?v=4)](https://github.com/benlaurie)
- [![@lrepasi](https://avatars.githubusercontent.com/u/41768113?v=4)](https://github.com/lrepasi)
- [![@CrispyConductor](https://avatars.githubusercontent.com/u/2132722?v=4)](https://github.com/CrispyConductor)
- [![@krasin](https://avatars.githubusercontent.com/u/21159?v=4)](https://github.com/krasin)
- [![@ep1cman](https://avatars.githubusercontent.com/u/5303409?v=4)](https://github.com/ep1cman)

[+ 5 contributors](https://github.com/synthetos/g2/graphs/contributors)

## [Environments 1](https://github.com/synthetos/g2/deployments)

-  [github-pages ](https://github.com/synthetos/g2/deployments/activity_log?environment=github-pages)Active

## Languages



- [C++61.9%](https://github.com/synthetos/g2/search?l=c%2B%2B) 
- [C34.7%](https://github.com/synthetos/g2/search?l=c) 
- [Pascal1.8%](https://github.com/synthetos/g2/search?l=pascal) 
- [Python0.7%](https://github.com/synthetos/g2/search?l=python) 
- [Makefile0.6%](https://github.com/synthetos/g2/search?l=makefile) 
- [GDB0.2%](https://github.com/synthetos/g2/search?l=gdb) 
- [Shell0.1%](https://github.com/synthetos/g2/search?l=shell)

- © 2021 GitHub, Inc.
- [Terms](https://docs.github.com/en/github/site-policy/github-terms-of-service)
- [Privacy](https://docs.github.com/en/github/site-policy/github-privacy-statement)
- [Security](https://github.com/security)
- [Status](https://www.githubstatus.com/)
- [Docs](https://docs.github.com/)



- [Contact GitHub](https://support.github.com/?tags=dotcom-footer)
- [Pricing](https://github.com/pricing)
- [API](https://docs.github.com/)
- [Training](https://services.github.com/)
- [Blog](https://github.blog/)
- [About](https://github.com/about)