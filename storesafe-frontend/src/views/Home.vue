<template>
  <div class="home">
    <div class="logo-left"><router-link to="/"><img src="@/assets/images/storesafe-logo.png" width="100%" /></router-link></div>
    <h1>StoreSafe Solutions</h1>
    <h2>Space Optimization, Labor Efficiency, Food Safety, Cost Savings, Sustainability</h2>
  </div>

  <div class="home-grey">
    <h4>StoreSafe Solutions empowers the foodservice industry to achieve their food safety, efficiency, sustainability, and cost savings goals through Cambro product education, assessments, collaboration, and training.</h4>

    <h4 class="home-start">See if you're meeting your Food Safety goals. Take our free online assessment today.</h4>
    <button v-if="!isLoggedIn" @click="navigateTo('/register')" class="btn-home-start">Take the StoreSafe Solutions Assessment</button>
    <button v-else @click="navigateTo('/start-assessment')" class="btn-home-start">Take the StoreSafe Solutions Assessment</button>
  </div>

  <div class="home-white">
    <h1>Launch from One Driving Force, Food Safety</h1>
    <h4>Explore the kitchen spaces below to see how operators use Cambro products for optimized performance.</h4>
    <div class="home-categories">
      <div class="home-cat-box">Receiving</div>
      <div class="home-cat-box">Storage</div>
      <div class="home-cat-box">Preparation</div>
      <div class="home-cat-box">Service</div>
      <div class="home-cat-box">Warewashing</div>
    </div>
    <h1>StoreSafe Resources</h1>
    <button class="btn-home-brochure">StoreSafe Solutions Brochure</button>
  </div>
</template>

<script>
export default {
  name: 'Home',
  data() {
    return {
      user: null
    };
  },
  computed: {
    isLoggedIn() {
      return !!this.user;
    }
  },
  methods: {
    navigateTo(route) {
      this.$router.push(route);
    },
    handleLoginSuccess(user) {
      this.user = user;
      localStorage.setItem('user', JSON.stringify(user));
    },
    logout() {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      this.user = null;
      this.$router.push('/login');
    }
  },
  created() {
    const user = localStorage.getItem('user');
    if (user) {
      this.user = JSON.parse(user);
    }
  }
};
</script>
