import os


template = """.. git documentation master file, created by
   sphinx-quickstart on Sun Sep 13 21:16:26 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to git's documentation!
===============================

.. toctree::
   :maxdepth: 1
   :caption: 基础:
   :numbered:

   base/eGit.md
   base/git汇总.md


.. toctree::
   :maxdepth: 1
   :caption: 主要内容:
   :numbered:

   main/Git Reset 三种模式.md
   main/git命令.md
   main/commit/reflog.md
   main/config/eConfig.md
   main/config/gitConfigLf.md
   main/ePatch/gitPatch.md
   main/gitignore/gitignore.md
   main/gitLog统计/gitlog.md
   main/history/gitRebase.md
   main/ssh/ssh.md

.. toctree::
   :maxdepth: 1
   :caption: 扩展:
   :numbered:

   extension/client/git-agent.md
   extension/client/git_proxy.md
   extension/client/git使用pem.md
   extension/client/git支持多仓库.md
   extension/eSubmoduel/gitSubmodule.md
   extension/git_hook/hook.md
   extension/gui/git-bash目录.md
   extension/gui/git_gui.md
   extension/lfs/Git LFS的使用.md
   extension/mergeTool/Git diff for .docx  format  file.md
   extension/repoService/gitlab使用.md
   extension/repoService/git_server.md
   extension/server/gitServer.md
   extension/server/搭建自己的私有Git仓库-Gogs.md
   extension/subtree/subtree.md
   extension/subtree/分离git仓库中的子目录并保留历史.md



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
"""

pth = "."
lst =[]

for r,d,f in os.walk(pth):
    for k in f:
        if os.path.splitext(k)[-1] in [".md",".rst"]:
            lst.append(os.path.join(r,k))
            # print(i,j,k)

for f in lst:
    print(f)

"""

readme
install
overview
tutorial
example
frequent Q&A



"""

"""
make htmlview
make html
make epub
make latex
make pdf

"""