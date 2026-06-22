// MongoDB Index Creation
const mongoose = require('mongoose');

async function createIndexes() {
  const db = mongoose.connection.db;
  await db.collection('users').createIndex({ id: 1 });
  await db.collection('communities').createIndex({ id: 1 });
  await db.collection('communities').createIndex({ createdAt: 1 });
}

createIndexes().then(() => console.log('Indexes created')).catch(err => console.error('Error creating indexes', err));