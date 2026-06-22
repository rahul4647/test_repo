const mongoose = require('mongoose');

const createIndexes = async () => {
  const communityModel = mongoose.model('Community');
  const userModel = mongoose.model('User');

  await communityModel.createIndex({ id: 1 }, { unique: true });
  await communityModel.createIndex({ name: 1 });
  await communityModel.createIndex({ createdAt: 1 });

  await userModel.createIndex({ id: 1 }, { unique: true });
  await userModel.createIndex({ name: 1 });
  await userModel.createIndex({ username: 1 });
};

createIndexes();