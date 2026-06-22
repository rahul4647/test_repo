const communityUsers = await User.updateMany(
  { communities: communityId },
  { $pull: { communities: communityId } }
);