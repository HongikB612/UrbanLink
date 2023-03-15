import 'package:urbanlink_project/models/posts.dart';

/// Community model
/// This model is used to store the community information
class Community {
  final String communityId;
  final String communityTitle;

  /// location of the community
  final String location;

  final List<Post> postList = <Post>[];

  Community({
    required this.communityId,
    required this.communityTitle,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'communityId': communityId,
      'communityTitle': communityTitle,
      'locationId': location,
    };
  }

  factory Community.fromJson(Map<String, dynamic> data) {
    return Community(
      communityId: data['communityId'] ?? 'Unknown',
      communityTitle: data['communityTitle'] ?? 'Unknown',
      location: data['locationId'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Community &&
        other.communityId == communityId &&
        other.communityTitle == communityTitle &&
        other.location == location;
  }

  @override
  int get hashCode {
    return communityId.hashCode ^ communityTitle.hashCode ^ location.hashCode;
  }
}
