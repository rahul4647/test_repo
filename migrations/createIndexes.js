const mongoose = require('mongoose');

async function createIndexes() {
  const db = mongoose.connection.db;
  await db.collection('Community').createIndex({ id: 1 });
  await db.collection('Community').createIndex({ createdBy: 1 });
  await db.collection('User').createIndex({ id: 1 });
  await db.collection('User').createIndex({ communities: 1 });
}

module.exports = createIndexes;