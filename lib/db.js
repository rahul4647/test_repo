const mongoose = require('mongoose');
const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:' ));
db.once('open', function () {
  console.log('Connected to MongoDB');
});
const communityIndex = {
  id: 1,
  name: 1
};
db.collection('communities').createIndex(communityIndex);
const threadIndex = {
  id: 1,
  parentId: 1
};
db.collection('threads').createIndex(threadIndex);