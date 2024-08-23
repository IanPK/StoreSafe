const Assessment = require('../models/assessment');
const Question = require('../models/question');

exports.createAssessment = async (req, res) => {
  const { title, userId } = req.body;
  try {
    const newAssessment = await Assessment.create({
      title,
      userId,
      answers: [],
      currentQuestionIndex: 0,
      completed: false,
      progress: 0
    });
    res.status(201).json(newAssessment);
  } catch (error) {
    console.error('Error creating assessment:', error);
    res.status(500).json({ error: error.message });
  }
};

exports.getAssessmentById = async (req, res) => {
  const { id } = req.params;
  try {
    const assessment = await Assessment.findByPk(id, {
      include: [{ model: Question, as: 'questions' }]
    });
    if (!assessment) {
      return res.status(404).json({ error: 'Assessment not found' });
    }
    res.json(assessment);
  } catch (error) {
    console.error('Error fetching assessment:', error);
    res.status(500).json({ error: error.message });
  }
};

exports.getAllAssessments = async (req, res) => {
  try {
    const assessments = await Assessment.findAll();
    res.json(assessments);
  } catch (error) {
    console.error('Error fetching assessments:', error);
    res.status(500).json({ error: error.message });
  }
};

exports.updateAssessmentTitle = async (req, res) => {
  const { id } = req.params;
  const { title } = req.body;

  try {
    const assessment = await Assessment.findByPk(id);
    if (!assessment) {
      return res.status(404).json({ error: 'Assessment not found' });
    }

    assessment.title = title;
    await assessment.save();

    res.json(assessment);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.deleteAssessment = async (req, res) => {
  const { id } = req.params;
  try {
    const assessment = await Assessment.findByPk(id);
    if (!assessment) {
      return res.status(404).json({ error: 'Assessment not found' });
    }
    await assessment.destroy();
    res.json({ message: 'Assessment deleted' });
  } catch (error) {
    console.error('Error deleting assessment:', error);
    res.status(500).json({ error: error.message });
  }
};

exports.updateAssessment = async (req, res) => {
  const { id } = req.params;
  const { title, answers, currentQuestionIndex, userId, completed } = req.body;

  try {
    const assessment = await Assessment.findByPk(id);
    if (!assessment) {
      return res.status(404).json({ error: 'Assessment not found' });
    }

    assessment.title = title;
    assessment.answers = answers;
    assessment.currentQuestionIndex = currentQuestionIndex;
    assessment.userId = userId;
    assessment.completed = completed;
    await assessment.save();

    res.json(assessment);
  } catch (error) {
    console.error('Error updating assessment:', error);
    res.status(500).json({ error: error.message });
  }
};
