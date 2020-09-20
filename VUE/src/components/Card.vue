<template>
  <b-container fluid>
    <b-row>
      <b-col xl="4" lg="6" md="12">
        <b-card
          v-bind:img-src="require('../assets/images/products/cappucino.jpg')"
          img-alt="Image"
          img-top
          class="custom-card"
        >
          <b-card-text class="custom-card-text-name font-book">Espresso</b-card-text>
          <b-card-text class="custom-card-text-price font-medium">Rp. 25.000</b-card-text>
        </b-card>
      </b-col>
      <b-col xl="4" lg="6" md="12">
        <b-card
          img-src="https://picsum.photos/300/220/?image=41"
          img-alt="Image"
          img-top
          class="custom-card"
        >
          <b-card-text class="custom-card-text-name font-book">{{name}}</b-card-text>
          <b-card-text class="custom-card-text-price font-medium">Rp. 15.000</b-card-text>
        </b-card>
      </b-col>
      <b-col xl="4" lg="6" md="12">
        <b-card
          img-src="https://picsum.photos/300/220/?image=41"
          img-alt="Image"
          img-top
          class="custom-card"
        >
          <b-card-text class="custom-card-text-name font-book">Cappucino</b-card-text>
          <b-card-text class="custom-card-text-price font-medium">Rp. 5.000</b-card-text>
        </b-card>
      </b-col>
      <b-col xl="4" lg="6" md="12">
        <b-card
          img-src="https://picsum.photos/300/220/?image=41"
          img-alt="Image"
          img-top
          class="custom-card"
        >
          <b-card-text class="custom-card-text-name font-book">Red Velvet Latte</b-card-text>
          <b-card-text class="custom-card-text-price font-medium">Rp. 35.000</b-card-text>
        </b-card>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  name: 'Card',
  props: ['nama', 'harga']
}
</script>
