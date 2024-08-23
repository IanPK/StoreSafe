const sequelize = require('../config/database');
const Assessment = require('./assessment'); // Adjust path as necessary
const Question = require('./question'); // Adjust path as necessary
const User = require('./user')(sequelize, sequelize.Sequelize.DataTypes);

Assessment.associate = function(models) {
  Assessment.hasMany(models.Question, { foreignKey: 'assessmentId' });
};

Question.associate = function(models) {
  Question.belongsTo(models.Assessment, { foreignKey: 'assessmentId' });
};

// Synchronize all models
sequelize.sync();

module.exports = {
  Assessment,
  Question,
  User,
  sequelize
};
