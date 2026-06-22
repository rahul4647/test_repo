// MongoDB Index Migration Script
// Run with: node db/migrations/add_indexes.js
const mongoose = require('mongoose');

async function addIndexes() {
  await mongoose.connect(process.env.MONGODB_URL || process.env.DATABASE_URL);

  const db = mongoose.connection.db;

  // Index for community lookups (fixes N+1 populate on author/community)
  await db.collection('communities').createIndex({ id: 1 }, { unique: true });
  await db.collection('communities').createIndex({ name: 1 });

  // Index for thread author queries (fixes N+1 populate)
  await db.collection('threads').createIndex({ author: 1 });
  await db.collection('threads').createIndex({ community: 1 });
  await db.collection('threads').createIndex({ createdAt: -1 });

  // Index for user community membership lookups
  await db.collection('users').createIndex({ communities: 1 });
  await db.collection('users').createIndex({ clerkId: 1 }, { unique: true, sparse: true });

  console.log('✅ MongoDB indexes created successfully');
  await mongoose.disconnect();
}

addIndexes().catch((err) => {
  console.error('❌ Migration failed:', err);
  process.exit(1);
});
