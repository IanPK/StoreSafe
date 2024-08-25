<template>
    <div class="admin-dashboard">
      <h1>Admin Dashboard</h1>
      <div v-if="loading">Loading...</div>
      <div v-else-if="error">{{ error }}</div>
      <div v-else>
        <div v-for="user in users" :key="user.id" class="user-card">
          <h2>{{ user.name }}</h2>
          <p>Email: {{ user.email }}</p>
          <p>Company: {{ user.company }}</p>
          <p>Industry: {{ user.industry }}</p>
          <h3>Assessments:</h3>
          <ul>
            <li v-for="assessment in user.assessments" :key="assessment.id">
              {{ assessment.title }} - Created on: {{ new Date(assessment.createdAt).toLocaleDateString() }}
            </li>
          </ul>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    name: 'AdminDashboard',
    data() {
      return {
        users: [],
        loading: true,
        error: null
      };
    },
    async created() {
        try {
            const response = await axios.get('/admin/users-with-assessments');
            this.users = response.data;
            this.loading = false;
        } catch (err) {
            console.error('Error fetching data:', err);
            this.error = `Failed to load users and assessments: ${err.message}`;
            this.loading = false;
        }
    }
  };
  </script>
  
  <style scoped>
  .admin-dashboard {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
  }
  .user-card {
    border: 1px solid #ddd;
    padding: 15px;
    margin-bottom: 20px;
    border-radius: 5px;
  }
  </style>