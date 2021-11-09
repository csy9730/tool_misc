# bibliometrix

[https://github.com/massimoaria/bibliometrix](https://github.com/massimoaria/bibliometrix)

[https://www.bibliometrix.org/](https://www.bibliometrix.org/)

## install
``` r
install.packages("bibliometrix")
library('bibliometrix')
biblioshiny()

# install_formats()
```


### log
```
R version 4.1.2 (2021-11-01) -- "Bird Hippie"
Copyright (C) 2021 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> install.packages("bibliometrix")
还安装相依关系‘listenv’, ‘parallelly’, ‘future’, ‘globals’, ‘future.apply’, ‘progressr’, ‘SQUAREM’, ‘lava’, ‘prodlim’, ‘proxy’, ‘iterators’, ‘gower’, ‘ipred’, ‘lubridate’, ‘timeDate’, ‘e1071’, ‘foreach’, ‘ModelMetrics’, ‘pROC’, ‘recipes’, ‘sys’, ‘backports’, ‘evaluate’, ‘highr’, ‘xfun’, ‘matrixStats’, ‘caret’, ‘RcppArmadillo’, ‘askpass’, ‘broom’, ‘corrplot’, ‘numDeriv’, ‘knitr’, ‘SparseM’, ‘MatrixModels’, ‘conquer’, ‘sp’, ‘minqa’, ‘nloptr’, ‘RcppEigen’, ‘colorspace’, ‘bit’, ‘fs’, ‘rappdirs’, ‘curl’, ‘openssl’, ‘fansi’, ‘utf8’, ‘yaml’, ‘viridis’, ‘ggsci’, ‘cowplot’, ‘ggsignif’, ‘gridExtra’, ‘polynom’, ‘rstatix’, ‘carData’, ‘pbkrtest’, ‘quantreg’, ‘maptools’, ‘lme4’, ‘farver’, ‘labeling’, ‘munsell’, ‘bit64’, ‘rematch’, ‘prettyunits’, ‘sass’, ‘httr’, ‘jsonlite’, ‘ellipsis’, ‘generics’, ‘glue’, ‘lifecycle’, ‘magrittr’, ‘R6’, ‘rlang’, ‘tibble’, ‘tidyselect’, ‘vctrs’, ‘pillar’, ‘htmltools’, ‘htmlwidgets’, ‘crosstalk’, ‘jquerylib’, ‘promises’, ‘abind’, ‘dendextend’, ‘ggpubr’, ‘reshape2’, ‘car’, ‘ellipse’, ‘flashClust’, ‘leaps’, ‘scatterplot3d’, ‘digest’, ‘gtable’, ‘isoband’, ‘scales’, ‘withr’, ‘Rcpp’, ‘pkgconfig’, ‘viridisLite’, ‘base64enc’, ‘lazyeval’, ‘purrr’, ‘data.table’, ‘zip’, ‘stringi’, ‘rentrez’, ‘XML’, ‘cli’, ‘clipr’, ‘crayon’, ‘hms’, ‘vroom’, ‘cpp11’, ‘tzdb’, ‘cellranger’, ‘progress’, ‘plyr’, ‘httpuv’, ‘mime’, ‘xtable’, ‘fontawesome’, ‘sourcetools’, ‘later’, ‘fastmap’, ‘commonmark’, ‘bslib’, ‘cachem’, ‘hunspell’, ‘janeaustenr’, ‘tokenizers’, ‘bibliometrixData’, ‘dimensionsR’, ‘dplyr’, ‘DT’, ‘factoextra’, ‘FactoMineR’, ‘forcats’, ‘ggplot2’, ‘ggrepel’, ‘igraph’, ‘plotly’, ‘openxlsx’, ‘pubmedR’, ‘RColorBrewer’, ‘readr’, ‘readxl’, ‘rscopus’, ‘shiny’, ‘SnowballC’, ‘stringdist’, ‘stringr’, ‘tidyr’, ‘tidytext’


  有二进制版本的，但源代码版本是后来的:
                  binary     source needs_compilation
xfun                0.27       0.28              TRUE
RcppArmadillo 0.10.7.0.0 0.10.7.3.0              TRUE
conquer            1.2.0      1.2.1              TRUE
nloptr           1.2.2.2    1.2.2.3              TRUE
glue               1.4.2      1.5.0              TRUE
tibble             3.1.5      3.1.6              TRUE
crosstalk          1.1.1      1.2.0             FALSE
car               3.0-11     3.0-12             FALSE
cpp11              0.4.0      0.4.1             FALSE
igraph             1.2.7      1.2.8              TRUE

  Binaries will be installed
trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/listenv_0.8.0.zip'
Content type 'application/zip' length 106747 bytes (104 KB)
downloaded 104 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/parallelly_1.28.1.zip'
Content type 'application/zip' length 276280 bytes (269 KB)
downloaded 269 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/future_1.23.0.zip'
Content type 'application/zip' length 692913 bytes (676 KB)
downloaded 676 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/globals_0.14.0.zip'
Content type 'application/zip' length 95521 bytes (93 KB)
downloaded 93 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/future.apply_1.8.1.zip'
Content type 'application/zip' length 155477 bytes (151 KB)
downloaded 151 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/progressr_0.9.0.zip'
Content type 'application/zip' length 261248 bytes (255 KB)
downloaded 255 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/SQUAREM_2021.1.zip'
Content type 'application/zip' length 183151 bytes (178 KB)
downloaded 178 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/lava_1.6.10.zip'
Content type 'application/zip' length 2993080 bytes (2.9 MB)
downloaded 2.9 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/prodlim_2019.11.13.zip'
Content type 'application/zip' length 421105 bytes (411 KB)
downloaded 411 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/proxy_0.4-26.zip'
Content type 'application/zip' length 245460 bytes (239 KB)
downloaded 239 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/iterators_1.0.13.zip'
Content type 'application/zip' length 343079 bytes (335 KB)
downloaded 335 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/gower_0.2.2.zip'
Content type 'application/zip' length 298218 bytes (291 KB)
downloaded 291 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/ipred_0.9-12.zip'
Content type 'application/zip' length 400480 bytes (391 KB)
downloaded 391 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/lubridate_1.8.0.zip'
Content type 'application/zip' length 1715713 bytes (1.6 MB)
downloaded 1.6 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/timeDate_3043.102.zip'
Content type 'application/zip' length 1553012 bytes (1.5 MB)
downloaded 1.5 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/e1071_1.7-9.zip'
Content type 'application/zip' length 1023138 bytes (999 KB)
downloaded 999 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/foreach_1.5.1.zip'
Content type 'application/zip' length 145971 bytes (142 KB)
downloaded 142 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/ModelMetrics_1.2.2.2.zip'
Content type 'application/zip' length 863920 bytes (843 KB)
downloaded 843 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/pROC_1.18.0.zip'
Content type 'application/zip' length 1532135 bytes (1.5 MB)
downloaded 1.5 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/recipes_0.1.17.zip'
Content type 'application/zip' length 1283122 bytes (1.2 MB)
downloaded 1.2 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/sys_3.4.zip'
Content type 'application/zip' length 59865 bytes (58 KB)
downloaded 58 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/backports_1.3.0.zip'
Content type 'application/zip' length 105005 bytes (102 KB)
downloaded 102 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/evaluate_0.14.zip'
Content type 'application/zip' length 76841 bytes (75 KB)
downloaded 75 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/highr_0.9.zip'
Content type 'application/zip' length 46731 bytes (45 KB)
downloaded 45 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/xfun_0.27.zip'
Content type 'application/zip' length 381113 bytes (372 KB)
downloaded 372 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/matrixStats_0.61.0.zip'
Content type 'application/zip' length 594008 bytes (580 KB)
downloaded 580 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/caret_6.0-90.zip'
Content type 'application/zip' length 3590111 bytes (3.4 MB)
downloaded 3.4 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/RcppArmadillo_0.10.7.0.0.zip'
Content type 'application/zip' length 2704940 bytes (2.6 MB)
downloaded 2.6 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/askpass_1.1.zip'
Content type 'application/zip' length 243646 bytes (237 KB)
downloaded 237 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/broom_0.7.10.zip'
Content type 'application/zip' length 1812677 bytes (1.7 MB)
downloaded 1.7 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/corrplot_0.90.zip'
Content type 'application/zip' length 2894500 bytes (2.8 MB)
downloaded 2.8 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/numDeriv_2016.8-1.1.zip'
Content type 'application/zip' length 116205 bytes (113 KB)
downloaded 113 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/knitr_1.36.zip'
Content type 'application/zip' length 1469082 bytes (1.4 MB)
downloaded 1.4 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/SparseM_1.81.zip'
Content type 'application/zip' length 1066525 bytes (1.0 MB)
downloaded 1.0 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/MatrixModels_0.5-0.zip'
Content type 'application/zip' length 434316 bytes (424 KB)
downloaded 424 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/conquer_1.2.0.zip'
Content type 'application/zip' length 1205699 bytes (1.1 MB)
downloaded 1.1 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/sp_1.4-5.zip'
Content type 'application/zip' length 1824901 bytes (1.7 MB)
downloaded 1.7 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/minqa_1.2.4.zip'
Content type 'application/zip' length 855876 bytes (835 KB)
downloaded 835 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/nloptr_1.2.2.2.zip'
Content type 'application/zip' length 1244239 bytes (1.2 MB)
downloaded 1.2 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/RcppEigen_0.3.3.9.1.zip'
Content type 'application/zip' length 2870028 bytes (2.7 MB)
downloaded 2.7 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/colorspace_2.0-2.zip'
Content type 'application/zip' length 2644996 bytes (2.5 MB)
downloaded 2.5 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/bit_4.0.4.zip'
Content type 'application/zip' length 641341 bytes (626 KB)
downloaded 626 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/fs_1.5.0.zip'
Content type 'application/zip' length 606453 bytes (592 KB)
downloaded 592 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/rappdirs_0.3.3.zip'
Content type 'application/zip' length 58764 bytes (57 KB)
downloaded 57 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/curl_4.3.2.zip'
Content type 'application/zip' length 4322506 bytes (4.1 MB)
downloaded 4.1 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/openssl_1.4.5.zip'
Content type 'application/zip' length 4101751 bytes (3.9 MB)
downloaded 3.9 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/fansi_0.5.0.zip'
Content type 'application/zip' length 248254 bytes (242 KB)
downloaded 242 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/utf8_1.2.2.zip'
Content type 'application/zip' length 209978 bytes (205 KB)
downloaded 205 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/yaml_2.2.1.zip'
Content type 'application/zip' length 207878 bytes (203 KB)
downloaded 203 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/viridis_0.6.2.zip'
Content type 'application/zip' length 3000051 bytes (2.9 MB)
downloaded 2.9 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/ggsci_2.9.zip'
Content type 'application/zip' length 2978926 bytes (2.8 MB)
downloaded 2.8 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/cowplot_1.1.1.zip'
Content type 'application/zip' length 1376095 bytes (1.3 MB)
downloaded 1.3 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/ggsignif_0.6.3.zip'
Content type 'application/zip' length 600825 bytes (586 KB)
downloaded 586 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/gridExtra_2.3.zip'
Content type 'application/zip' length 1109431 bytes (1.1 MB)
downloaded 1.1 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/polynom_1.4-0.zip'
Content type 'application/zip' length 312687 bytes (305 KB)
downloaded 305 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/rstatix_0.7.0.zip'
Content type 'application/zip' length 607633 bytes (593 KB)
downloaded 593 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/carData_3.0-4.zip'
Content type 'application/zip' length 1822339 bytes (1.7 MB)
downloaded 1.7 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/pbkrtest_0.5.1.zip'
Content type 'application/zip' length 357147 bytes (348 KB)
downloaded 348 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/quantreg_5.86.zip'
Content type 'application/zip' length 1942914 bytes (1.9 MB)
downloaded 1.9 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/maptools_1.1-2.zip'
Content type 'application/zip' length 2171462 bytes (2.1 MB)
downloaded 2.1 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/lme4_1.1-27.1.zip'
Content type 'application/zip' length 5356316 bytes (5.1 MB)
downloaded 5.1 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/farver_2.1.0.zip'
Content type 'application/zip' length 1752666 bytes (1.7 MB)
downloaded 1.7 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/labeling_0.4.2.zip'
Content type 'application/zip' length 62679 bytes (61 KB)
downloaded 61 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/munsell_0.5.0.zip'
Content type 'application/zip' length 245439 bytes (239 KB)
downloaded 239 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/bit64_4.0.5.zip'
Content type 'application/zip' length 565770 bytes (552 KB)
downloaded 552 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/rematch_1.0.1.zip'
Content type 'application/zip' length 16237 bytes (15 KB)
downloaded 15 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/prettyunits_1.1.1.zip'
Content type 'application/zip' length 37799 bytes (36 KB)
downloaded 36 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/sass_0.4.0.zip'
Content type 'application/zip' length 3639381 bytes (3.5 MB)
downloaded 3.5 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/httr_1.4.2.zip'
Content type 'application/zip' length 519993 bytes (507 KB)
downloaded 507 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/jsonlite_1.7.2.zip'
Content type 'application/zip' length 544583 bytes (531 KB)
downloaded 531 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/ellipsis_0.3.2.zip'
Content type 'application/zip' length 49228 bytes (48 KB)
downloaded 48 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/generics_0.1.1.zip'
Content type 'application/zip' length 76323 bytes (74 KB)
downloaded 74 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/glue_1.4.2.zip'
Content type 'application/zip' length 155693 bytes (152 KB)
downloaded 152 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/lifecycle_1.0.1.zip'
Content type 'application/zip' length 123387 bytes (120 KB)
downloaded 120 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/magrittr_2.0.1.zip'
Content type 'application/zip' length 235949 bytes (230 KB)
downloaded 230 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/R6_2.5.1.zip'
Content type 'application/zip' length 84254 bytes (82 KB)
downloaded 82 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/rlang_0.4.12.zip'
Content type 'application/zip' length 1202691 bytes (1.1 MB)
downloaded 1.1 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/tibble_3.1.5.zip'
Content type 'application/zip' length 871287 bytes (850 KB)
downloaded 850 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/tidyselect_1.1.1.zip'
Content type 'application/zip' length 204336 bytes (199 KB)
downloaded 199 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/vctrs_0.3.8.zip'
Content type 'application/zip' length 1254019 bytes (1.2 MB)
downloaded 1.2 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/pillar_1.6.4.zip'
Content type 'application/zip' length 1041644 bytes (1017 KB)
downloaded 1017 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/htmltools_0.5.2.zip'
Content type 'application/zip' length 347600 bytes (339 KB)
downloaded 339 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/htmlwidgets_1.5.4.zip'
Content type 'application/zip' length 905311 bytes (884 KB)
downloaded 884 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/jquerylib_0.1.4.zip'
Content type 'application/zip' length 525860 bytes (513 KB)
downloaded 513 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/promises_1.2.0.1.zip'
Content type 'application/zip' length 2320151 bytes (2.2 MB)
downloaded 2.2 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/abind_1.4-5.zip'
Content type 'application/zip' length 63748 bytes (62 KB)
downloaded 62 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/dendextend_1.15.2.zip'
Content type 'application/zip' length 3890596 bytes (3.7 MB)
downloaded 3.7 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/ggpubr_0.4.0.zip'
Content type 'application/zip' length 1906584 bytes (1.8 MB)
downloaded 1.8 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/reshape2_1.4.4.zip'
Content type 'application/zip' length 817933 bytes (798 KB)
downloaded 798 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/ellipse_0.4.2.zip'
Content type 'application/zip' length 72081 bytes (70 KB)
downloaded 70 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/flashClust_1.01-2.zip'
Content type 'application/zip' length 36943 bytes (36 KB)
downloaded 36 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/leaps_3.1.zip'
Content type 'application/zip' length 103031 bytes (100 KB)
downloaded 100 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/scatterplot3d_0.3-41.zip'
Content type 'application/zip' length 338278 bytes (330 KB)
downloaded 330 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/digest_0.6.28.zip'
Content type 'application/zip' length 269525 bytes (263 KB)
downloaded 263 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/gtable_0.3.0.zip'
Content type 'application/zip' length 434379 bytes (424 KB)
downloaded 424 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/isoband_0.2.5.zip'
Content type 'application/zip' length 2726780 bytes (2.6 MB)
downloaded 2.6 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/scales_1.1.1.zip'
Content type 'application/zip' length 558363 bytes (545 KB)
downloaded 545 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/withr_2.4.2.zip'
Content type 'application/zip' length 212981 bytes (207 KB)
downloaded 207 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/Rcpp_1.0.7.zip'
Content type 'application/zip' length 3262930 bytes (3.1 MB)
downloaded 3.1 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/pkgconfig_2.0.3.zip'
Content type 'application/zip' length 22511 bytes (21 KB)
downloaded 21 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/viridisLite_0.4.0.zip'
Content type 'application/zip' length 1299494 bytes (1.2 MB)
downloaded 1.2 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/base64enc_0.1-3.zip'
Content type 'application/zip' length 43156 bytes (42 KB)
downloaded 42 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/lazyeval_0.2.2.zip'
Content type 'application/zip' length 172735 bytes (168 KB)
downloaded 168 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/purrr_0.3.4.zip'
Content type 'application/zip' length 430072 bytes (419 KB)
downloaded 419 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/data.table_1.14.2.zip'
Content type 'application/zip' length 2600255 bytes (2.5 MB)
downloaded 2.5 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/zip_2.2.0.zip'
Content type 'application/zip' length 1122124 bytes (1.1 MB)
downloaded 1.1 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/stringi_1.7.5.zip'
Content type 'application/zip' length 16449351 bytes (15.7 MB)
downloaded 15.7 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/rentrez_1.2.3.zip'
Content type 'application/zip' length 146302 bytes (142 KB)
downloaded 142 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/XML_3.99-0.8.zip'
Content type 'application/zip' length 4260428 bytes (4.1 MB)
downloaded 4.1 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/cli_3.1.0.zip'
Content type 'application/zip' length 1236112 bytes (1.2 MB)
downloaded 1.2 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/clipr_0.7.1.zip'
Content type 'application/zip' length 52685 bytes (51 KB)
downloaded 51 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/crayon_1.4.2.zip'
Content type 'application/zip' length 156709 bytes (153 KB)
downloaded 153 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/hms_1.1.1.zip'
Content type 'application/zip' length 104228 bytes (101 KB)
downloaded 101 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/vroom_1.5.5.zip'
Content type 'application/zip' length 2045796 bytes (2.0 MB)
downloaded 2.0 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/tzdb_0.2.0.zip'
Content type 'application/zip' length 1441969 bytes (1.4 MB)
downloaded 1.4 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/cellranger_1.1.0.zip'
Content type 'application/zip' length 104688 bytes (102 KB)
downloaded 102 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/progress_1.2.2.zip'
Content type 'application/zip' length 85988 bytes (83 KB)
downloaded 83 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/plyr_1.8.6.zip'
Content type 'application/zip' length 1498328 bytes (1.4 MB)
downloaded 1.4 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/httpuv_1.6.3.zip'
Content type 'application/zip' length 1695975 bytes (1.6 MB)
downloaded 1.6 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/mime_0.12.zip'
Content type 'application/zip' length 48094 bytes (46 KB)
downloaded 46 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/xtable_1.8-4.zip'
Content type 'application/zip' length 706814 bytes (690 KB)
downloaded 690 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/fontawesome_0.2.2.zip'
Content type 'application/zip' length 1529170 bytes (1.5 MB)
downloaded 1.5 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/sourcetools_0.1.7.zip'
Content type 'application/zip' length 691460 bytes (675 KB)
downloaded 675 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/later_1.3.0.zip'
Content type 'application/zip' length 860078 bytes (839 KB)
downloaded 839 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/fastmap_1.1.0.zip'
Content type 'application/zip' length 215464 bytes (210 KB)
downloaded 210 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/commonmark_1.7.zip'
Content type 'application/zip' length 265739 bytes (259 KB)
downloaded 259 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/bslib_0.3.1.zip'
Content type 'application/zip' length 5038496 bytes (4.8 MB)
downloaded 4.8 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/cachem_1.0.6.zip'
Content type 'application/zip' length 78973 bytes (77 KB)
downloaded 77 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/hunspell_3.0.1.zip'
Content type 'application/zip' length 2127043 bytes (2.0 MB)
downloaded 2.0 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/janeaustenr_0.1.5.zip'
Content type 'application/zip' length 1625549 bytes (1.6 MB)
downloaded 1.6 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/tokenizers_0.2.1.zip'
Content type 'application/zip' length 1351675 bytes (1.3 MB)
downloaded 1.3 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/bibliometrixData_0.1.0.zip'
Content type 'application/zip' length 2957130 bytes (2.8 MB)
downloaded 2.8 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/dimensionsR_0.0.2.zip'
Content type 'application/zip' length 80004 bytes (78 KB)
downloaded 78 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/dplyr_1.0.7.zip'
Content type 'application/zip' length 1344315 bytes (1.3 MB)
downloaded 1.3 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/DT_0.19.zip'
Content type 'application/zip' length 1793936 bytes (1.7 MB)
downloaded 1.7 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/factoextra_1.0.7.zip'
Content type 'application/zip' length 417376 bytes (407 KB)
downloaded 407 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/FactoMineR_2.4.zip'
Content type 'application/zip' length 3758634 bytes (3.6 MB)
downloaded 3.6 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/forcats_0.5.1.zip'
Content type 'application/zip' length 357775 bytes (349 KB)
downloaded 349 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/ggplot2_3.3.5.zip'
Content type 'application/zip' length 4130482 bytes (3.9 MB)
downloaded 3.9 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/ggrepel_0.9.1.zip'
Content type 'application/zip' length 1119253 bytes (1.1 MB)
downloaded 1.1 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/igraph_1.2.7.zip'
Content type 'application/zip' length 9012356 bytes (8.6 MB)
downloaded 8.6 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/plotly_4.10.0.zip'
Content type 'application/zip' length 3175348 bytes (3.0 MB)
downloaded 3.0 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/openxlsx_4.2.4.zip'
Content type 'application/zip' length 2820763 bytes (2.7 MB)
downloaded 2.7 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/pubmedR_0.0.3.zip'
Content type 'application/zip' length 45723 bytes (44 KB)
downloaded 44 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/RColorBrewer_1.1-2.zip'
Content type 'application/zip' length 55707 bytes (54 KB)
downloaded 54 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/readr_2.0.2.zip'
Content type 'application/zip' length 1794824 bytes (1.7 MB)
downloaded 1.7 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/readxl_1.3.1.zip'
Content type 'application/zip' length 1717472 bytes (1.6 MB)
downloaded 1.6 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/rscopus_0.6.6.zip'
Content type 'application/zip' length 239253 bytes (233 KB)
downloaded 233 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/shiny_1.7.1.zip'
Content type 'application/zip' length 4231727 bytes (4.0 MB)
downloaded 4.0 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/SnowballC_0.7.0.zip'
Content type 'application/zip' length 450226 bytes (439 KB)
downloaded 439 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/stringdist_0.9.8.zip'
Content type 'application/zip' length 710802 bytes (694 KB)
downloaded 694 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/stringr_1.4.0.zip'
Content type 'application/zip' length 217022 bytes (211 KB)
downloaded 211 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/tidyr_1.1.4.zip'
Content type 'application/zip' length 1070383 bytes (1.0 MB)
downloaded 1.0 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/tidytext_0.3.2.zip'
Content type 'application/zip' length 3050933 bytes (2.9 MB)
downloaded 2.9 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/bibliometrix_3.1.4.zip'
Content type 'application/zip' length 889925 bytes (869 KB)
downloaded 869 KB

package ‘listenv’ successfully unpacked and MD5 sums checked
package ‘parallelly’ successfully unpacked and MD5 sums checked
package ‘future’ successfully unpacked and MD5 sums checked
package ‘globals’ successfully unpacked and MD5 sums checked
package ‘future.apply’ successfully unpacked and MD5 sums checked
package ‘progressr’ successfully unpacked and MD5 sums checked
package ‘SQUAREM’ successfully unpacked and MD5 sums checked
package ‘lava’ successfully unpacked and MD5 sums checked
package ‘prodlim’ successfully unpacked and MD5 sums checked
package ‘proxy’ successfully unpacked and MD5 sums checked
package ‘iterators’ successfully unpacked and MD5 sums checked
package ‘gower’ successfully unpacked and MD5 sums checked
package ‘ipred’ successfully unpacked and MD5 sums checked
package ‘lubridate’ successfully unpacked and MD5 sums checked
package ‘timeDate’ successfully unpacked and MD5 sums checked
package ‘e1071’ successfully unpacked and MD5 sums checked
package ‘foreach’ successfully unpacked and MD5 sums checked
package ‘ModelMetrics’ successfully unpacked and MD5 sums checked
package ‘pROC’ successfully unpacked and MD5 sums checked
package ‘recipes’ successfully unpacked and MD5 sums checked
package ‘sys’ successfully unpacked and MD5 sums checked
package ‘backports’ successfully unpacked and MD5 sums checked
package ‘evaluate’ successfully unpacked and MD5 sums checked
package ‘highr’ successfully unpacked and MD5 sums checked
package ‘xfun’ successfully unpacked and MD5 sums checked
package ‘matrixStats’ successfully unpacked and MD5 sums checked
package ‘caret’ successfully unpacked and MD5 sums checked
package ‘RcppArmadillo’ successfully unpacked and MD5 sums checked
package ‘askpass’ successfully unpacked and MD5 sums checked
package ‘broom’ successfully unpacked and MD5 sums checked
package ‘corrplot’ successfully unpacked and MD5 sums checked
package ‘numDeriv’ successfully unpacked and MD5 sums checked
package ‘knitr’ successfully unpacked and MD5 sums checked
package ‘SparseM’ successfully unpacked and MD5 sums checked
package ‘MatrixModels’ successfully unpacked and MD5 sums checked
package ‘conquer’ successfully unpacked and MD5 sums checked
package ‘sp’ successfully unpacked and MD5 sums checked
package ‘minqa’ successfully unpacked and MD5 sums checked
package ‘nloptr’ successfully unpacked and MD5 sums checked
package ‘RcppEigen’ successfully unpacked and MD5 sums checked
package ‘colorspace’ successfully unpacked and MD5 sums checked
package ‘bit’ successfully unpacked and MD5 sums checked
package ‘fs’ successfully unpacked and MD5 sums checked
package ‘rappdirs’ successfully unpacked and MD5 sums checked
package ‘curl’ successfully unpacked and MD5 sums checked
package ‘openssl’ successfully unpacked and MD5 sums checked
package ‘fansi’ successfully unpacked and MD5 sums checked
package ‘utf8’ successfully unpacked and MD5 sums checked
package ‘yaml’ successfully unpacked and MD5 sums checked
package ‘viridis’ successfully unpacked and MD5 sums checked
package ‘ggsci’ successfully unpacked and MD5 sums checked
package ‘cowplot’ successfully unpacked and MD5 sums checked
package ‘ggsignif’ successfully unpacked and MD5 sums checked
package ‘gridExtra’ successfully unpacked and MD5 sums checked
package ‘polynom’ successfully unpacked and MD5 sums checked
package ‘rstatix’ successfully unpacked and MD5 sums checked
package ‘carData’ successfully unpacked and MD5 sums checked
package ‘pbkrtest’ successfully unpacked and MD5 sums checked
package ‘quantreg’ successfully unpacked and MD5 sums checked
package ‘maptools’ successfully unpacked and MD5 sums checked
package ‘lme4’ successfully unpacked and MD5 sums checked
package ‘farver’ successfully unpacked and MD5 sums checked
package ‘labeling’ successfully unpacked and MD5 sums checked
package ‘munsell’ successfully unpacked and MD5 sums checked
package ‘bit64’ successfully unpacked and MD5 sums checked
package ‘rematch’ successfully unpacked and MD5 sums checked
package ‘prettyunits’ successfully unpacked and MD5 sums checked
package ‘sass’ successfully unpacked and MD5 sums checked
package ‘httr’ successfully unpacked and MD5 sums checked
package ‘jsonlite’ successfully unpacked and MD5 sums checked
package ‘ellipsis’ successfully unpacked and MD5 sums checked
package ‘generics’ successfully unpacked and MD5 sums checked
package ‘glue’ successfully unpacked and MD5 sums checked
package ‘lifecycle’ successfully unpacked and MD5 sums checked
package ‘magrittr’ successfully unpacked and MD5 sums checked
package ‘R6’ successfully unpacked and MD5 sums checked
package ‘rlang’ successfully unpacked and MD5 sums checked
package ‘tibble’ successfully unpacked and MD5 sums checked
package ‘tidyselect’ successfully unpacked and MD5 sums checked
package ‘vctrs’ successfully unpacked and MD5 sums checked
package ‘pillar’ successfully unpacked and MD5 sums checked
package ‘htmltools’ successfully unpacked and MD5 sums checked
package ‘htmlwidgets’ successfully unpacked and MD5 sums checked
package ‘jquerylib’ successfully unpacked and MD5 sums checked
package ‘promises’ successfully unpacked and MD5 sums checked
package ‘abind’ successfully unpacked and MD5 sums checked
package ‘dendextend’ successfully unpacked and MD5 sums checked
package ‘ggpubr’ successfully unpacked and MD5 sums checked
package ‘reshape2’ successfully unpacked and MD5 sums checked
package ‘ellipse’ successfully unpacked and MD5 sums checked
package ‘flashClust’ successfully unpacked and MD5 sums checked
package ‘leaps’ successfully unpacked and MD5 sums checked
package ‘scatterplot3d’ successfully unpacked and MD5 sums checked
package ‘digest’ successfully unpacked and MD5 sums checked
package ‘gtable’ successfully unpacked and MD5 sums checked
package ‘isoband’ successfully unpacked and MD5 sums checked
package ‘scales’ successfully unpacked and MD5 sums checked
package ‘withr’ successfully unpacked and MD5 sums checked
package ‘Rcpp’ successfully unpacked and MD5 sums checked
package ‘pkgconfig’ successfully unpacked and MD5 sums checked
package ‘viridisLite’ successfully unpacked and MD5 sums checked
package ‘base64enc’ successfully unpacked and MD5 sums checked
package ‘lazyeval’ successfully unpacked and MD5 sums checked
package ‘purrr’ successfully unpacked and MD5 sums checked
package ‘data.table’ successfully unpacked and MD5 sums checked
package ‘zip’ successfully unpacked and MD5 sums checked
package ‘stringi’ successfully unpacked and MD5 sums checked
package ‘rentrez’ successfully unpacked and MD5 sums checked
package ‘XML’ successfully unpacked and MD5 sums checked
package ‘cli’ successfully unpacked and MD5 sums checked
package ‘clipr’ successfully unpacked and MD5 sums checked
package ‘crayon’ successfully unpacked and MD5 sums checked
package ‘hms’ successfully unpacked and MD5 sums checked
package ‘vroom’ successfully unpacked and MD5 sums checked
package ‘tzdb’ successfully unpacked and MD5 sums checked
package ‘cellranger’ successfully unpacked and MD5 sums checked
package ‘progress’ successfully unpacked and MD5 sums checked
package ‘plyr’ successfully unpacked and MD5 sums checked
package ‘httpuv’ successfully unpacked and MD5 sums checked
package ‘mime’ successfully unpacked and MD5 sums checked
package ‘xtable’ successfully unpacked and MD5 sums checked
package ‘fontawesome’ successfully unpacked and MD5 sums checked
package ‘sourcetools’ successfully unpacked and MD5 sums checked
package ‘later’ successfully unpacked and MD5 sums checked
package ‘fastmap’ successfully unpacked and MD5 sums checked
package ‘commonmark’ successfully unpacked and MD5 sums checked
package ‘bslib’ successfully unpacked and MD5 sums checked
package ‘cachem’ successfully unpacked and MD5 sums checked
package ‘hunspell’ successfully unpacked and MD5 sums checked
package ‘janeaustenr’ successfully unpacked and MD5 sums checked
package ‘tokenizers’ successfully unpacked and MD5 sums checked
package ‘bibliometrixData’ successfully unpacked and MD5 sums checked
package ‘dimensionsR’ successfully unpacked and MD5 sums checked
package ‘dplyr’ successfully unpacked and MD5 sums checked
package ‘DT’ successfully unpacked and MD5 sums checked
package ‘factoextra’ successfully unpacked and MD5 sums checked
package ‘FactoMineR’ successfully unpacked and MD5 sums checked
package ‘forcats’ successfully unpacked and MD5 sums checked
package ‘ggplot2’ successfully unpacked and MD5 sums checked
package ‘ggrepel’ successfully unpacked and MD5 sums checked
package ‘igraph’ successfully unpacked and MD5 sums checked
package ‘plotly’ successfully unpacked and MD5 sums checked
package ‘openxlsx’ successfully unpacked and MD5 sums checked
package ‘pubmedR’ successfully unpacked and MD5 sums checked
package ‘RColorBrewer’ successfully unpacked and MD5 sums checked
package ‘readr’ successfully unpacked and MD5 sums checked
package ‘readxl’ successfully unpacked and MD5 sums checked
package ‘rscopus’ successfully unpacked and MD5 sums checked
package ‘shiny’ successfully unpacked and MD5 sums checked
package ‘SnowballC’ successfully unpacked and MD5 sums checked
package ‘stringdist’ successfully unpacked and MD5 sums checked
package ‘stringr’ successfully unpacked and MD5 sums checked
package ‘tidyr’ successfully unpacked and MD5 sums checked
package ‘tidytext’ successfully unpacked and MD5 sums checked
package ‘bibliometrix’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\admin\AppData\Local\Temp\RtmpYrfysL\downloaded_packages
安装源码包‘crosstalk’, ‘car’, ‘cpp11’

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/src/contrib/crosstalk_1.2.0.tar.gz'
Content type 'application/octet-stream' length 296495 bytes (289 KB)
downloaded 289 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/src/contrib/car_3.0-12.tar.gz'
Content type 'application/octet-stream' length 331330 bytes (323 KB)
downloaded 323 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/src/contrib/cpp11_0.4.1.tar.gz'
Content type 'application/octet-stream' length 317650 bytes (310 KB)
downloaded 310 KB

* installing *source* package 'crosstalk' ...
** package 'crosstalk' successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
  converting help for package 'crosstalk'
    finding HTML links ... done
    ClientValue                             html  
    SharedData                              html  
    bscols                                  html  
    crosstalkLibs                           html  
    filter_select                           html  
    filter_slider                           html  
    finding level-2 HTML links ... done

    getDefaultReactiveDomain                html  
    is.SharedData                           html  
    maintain_selection                      html  
    scale_fill_selection                    html  
** building package indices
** testing if installed package can be loaded from temporary location
*** arch - i386
*** arch - x64
** testing if installed package can be loaded from final location
*** arch - i386
*** arch - x64
** testing if installed package keeps a record of temporary installation path
* DONE (crosstalk)
* installing *source* package 'car' ...
** package 'car' successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
  converting help for package 'car'
    finding HTML links ... done
    Anova                                   html  
    Boot                                    html  
    Boxplot                                 html  
    Contrasts                               html  
    Ellipses                                html  
    Export                                  html  
    Import                                  html  
    Predict                                 html  
    S                                       html  
    ScatterplotSmoothers                    html  
    finding level-2 HTML links ... done

    Tapply                                  html  
    TransformationAxes                      html  
    avPlots                                 html  
    bcPower                                 html  
    boxCox                                  html  
    boxCoxVariable                          html  
    boxTidwell                              html  
    brief                                   html  
    car-defunct                             html  
    car-deprecated                          html  
    car-internal                            html  
    carHexsticker                           html  
    carPalette                              html  
    carWeb                                  html  
    ceresPlots                              html  
    compareCoefs                            html  
    crPlots                                 html  
    deltaMethod                             html  
    densityPlot                             html  
    dfbetaPlots                             html  
    durbinWatsonTest                        html  
    hccm                                    html  
    hist.boot                               html  
REDIRECT:topic	 Previous alias or file overwritten by alias: E:/Program Files/R/R-4.1.2/library/00LOCK-car/00new/car/help/Confint.boot.html
    infIndexPlot                            html  
    influence-mixed-models                  html  
    influencePlot                           html  
    invResPlot                              html  
    invTranPlot                             html  
    leveneTest                              html  
    leveragePlots                           html  
    linearHypothesis                        html  
    logit                                   html  
    marginalModelPlot                       html  
    mcPlots                                 html  
    ncvTest                                 html  
    outlierTest                             html  
    panel.car                               html  
    poTest                                  html  
    powerTransform                          html  
    qqPlot                                  html  
    recode                                  html  
REDIRECT:topic	 Previous alias or file overwritten by alias: E:/Program Files/R/R-4.1.2/library/00LOCK-car/00new/car/help/Recode.html
    regLine                                 html  
    residualPlots                           html  
    scatter3d                               html  
    scatterplot                             html  
    scatterplotMatrix                       html  
    showLabels                              html  
    sigmaHat                                html  
    some                                    html  
    spreadLevelPlot                         html  
    strings2factors                         html  
    subsets                                 html  
    symbox                                  html  
    testTransform                           html  
    vif                                     html  
    wcrossprod                              html  
    which.names                             html  
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
*** arch - i386
*** arch - x64
** testing if installed package can be loaded from final location
*** arch - i386
*** arch - x64
** testing if installed package keeps a record of temporary installation path
* DONE (car)
* installing *source* package 'cpp11' ...
** package 'cpp11' successfully unpacked and MD5 sums checked
** using staged installation
Warning in parse(con, encoding = "UTF-8") :
  argument encoding="UTF-8" is ignored in MBCS locales
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
  converting help for package 'cpp11'
    finding HTML links ... done
    cpp11-package                           html  
    cpp_register                            html  
    cpp_source                              html  
    cpp_vendor                              html  
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
*** arch - i386
*** arch - x64
** testing if installed package can be loaded from final location
*** arch - i386
*** arch - x64
** testing if installed package keeps a record of temporary installation path
* DONE (cpp11)

The downloaded source packages are in
	‘C:\Users\admin\AppData\Local\Temp\RtmpYrfysL\downloaded_packages’
> 
> library('bibliometrix')
To cite bibliometrix in publications, please use:

Aria, M. & Cuccurullo, C. (2017) bibliometrix: An R-tool for comprehensive science mapping analysis, 
                                 Journal of Informetrics, 11(4), pp 959-975, Elsevier.
                        

https://www.bibliometrix.org

                        
For information and bug reports:
                        - Send an email to info@bibliometrix.org   
                        - Write a post on https://github.com/massimoaria/bibliometrix/issues
                        
Help us to keep Bibliometrix free to download and use by contributing with a small donation to support our research team (https://bibliometrix.org/donate.html)

                        
To start with the shiny web-interface, please digit:
biblioshiny()
```


#### 5
```
> biblioshiny()
载入需要的程辑包：shiny

Listening on http://127.0.0.1:7262
载入需要的程辑包：rio
The following rio suggested packages are not installed: ‘arrow’, ‘feather’, ‘fst’, ‘hexView’, ‘pzfx’, ‘readODS’, ‘rmarkdown’, ‘rmatio’, ‘xml2’
Use 'install_formats()' to install them
载入需要的程辑包：DT

载入程辑包：‘DT’

The following objects are masked from ‘package:shiny’:

    dataTableOutput, renderDataTable

载入需要的程辑包：ggplot2
载入需要的程辑包：shinycssloaders
载入需要的程辑包：shinythemes
载入需要的程辑包：wordcloud2
载入需要的程辑包：ggmap
Google's Terms of Service: https://cloud.google.com/maps-platform/terms/.
Please cite ggmap if you use it! See citation("ggmap") for details.
载入需要的程辑包：maps
载入需要的程辑包：visNetwork
载入需要的程辑包：plotly

载入程辑包：‘plotly’

The following object is masked from ‘package:ggmap’:

    wind

The following object is masked from ‘package:ggplot2’:

    last_plot

The following object is masked from ‘package:rio’:

    export

The following object is masked from ‘package:stats’:

    filter

The following object is masked from ‘package:graphics’:

    layout

Warning in name %in% fa_tbl$v4_name :
  strings not representable in native encoding will be translated to UTF-8
```



#### 4
```

> install_formats()
还安装相依关系‘assertthat’, ‘tinytex’


  有二进制版本的，但源代码版本是后来的:
        binary source needs_compilation
tinytex   0.34   0.35             FALSE

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/assertthat_0.2.1.zip'
Content type 'application/zip' length 54968 bytes (53 KB)
downloaded 53 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/arrow_6.0.0.2.zip'
Content type 'application/zip' length 20123246 bytes (19.2 MB)
downloaded 19.2 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/feather_0.3.5.zip'
Content type 'application/zip' length 889771 bytes (868 KB)
downloaded 868 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/fst_0.9.4.zip'
Content type 'application/zip' length 1514685 bytes (1.4 MB)
downloaded 1.4 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/hexView_0.3-4.zip'
Content type 'application/zip' length 98683 bytes (96 KB)
downloaded 96 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/pzfx_0.3.0.zip'
Content type 'application/zip' length 631046 bytes (616 KB)
downloaded 616 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/readODS_1.7.0.zip'
Content type 'application/zip' length 76591 bytes (74 KB)
downloaded 74 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/rmarkdown_2.11.zip'
Content type 'application/zip' length 3661405 bytes (3.5 MB)
downloaded 3.5 MB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/rmatio_0.16.0.zip'
Content type 'application/zip' length 973790 bytes (950 KB)
downloaded 950 KB

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/contrib/4.1/xml2_1.3.2.zip'
Content type 'application/zip' length 3007272 bytes (2.9 MB)
downloaded 2.9 MB

package ‘assertthat’ successfully unpacked and MD5 sums checked
package ‘arrow’ successfully unpacked and MD5 sums checked
package ‘feather’ successfully unpacked and MD5 sums checked
package ‘fst’ successfully unpacked and MD5 sums checked
package ‘hexView’ successfully unpacked and MD5 sums checked
package ‘pzfx’ successfully unpacked and MD5 sums checked
package ‘readODS’ successfully unpacked and MD5 sums checked
package ‘rmarkdown’ successfully unpacked and MD5 sums checked
package ‘rmatio’ successfully unpacked and MD5 sums checked
package ‘xml2’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\admin\AppData\Local\Temp\RtmpELxARi\downloaded_packages
安装源码包‘tinytex’

trying URL 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/src/contrib/tinytex_0.35.tar.gz'
Content type 'application/octet-stream' length 30624 bytes (29 KB)
downloaded 29 KB

* installing *source* package 'tinytex' ...
** package 'tinytex' successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
  converting help for package 'tinytex'
    finding HTML links ... done
    check_installed                         html  
    copy_tinytex                            html  
    install_tinytex                         html  
    is_tinytex                              html  
    latexmk                                 html  
    parse_install                           html  
    parse_packages                          html  
    r_texmf                                 html  
    tl_pkgs                                 html  
    tl_sizes                                html  
    tlmgr                                   html  
** building package indices
** testing if installed package can be loaded from temporary location
*** arch - i386
*** arch - x64
** testing if installed package can be loaded from final location
*** arch - i386
*** arch - x64
** testing if installed package keeps a record of temporary installation path
* DONE (tinytex)

The downloaded source packages are in
	‘C:\Users\admin\AppData\Local\Temp\RtmpELxARi\downloaded_packages’
[1] TRUE
```
