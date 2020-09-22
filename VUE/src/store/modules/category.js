import axios from 'axios'

export default {
  state: {
    categorys: []
  },
  mutations: {
    data_category(state, payload) {
      state.categorys = payload.msg
      // state.categorys = payload.data
    }
  },
  actions: {
    act_get_category(context, payload) {
      axios
        .get(`${process.env.VUE_APP_BASE_URL}/category`)
        .then((response) => {
          console.log(response)
          context.commit('data_category', response.data)
        })
        .catch((error) => {
          console.log(error)
        })
    }
  },
  getters: {
    get_get_category(state) {
      return state.categorys
    }
  },
  created() {
    console.log(this.act_get_category())
  }
}
