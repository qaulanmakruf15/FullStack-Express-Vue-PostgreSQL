<template>
<body>
  <b-container fluid style="padding: 0;">
    <b-row>
      <b-col sm="12" class="navbarOne">
        <b-row>
          <b-col sm="12" class="text-center" style="margin-top: 5px;">
            <p style="font-size: 30px">Food Items</p>
          </b-col>
        </b-row>
      </b-col>
      <b-col sm="12">
        <b-breadcrumb class="col-sm-10 col-md-8 col-lg-6 col-xl-3" style="margin-top: 20px;">
          <b-breadcrumb-item router-link to="/">
            <b-icon icon="house-fill" scale="1.25" shift-v="1.25" aria-hidden="true"></b-icon>Home
          </b-breadcrumb-item>
          <b-breadcrumb-item router-link to="/management">Management</b-breadcrumb-item>
        </b-breadcrumb>
        <b-card no-body>
          <b-tabs pills card vertical>
            <b-tab title="Add Product" active>
              <ProductAdd />
            </b-tab>
            <b-tab title="User">
              <b-card-text>Tab contents 2</b-card-text>
            </b-tab>
            <b-tab title="Category">
              <b-card-text>Tab contents 3</b-card-text>
            </b-tab>
          </b-tabs>
        </b-card>
      </b-col>
    </b-row>
  </b-container>
</body>
</template>

<script>
import ProductAdd from '@/components/Add_product.vue'
export default {
  name: 'Management',
  components: {
    ProductAdd
  }
}
</script>

<style scoped>
.navbarOne {
  height: 70px;
  background-color: #ffffff;
  box-shadow: 0 4px 5px -2px gray;
  border-left: #cecece 1px solid;
  border-right: #cecece 1px solid;
  z-index: 1;
}
body {
  overflow: hidden;
}
</style>
