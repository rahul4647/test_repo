// Migration script to add indexes to MongoDB collections

const mongoose = require('mongoose');

async function addIndexes() {
  const db = mongoose.connection.db;

  await db.collection('users').createIndex({ id: 1 }, { unique: true });
  await db.collection('communities').createIndex({ id: 1 }, { unique: true });
  await db.collection('threads').createIndex({ parentId: 1 });
  await db.collection('threads').createIndex({ createdAt: -1 });
}

module.exports = { addIndexes };