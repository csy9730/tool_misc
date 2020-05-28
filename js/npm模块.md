# npm

## entry
vue是js脚本,位于C:\Users\admin\AppData\Roaming\npm\node_modules\vue-cli\bin

## package

package.json,位于C:\Users\admin\AppData\Roaming\npm\node_modules\vue-cli
``` json
{
  "name": "vue-cli",
  "version": "2.9.6",
  "description": "A simple CLI for scaffolding Vue.js projects.",
  "preferGlobal": true,
  "bin": {
    "vue": "bin/vue",
    "vue-init": "bin/vue-init",
    "vue-list": "bin/vue-list"
  },
    "scripts": {
    "test": "npm run lint && npm run e2e",
    "lint": "eslint test/e2e/test*.js lib bin/* --env mocha",
    "e2e": "rimraf test/e2e/mock-template-build && mocha test/e2e/test.js --slow 1000"
  },
}
```

通过`npm run hello`调用scripts的入口
## command
建立命令行的快捷方式
[vue-cli@2.9.6] link C:\Users\admin\AppData\Roaming\npm\vue@ -> C:\Users\admin\AppData\Roaming\npm\node_modules\vue-cli\bin\vue
[vue-cli@2.9.6] link C:\Users\admin\AppData\Roaming\npm\vue-init@ -> C:\Users\admin\AppData\Roaming\npm\node_modules\vue-cli\bin\vue-init
[vue-cli@2.9.6] link C:\Users\admin\AppData\Roaming\npm\vue-list@ -> C:\Users\admin\AppData\Roaming\npm\node_modules\vue-cli\bin\vue-list

