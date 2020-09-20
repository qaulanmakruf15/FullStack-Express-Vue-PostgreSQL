<template>
  <div class="container">
    <div class="row">
      <div class="col-sm-5 mx-auto">
        <div class="card card-signin my-5" style="border-radius: 20px; box-shadow: 5px 10px 8px #888888;">
          <div class="card-body">
            <h3 class="card-title text-center mb-4">Register</h3>
            <b-form @submit.prevent="onSubmit" @reset.prevent="onReset">
              <b-form-input
                type="text"
                v-model="form.name"
                placeholder="Name"
                required
              />
              <small id="passwordHelpBlock" class="form-text text-muted">
                * Required.
              </small>
              <br />
              <b-form-input
                type="email"
                v-model="form.email"
                placeholder="Email"
                required
              />
              <small id="passwordHelpBlock" class="form-text text-muted">
                Must valid email.
              </small>
              <br />
              <b-form-input
                type="password"
                v-model="form.password"
                placeholder="Password"
                required
              />
              <small id="passwordHelpBlock" class="form-text text-muted">
                Atleast 8 character.
              </small>
              <br />
              <b-button block variant="success" type="submit">
                <b>Submit</b>
              </b-button>
              <b-button block variant="danger" type="reset">
                <b>Reset</b>
              </b-button>
            </b-form>
            <hr />

            <div>
              <p class="register-alert">
                Already have an account ?
                <router-link to="/login">
                <a
                  class="register-here"
                  type="register"
                >Login here</a>
                </router-link>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'
export default {
  name: 'Login',
  data() {
    return {
      form: {
        name: '',
        email: '',
        password: ''
      }
    }
  },
  computed: {
    ...mapState(['name'])
  },
  methods: {
    ...mapActions(['register']),
    onSubmit() {
      this.register(this.form).then(result => {
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
