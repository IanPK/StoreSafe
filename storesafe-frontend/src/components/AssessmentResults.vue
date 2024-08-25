<template>
  <div class="assessment-results">
    <h1>Assessment Results</h1>
    <p v-if="!isComplete">Note: This assessment is incomplete. Results are based on answered questions only.</p>
    <p>Total Score: {{ scores.totalScore.toFixed(2) }}%</p>
    <h3>Category Scores:</h3>
    <ul>
      <li v-for="(score, category) in scores.categoryScores" :key="category">
        {{ category }}: {{ score.toFixed(2) }}%
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    answers: {
      type: Object,
      required: true
    },
    questions: {
      type: Array,
      required: true
    },
    isComplete: {
      type: Boolean,
      required: true
    }
  },
  computed: {
    scores() {
      const categoryTotals = {
        'Food Safety': 0,
        'Space Optimization': 0,
        'Cost Savings': 0,
        'Labor Efficiency': 0,
        'Sustainability': 0
      };
      const categoryMaxPoints = { ...categoryTotals };
      let totalPoints = 0;
      let maxPossiblePoints = 0;

      this.questions.forEach((question) => {
        const answer = this.answers[question.id];
        
        // Only calculate scores for answered questions
        if (answer !== undefined) {
          Object.keys(categoryTotals).forEach(category => {
            const weightKey = `weight${category.replace(/\s+/g, '')}`;
            const weight = question[weightKey] || 0;
            categoryMaxPoints[category] += weight;
            maxPossiblePoints += weight;

            if (answer === true) {
              categoryTotals[category] += weight;
              totalPoints += weight;
            }
          });
        }
      });

      const totalScore = maxPossiblePoints > 0 ? (totalPoints / maxPossiblePoints) * 100 : 0;

      const categoryScores = {};
      Object.keys(categoryTotals).forEach(category => {
        categoryScores[category] = categoryMaxPoints[category] > 0 ? 
          (categoryTotals[category] / categoryMaxPoints[category]) * 100 : 0;
      });

      return {
        totalScore,
        categoryScores
      };
    }
  }
}
</script>