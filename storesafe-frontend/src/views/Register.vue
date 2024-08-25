<template>
  <div class="register container mt-5">
    <div class="logo"><router-link to="/"><img src="@/assets/images/storesafe-logo.png" width="100%" /></router-link></div>
    <h1 style="text-align: center;">Create Account</h1>
    <form @submit.prevent="register">
      <div class="form-group">
        <label for="name">Name:</label>
        <input type="text" v-model="name" class="form-control" required />
      </div>
      <div class="form-group">
        <label for="company">Company:</label>
        <input type="text" v-model="company" class="form-control" required />
      </div>
      <div class="form-group">
        <label for="industry">Industry:</label>
        <input type="text" v-model="industry" class="form-control" required />
      </div>
      <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" v-model="email" class="form-control" required />
      </div>
      <div class="form-group">
        <label for="phone">Phone:</label>
        <input type="text" v-model="phone" class="form-control" required />
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" v-model="password" class="form-control" required />
      </div>
      <div class="form-group">
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" v-model="confirmPassword" class="form-control" required />
      </div>
      <p v-if="passwordError" class="text-danger">{{ passwordError }}</p>
      <button type="submit" class="btn-register" :disabled="!passwordsMatch">Register</button>
      <p v-if="error" class="text-danger">{{ error }}</p>
    </form>
  </div>
  <div class="login" style="text-align: center;">
    Have an account already? &nbsp; 
    <router-link v-if="!isLoggedIn" to="/login">Log In</router-link>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      name: '',
      company: '',
      industry: '',
      email: '',
      phone: '',
      password: '',
      confirmPassword: '',
      error: '',
      passwordError: ''
    };
  },
  computed: {
    passwordsMatch() {
      return this.password === this.confirmPassword;
    }
  },
  watch: {
    password() {
      this.validatePasswords();
    },
    confirmPassword() {
      this.validatePasswords();
    }
  },
  methods: {
    validatePasswords() {
      if (this.password !== this.confirmPassword) {
        this.passwordError = "Passwords do not match.";
      } else {
        this.passwordError = "";
      }
    },
    async register() {
      if (!this.passwordsMatch) {
        this.error = "Passwords do not match. Please try again.";
        return;
      }
      try {
        const response = await axios.post(`https://storesafe.fyi/users/register`, {
          name: this.name,
          company: this.company,
          industry: this.industry,
          email: this.email,
          phone: this.phone,
          password: this.password,
        });
        console.log('Registration successful:', response.data);
        this.$router.push('/login');
      } catch (error) {
        if (error.response) {
          console.error('Error response:', error.response);
          this.error = error.response.data.error || error.response.statusText;
        } else if (error.request) {
          console.error('Error request:', error.request);
          this.error = 'No response received from server.';
        } else {
          console.error('Error message:', error.message);
          this.error = error.message;
        }
      }
    },
  },
};
</script>

<style>
/* Add your styles here */
</style>