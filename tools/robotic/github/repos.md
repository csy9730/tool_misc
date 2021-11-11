# github repos

### ROS
[ROS](https://github.com/ros2/ros2)

### openPLC
[https://github.com/thiagoralves/OpenPLC_v3.git](https://github.com/thiagoralves/OpenPLC_v3.git)

[https://www.openplcproject.com/](https://www.openplcproject.com/)

### moveit
[moveit](https://moveit.ros.org/)


### octomap
[https://github.com/OctoMap/octomap](https://github.com/OctoMap/octomap)

> OctoMap - An Efficient Probabilistic 3D Mapping Framework Based on Octrees.

[http://octomap.github.io](http://octomap.github.io/)

Originally developed by Kai M. Wurm and Armin Hornung, University of Freiburg, Copyright (C) 2009-2014. Currently maintained by [Armin Hornung](https://github.com/ahornung). See the [list of contributors](https://github.com/OctoMap/octomap/blob/devel/octomap/AUTHORS.txt) for further authors.

License:

- octomap: [New BSD License](https://github.com/OctoMap/octomap/blob/devel/octomap/LICENSE.txt)
- octovis and related libraries: [GPL](https://github.com/OctoMap/octomap/blob/devel/octovis/LICENSE.txt)

Download the latest releases: <https://github.com/octomap/octomap/releases>

API documentation: <https://octomap.github.io/octomap/doc/>

Build status: [![Build Status](https://camo.githubusercontent.com/8d8f8a2262b438dd531fe63e116b861cc3f3c78d48badf0f38310a14eb5faa55/68747470733a2f2f7472617669732d63692e6f72672f4f63746f4d61702f6f63746f6d61702e706e673f6272616e63683d646576656c)](https://travis-ci.org/OctoMap/octomap)

Report bugs and request features in our tracker: <https://github.com/OctoMap/octomap/issues>

A list of changes is available in the [octomap changelog](https://github.com/OctoMap/octomap/blob/devel/octomap/CHANGELOG.txt)

#### OVERVIEW

OctoMap consists of two separate libraries each in its own subfolder: **octomap**, the actual library, and **octovis**, our visualization libraries and tools. This README provides an overview of both, for details on compiling each please see [octomap/README.md](https://github.com/OctoMap/octomap/blob/devel/octomap/README.md) and [octovis/README.md](https://github.com/OctoMap/octomap/blob/devel/octovis/README.md) respectively. See <http://www.ros.org/wiki/octomap> and <http://www.ros.org/wiki/octovis> if you want to use OctoMap in ROS; there are pre-compiled packages available.

You can build each library separately with CMake by running it from the subdirectories, or build octomap and octovis together from this top-level directory. E.g., to only compile the library, run:

```
cd octomap
mkdir build
cd build
cmake ..
make
```

To compile the complete package, run:

```
cd build
cmake ..
make
```

Binaries and libs will end up in the directories `bin` and `lib` of the top-level directory where you started the build.

See [octomap README](https://github.com/OctoMap/octomap/blob/devel/octomap/README.md) and [octovis README](https://github.com/OctoMap/octomap/blob/devel/octovis/README.md) for further details and hints on compiling, especially under Windows.

### sbpl
[https://github.com/sbpl/sbpl](https://github.com/sbpl/sbpl)

[http://www.sbpl.net/](http://www.sbpl.net/)

Search-based Planning Laboratory researches methodologies and algorithms that enable autonomous systems to act fast, intelligently and robustly. Our research concentrates mostly on developing novel planning approaches, coming up with novel heuristic searches and investigating how planning can be combined with machine learning. Our work spans graph theory, algorithms, data structures, machine learning and of course robotics. We use our algorithms to build real-time planners for complex robotic systems operating in real world and performing challenging tasks ranging from autonomous navigation and autonomous flight to multi-agent systems and to full-body mobile manipulation.

In a bit more details, we study such problems as high-dimensional motion planning, task planning, planning under uncertainty and multi-agent planning.  Our goal is to develop planners that work in real-time and deal with complex real-world environments. We are also actively pursuing planning approaches that "learn from experience". In all of our work, we strive to develop methods that come with rigorous analytical guarantees on performance such as completeness and bounds on sub-optimality. Such guarantees help dramatically users to analyze and anticipate the behavior of autonomous systems which is crucial for safe autonomy alongside people. The lab is home to several robots including PR2 robot, segbot robot, hexarotor aerial vehicle, quadrotor aerial vehicles and few other smaller aerial vehicles.  In addition, we build planners for a number of large-scale robotic systems such as humanoid robots and full-scale helicopter.

### ompl
[https://github.com/ompl/ompl](https://github.com/ompl/ompl)

[http://ompl.kavrakilab.org/](http://ompl.kavrakilab.org/)
The Open Motion Planning Library (OMPL)


**OMPL**, the Open Motion Planning Library, consists of many state-of-the-art sampling-based motion planning algorithms. OMPL itself does not contain any code related to, e.g., collision checking or visualization. This is a deliberate design choice, so that OMPL is not tied to a particular collision checker or visualization front end. The library is designed so it can be easily integrated into [systems that provide the additional needed components](http://ompl.kavrakilab.org/integration.html).

**OMPL.app**, the front-end for [OMPL](http://ompl.kavrakilab.org/core), contains a lightweight wrapper for the [FCL](https://github.com/flexible-collision-library/fcl) and [PQP](http://gamma.cs.unc.edu/SSV) collision checkers and a simple GUI based on [PyQt](http://www.riverbankcomputing.co.uk/software/pyqt/intro) / [PySide](https://wiki.qt.io/Qt_for_Python). The graphical front-end can be used for planning motions for rigid bodies and a few vehicle types (first-order and second-order cars, a blimp, and a quadrotor). It relies on the [Assimp](http://assimp.org/) library to import a large variety of mesh formats that can be used to represent the robot and its environment.

### ODE
[http://www.ode.org/](http://www.ode.org/)

ODE is an open source, high performance library for simulating rigid body dynamics. It is fully featured, stable, mature and platform independent with an easy to use C/C++ API. It has advanced joint types and integrated collision detection with friction. ODE is useful for simulating vehicles, objects in virtual reality environments and virtual creatures. It is currently used in many computer games, 3D authoring tools and simulation tools.

[Get the source code from BitBucket](https://bitbucket.org/odedevs/ode/).

The [ODE wiki](http://ode.org/wiki/) is the main documentation for ODE.

[Here is the mailing list for ODE](https://groups.google.com/forum/#!forum/ode-users). Please post all ODE related questions and comments to this list, not to author's personal email accounts. Archives of the mailing list prior to 12/12/2007 are [stored here](http://ode.org/old_list_archives/).
### FCL

[https://github.com/flexible-collision-library/fcl](https://github.com/flexible-collision-library/fcl)

FCL is a library for performing three types of proximity queries on a pair of geometric models composed of triangles.

- Collision detection: detecting whether the two models overlap, and optionally, all of the triangles that overlap.
- Distance computation: computing the minimum distance between a pair of models, i.e., the distance between the closest pair of points.
- Tolerance verification: determining whether two models are closer or farther than a tolerance distance.
- Continuous collision detection: detecting whether the two moving models overlap during the movement, and optionally, the time of contact.
- Contact information: for collision detection and continuous collision detection, the contact information (including contact normals and contact points) can be returned optionally.

FCL has the following features

- C++ interface
- Compilable for either linux or win32 (both makefiles and Microsoft Visual projects can be generated using cmake)
- No special topological constraints or adjacency information required for input models – all that is necessary is a list of the model's triangles
- Supported different object shapes:

- box
- sphere
- ellipsoid
- capsule
- cone
- cylinder
- convex
- half-space
- plane
- mesh
- octree (optional, octrees are represented using the octomap library [http://octomap.github.com](http://octomap.github.com/))

### libccd
[libccd](https://github.com/danfis/libccd)

libccd is library for a collision detection between two convex shapes. libccd implements variation on **Gilbert–Johnson–Keerthi algorithm** plus **Expand Polytope Algorithm** (EPA) and also implements algorithm **Minkowski Portal Refinement** (MPR, a.k.a. XenoCollide) as described in Game Programming Gems 7.

libccd is the only available open source library of my knowledge that include MPR algorithm working in 3-D space. However, there is a library called mpr2d, implemented in D programming language, that works in 2-D space.

libccd is currently part of:

[ODE](http://www.ode.org/) library (see ODE's ./configure --help how to enable it),
FCL library from Willow Garage,
Bullet3 library (https://github.com/bulletphysics/bullet3).

For implementation details on GJK algorithm, see http://www.win.tue.nl/~gino/solid/jgt98convex.pdf.

### linuxCNC
[https://github.com/LinuxCNC/linuxcnc]([https://github.com/LinuxCNC/linuxcnc])

### TinyG
TinyG项目是一个多轴运动控制系统，它面向数控加工中心和其它需要高精度运动控制的应用场景。TinyG是一个针对中小型功率电机控制的嵌入式解决方案。
### marlin
### Smoothieware
### Orocos
个开源的机器人控制程序开发软件
## misc



OpenRTM
ORCA ？
Beremiz衍生出了一些软件控制方案，例如OpenPLC、KOSMOS

