import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/posts.dart';

/// Community model
/// This model is used to store the community information
class Community {
  final String communityId;
  final String communityName;

  /// location of the community
  final String location;

  final List<Post> postList = <Post>[];

  Community({
    required this.communityId,
    required this.communityName,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'communityId': communityId,
      'communityTitle': communityName,
      'locationId': location,
    };
  }

  factory Community.fromJson(Map<String, dynamic> data) {
    return Community(
      communityId: data['communityId'] ?? 'Unknown',
      communityName: data['communityName'] ?? 'Unknown',
      location: data['location'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Community &&
        other.communityId == communityId &&
        other.communityName == communityName &&
        other.location == location;
  }

  @override
  int get hashCode {
    return communityId.hashCode ^ communityName.hashCode ^ location.hashCode;
  }

  factory Community.fromSnapshot(DocumentSnapshot snapshot) {
    return Community.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
