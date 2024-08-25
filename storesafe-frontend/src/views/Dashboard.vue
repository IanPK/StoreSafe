<template>
  <div class="dashboard">
    <div class="logo"><router-link to="/"><img src="@/assets/images/storesafe-logo.png" width="100%" /></router-link></div>
    <button @click="startNewAssessment" class="btn-start">New Assessment</button>
    <h1>Your Assessments</h1>
    <div class="dash-assess">
      <div v-for="assessment in assessments" :key="assessment.id" class="dash-box">
        <div v-if="editingId === assessment.id">
          <input v-model="editTitle" @keyup.enter="updateAssessmentTitle(assessment)">
          <button @click="updateAssessmentTitle(assessment)">Save</button>
          <button @click="cancelEdit">Cancel</button>
        </div>
        <h2>{{ assessment.title }}</h2>
        <button @click="continueAssessment(assessment.id)" class="dash-continue">Continue</button> <!-- Changed to pass 'id' -->
        <button @click="viewResults(assessment)" class="dash-results">View Results</button>
        <button @click="startEdit(assessment)" class="dash-edit">Edit Title</button>
        <button @click="deleteAssessment(assessment)" class="dash-delete">Delete</button>
        <div class="cleaner"></div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      assessments: [],
      editingId: null,
      editTitle: ''
    };
  },
  created() {
    this.fetchAssessments();
  },
  computed: {
    isAssessmentComplete() {
      return (assessment) => {
        return assessment.answers && 
               assessment.answers.length === assessment.questions.length &&
               assessment.answers.every(answer => answer !== null && answer !== undefined);
      };
    }
  },
  methods: {
    async fetchAssessments() {
      try {
        const response = await axios.get('https://storesafe.fyi/assessment');
        this.assessments = response.data.map(assessment => ({
          ...assessment,
          questions: assessment.questions || [],
        }));
      } catch (error) {
        console.error('Error fetching assessments:', error);
      }
    },
    continueAssessment(id) {
      this.$router.push({ name: 'Assessment', params: { id } });
    },
    viewResults(assessment) {
      this.$router.push({ name: 'Results', params: { id: assessment.id } });
    },
    startNewAssessment() {
      this.$router.push('/start-assessment');
    },
    startEdit(assessment) {
      this.editingId = assessment.id;
      this.editTitle = assessment.title;
    },
    cancelEdit() {
      this.editingId = null;
      this.editTitle = '';
    },
    async updateAssessmentTitle(assessment) {
      try {
        await axios.put(`https://storesafe.fyi/assessment/${assessment.id}`, {
          title: this.editTitle
        });
        assessment.title = this.editTitle;
        this.editingId = null;
        this.editTitle = '';
      } catch (error) {
        console.error('Error updating assessment title:', error);
      }
    },
    async deleteAssessment(assessment) {
      if (confirm('Are you sure you want to delete this assessment?')) {
        try {
          await axios.delete(`https://storesafe.fyi/assessment/${assessment.id}`);
          this.assessments = this.assessments.filter(a => a.id !== assessment.id);
        } catch (error) {
          console.error('Error deleting assessment:', error);
        }
      }
    }
  },
};
</script>
