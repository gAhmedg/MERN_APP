// const mongoose = require('mongoose');
const mongoose = require('mongoose');

const connectionString = 'mongodb://mongo:27017/cinema';

mongoose.connect(connectionString, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).catch((e) => {
  console.error('Connection error', e.message);
});

const db = mongoose.connection;

db.on('error', console.error.bind(console, 'MongoDB connection error:'));

module.exports = db;
