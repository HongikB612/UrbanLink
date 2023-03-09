/// Community model
/// This model is used to store the community information
class Community {
  final int communityId;
  final String communityName;

  /// location of the community
  String communityLocation;

  Community({
    required this.communityId,
    required this.communityName,
    required this.communityLocation,
  });
}
