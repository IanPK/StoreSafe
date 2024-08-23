const express = require('express');
const router = express.Router();
const userRoutes = require('./userRoutes');
const assessmentRoutes = require('./assessmentRoutes');
const questionRoutes = require('./questionRoutes');

// Use routes
router.use('/users', userRoutes);
router.use('/assessment', assessmentRoutes);
router.use('/question', questionRoutes);

module.exports = router;