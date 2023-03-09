import 'package:urbanlink_project/models/posts.dart';

/// Community model
/// This model is used to store the community information
class Community {
  final String communityId;
  final String communityTitle;

  /// location of the community
  final String locaationId;

  final List<Post> postList = <Post>[];

  Community({
    required this.communityId,
    required this.communityTitle,
    required this.locaationId,
  });
}
