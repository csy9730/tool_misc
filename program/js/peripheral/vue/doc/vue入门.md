# Vue入门

vue是典型地MVVC架构。

## demo
vue编程分为js部分和html模板部分。
js部分定义vue对象，内嵌了json结构的data和el字符串。
html5端的div通过id绑定vue::el实现渲染，data指定一个嵌套字典，div通过双大括号{{attr}}的形式访问data.attr，生成绑定。
methods是一个字典，包含多个函数，用于渲染动态生成的数据。
运行时改变vue内置变量的值，会立刻改变html，重新部分渲染生成的显示结果。

``` html
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Vue 测试实例 - 菜鸟教程(runoob.com)</title>    
    <!-- 开发环境版本，包含了有帮助的命令行警告 -->
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>	
    <div id="app">
        {{ message }}
    </div>
	<script type="text/javascript">
        var app = new Vue({
            el: '#app',
            data: {
                message: 'Hello Vue!'
            }
        })
	</script>
</body>
</html>
```

## v指令
v-bind 特性被称为指令
{{attr}}可以对文本实现替换（渲染），通过v-指令可以实现特殊的响应式行为，
如果你再次打开浏览器的 JavaScript 控制台，输入 app2.message = '新消息'，就会再一次看到这个绑定了 title 特性的 HTML 已经进行了更新

v-bind指令可以从js渲染数据到html，v-model可以从html传数据到js。
### 响应特性
响应指的是数据和UI显示的双向绑定流程，即改变数据会改变UI显示，改变UI显示会更新数据。
只有当实例被创建时就已经存在于 data 中的属性才是响应式的，所以对初始不存在或无效的待绑定数据，需要在Vue中设置一些初始值。

使用 Object.freeze()，这会阻止修改现有的属性，也意味着响应系统无法再追踪变化。
### 数据访问

``` javaScript
var data = { a: 1 }
var vm = new Vue({
  el: '#example',
  data: data
})

vm.$data === data // => true
vm.$el === document.getElementById('example') // => true

// $watch 是一个实例方法
vm.$watch('a', function (newValue, oldValue) {
  // 这个回调将在 `vm.a` 改变后调用
})
```
在命令行中可以直接用vm.a访问data的属性
### hook
每个 Vue 实例在被创建时都要经过一系列的初始化过程——例如，需要设置数据监听、编译模板、将实例挂载到 DOM 并在数据变化时更新 DOM 等。同时在这个过程中也会运行一些叫做生命周期钩子的函数，这给了用户在不同阶段添加自己的代码的机会。
比如 created 钩子可以用来在一个实例被创建之后执行代码：
``` javaScript
new Vue({
  data: {
    a: 1
  },
  created: function () {
    // `this` 指向 vm 实例
    console.log('a is: ' + this.a)
  }
})
// => "a is: 1"
```
也有一些其它的钩子，在实例生命周期的不同阶段被调用，如 mounted、updated 和 destroyed。生命周期钩子的 this 上下文指向调用它的 Vue 实例。

![234234](https://cn.vuejs.org/images/lifecycle.png)


v-html
v-once
Mustache 语法不能作用在 HTML 特性上，遇到这种情况应该使用 v-bind 指令：

，我们一直都只绑定简单的属性键值。但实际上，对于所有的数据绑定，Vue.js 都提供了完全的 JavaScript 表达式支持。
``` javaScript
{{ number + 1 }}
{{ ok ? 'YES' : 'NO' }}
{{ message.split('').reverse().join('') }}
<div v-bind:id="'list-' + id"></div>
```

模板表达式都被放在沙盒中，只能访问全局变量的一个白名单，如 Math 和 Date 。你不应该在模板表达式中试图访问用户定义的全局变量。

一些指令能够接收一个“参数”，在指令名称之后以冒号表示。例如，v-bind 指令可以用于响应式地更新 HTML 特性：
`<a v-bind:href="url">...</a>`
在这里 href 是参数，告知 v-bind 指令将该元素的 href 特性与表达式 url 的值绑定。
另一个例子是 v-on 指令，它用于监听 DOM 事件：
`<a v-on:click="doSomething">...</a>`
动态参数
`<a v-bind:[attributeName]="url"> ... </a>`

v-bind 缩写`:` , v-on 缩写`@`


## computed
computed与method类似，
``` javaScript
var vm = new Vue({
  el: '#example',
  data: {
    message: 'Hello'
  },
  computed: {
    // 计算属性的 getter
    reversedMessage: function () {
      // `this` 指向 vm 实例
      return this.message.split('').reverse().join('')
    }
  }
})
```
我们可以将同一函数定义为一个方法而不是一个计算属性。两种方式的最终结果确实是完全相同的。然而，不同的是计算属性是基于它们的响应式依赖进行缓存的。只在相关响应式依赖发生改变时它们才会重新求值。这就意味着只要 message 还没有发生改变，多次访问 reversedMessage 计算属性会立即返回之前的计算结果，而不必再次执行函数。
这也同样意味着下面的计算属性将不再更新，因为 Date.now() 不是响应式依赖：
```
computed: {
  now: function () {
    return Date.now()
  }
}
```
computed函数有绑定变量这个依赖列表。
计算属性默认只有 getter ，不过在需要时你也可以提供一个 setter ：

### watch