<template>
  <b-card-group deck style="width: 700px; margin: auto;">
    <b-card header="ADD PRODUCT" align="center">
      <b-form v-on:submit.prevent="method_add_product">
        <b-alert :show="alert">{{this.alert_message}}</b-alert>
        <b-row>
          <b-col sm="3" style="margin: auto; text-align: right;">
            <label for="input-name">Product Name</label>
          </b-col>
          <b-col sm="9">
            <b-form-input v-model="form.name" type="text" required placeholder="Product Name"></b-form-input>
          </b-col>
        </b-row>

        <b-row style="margin-top: 20px;">
          <b-col sm="3" style="margin: auto; text-align: right;">
            <label for="input-name">Image</label>
          </b-col>
          <b-col sm="9">
            <b-form-file @change="method_handle_file" id="input-2" required placeholder="Image"></b-form-file>
          </b-col>
        </b-row>

        <b-row style="margin-top: 20px;">
          <b-col sm="3" style="margin: auto; text-align: right;">
            <label for="input-name">Category</label>
          </b-col>
          <b-col sm="9">
            <b-form-select v-model="form.id_category">
              <b-form-select-option
                v-for="(valueCategory, index) in getter_get_category"
                :key="index"
                :value="`${valueCategory.category_id}`"
              >{{valueCategory.category_name}}</b-form-select-option>
            </b-form-select>
          </b-col>
        </b-row>

        <b-row style="margin-top: 20px;">
          <b-col sm="3" style="margin: auto; text-align: right;">
            <label for="input-name">Status</label>
          </b-col>
          <b-col sm="9">
            <b-form-select v-model="form.status" id="input-3" :options="status"></b-form-select>
          </b-col>
        </b-row>

        <b-row style="margin-top: 20px;">
          <b-col sm="3" style="margin: auto; text-align: right;">
            <label for="input-name">Price</label>
          </b-col>
          <b-col sm="9">
            <b-form-input v-model="form.price" id="input-4" placeholder="Price"></b-form-input>
          </b-col>
        </b-row>

        <b-row style="margin-top: 20px; float: 0;">
          <b-col sm="6" class="text-right">
            <b-button type="reset" variant="danger">Reset</b-button>
          </b-col>
          <b-col sm="6" class="text-left">
            <b-button type="submit" variant="success">Save</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-card>
  </b-card-group>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  name: 'ProductAdd',
  data() {
    return {
      form: {
        name: '',
        image: {},
        id_category: '',
        price: '',
        status: ''
      },
      status: [
        { value: '1', text: 'Active' },
        { value: '0', text: 'Non Active' }
      ],
      alert: false,
      alert_message: ''
    }
  },
  computed: {
    ...mapGetters({
      getter_get_product: 'get_product',
      getter_get_category: 'get_get_category'
    })
  },
  methods: {
    // Alias action and method di dalam method
    ...mapActions({
      action_get_products: 'get_products',
      action_add_product: 'add_product',
      action_get_category: 'act_get_category'
    }),
    method_handle_file(event) {
      this.form.image = event.target.files[0]
      if (this.form.image.size >= 1000000) {
        this.alert_message = 'File max size is 1024kb'
        this.alert = true
      } else {
        this.alert = false
      }
    },
    method_add_product() {
      const data = new FormData()
      data.append('name', this.form.name)
      data.append('id_category', this.form.id_category)
      data.append('price', this.form.price)
      data.append('status', this.form.status)
      data.append('image', this.form.image)
      this.action_add_product(data)
        .then((response) => {
          this.form = []
          this.action_get_products()
          this.alert_message = 'Add Product Success'
          this.alert = true
        })
        .catch((error) => {
          console.log(error)
        })
    }
  },
  created() {
    this.action_get_category()
  }
}
</script>
