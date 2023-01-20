# sphinx help
### builder
- html
- epub
- latex


### sphinx_quickstart

sphinx_quickstart 可以通过交互方式生成makefile和命令行。

```
(jupt) D:\projects\docs>sphinx-quickstart.exe --help
usage: sphinx-quickstart [OPTIONS] <PROJECT_DIR>

Generate required files for a Sphinx project. sphinx-quickstart is an
interactive tool that asks some questions about your project and then
generates a complete documentation directory and sample Makefile to be used
with sphinx-build.

positional arguments:
  PROJECT_DIR           project root

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           quiet mode
  --version             show program's version number and exit

Structure options:
  --sep                 if specified, separate source and build dirs
  --dot DOT             replacement for dot in _templates etc.

Project basic options:
  -p PROJECT, --project PROJECT
                        project name
  -a AUTHOR, --author AUTHOR
                        author names
  -v VERSION            version of project
  -r RELEASE, --release RELEASE
                        release of project
  -l LANGUAGE, --language LANGUAGE
                        document language
  --suffix SUFFIX       source file suffix
  --master MASTER       master document name
  --epub                use epub

Extension options:
  --ext-autodoc         enable autodoc extension
  --ext-doctest         enable doctest extension
  --ext-intersphinx     enable intersphinx extension
  --ext-todo            enable todo extension
  --ext-coverage        enable coverage extension
  --ext-imgmath         enable imgmath extension
  --ext-mathjax         enable mathjax extension
  --ext-ifconfig        enable ifconfig extension
  --ext-viewcode        enable viewcode extension
  --ext-githubpages     enable githubpages extension
  --extensions EXTENSIONS
                        enable arbitrary extensions

Makefile and Batchfile creation:
  --makefile            create makefile
  --no-makefile         do not create makefile
  --batchfile           create batchfile
  --no-batchfile        do not create batchfile
  -m, --use-make-mode   use make-mode for Makefile/make.bat
  -M, --no-use-make-mode
                        do not use make-mode for Makefile/make.bat

Project templating:
  -t TEMPLATEDIR, --templatedir TEMPLATEDIR
                        template directory for template files
  -d NAME=VALUE         define a template variable

For more information, visit <http://sphinx-doc.org/>.
```

### sphinx_build
可以基于源目录生成目标在目标目录。
```

(jupt) D:\projects\>sphinx-build  --help
usage: sphinx-build [OPTIONS] SOURCEDIR OUTPUTDIR [FILENAMES...]

Generate documentation from source files. sphinx-build generates documentation
from the files in SOURCEDIR and places it in OUTPUTDIR. It looks for 'conf.py'
in SOURCEDIR for the configuration settings. The 'sphinx-quickstart' tool may
be used to generate template files, including 'conf.py' sphinx-build can
create documentation in different formats. A format is selected by specifying
the builder name on the command line; it defaults to HTML. Builders can also
perform other tasks related to documentation processing. By default,
everything that is outdated is built. Output only for selected files can be
built by specifying individual filenames.

positional arguments:
  sourcedir         path to documentation source files
  outputdir         path to output directory
  filenames         a list of specific files to rebuild. Ignored if -a is
                    specified

optional arguments:
  -h, --help        show this help message and exit
  --version         show program's version number and exit

general options:
  -b BUILDER        builder to use (default: html)
  -a                write all files (default: only write new and changed
                    files)
  -E                don't use a saved environment, always read all files
  -d PATH           path for the cached environment and doctree files
                    (default: OUTPUTDIR/.doctrees)
  -j N              build in parallel with N processes where possible (special
                    value "auto" will set N to cpu-count)

build configuration options:
  -c PATH           path where configuration file (conf.py) is located
                    (default: same as SOURCEDIR)
  -C                use no config file at all, only -D options
  -D setting=value  override a setting in configuration file
  -A name=value     pass a value into HTML templates
  -t TAG            define tag: include "only" blocks with TAG
  -n                nit-picky mode, warn about all missing references

console output options:
  -v                increase verbosity (can be repeated)
  -q                no output on stdout, just warnings on stderr
  -Q                no output at all, not even warnings
  --color           do emit colored output (default: auto-detect)
  -N, --no-color    do not emit colored output (default: auto-detect)
  -w FILE           write warnings (and errors) to given file
  -W                turn warnings into errors
  --keep-going      with -W, keep going when getting warnings
  -T                show full traceback on exception
  -P                run Pdb on exception

For more information, visit <http://sphinx-doc.org/>.
```

