# pthread-win32

[pthread-win32](https://sourceware.org/pthreads-win32/)

## What is this project about?

The [POSIX 1003.1-2001](http://www.unix-systems.org/version3/ieee_std.html) standard defines an application programming interface (API) for writing multithreaded applications. This interface is known more commonly as *pthreads*. A good number of modern operating systems include a threading library of some kind: Solaris (UI) threads, Win32 threads, DCE threads, DECthreads, or any of the draft revisions of the pthreads standard. The trend is that most of these systems are slowly adopting the pthreads standard API, with application developers following suit to reduce porting woes.

Win32 does not, and is unlikely to ever, support pthreads natively. This project seeks to provide a freely available and high-quality solution to this problem.

Various individuals have been working on independent implementations of this well-documented and standardised threading API, but most of them never see the light of day. The tendency is for people to only implement what they personally need, and that usually does not help others. This project attempts to consolidate these implementations into one implementation of pthreads for Win32.

## **License**

This implementation is [free software](http://www.gnu.org/), distributed under the [GNU Lesser General Public License](https://sourceware.org/pthreads-win32/copying.html) (LGPL).