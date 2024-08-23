const { Model, DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Question = require('./question'); // Ensure this path is correct

class Assessment extends Model {}

Assessment.init({
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  answers: {
    type: DataTypes.JSON,
    allowNull: false,
  },
  currentQuestionIndex: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  completed: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false
  },
  progress: {
    type: DataTypes.FLOAT,
    allowNull: false,
  }
}, {
  sequelize,
  modelName: 'Assessment',
});
Assessment.associate = (models) => {
  Assessment.belongsTo(models.User, { as: 'user', foreignKey: 'userId' });
};

Assessment.hasMany(Question, { foreignKey: 'assessmentId', as: 'questions' });
Question.belongsTo(Assessment, { foreignKey: 'assessmentId' });

module.exports = Assessment;
