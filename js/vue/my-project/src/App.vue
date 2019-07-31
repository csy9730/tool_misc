<template>
  <div id="app">
    <h1>{{ msg }}</h1>
    <h1>{{ msg2 }}</h1>
    <img src="./assets/logo.png">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App',
  data () {
    return {
      msg: '欢迎来到菜鸟教程222！',
      msg2: '欢迎来到菜鸟教程333！'
    }
  }
}
</script>



<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
