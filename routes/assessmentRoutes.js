const express = require('express');
const router = express.Router();
const assessmentController = require('../controllers/assessmentController');

// Check if all methods in assessmentController are correctly imported
router.get('/:id', assessmentController.getAssessmentById);
router.post('/', assessmentController.createAssessment);
router.put('/:id', assessmentController.updateAssessment);
router.delete('/:id', assessmentController.deleteAssessment);
router.get('/', assessmentController.getAllAssessments);

module.exports = router;
