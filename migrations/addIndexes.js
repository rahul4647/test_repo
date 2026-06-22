const mongoose = require('mongoose');

async function addIndexes() {
  const db = mongoose.connection;
  await db.collection('users').createIndex({ id: 1 });
  await db.collection('communities').createIndex({ id: 1 });
  await db.collection('threads').createIndex({ parentId: 1 });
  console.log('Indexes created');
}

addIndexes().catch(err => console.error(err));