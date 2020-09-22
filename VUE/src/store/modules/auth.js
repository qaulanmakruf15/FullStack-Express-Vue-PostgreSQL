import axios from 'axios'
import router from '../../router/index'

export default {
  state: {
    user: {},
    token: localStorage.getItem('token') || null // or or kalo ga ada null
  },
  mutations: {
    dataUser(state, payload) {
      state.user = payload
      state.token = payload.token
    },
    delUser(state) {
      state.user = {}
      state.token = null
    }
  },
  actions: {
    login(context, payload) {
      return new Promise((resolve, reject) => {
        axios.post(`${process.env.VUE_APP_BASE_URL}/user/login`, payload).then(response => {
          context.commit('dataUser', response.data.data)
          localStorage.setItem('token', response.data.data.token)
          resolve(response.data.data)
        }).catch(error => {
          reject(error.response)
        })
      })
    },
    register(context, payload) {
      return new Promise((resolve, reject) => {
        axios.post(`${process.env.VUE_APP_BASE_URL}/user/register`, payload).then(response => {
          resolve(response.data.data)
        }).catch(error => {
          reject(error.response)
        })
      })
    },
    logout(context) {
      localStorage.removeItem('token')
      context.commit('delUser')
      router.push('/login')
    },
    interceptorsRequest(context) {
      axios.interceptors.request.use(function (config) {
        config.headers.Authorization = `Bearer ${context.state.token}`
        return config
      }, function (error) {
        return Promise.reject(error)
      })
    },
    interceptorsResponse(context) {
      axios.interceptors.response.use(function (response) {
        return response
      }, function (error) {
        console.log(error.response)
        if (error.response.status === 403) {
          if (error.response.data.msg === 'invalid token' || error.response.data.msg === 'invalid signature') {
            localStorage.removeItem('token')
            context.commit('delUser')
            router.push('/login')
            alert('Sorry your token invalid. cant access this pages')
          } else if (error.response.data.msg === 'jwt expired') {
            localStorage.removeItem('token')
            context.commit('delUser')
            router.push('/login')
            alert('Sorry your token expired. Cant access this pages')
          }
        }
        return Promise.reject(error)
      })
    }
  },
  getters: {
    isLogin(state) {
      return state.token !== null
    },
    data_user(state) {
      return state.user
    }
  }
}
