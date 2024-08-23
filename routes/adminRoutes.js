// routes/adminRoutes.js

const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController');
const { authenticateToken, isAdmin } = require('../middleware/auth');

router.get('/users-with-assessments', authenticateToken, isAdmin, adminController.getAllUsersWithAssessments);

module.exports = router;