// Migration script to create necessary indexes
const mongoose = require('mongoose');

async function createIndexes() {
  const db = mongoose.connection.db;
  await db.collection('users').createIndex({ id: 1 });
  await db.collection('communities').createIndex({ id: 1 });
}

module.exports = createIndexes;