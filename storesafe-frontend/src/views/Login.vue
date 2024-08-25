<template>
  <div class="login container mt-5">
    <div class="logo"><router-link to="/"><img src="@/assets/images/storesafe-logo.png" width="100%" /></router-link></div>
    <h1 class="text-center">Login</h1>
    <div v-if="errorMessage" class="alert alert-danger mt-3">{{ errorMessage }}</div>
    <form @submit.prevent="login" class="mt-3">
      <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" v-model="email" class="form-control" required />
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" v-model="password" class="form-control" required />
      </div>
      <button type="submit" class="btn btn-primary btn-block mt-3 btn-login">Login</button>
    </form>
  </div>
  <div class="login" style="text-align: center;">
    Need to create an account? &nbsp; 
    <router-link v-if="!isLoggedIn" to="/register">Create Account</router-link>
  </div>
</template>

<script>
import axios from 'axios';

const apiClient = axios.create({
  baseURL: process.env.VUE_APP_API_URL || 'https://storesafe.fyi',
});

export default {
  emits: ['loginSuccess'],
  data() {
    return {
      email: '',
      password: '',
      errorMessage: '',
    };
  },
  methods: {
    async login() {
      this.errorMessage = '';
      console.log('VUE_APP_API_URL:', process.env.VUE_APP_API_URL);
      const loginUrl = `https://storesafe.fyi/users/login`;
      console.log('Login URL:', loginUrl);

      try {
        const response = await axios.post(loginUrl, {
          email: this.email,
          password: this.password
        }, {
          withCredentials: true
        });
        console.log('Login successful:', response.data);
        console.log('User object:', this.$store.state.auth.user);
        localStorage.setItem('token', response.data.token);
        localStorage.setItem('user', JSON.stringify(response.data.user));
        this.$emit('login-success', response.data.user);
        this.$router.push('/');
      } catch (error) {
        console.error('Error during login:', error.response ? error.response.data : error.message);
        if (error.response) {
          // The request was made and the server responded with a status code
          // that falls out of the range of 2xx
          if (error.response.status === 400) {
            this.errorMessage = error.response.data.error || 'Invalid email or password.';
          } else if (error.response.status === 404) {
            this.errorMessage = 'User not found. Please check your email.';
          } else {
            this.errorMessage = 'An error occurred during login. Please try again.';
          }
        } else if (error.request) {
          // The request was made but no response was received
          this.errorMessage = 'No response from server. Please try again later.';
        } else {
          // Something happened in setting up the request that triggered an Error
          this.errorMessage = 'An error occurred. Please try again.';
        }
      }
    },
  },
};
</script>