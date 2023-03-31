import 'package:urbanlink_project/models/community/community.dart';

class CommunityBuilder {
  String _communityId = '';
  String _communityName = '';
  String _location = '';

  CommunityBuilder setCommunityId(String communityId) {
    _communityId = communityId;
    return this;
  }

  CommunityBuilder setCommunityName(String communityName) {
    _communityName = communityName;
    return this;
  }

  CommunityBuilder setLocation(String location) {
    _location = location;
    return this;
  }

  Community build() {
    return Community(
      communityId: _communityId,
      communityName: _communityName,
      location: _location,
    );
  }
}
