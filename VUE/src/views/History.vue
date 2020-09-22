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
    </div>
    <!-- End sidemenu -->

    <div id="page-content-wrapper">
      <b-container fluid>
        <!-- Header -->
        <b-row style="margin-left:0px;">
          <b-col xl="12" md="12" sm="12" xs="12" class="navbarOne">
            <b-container fluid>
              <b-row>
                <b-col
                  xl="10"
                  lg="8"
                  md="8"
                  sm="8"
                  class="col-8 text-center"
                  style="margin-top: 5px;"
                >
                  <p style="font-size: 25px; margin-top: 10px">Food Items</p>
                </b-col>
              </b-row>
            </b-container>
          </b-col>
        </b-row>
        <!-- End Header -->
        <!-- Modal -->
        <b-modal id="modal-lg" size="md" :title="this.modalTitle" hide-footer>
          <b-alert :show="varAlert">{{this.varAlertMessage}} Product Success</b-alert>
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
              <b-form-input v-model="form.image" id="input-2" required placeholder="Image"></b-form-input>
            </b-form-group>

            <b-form-group id="input-group-3" label="Category" label-for="input-3">
              <b-form-select v-model="form.id_category" class="mb-3">
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
        <!-- Content -->
        <b-row style="margin-left:0px;">
          <b-col xl="12" md="12" sm="12" class="background-content">
            <!-- Food Items -->
            <b-row>
              <b-col sm="12" style="padding-right: 30px;padding-left: 30px;padding-top: 20px;">
                <b-container fluid>
                  <b-row>
                    <b-col sm="4">
                      <div class="card">
                        <div
                          class="card-body"
                          style="background-image: linear-gradient(-90deg, #FBB2B4, rgba(255, 143, 178, 0.25));"
                        >
                          <p class="card-text">Today's Income</p>
                          <h5
                            class="card-title"
                          >Rp. {{(this.card_todayIncome).toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.')}}</h5>
                          <p class="card-text">+2% Yesterday</p>
                        </div>
                      </div>
                    </b-col>
                    <b-col sm="4">
                      <div class="card">
                        <div
                          class="card-body"
                          style="background-image: linear-gradient(-90deg, #29DFFF, rgba(41, 223, 255, 0.25));"
                        >
                          <p class="card-text">Orders</p>
                          <h5
                            class="card-title"
                          >Rp. {{(this.card_order).toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.')}}</h5>
                          <p class="card-text">+5% Lastweek</p>
                        </div>
                      </div>
                    </b-col>
                    <b-col sm="4">
                      <div class="card">
                        <div
                          class="card-body"
                          style="background-image: linear-gradient(-90deg, #AB84C8, rgba(241, 201, 236, 0.25));"
                        >
                          <p class="card-text">This Year's Income</p>
                          <h5
                            class="card-title"
                          >Rp. {{(this.card_yearIncome).toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.')}}</h5>
                          <p class="card-text">+10% Lastyear</p>
                        </div>
                      </div>
                    </b-col>
                    <b-col sm="12" style="margin-top: 20px;">
                      <b-container fluid style="background-color: white; border-radius:5px;">
                        <b-row>
                          <b-col sm="12">
                            <div style="margin-left: 20px; margin-top: 20px;">
                              <h4 class="font-medium">Revenue</h4>
                            </div>
                            <line-chart :data="chart_thisMonth" />
                          </b-col>
                        </b-row>
                      </b-container>
                    </b-col>
                    <b-col sm="12" style="margin-top: 20px; margin-bottom: 30px;">
                      <div style="background-color: white; border-radius: 5px;padding: 20px;">
                        <h4 class="font-medium">Recent Order</h4>
                        <b-table striped hover :items="order" :fields="tableFields"></b-table>
                      </div>
                    </b-col>
                  </b-row>
                </b-container>
              </b-col>
              <!-- End Food Items -->
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

export default {
  name: 'Axios',
  data() {
    return {
      data: [
        {
          name: 'This Month',
          data: {
            '2020-01-01': 30000,
            '2020-01-02': 40000,
            '2020-01-03': 23000,
            '2020-01-04': 10000,
            '2020-01-05': 13000,
            '2020-01-06': 2000,
            '2020-01-07': 7000,
            '2020-01-08': 320000,
            '2020-01-09': 11000
          }
        },
        {
          name: 'Last Month',
          data: {
            '2020-01-01': 3,
            '2020-01-02': 4,
            '2020-01-03': 7,
            '2020-01-04': 1,
            '2020-01-05': 25,
            '2020-01-06': 2,
            '2020-01-07': 1,
            '2020-01-08': 32,
            '2020-01-09': 11
          }
        }
      ],
      this_months: '',
      last_months: '',
      tableFields: ['invoices', 'cashiers', 'dates', 'names', 'subtotals'],
      tableItems: [],
      orderDummy: [],
      order: [],
      products: [],
      categorys: [],
      cart: [],
      card_todayIncome: '',
      card_order: '',
      card_yearIncome: '',
      chart_thisMonth: [],
      chart_lastMonth: '',
      invoice: Math.floor(Math.random() * 1000000000 + 1),
      varAlertMessage: '',
      modalTitle: 'Add Product',
      productId: '',
      buttonModalSave: true,
      selectOptionStatus: [
        { value: '1', text: 'Active' },
        { value: '0', text: 'Non Active' }
      ],
      form: {
        name: '',
        image: '',
        id_category: '',
        price: '',
        status: ''
      },
      form_category: {
        name: ''
      },
      varAlert: false,
      totalRows: null
    }
  },
  computed: {
    rows() {
      return this.totalRows
    }
  },
  created() {
    this.get_order()
    this.today_incomes()
    this.orders()
    this.years_income()
    this.thisMonth()
    this.lastMonth()
  },
  methods: {
    get_order() {
      axios
        .get(`${process.env.VUE_APP_BASE_URL}/order`)
        .then((response) => {
          this.orderDummy = response.data.data
          this.orderDummy.map((value) => {
            const setItem = {
              invoices: `#${value.invoices}`,
              cashiers: 'Pevita Pierce',
              dates: value.dates.slice(0, 10),
              names: value.names,
              subtotals: `Rp. ${value.subtotals
                .toString()
                .replace(/\B(?=(\d{3})+(?!\d))/g, '.')}`
            }
            this.order = [...this.order, setItem]
          })
        })
        .catch((error) => {
          console.log(error)
        })
    },
    today_incomes() {
      axios
        .get(`${process.env.VUE_APP_BASE_URL}/order/today_income`)
        .then((response) => {
          this.card_todayIncome = response.data.data[0].subtotals
        })
        .catch((error) => {
          console.log(error)
        })
    },
    orders() {
      axios
        .get(`${process.env.VUE_APP_BASE_URL}/order/total_order`)
        .then((response) => {
          this.card_order = response.data.data[0].totals
        })
        .catch((error) => {
          console.log(error)
        })
    },
    years_income() {
      axios
        .get(`${process.env.VUE_APP_BASE_URL}/order/total_yearIncome`)
        .then((response) => {
          this.card_yearIncome = response.data.data[0].subtotals
          // console.log(response.data.data[0].subtotals)
        })
        .catch((error) => {
          console.log(error)
        })
    },
    thisMonth() {
      axios
        .get(`${process.env.VUE_APP_BASE_URL}/order/this_month`)
        .then((response) => {
          const setChart = response.data.data
          for (let i = 0; i < setChart.length; i++) {
            this.chart_thisMonth.push([
              setChart[i].dates,
              setChart[i].subtotals
            ])
          }

          // this.card_yearIncome = response.data.data[0].subtotals
          console.log(this.chart_thisMonth)
        })
        .catch((error) => {
          console.log(error)
        })
    },
    lastMonth() {
      axios
        .get(`${process.env.VUE_APP_BASE_URL}/order/last_month`)
        .then((response) => {
          // this.card_yearIncome = response.data.data[0].subtotals
          console.log(response.data.data)
        })
        .catch((error) => {
          console.log(error)
        })
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
    addProduct() {
      this.modalTitle = 'Add Product'
      axios
        .post(`${process.env.VUE_APP_BASE_URL}/product`, this.form)
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
  background-color: #ffffff;
  box-shadow: 0 0px 6px -2px ffff;
  border-left: none;
  border-right: #cecece 1px solid;
  z-index: 1;
}
.navbarTwo {
  height: 70px;
  background-color: #ffffff;
  box-shadow: 0 4px 5px -2px gray;
  border-left: #cecece 1px solid;
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
  height: 50px;
}
</style>
