require('dotenv').config();
const express = require('express');
const cors = require('cors');
const sequelize = require('./config/database');
const routes = require('./routes');
const assessmentRoutes = require('./routes/assessmentRoutes');
const questionRoutes = require('./routes/questionRoutes');
const userRoutes = require('./routes/userRoutes');
const authRoutes = require('./routes/authRoutes');
const adminRoutes = require('./routes/adminRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

const corsOptions = {
  origin: process.env.ORIGIN,
  credentials: true
};

app.use(cors(corsOptions));
app.use(express.json());

app.use('/assessment', assessmentRoutes);
app.use('/questions', questionRoutes);
app.use('/users', userRoutes);
app.use('/auth', authRoutes);
app.use('/admin', (req, res, next) => {
  console.log('Admin route accessed:', req.method, req.path);
  next();
}, adminRoutes);

app.get('/', (req, res) => {
  res.send('Welcome to StoreSafe Assessment Tool');
});
app.use((req, res, next) => {
  res.status(404).send('Not Found');
});

console.log('API URL:', process.env.VUE_APP_API_URL);


// Optional: Add this line to handle preflight requests for all routes
app.options('*', cors());

sequelize.authenticate()
  .then(() => {
    console.log('Connection to database established successfully.');
    return sequelize.sync();
  })
  .then(() => {
    console.log('Database synchronized.');
    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  });