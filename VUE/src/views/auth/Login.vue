<template>
<body>
  <!-- <div class="container">
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
  </div> -->

<div class="login-page">
  <div class="form">
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
      <button>Sign In</button>
      <p class="message">Don't have an account? <router-link to="/register">
                <a
                  class="register-here"
                  type="register"
                >Register here</a>
                </router-link></p>
    </b-form>
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
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.login-page {
  width: 360px;
  padding: 8% 0;
  margin: auto;
}
.form {
  position: relative;
  z-index: 1;
  background: rgba(205, 205, 205, .2);
  max-width: 360px;
  margin: 0 auto 100px;
  padding: 45px;
  text-align: center;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  color: #000;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
.form button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #00BFFF;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #000;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form button:hover,.form button:active,.form button:focus {
  background: #1E90FF
}
.form .message {
  margin: 15px 0 0;
  color: #ffff;
  font-size: 13px;
}
.form .message a {
  color: #e5be93;
  text-decoration: none;
}
.form .register-form {
  display: none;
}
.container {
  position: relative;
  z-index: 1;
  max-width: 300px;
  margin: 0 auto;
}
.container:before, .container:after {
  content: "";
  display: block;
  clear: both;
}
.container .info {
  margin: 50px auto;
  text-align: center;
}
.container .info h1 {
  margin: 0 0 15px;
  padding: 0;
  font-size: 36px;
  font-weight: 300;
  color: #1a1a1a;
}
.container .info span {
  color: #4d4d4d;
  font-size: 12px;
}
.container .info span a {
  color: #000000;
  text-decoration: none;
}
.container .info span .fa {
  color: #EF3B3A;
}
body {
  background: #ffff; /* fallback for old browsers */
  background: -webkit-linear-gradient(right, #76b852, #8DC26F);
  background: -moz-linear-gradient(right, #76b852, #8DC26F);
  background: -o-linear-gradient(right, #76b852, #8DC26F);
  background: linear-gradient(to left, #76b852, #8DC26F);
  font-family: "Roboto", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background: url("https://images.unsplash.com/photo-1541929347448-1a5788e6178a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1580&q=1280") ;
  height:100%;
}
</style>
