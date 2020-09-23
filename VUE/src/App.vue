<template>
  <div id="app">
    <router-view />
  </div>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  name: 'app',
  methods: {
    ...mapActions(['interceptorsRequest', 'interceptorsResponse'])
  },
  created() {
    // console.log('hello')
    this.interceptorsRequest()
    this.interceptorsResponse()
  }
}
</script>

<style>
html,
body {
  margin: 0;
  padding: 0;
  height: 100%;
}
</style>
