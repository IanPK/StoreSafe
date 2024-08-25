<template>
  <div id="app" :class="currentRouteName">
    <div class="menu-container" :class="{ 'menu-open': isMenuOpen }">
      <button class="hamburger mobile" @click="toggleMenu">
        <span :class="{ 'active': isMenuOpen }"></span>
      </button>

      <nav>
      <router-link v-if="!isLoggedIn" to="/register" @click.native="closeMenu">Create an Account</router-link>
      <router-link v-if="!isLoggedIn" to="/login" @click.native="closeMenu">Log In</router-link>
      <span v-if="isLoggedIn">Welcome, {{ user.name }}!</span>
      <router-link v-if="isLoggedIn" to="/start-assessment" @click.native="closeMenu">New Assessment</router-link>
      <router-link v-if="isLoggedIn" to="/dashboard" @click.native="closeMenu">Dashboard</router-link>
      <router-link v-if="isLoggedIn" to="/login" @click.native="logout">Logout</router-link>
      <router-link v-if="isAdmin" to="/admin" @click.native="closeMenu">Admin Dashboard</router-link>
    </nav>
    </div>
    <router-view @login-success="handleLoginSuccess"/>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isMenuOpen: false,
      user: null
    };
  },
  computed: {
    isLoggedIn() {
      return !!this.user;
    },
    isAdmin() {
      return this.user && this.user.isAdmin;
    },
    currentRouteName() {
      return this.$route.name || '';
    }
  },
  methods: {
    handleLoginSuccess(user) {
      this.user = user;
      localStorage.setItem('user', JSON.stringify(user));
      console.log('User after login:', this.user);
      console.log('Is Admin:', this.isAdmin);
    },
    toggleMenu() {
      this.isMenuOpen = !this.isMenuOpen;
    },
    closeMenu() {
      this.isMenuOpen = false;
    },
    logout() {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      this.user = null;
      this.$router.push('/login');
      this.isMenuOpen = false;
    }
  },
  created() {
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      this.user = JSON.parse(storedUser);
      console.log('User from localStorage:', this.user);
      console.log('Is Admin:', this.isAdmin);
    }
  }
};
</script>

<style>
.menu-container {
  position: relative;
}

.hamburger {
  position: absolute;
  top: 20px;
  right: 30px;
  width: 30px;
  height: 20px;
  background: none;
  border: none;
  cursor: pointer;
  z-index: 10;
  display: flex;
  align-items: center;
  justify-content: center;
}

.hamburger span {
  display: block;
  width: 100%;
  height: 4px;
  background: #444;
  transition: transform 0.3s ease, opacity 0.3s ease;
}

.hamburger span::before,
.hamburger span::after {
  content: '';
  position: absolute;
  width: 100%;
  height: 4px;
  background: #444;
  transition: transform 0.3s ease;
}

.hamburger span::before {
  transform: translateY(-10px);
}

.hamburger span::after {
  transform: translateY(10px);
}

.hamburger span.active {
  background: transparent;
}

.hamburger span.active::before {
  transform: rotate(45deg);
}
.hamburger span.active::after {
  transform: rotate(-45deg);
}
button.hamburger:hover {
  background: none;
}

nav {
  display: flex;
  justify-content: space-around;
  align-items: center;
}

@media (max-width: 768px) {
  nav {
    position: fixed;
    top: 0;
    right: 0;
    height: 100vh;
    width: 100%;
    background: rgba(245,245,245,0.95);
    flex-direction: column;
    justify-content: center !important;
    align-items: center;
    transform: translateX(100%);
    transition: transform 0.3s ease-in-out;
  }

  nav a {
    color: #444;
    font-size: 10vw;
    margin: 2vw 0;
  }

  .menu-container.menu-open nav {
    transform: translateX(0);
  }
}
</style>