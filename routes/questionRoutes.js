const express = require('express');
const router = express.Router();
const questionController = require('../controllers/questionController');

// Define question routes
router.post('/', questionController.createQuestion);
router.get('/', questionController.getAllQuestions);
router.get('/:id', questionController.getQuestionById);
router.put('/:id', questionController.updateQuestion);
router.delete('/:id', questionController.deleteQuestion);

// These routes are not implemented in the controller yet, so they're commented out
// router.get('/category/:category', questionController.getQuestionsByCategory);
// router.get('/assessment/:assessmentId', questionController.getQuestionsByAssessmentId);

module.exports = router;