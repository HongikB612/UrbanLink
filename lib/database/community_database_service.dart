import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/communities.dart';
import 'package:urbanlink_project/services/auth.dart';

class CommunityDatabaseService {
  static final CollectionReference _communityCollection =
      FirebaseFirestore.instance.collection('communities');

  static Future<Community> createCommunity(Community community) async {
    final docCommunity = _communityCollection.doc();
    final json = {
      'communityId': docCommunity.id,
      'communityName': community.communityName,
      'location': community.location,
    };
    try {
      await docCommunity.set(json);
      return community;
    } catch (e) {
      logger.e('Error: $e');
    }

    return Community(
        communityId: docCommunity.id,
        communityName: community.communityName,
        location: community.location);
  }

  static Stream<List<Community>> getCommunities() {
    try {
      return _communityCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Community.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }

  static Future<Community> getCommunityById(String communityId) async {
    try {
      final snapshot = await _communityCollection.doc(communityId).get();
      if (snapshot.exists) {
        return Community.fromSnapshot(snapshot);
      }
    } catch (e) {
      logger.e('Error: $e');
    }
    return Community(communityId: '', communityName: '', location: '');
  }

  static Future<Community> getCommunityByLocation(String location) async {
    try {
      final snapshot = await _communityCollection
          .where('location', isEqualTo: location)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return Community.fromSnapshot(snapshot.docs.first);
      }
    } catch (e) {
      logger.e('Error: $e');
    }
    return Community(communityId: '', communityName: '', location: '');
  }

  static Stream<List<Community>> getCommunityStreamByLocation(String query) {
    try {
      return _communityCollection
          .where('location', isGreaterThanOrEqualTo: query)
          .where('location', isLessThan: '${query}z')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Community.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }
}
