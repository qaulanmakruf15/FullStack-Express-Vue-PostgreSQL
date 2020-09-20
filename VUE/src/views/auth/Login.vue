<template>
<body>
  <div class="container">
    <div class="row">
      <div class="col-sm-5 mx-auto">
        <div class="card card-signin my-5" style="border-radius: 20px; box-shadow: 5px 10px 8px #888888;">
          <div class="card-body">
            <h3 class="card-title text-center mb-4">Sign In</h3>
            <b-form @submit.prevent="onSubmit" @reset.prevent="onReset">
              <b-form-input
                type="email"
                v-model="form.email"
                placeholder="Email"
                required
              />
              <br />
              <b-form-input
                type="password"
                v-model="form.password"
                placeholder="Password"
                required
              />
              <br />
              <b-button block variant="primary" type="submit">
                <b>Submit</b>
              </b-button>
              <b-button block variant="primary" type="reset">
                <b>Reset</b>
              </b-button>
            </b-form>
            <hr />

            <div>
              <p class="register-alert">
                Don't have an account ?
                <router-link to="/register">
                <a
                  class="register-here"
                  type="register"
                >Register here</a>
                </router-link>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  </body>
</template>

<script>
import { mapState, mapActions } from 'vuex'
export default {
  name: 'Login',
  data() {
    return {
      form: {
        email: '',
        password: ''
      }
    }
  },
  computed: {
    ...mapState(['name'])
  },
  methods: {
    ...mapActions(['login']),
    onSubmit() {
      this.login(this.form).then(result => {
        console.log(result)
        this.$router.push('/')
      }).catch(error => {
        console.log(error)
      })
    },
    onReset() {
      this.form = {
        email: '',
        password: ''
      }
    }
  }
}
</script>

<style scoped>
body {
background-color: #fff;
}
</style>
