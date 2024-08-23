'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.addColumn('Assessments', 'currentQuestionIndex', {
      type: Sequelize.INTEGER,
      defaultValue: 0
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.removeColumn('Assessments', 'currentQuestionIndex');
  }
};
