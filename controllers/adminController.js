// controllers/adminController.js
const { User, Assessment } = require('../models');

exports.getAllUsersWithAssessments = async (req, res) => {
    try {
      const users = await User.findAll({
        include: [{
          model: Assessment,
          as: 'assessments'
        }],
        attributes: { exclude: ['password'] }
      });
      res.json(users);
    } catch (error) {
      console.error('Error fetching users with assessments:', error);
      res.status(500).json({ message: 'Error fetching users and assessments', error: error.message });
    }
  };