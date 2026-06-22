const mongoose = require('mongoose');

async function addIndexes() {
  const db = mongoose.connection.db;
  await db.collection('communities').createIndex({ id: 1 });
  await db.collection('users').createIndex({ id: 1 });
  console.log('Indexes created successfully');
}

module.exports = addIndexes;