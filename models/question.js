const { Model, DataTypes } = require('sequelize');
const sequelize = require('../config/database');

class Question extends Model {}

Question.init({
  question: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  assessmentId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  category: {
    type: DataTypes.STRING,
    allowNull: true
  },
  weightFoodSafety: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  weightSpaceOptimization: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  weightCostSavings: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  weightLaborEfficiency: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  weightSustainability: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
}, {
  sequelize,
  modelName: 'Question',
});

module.exports = Question;
