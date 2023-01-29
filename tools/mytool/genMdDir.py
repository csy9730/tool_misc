import os
import sys
from jinja2 import Template
from typing import List, Dict

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

rstTemplate = """{% if title %}{{title}}
{% else %}readme{% endif %}
==================

.. toctree::
   :maxdepth: 1
   :caption: 扩展:
   :numbered:

   {% for txt in txt_list -%}
    {{ txt.path }}
   {% endfor %}
"""

mdTemplate = """{% if title %}# {{title}} {% else %}# readme{% endif %}

{% for txt in txt_list -%}
- [{{ txt.name }}]({{txt.path}})
{% endfor %}
"""

def genMdfiles(pth:str) -> List[Dict[str, str]]:
    lst =[]

    for r, d, f in os.walk(pth):
        for k in f:
            if os.path.splitext(k)[-1] in [".md", ".rst"]:
                p = os.path.join(r, k)
                p = p.replace('\\', '/')
                p=p.lstrip('./')
                dct = {}
                dct["path"] = p.replace(' ', '%20')
                dct["name"] = os.path.basename(p)
                lst.append(dct)
                # print(i,j,k)
    return lst 


def genContent(lst:List[Dict[str, str]], template:str, **kwargs) -> str:
    tp = Template(template)
    dct = {"txt_list": lst, **kwargs}
    txt = tp.render(**dct)
    return txt


def parse_args(cmds=None):
    import argparse
    parser = argparse.ArgumentParser(description="your script description")
    parser.add_argument('path', default='.', help='path file')
    parser.add_argument('--verbose', '-v', action='store_true', help='verbose mode')
    parser.add_argument('--output', '-o', help='output file') 
    parser.add_argument('--output-type', '-ot', choices=['rst', 'md'], help='output file type') 
    parser.add_argument('--title', '-t', help='title') 

    args = parser.parse_args(cmds) 
    return args

def main(cmds=None):
    args = parse_args(cmds)
    lst = genMdfiles(args.path)  

    if args.output_type is None:
        output_type = 'rst' if os.path.splitext(args.output)[-1] == '.rst' else 'md'
    else:
        output_type = args.output_type
    if output_type == "md":
        temp = mdTemplate
    else:
        temp = rstTemplate

    if args.verbose:
        print(lst)
    txt = genContent(lst, temp, title=args.title)
    if args.output:
        with open(args.output, 'w') as fp:
            fp.write(txt)
    else:
        print(txt)


if __name__ == "__main__":
    main()