### sphinx autogen
```

(jupt) D:\projects>sphinx-autogen.exe --help
usage: sphinx-autogen [OPTIONS] <SOURCE_FILE>...

Generate ReStructuredText using autosummary directives. sphinx-autogen is a
frontend to sphinx.ext.autosummary.generate. It generates the reStructuredText
files from the autosummary directives contained in the given input files. The
format of the autosummary directive is documented in the
``sphinx.ext.autosummary`` Python module and can be read using:: pydoc
sphinx.ext.autosummary

positional arguments:
  source_file           source files to generate rST files for

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        directory to place all output in
  -s SUFFIX, --suffix SUFFIX
                        default suffix for files (default: rst)
  -t TEMPLATES, --templates TEMPLATES
                        custom template directory (default: None)
  -i, --imported-members
                        document imported members (default: False)

For more information, visit <http://sphinx-doc.org/>.
```

### apidoc
```

(jupt) D:\projects>sphinx-apidoc.exe -h
usage: sphinx-apidoc [OPTIONS] -o <OUTPUT_PATH> <MODULE_PATH> [EXCLUDE_PATTERN, ...]

Look recursively in <MODULE_PATH> for Python modules and packages and create
one reST file with automodule directives per package in the <OUTPUT_PATH>. The
<EXCLUDE_PATTERN>s can be file and/or directory patterns that will be excluded
from generation. Note: By default this script will not overwrite already
created files.

positional arguments:
  module_path           path to module to document
  exclude_pattern       fnmatch-style file and/or directory patterns to
                        exclude from generation

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -o DESTDIR, --output-dir DESTDIR
                        directory to place all output
  -q                    no output on stdout, just warnings on stderr
  -d MAXDEPTH, --maxdepth MAXDEPTH
                        maximum depth of submodules to show in the TOC
                        (default: 4)
  -f, --force           overwrite existing files
  -l, --follow-links    follow symbolic links. Powerful when combined with
                        collective.recipe.omelette.
  -n, --dry-run         run the script without creating files
  -e, --separate        put documentation for each module on its own page
  -P, --private         include "_private" modules
  --tocfile TOCFILE     filename of table of contents (default: modules)
  -T, --no-toc          don't create a table of contents file
  -E, --no-headings     don't create headings for the module/package packages
                        (e.g. when the docstrings already contain them)
  -M, --module-first    put module documentation before submodule
                        documentation
  --implicit-namespaces
                        interpret module paths according to PEP-0420 implicit
                        namespaces specification
  -s SUFFIX, --suffix SUFFIX
                        file suffix (default: rst)
  -F, --full            generate a full project with sphinx-quickstart
  -a, --append-syspath  append module_path to sys.path, used when --full is
                        given
  -H HEADER, --doc-project HEADER
                        project name (default: root module name)
  -A AUTHOR, --doc-author AUTHOR
                        project author(s), used when --full is given
  -V VERSION, --doc-version VERSION
                        project version, used when --full is given
  -R RELEASE, --doc-release RELEASE
                        project release, used when --full is given, defaults
                        to --doc-version

extension options:
  --extensions EXTENSIONS
                        enable arbitrary extensions
  --ext-autodoc         enable autodoc extension
  --ext-doctest         enable doctest extension
  --ext-intersphinx     enable intersphinx extension
  --ext-todo            enable todo extension
  --ext-coverage        enable coverage extension
  --ext-imgmath         enable imgmath extension
  --ext-mathjax         enable mathjax extension
  --ext-ifconfig        enable ifconfig extension
  --ext-viewcode        enable viewcode extension
  --ext-githubpages     enable githubpages extension

Project templating:
  -t TEMPLATEDIR, --templatedir TEMPLATEDIR
                        template directory for template files

For more information, visit <http://sphinx-doc.org/>.
```


### make target
```
(root) D:\Project\mylib\tool_misc\tools>make
Sphinx v1.6.3
Please use `make target' where target is one of
  html        to make standalone HTML files
  dirhtml     to make HTML files named index.html in directories
  singlehtml  to make a single large HTML file
  pickle      to make pickle files
  json        to make JSON files
  htmlhelp    to make HTML files and an HTML help project
  qthelp      to make HTML files and a qthelp project
  devhelp     to make HTML files and a Devhelp project
  epub        to make an epub
  latex       to make LaTeX files, you can set PAPER=a4 or PAPER=letter
  text        to make text files
  man         to make manual pages
  texinfo     to make Texinfo files
  gettext     to make PO message catalogs
  changes     to make an overview of all changed/added/deprecated items
  xml         to make Docutils-native XML files
  pseudoxml   to make pseudoxml-XML files for display purposes
  linkcheck   to check all external links for integrity
  doctest     to run all doctests embedded in the documentation (if enabled)
  coverage    to run coverage check of the documentation (if enabled)
```