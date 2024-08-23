const { Question } = require('../models');

exports.createQuestion = async (req, res) => {
  const { assessmentId, question, foodSafety, spaceOptimization, costSavings, laborEfficiency, sustainability } = req.body;

  try {
    const newQuestion = await Question.create({
      assessmentId,
      question,
      // foodSafety,
      // spaceOptimization,
      // costSavings,
      // laborEfficiency,
      // sustainability
    });
    res.status(201).json(newQuestion);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.updateQuestion = async (req, res) => {
  const { id } = req.params;
  const updates = req.body;
  try {
    const [updated] = await Question.update(updates, { where: { id } });
    if (updated) {
      const updatedQuestion = await Question.findByPk(id);
      return res.json(updatedQuestion);
    }
    throw new Error('Question not found');
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

exports.getQuestionById = async (req, res) => {
  const { id } = req.params;
  try {
    const question = await Question.findByPk(id);
    if (question) {
      return res.json(question);
    }
    return res.status(404).json({ message: 'Question not found' });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

exports.getAllQuestions = async (req, res) => {
  try {
    const questions = await Question.findAll();
    console.log('First question:', JSON.stringify(questions[0], null, 2));
    console.log('Total questions:', questions.length);
    console.log('Categories:', questions.map(q => q.category).filter((v, i, a) => a.indexOf(v) === i));
    res.json(questions);
  } catch (err) {
    console.error('Error fetching questions:', err);
    res.status(500).json({ error: err.message });
  }
};

exports.deleteQuestion = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await Question.destroy({ where: { id } });
    if (result === 0) {
      return res.status(404).json({ error: 'Question not found' });
    }
    res.status(204).send();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
