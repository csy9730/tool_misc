# ompl

[https://ompl.kavrakilab.org/](https://ompl.kavrakilab.org/)

The Open Motion Planning Library


Constrained Motion Planning
OMPL supports planning for kinematically constrained robots. This parallel manipulator (included as a demo program) has over 150 degrees of freedom, but feasible motions can still be computed in seconds.

Previous Next
OMPL, the Open Motion Planning Library, consists of many state-of-the-art sampling-based motion planning algorithms. OMPL itself does not contain any code related to, e.g., collision checking or visualization. This is a deliberate design choice, so that OMPL is not tied to a particular collision checker or visualization front end. The library is designed so it can be easily integrated into systems that provide the additional needed components.

OMPL.app, the front-end for OMPL, contains a lightweight wrapper for the FCL and PQP collision checkers and a simple GUI based on PyQt / PySide. The graphical front-end can be used for planning motions for rigid bodies and a few vehicle types (first-order and second-order cars, a blimp, and a quadrotor). It relies on the Assimp library to import a large variety of mesh formats that can be used to represent the robot and its environment.



git clone https://github.com/ompl/ompl.git

[https://ompl.kavrakilab.org/download.html](https://ompl.kavrakilab.org/download.html)