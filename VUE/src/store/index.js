import Vue from 'vue'
import Vuex from 'vuex'
import Auth from './modules/auth'
import Product from './modules/product'
import Category from './modules/category'
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    Auth,
    Product,
    Category
  },
  state: {
    name: 'Qaulan Makruf'
  },
  mutations: {},
  actions: {},
  getters: {},
  plugins: [createPersistedState({ path: ['Auth.user'], storage: window.sessionStorage })]
})
