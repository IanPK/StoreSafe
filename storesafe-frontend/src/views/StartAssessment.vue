<template>
  <div class="start-assessment container">
    <div class="logo"><router-link to="/"><img src="@/assets/images/storesafe-logo.png" width="100%" /></router-link></div>
    <h1>Start Assessment</h1>
    <h4>Let's give your new assessment a name.</h4>
    <div class="form-group">
      <form @submit.prevent="startAssessment">
        <br />
        <input v-model="title" class="form-control" placeholder="Coffee Shop on Main" required>
        <br />
        <button type="submit" class="btn-register">Start Assessment</button>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      title: '',
    };
  },
  methods: {
    async startAssessment() {
      try {
        const userId = this.$store.getters.getUser?.id;
        if (!userId) {
          this.$router.push('/login');
          return;
        }
        const response = await axios.post('https://storesafe.fyi/assessments', {
          title: this.title,
          userId
        });
        const newAssessment = response.data;
        this.$router.push({ name: 'Assessment', params: { id: newAssessment.id } });
      } catch (error) {
        console.error('Error starting new assessment:', error);
      }
    }
  }
};
</script>
