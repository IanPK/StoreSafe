<template>
  <div class="assessment container">
    <div class="logo">
      <img src="@/assets/images/storesafe-logo.png" alt="StoreSafe logo" />
    </div>

    <h1 class="assessment-title">{{ assessmentTitle }}</h1>
    
    <div class="category-navigation">
      <div v-for="category in categories" :key="category" class="category-section">
        <button 
          :class="{ active: currentCategory === category }"
          @click="jumpToCategory(category)"
        >
          {{ category }}
        </button>
        <div class="question-dots">
          <span 
            v-for="(question, index) in questionsByCategory[category]" 
            :key="index"
            class="dot"
            :class="getDotClass(question.id)"
          ></span>
        </div>
      </div>
    </div>

    <!-- <div class="question-dots">
      <span 
        v-for="(question, index) in questionsByCategory[currentCategory]" 
        :key="index"
        class="dot"
        :class="getDotClass(question.id)"
      ></span>
    </div> -->

    <div v-if="loading">Loading questions...</div>
    <div v-else-if="error">Error: {{ error }}</div>
    <div v-if="currentQuestion" class="question-container">
      <button @click="navigateQuestion(-1)" class="nav-button left"><img src="@/assets/images/left-arrow.svg" alt="Previous Question" class="nav-arrow"/></button>
      
      <div class="question-content">
        <h2>{{ currentQuestionIndex + 1 }}. {{ currentQuestion.question }}</h2>
        <div class="yes-no">
          <button 
            @click="answerQuestion(currentQuestion.id, true)" 
            :class="['yes', { active: answers[currentQuestion.id] === true }]"
          >
            Yes
          </button>
          <button 
            @click="answerQuestion(currentQuestion.id, false)" 
            :class="['no', { active: answers[currentQuestion.id] === false }]"
          >
            No
          </button>
        </div>
      </div>
      
      <button @click="navigateQuestion(1)" class="nav-button right"><img src="@/assets/images/right-arrow.svg" alt="Next Question" class="nav-arrow"/></button>
    </div>

    <button @click="saveAndReturn" class="save-progress">
      Save & Return to Dashboard
    </button>
  </div>
</template>

<script>
import AssessmentResults from '@/components/AssessmentResults.vue'
import axios from 'axios';

