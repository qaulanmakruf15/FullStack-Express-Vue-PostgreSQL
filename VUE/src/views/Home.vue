<template>
  <div class="d-flex" id="wrapper">
    <!-- Sidemenu -->
    <div class="sidemenu-box" id="sidemenu-wrapper">
      <b-row
        class="sidemenu-header-box text-center align-items-center"
        style="box-shadow: 0 0px 6px -2px gray; #ffff 1px solid;"
      >
        <b-col xl="12" style>
          <button class="btn-custom" id="menu-toggle">
                    <img src="../assets/images/icons/menu.png" style="width: 30px; height: 30px; margin-top: -5px" />
                  </button>
        </b-col>
      </b-row>
      <b-row class="sidemenu-header-box text-center align-items-center">
        <b-col xl="12">
          <!-- <a href="/" class="modify-link-text"> -->
          <router-link to="/">
            <img src="../assets/images/icons/fork.png" style="width: 40px; height: 40px;" />
          </router-link>
          <!-- </a> -->
        </b-col>
      </b-row>
      <b-row class="sidemenu-header-box text-center align-items-center">
        <b-col xl="12">
          <!-- <a href="/history" class="modify-link-text"> -->
          <router-link to="/history">
            <img src="../assets/images/icons/clipboard.png" style="width: 40px; height: 40px;" />
          </router-link>
          <!-- </a> -->
        </b-col>
      </b-row>
      <b-row class="sidemenu-header-box text-center align-items-center">
        <b-col xl="12">
          <b-button v-b-modal.modal-lg style="background-color: transparent; border: none;">
            <img src="../assets/images/icons/add.png" style="width: 40px; height: 40px;" />
          </b-button>
        </b-col>
      </b-row>

      <b-row
        v-if="data_user.role_id===2"
        class="sidemenu-header-box text-center align-items-center"
      >
        <b-col xl="12">
          <b-button v-b-modal.modal-lg style="background-color: transparent; border: none;">
            <img src="../assets/images/icons/add.png" style="width: 40px; height: 40px;" />
          </b-button>
        </b-col>
      </b-row>
      <b-row v-else class="sidemenu-header-box text-center align-items-center"></b-row>
    </div>
    <!-- End sidemenu -->
    <!-- Modal -->
    <b-modal id="modal-lg" size="md" :title="this.modalTitle" hide-footer>
      <b-alert :show="varAlert">{{this.varAlertMessage}} Product Success</b-alert>
      <b-alert :show="alert_image" class="small form-text text-muted">Max image is 1024 kb</b-alert>
      <b-form v-on:submit.prevent="addProduct">
        <!-- .prevent mengatasi reload -->
        <b-form-group id="input-group-1" label="Product Name" label-for="input-1">
          <b-form-input
            v-model="form.name"
            id="input-1"
            type="text"
            required
            placeholder="Product Name"
          ></b-form-input>
        </b-form-group>

        <b-form-group id="input-group-2" label="Image" label-for="input-2">
          <b-form-file @change="handle_file" id="input-2" required placeholder="Image"></b-form-file>
        </b-form-group>

        <b-form-group id="input-group-3" label="Category" label-for="input-3">
          <b-form-select v-model="form.id_category" class="mb-3" :options="selectCategoryStatus">
            <b-form-select-option
              v-for="(valueCategory, index) in categorys"
              :key="index"
              :value="`${valueCategory.category_id}`"
            >{{valueCategory.category_name}}</b-form-select-option>
          </b-form-select>
        </b-form-group>

        <b-form-group id="input-group-3" label="Status" label-for="input-3">
          <b-form-select v-model="form.status" id="input-3" :options="selectOptionStatus"></b-form-select>
        </b-form-group>

        <b-form-group id="input-group-4" label="Price" label-for="input-4">
          <b-form-input v-model="form.price" id="input-4" placeholder="Price"></b-form-input>
        </b-form-group>
        <b-row>
          <b-col sm="8">
            <b-button type="submit" v-if="buttonModalSave" variant="success">Save</b-button>
            <b-button type="button" v-else variant="info" @click="editProduct()">Edit</b-button>
          </b-col>
          <b-col sm="4" align-self="end">
            <b-button
              type="button"
              v-b-modal.modal-category
              variant="primary"
              style="margin: auto;"
            >Add Category</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-modal>
    <!-- End Modal -->
    <!-- Modal Category-->
    <b-modal id="modal-category" size="md" title="Add Category" hide-footer>
      <b-alert :show="varAlert">{{this.varAlertMessage}} Product Success</b-alert>
      <b-form v-on:submit.prevent="add_category">
        <b-form-group id="input-group-4" label="Price" label-for="input-4">
          <b-form-input v-model="form_category.name" id="input-4" placeholder="Category name"></b-form-input>
        </b-form-group>

        <b-button type="submit" variant="success">Save</b-button>
      </b-form>
    </b-modal>
    <!-- End Modal -->
    <!-- Modal Checkout-->
    <b-modal id="modal-checkout" size="md" title="Add Category" hide-footer hide-header>
      <b-row>
        <b-col sm="6">
          <p class="font-medium">Checkout</p>
        </b-col>
        <b-col sm="6" class="text-right">
          <p class="font-medium">Receipt no: #{{this.invoice}}</p>
        </b-col>
        <b-col sm="12" style="margin-top: -15px; margin-bottom: 15px">
          <p class="font-book">Cashier: Pevita Pierce</p>
        </b-col>
        <b-col sm="12" v-for="(checkoutItem, index) in cart" :key="index">
          <p class="font-medium">
            {{checkoutItem.product_name}} {{checkoutItem.qty}}x
            <span
              class="float-right"
            >Rp. {{(checkoutItem.product_price * checkoutItem.qty).toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.')}}</span>
          </p>
        </b-col>
        <b-col sm="12">
          <p
            class="font-medium text-right"
          >Total: Rp. {{TotalCart().toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.')}}</p>
        </b-col>
        <b-col sm="12">
          <p class="font-medium">Payment: Cash</p>
        </b-col>
        <b-col sm="12">
          <b-button
            @click="checkout"
            v-b-modal.modal-checkout
            variant="info"
            size="md"
            style="width: 100%; background-color:#F24F8A; margin-bottom: 5px;"
          >Print</b-button>
        </b-col>
        <b-col sm="12">
          <p class="font-medium text-center" style="margin-bottom: 5px;">Or</p>
        </b-col>
        <b-col sm="12">
          <b-button variant="info" size="md" style="width: 100%;">Send Email</b-button>
        </b-col>
      </b-row>
    </b-modal>
    <!-- End Modal -->

    <div id="page-content-wrapper">
      <b-container fluid>
        <!-- Header -->
        <b-row style="margin-left:0px;">
          <b-col xl="8" md="7" sm="7" xs="12" class="navbarOne">
            <b-container>
              <b-row>
                <b-col xl="1" lg="2" md="2" sm="2" class="col-2" style="margin-top: 15px;">
                  <!-- <button class="btn-custom" id="menu-toggle">
                    <img src="../assets/images/icons/menu.png" style="width: 30px; height: 30px" />
                  </button> -->
                </b-col>
                <b-col xl="10" lg="8" md="8" sm="8" class="col-8 text-center" style="margin-top: 14px;"
                >
                  <p style="font-size:26px">Food Items</p>
                </b-col>
                <b-col xl="1" lg="2" md="2" sm="2" xs="1" class="col-2" style="margin-top: 20px;">
                  <button class="btn-custom">
                    <a @click="logout">
                      <img
                        src="../assets/images/icons/logout.png"
                        style="width: 30px; height: 30px"
                      />
                    </a>
                  </button>
                </b-col>
              </b-row>
            </b-container>
          </b-col>
          <b-col xl="4" md="5" sm="5" class="navbarTwo text-center">
            <div class="d-flex justify-content-center">
              <p style="font-size: 30px; margin-top: 10px">Cart</p>
              <div
                style="width: 30px; height: 30px; background-color: #57CAD5; border-radius: 50px; margin-top: 18px; margin-left:5px;"
              >
                <p style="font-size: 25px; margin-top: -5px;color:white;">{{this.cart.length}}</p>
              </div>
            </div>
          </b-col>
        </b-row>

        <!-- End Header -->
        <!-- Content -->
        <b-row style="margin-left:0px;">
          <b-col xl="12" md="12" sm="12" class="background-content">
            <!-- Food Items -->
            <b-row>
              <b-col
                xl="8"
                md="7"
                sm="7"
                style="padding-right: 30px;padding-left: 30px;padding-top: 20px;"
              >
                <b-container fluid>
                  <b-row>
                    <b-col xl="12" style="margin-bottom: 15px;">
                      <b-form inline class="float-right" v-on:submit.prevent="search_product">
                        <b-input
                          id="inline-form-input-name"
                          class="mb-2 mr-sm-2 mb-sm-0"
                          placeholder="Search Product"
                          v-model="search"
                        ></b-input>

                        <b-dropdown
                          id="sort"
                          :text="sortText"
                          class="m-2 sort-btn"
                          variant="primary"
                        >
                          <b-dropdown-item-button @click="sort_category()" active>Category</b-dropdown-item-button>
                          <b-dropdown-divider></b-dropdown-divider>
                          <b-dropdown-group id="dropdown-group-1" header="Name">
                            <b-dropdown-item-button @click="sort_asc()">A-Z</b-dropdown-item-button>
                            <b-dropdown-item-button @click="sort_desc()">Z-A</b-dropdown-item-button>
                          </b-dropdown-group>
                          <b-dropdown-divider></b-dropdown-divider>
                          <b-dropdown-group id="dropdown-group-2" header="Date">
                            <b-dropdown-item-button @click="sort_date_asc()">Oldest</b-dropdown-item-button>
                            <b-dropdown-item-button @click="sort_date_desc()">Newest</b-dropdown-item-button>
                          </b-dropdown-group>
                          <b-dropdown-divider></b-dropdown-divider>
                          <b-dropdown-group id="dropdown-group-3" header="Price">
                            <b-dropdown-item-button @click="sort_price_asc()">Lowest</b-dropdown-item-button>
                            <b-dropdown-item-button @click="sort_price_desc()">Highest</b-dropdown-item-button>
                          </b-dropdown-group>
                        </b-dropdown>
                        <b-button type="submit" variant="primary">Find</b-button>
                      </b-form>
                    </b-col>

                    <b-col xl="4" lg="6" md="12" v-for="(item, index) in products" :key="index">
                      <b-card
                        img-src="https://images.unsplash.com/photo-1546619034-1eebcb08bb87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
                        img-alt="Image"
                        img-top
                        class="custom-card"
                      >
                        <b-card-text class="custom-card-text-name font-book">{{item.name}}</b-card-text>
                        <b-card-text
                          class="custom-card-text-price font-medium"
                        >Rp. {{item.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.') }}</b-card-text>
                        <b-button variant="primary" @click="addToCart(item)" size="sm">Add</b-button>
                        <b-button
                          variant="info"
                          v-b-modal.modal-lg
                          @click="setUpdateProduct(item)"
                          size="sm"
                        >Edit</b-button>
                        <b-button variant="danger" @click="deleteProduct(item.id)" size="sm">Delete</b-button>
                      </b-card>
                    </b-col>
                  </b-row>
                </b-container>
              </b-col>
              <!-- End Food Items -->
              <!-- Cart -->
              <b-col xl="4" md="5" sm="5" xs="12" style="background-color: white;">
                <b-row>
                  <b-col xl="12" v-if="cart.length > 0">
                    <div class="mt-3 mr-3" v-for="(item, index) in cart" :key="index">
                      <b-card
                        img-src="https://images.unsplash.com/photo-1543392883-914cfa6f9ed4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
                        img-alt="Card image"
                        img-left
                        class="custom-card-cart custom-padding-cart-body"
                        style="border: none;"
                      >
                        <b-card-text style="font-family: AirbnbMedium;">{{item.product_name}}</b-card-text>

                        <b-button
                          variant="primary"
                          size="sm"
                          class="cart-qty"
                          @click="qtyMin(item)"
                        >-</b-button>
                        <b-button
                          variant="primary"
                          size="sm"
                          class="cart-qty"
                          style="background-color:white; font-weight: italic; border-left: none; border-right: none;"
                        >{{item.qty}}</b-button>
                        <b-button
                          variant="primary"
                          size="sm"
                          class="cart-qty"
                          @click="qtyPlus(item)"
                        >+</b-button>
                        <b-button
                          variant="primary"
                          size="sm"
                          style="margin-left: 60px; font-family: airBnbMedium; background-color: white; color: black; border: none;"
                        >Rp. {{(item.product_price * item.qty).toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.')}}</b-button>
                      </b-card>
                    </div>
                    <!-- Checkout -->
                    <b-container>
                      <b-row>
                        <b-col xl="4" style="margin-top: 20px;">
                          <p>Total:</p>
                        </b-col>
                        <b-col xl="8" style="margin-top: 20px;">
                          <p
                            class="text-right"
                          >Rp. {{TotalCart().toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.')}} *</p>
                        </b-col>
                        <b-col xl="12" style="margin-top: 5px;">
                          <b-button
                            @click="checkout"
                            v-b-modal.modal-checkout
                            squared
                            variant="info"
                            size="md"
                            style="width: 100%;"
                          >Checkout</b-button>
                        </b-col>
                        <b-col xl="12" style="margin-top: 10px;">
                          <b-button
                            @click="reset_cart()"
                            squared
                            variant="danger"
                            size="md"
                            style="width: 100%;"
                          >Cancel</b-button>
                        </b-col>
                      </b-row>
                    </b-container>
                  </b-col>

                  <b-col xl="12" v-else>
                    <div class="text-center">
                      <img
                        src="../assets/images/icons/food_sidebar.png"
                        style="width: 250px; margin-top: 50px;"
                        class="col-12"
                        md="12"
                        sm="12"
                        xs="12"
                      />
                      <p
                        style="font-size: 25px; font-weight: regular; line-height: 10pt; margin-top: -20px;"
                      >Your cart is empty</p>
                      <p
                        style="font-size: 15px; font-weight: semi-bold;color: #CECECE;"
                      >Please add some items from the menu</p>
                    </div>
                  </b-col>
                </b-row>
              </b-col>
              <!-- End Cart -->
            </b-row>
          </b-col>
        </b-row>
        <footer style="background-color: white;">
          <b-row>
            <b-col xl="12" class="footers text-center">
              <p style="margin-top: 10px;"></p>
            </b-col>
          </b-row>
        </footer>
        <!-- End Content -->
      </b-container>
    </div>
    <!-- end wrapper -->
  </div>
  <!-- end flex -->
</template>

<script>
import axios from 'axios'
import { mapActions } from 'vuex'

export default {
  name: 'Axios',
  data() {
    return {
      categorys: [],
      cart: [],
      invoice: Math.floor(Math.random() * 1000000000 + 1),
      search: '',
      sort: '',
      sortText: 'Sort',
      varAlertMessage: '',
      alert_image: false,
      modalTitle: 'Add Product',
      productId: '',
      buttonModalSave: true,
      selectOptionStatus: [
        { value: '1', text: 'Active' },
        { value: '0', text: 'Non Active' }
      ],
      selectCategoryStatus: [
        { value: '1', text: 'Food' },
        { value: '2', text: 'Drink' }
      ],
      form: {
        name: '',
        image: {},
        id_category: '',
        price: '',
        status: ''
      },
      form_category: {
        name: ''
      },
      varAlert: false
    }
  },
  computed: {
    products() {
      return this.$store.getters.get_product
    },
    rows() {
      return this.$store.getters.getTotalRows
    },
    data_user() {
      return this.$store.getters.data_user
    }
  },
  created() {
    this.get_products()
    this.get_category()
  },
  methods: {
    ...mapActions(['get_products', 'logout', 'add_product']),
    checkout() {
      const setCart = {
        orders: [...this.cart]
      }
      axios
        .post(`${process.env.VUE_APP_BASE_URL}/order`, setCart)
        .then((response) => {})
        .catch((error) => {
          console.log(error)
        })
    },
    qtyPlus(data) {
      const incrementData = this.cart.find(
        (value) => value.product_id === data.product_id
      )
      incrementData.qty += 1
      incrementData.price = data.product_price * data.qty
      incrementData.ppn = (data.price * 5) / 100
    },
    qtyMin(data) {
      const incrementData = this.cart.find(
        (value) => value.product_id === data.product_id
      )
      incrementData.qty -= 1
    },
    addToCart(data) {
      const setCart = {
        invoice: this.invoice,
        product_id: data.id,
        product_name: data.name,
        product_image: data.image,
        product_price: data.price,
        price: data.price * 1,
        ppn: (data.price * 5) / 100,
        qty: 1
      }
      const fixedData = [...this.cart, setCart]
      const addedItem = fixedData.find((item) => item.product_id === data.id)
      const existItem = this.cart.find((item) => item.product_id === data.id)
      if (existItem) {
        addedItem.qty += 1
      } else {
        this.cart = [...this.cart, setCart]
      }
    },
    TotalCart() {
      let total = 0
      for (let i = 0; i < this.cart.length; i++) {
        total += this.cart[i].product_price * this.cart[i].qty
      }
      return total
    },
    reset_cart() {
      this.cart = []
    },
    get_category() {
      axios
        .get(`${process.env.VUE_APP_BASE_URL}/category`)
        .then((response) => {
          this.categorys = response.data.data
        })
        .catch((error) => {
          console.log(error)
        })
    },
    sort_category() {
      this.sortText = 'Category'
      this.sort = 'id_category'
      this.get_products()
    },
    sort_asc() {
      if (this.sort === 'name desc') {
        this.get_products()
      } else {
        axios
          .get(`${process.env.VUE_APP_BASE_URL}/product/ordername`)
          .then((response) => {
            this.$store.dispatch('changeProduct', response.data.data || response.data.msg)
          })
          .catch((error) => {
            console.log(error)
          })
      }
    },
    // sort_asc() {
    //   this.sortText = 'Name (A-Z)'
    //   this.sort = 'name asc'
    //   // this.get_products()
    //   this.$store.dispatch('changeProduct', this.get_products)
    // },
    sort_desc() {
      this.sort = 'Name (Z-A)'
      this.sort = 'name desc'
      this.get_products()
    },
    sort_date_asc() {
      this.sort = 'Date (Newest)'
      this.sort = 'created asc'
      this.get_products()
    },
    sort_date_desc() {
      this.sort = 'Date (Oldest)'
      this.sort = 'created desc'
      this.get_products()
    },
    sort_price_asc() {
      if (this.sort === 'price ASC') {
        this.get_products()
      } else {
        axios
          .get(`${process.env.VUE_APP_BASE_URL}/product/orderprice`)
          .then((response) => {
            this.$store.dispatch('changeProduct', response.data.data || response.data.msg)
          })
          .catch((error) => {
            console.log(error)
          })
      }
    },
    // sort_price_asc() {
    //   this.sortText = 'Price (Lowest)'
    //   this.sort = 'price ASC'
    //   this.get_products()
    // },
    sort_price_desc() {
      this.sortText = 'Price (Highest)'
      this.sort = 'price DESC'
      this.get_products()
    },
    search_product() {
      if (this.search === '') {
        this.get_products()
      } else {
        axios
          .get(`${process.env.VUE_APP_BASE_URL}/product/search?search=${this.search}`)
          .then((response) => {
            this.$store.dispatch('changeProduct', response.data.data || response.data.msg)
            // console.log(this.products)
          })
          .catch((error) => {
            console.log(error)
          })
      }
    },
    add_category() {
      axios
        .post(`${process.env.VUE_APP_BASE_URL}/category`, this.form_category)
        .then((response) => {
          this.form_category = []
          this.get_category()
        })
        .catch((error) => {
          console.log(error)
        })
    },
    handle_file(event) {
      this.form.image = event.target.files[0]
      console.log(this.form.image.size)
      if (this.form.image.size >= 1000000) {
        this.alert_image = true
      } else {
        this.alert_image = false
      }
    },
    addProduct() {
      this.modalTitle = 'Add Product'
      const data = new FormData()
      data.append('name', this.form.name)
      data.append('id_category', this.form.id_category)
      data.append('price', this.form.price)
      data.append('status', this.form.status)
      data.append('image', this.form.image)
      this.add_product(data)
        .then((response) => {
          this.varAlertMessage = 'Add'
          this.varAlert = true
          this.form = []
          this.get_products()
        })
        .catch((error) => {
          console.log(error)
        })
    },
    setUpdateProduct(data) {
      this.modalTitle = 'Edit Product'
      this.buttonModalSave = false
      this.varAlert = false
      this.form = {
        name: data.name,
        image: data.image,
        id_category: data.category_id,
        price: data.price,
        status: data.status
      }
      this.productId = data.id
    },
    editProduct(data) {
      axios
        .patch(`${process.env.VUE_APP_BASE_URL}/product/${this.productId}`, this.form)
        .then((response) => {
          this.varAlertMessage = 'Edit'
          this.varAlert = true
          this.form = [] // Check this if error
          this.buttonModalSave = true
          this.get_products()
        })
        .catch((error) => {
          console.log(error)
        })
    },
    deleteProduct(id) {
      axios
        .delete(`${process.env.VUE_APP_BASE_URL}/product/${id}`)
        .then((response) => {
          this.get_products()
        })
        .catch((error) => {
          console.log(error)
        })
    }
  }
}
</script>

<style scoped>
/* Global */
@font-face {
  font-family: 'AirbnbMedium';
  src: url('../assets/fonts/AirbnbCerealMedium.ttf');
}
@font-face {
  font-family: 'AirbnbBook';
  src: url('../assets/fonts/AirbnbCerealBook.ttf');
}
.font-medium {
  font-family: AirbnbMedium;
}
.font-book {
  font-family: AirbnbBook;
}
/* Modify Bootstrap */
.container-fluid {
  padding-right: 0;
  padding-left: 0;
  margin-right: auto;
  margin-left: auto;
}
.card-img-left .card-body {
  padding-top: 0px;
}
/* Wrapper */
#wrapper {
  overflow: hidden;
}
.background-content {
  background-color: rgba(190, 195, 202, 0.3);
  height: 100%;
}
/* Custom Style */
.custom-card {
  background-color: transparent;
  border: none;
  font-size: 16pt;
}
.custom-card img {
  object-fit: cover;
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
}
.custom-card-cart img {
  width: 90px;
  height: 90px;
  object-fit: cover;
  margin: auto;
  margin-left: 10px;
}
@media (max-width: 576px) {
  .custom-card img {
    object-fit: cover;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
  }
}
@media (min-width: 992px) {
  .custom-card img {
    width: 240px;
    height: 180px;
    object-fit: cover;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
  }
}
.custom-card-text-name {
  margin-left: -10px;
  margin-top: -15px;
}
.custom-card-text-price {
  margin-left: -10px;
  margin-top: -20px;
}
.btn-custom {
  background-color: transparent;
  border: none;
}
.custom-padding-cart-body .card-body {
  padding-top: 5px;
}
.cart-qty {
  border-radius: 0;
  border: 1px solid #82de3a;
  background-color: rgba(130, 222, 58, 0.2);
  color: #82de3a;
  font-family: AirbnbMedium;
  font-weight: bold;
}
/* Navbar */
.navbarOne {
  height: 70px;
  /* padding-left:10px; */
  background-color: #ffffff;
  box-shadow: 0 0px 6px -2px ffff;
  border-left: none;
  border-right: #ffff 1px solid;
  z-index: 1;
}
.navbarTwo {
  height: 70px;
  background-color: #ffffff;
  box-shadow: 0 0px 6px -2px gray;
  border-left: none;
  border-right: #cecece 1px solid;
  z-index: 1;
}
@media (max-width: 576px) {
  .navbarOne {
    box-shadow: none;
  }
  .navbarTwo {
    box-shadow: none;
  }
}
/* Sidemenu */
.sidemenu-box {
  width: 90px;
  height: 100%;

}
#sidemenu-wrapper {
  min-height: 100vh;
  margin-left: 0;
  -webkit-transition: margin 0.25s ease-out;
  -moz-transition: margin 0.25s ease-out;
  -o-transition: margin 0.25s ease-out;
  transition: margin 0.25s ease-out;
}
.sidemenu-header-box {
  height: 70px;
  font-size: 25px;
}
.modify-link-text {
  text-decoration: none;
  color: black;
}
.modify-link-text:hover {
  text-decoration: none;
  color: black;
}
#page-content-wrapper {
  width: 100%;
}
#wrapper.toggled #sidemenu-wrapper {
  /* margin-left: 0; */
  margin-left: -6rem;
}
/* Footer */
.footers {
  width: 100%;
  height: 20px;
}
</style>
