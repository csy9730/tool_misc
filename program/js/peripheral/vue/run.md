# vue+electron

## 安装

``` bash
cnpm install @vue/cli -g
npm update @vue/cli -g # vue 3.9

vue create electron-vue-demo
cd electron-vue-demo
vue add electron-builder # 
# edit package.json to install  electron
cnpm install # 
```



``` bash


npm run build #  generate dist folder 
npm run electron:serve # running
npm run electron:build # generate dist_electron folder 
```



npm run electron:build代码已经是混淆

``` bash

.gitignore
babel.config.js
background.js
node_modules
package-lock.json
package.json
README.md
dist		# 
dist_electron
public
src
```



```text
vue -V


```

dist ：  

dist_electron：