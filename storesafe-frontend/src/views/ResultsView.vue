<template>
  <div class="results-view container">
    <div class="logo"><router-link to="/"><img src="@/assets/images/storesafe-logo.png" width="100%" /></router-link></div>
    <div v-if="isLoading">Loading...</div>
    <AssessmentResults 
      v-else-if="assessment && questions.length"
      :answers="assessment.answers" 
      :questions="questions"
      :currentQuestionIndex="assessment.currentQuestionIndex"
    />
    <div v-else>Failed to load assessment data.</div>
  </div>
</template>

<script>
import AssessmentResults from '@/components/AssessmentResults.vue'
import axios from 'axios';

export default {
  components: {
    AssessmentResults
  },
  props: ['id'],
  data() {
    return {
      assessment: null,
      questions: [],
      isLoading: true
    }
  },
  async created() {
    try {
      const [assessmentResponse, questionsResponse] = await Promise.all([
        axios.get(`https://storesafe.fyi/assessment/${this.id}`),
        axios.get('https://storesafe.fyi/questions')
      ]);
      this.assessment = assessmentResponse.data;
      this.questions = questionsResponse.data;
      console.log('Assessment:', this.assessment);
      console.log('Questions:', this.questions);
    } catch (error) {
      console.error('Error fetching data:', error);
    } finally {
      this.isLoading = false;
    }
  }
}
</script>