export default {
  components: {
    AssessmentResults
  },
  data() {
    return {
      assessmentId: null,
      assessmentTitle: '',
      questions: [],
      categories: ['receiving', 'storage', 'preparation', 'service', 'sanitation'],
      currentCategory: '',
      currentQuestionIndex: 0,
      questionsByCategory: {},
      lastAnsweredQuestionIndex: {},
      answers: {},
      loading: true,
      error: null,
      userId: null
    };
  },
  computed: {
    currentQuestion() {
      return this.questionsByCategory[this.currentCategory]?.[this.currentQuestionIndex];
    },
    sectionTitle() {
      return this.currentCategory || 'No category';
    },
    progress() {
      const categoryQuestions = this.questionsByCategory[this.currentCategory] || [];
      return categoryQuestions.length ? ((this.currentQuestionIndex + 1) / categoryQuestions.length) * 100 : 0;
    },
    isAssessmentComplete() {
      return Object.keys(this.answers).length === this.questions.length;
    },
  },
  created() {
    this.assessmentId = this.$route.params.id;
    this.userId = this.$store.getters.getUser?.id;
    if (!this.userId) {
      console.error('User ID not found. Please ensure the user is logged in.');
      this.$router.push('/login');
    } else {
      this.fetchAssessment();
    }
  },
  methods: {
    async fetchAssessment() {
      this.loading = true;
      this.error = null;
      try {
        const response = await axios.get(`https://storesafe.fyi/assessment/${this.assessmentId}`);
        const assessment = response.data;
        this.assessmentTitle = assessment.title;
        this.answers = assessment.answers || {};
        this.currentQuestionIndex = assessment.currentQuestionIndex || 0;
        this.currentCategory = assessment.currentCategory || this.categories[0];
        this.lastAnsweredQuestionIndex = assessment.lastAnsweredQuestionIndex || {};
        await this.fetchQuestions();
        this.initializeLastAnsweredIndices();
      } catch (error) {
        console.error('Error fetching assessment:', error);
        this.error = 'Failed to load assessment. Please try again.';
      } finally {
        this.loading = false;
      }
    },
    async fetchQuestions() {
      this.loading = true;
      this.error = null;
      try {
        const response = await axios.get('https://storesafe.fyi/questions');
        this.questions = response.data;
        this.organizeQuestionsByCategory();
        this.setInitialCategory();
      } catch (error) {
        console.error('Error fetching questions:', error);
        this.error = 'Failed to load questions. Please try again.';
      } finally {
        this.loading = false;
      }
    },
    organizeQuestionsByCategory() {
      this.questionsByCategory = this.categories.reduce((acc, category) => {
        acc[category] = this.questions.filter(q => q.category === category);
        return acc;
      }, {});
    },
    initializeLastAnsweredIndices() {
      this.categories.forEach(category => {
        if (!this.lastAnsweredQuestionIndex[category]) {
          const categoryQuestions = this.questionsByCategory[category] || [];
          const lastAnsweredIndex = categoryQuestions.findIndex(q => this.answers[q.id] === undefined);
          this.lastAnsweredQuestionIndex[category] = lastAnsweredIndex === -1 ? categoryQuestions.length : lastAnsweredIndex;
        }
      });
    },
    setInitialCategory() {
      this.currentCategory = this.categories[0];
      this.currentQuestionIndex = this.lastAnsweredQuestionIndex[this.currentCategory] || 0;
    },

    jumpToCategory(category) {
      this.currentCategory = category;
      const questions = this.questionsByCategory[category] || [];
      const firstUnansweredIndex = questions.findIndex(q => this.answers[q.id] === undefined);
      this.currentQuestionIndex = firstUnansweredIndex !== -1 ? firstUnansweredIndex : questions.length - 1;
      
      // Scroll to the top of the page
      window.scrollTo(0, 0);
    },

    findFirstUnansweredQuestionIndex(category) {
      const questions = this.questionsByCategory[category] || [];
      const index = questions.findIndex(q => this.answers[q.id] === undefined);
      return index === -1 ? questions.length - 1 : index;
    },

    navigateQuestion(direction) {
      const questions = this.questionsByCategory[this.currentCategory] || [];
      this.currentQuestionIndex = (this.currentQuestionIndex + direction + questions.length) % questions.length;
    },

    async answerQuestion(questionId, answer) {
      this.answers[questionId] = answer;
      
      try {
        const currentCategoryQuestions = this.questionsByCategory[this.currentCategory];
        const nextUnansweredIndex = currentCategoryQuestions.findIndex((q, index) => 
          index > this.currentQuestionIndex && this.answers[q.id] === undefined
        );

        if (nextUnansweredIndex !== -1) {
          this.currentQuestionIndex = nextUnansweredIndex;
        } else {
          const nextCategoryIndex = this.categories.indexOf(this.currentCategory) + 1;
          if (nextCategoryIndex < this.categories.length) {
            this.currentCategory = this.categories[nextCategoryIndex];
            this.currentQuestionIndex = this.findFirstUnansweredQuestionIndex(this.currentCategory);
          } else {
            // All categories completed
            this.currentQuestionIndex = currentCategoryQuestions.length - 1;
          }
        }
        
        await this.saveAssessment();
      } catch (error) {
        console.error('Error saving answer:', error);
        // Optionally show an error message to the user
      }
    },
    async completeAssessment() {
      try {
        const updatedAssessment = await this.saveAssessment();
        this.$router.push(`/results/${this.assessmentId}`);
        console.log('Assessment completed!');
      } catch (error) {
        console.error('Error completing assessment:', error);
        // Handle error (show message to user, etc.)
      }
    },

    async saveAssessment() {
      try {
        const answeredQuestions = Object.keys(this.answers).reduce((acc, questionId) => {
          if (this.answers[questionId] !== undefined) {
            acc[questionId] = this.answers[questionId];
          }
          return acc;
        }, {});

        const response = await axios.put(`https://storesafe.fyi/assessment/${this.assessmentId}`, {
          title: this.assessmentTitle,
          answers: answeredQuestions,
          currentCategory: this.currentCategory,
          currentQuestionIndex: this.currentQuestionIndex,
          userId: this.userId,
          completed: this.isAssessmentCompleted()
        });
        console.log('Assessment saved:', response.data);
        return response.data;
      } catch (error) {
        console.error('Error saving assessment:', error.response ? error.response.data : error.message);
        throw error;
      }
    },
    isAssessmentCompleted() {
      return this.categories.every(category => {
        const categoryQuestions = this.questionsByCategory[category];
        if (!categoryQuestions || categoryQuestions.length === 0) {
          return true; // Consider an empty category as completed
        }
        return categoryQuestions.every(question => 
          this.answers[question.id] !== undefined
        );
      });
    },
    async saveAndReturn() {
      try {
        await this.saveAssessment();
        this.$router.push('/dashboard');
      } catch (error) {
        console.error('Error saving assessment:', error);
        // Optionally show an error message to the user
      }
    },
    getDotClass(questionId) {
      if (this.answers[questionId] === undefined) {
        return 'unanswered';
      }
      return this.answers[questionId] ? 'answered-yes' : 'answered-no';
    },
  }
};
</script>
