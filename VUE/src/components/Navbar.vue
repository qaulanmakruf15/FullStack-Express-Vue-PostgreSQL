<template>
<!-- Sidemenu -->
  <div class="sidemenu-box" id="sidemenu-wrapper">
    <b-row
      class="sidemenu-header-box text-center align-items-center"
      style="border-bottom: #cecece 1px solid;"
    >
      <b-col xl="12">
        <a href class="modify-link-text">Menu</a>
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
    <b-row v-if="data_user.role_id===2" class="sidemenu-header-box text-center align-items-center">
      <b-col xl="12">
        <b-button v-b-modal.modal-lg style="background-color: transparent; border: none;">
          <img src="../assets/images/icons/add.png" style="width: 40px; height: 40px;" />
        </b-button>
      </b-col>
    </b-row>
    <b-row v-else class="sidemenu-header-box text-center align-items-center">
    </b-row>
  </div>
  <!-- End sidemenu -->
</template>

<script>
export default {
  name: 'Navbar'
}
</script>
