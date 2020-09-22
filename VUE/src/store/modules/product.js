import axios from 'axios'

export default {
  state: {
    products: []
  },
  mutations: {
    data_product(state, payload) {
      state.products = payload.msg
    },
    changeProduct(state, newProducts) {
      state.products = newProducts
    }
  },
  actions: {
    async get_products(context, payload) {
      await axios
        .get(
          `${process.env.VUE_APP_BASE_URL}/product`
        )
        .then((response) => {
          console.log(response)
          context.commit('data_product', response.data)
          //   console.log(response)
        })
        .catch((error) => {
          console.log(error)
        })
    },
    add_product(context, payload) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${process.env.VUE_APP_BASE_URL}/product`, payload)
          .then(response => {
            resolve(response.data)
          })
          .catch(error => {
            reject(error.response)
          })
      })
    },
    changeProduct({
      commit
    }, newProducts) {
      commit('changeProduct', newProducts)
    }
  },
  getters: {
    get_product(state) {
      return state.products
    },
    getTotalRows(state) {
      return state.total_rows
    },
    getCart(state) {
      return state.cart
    }
  }
}
