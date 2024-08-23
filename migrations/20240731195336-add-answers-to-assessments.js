'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.addColumn('Assessments', 'answers', {
      type: Sequelize.JSON,
      defaultValue: {}
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.removeColumn('Assessments', 'answers');
  }
};