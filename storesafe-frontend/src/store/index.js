import { createStore } from 'vuex';

const store = createStore({
  state: {
    auth: {
      user: JSON.parse(localStorage.getItem('user')) || null
    }
  },
  mutations: {
    setUser(state, user) {
      state.auth.user = user;
      localStorage.setItem('user', JSON.stringify(user));
    },
    clearUser(state) {
      state.auth.user = null;
      localStorage.removeItem('user');
    }
  },
  actions: {
    
  },
  getters: {
    isAuthenticated: state => !!state.auth.user,
    getUser: state => state.auth.user,
    isAdmin: state => state.auth.user && state.auth.user.isAdmin,
  }
});

export default store;
