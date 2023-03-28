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

  static Future<List<Community>> getCommunitiesByLocation(String query) {
    List<String> words = query.split(' ');
    for (var word in words) {
      word = word.toLowerCase();
    }

    try {
      return _communityCollection.get().then((snapshot) {
        return snapshot.docs
            .map((doc) => Community.fromSnapshot(doc))
            .where((community) {
          final List<String> searchList = setSearchParam(community.location);
          for (var word in words) {
            if (searchList.contains(word)) {
              return true;
            }
          }
          return false;
        }).toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return Future.value([]);
    }
  }

  static Stream<List<Community>> getCommunityStreamByLocation(String query) {
    List<String> words = query.split(' ');
    for (var word in words) {
      word = word.toLowerCase();
    }

    try {
      return _communityCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Community.fromSnapshot(doc))
            .where((community) {
          final List<String> searchList = setSearchParam(community.location);
          for (var word in words) {
            if (searchList.contains(word)) {
              return true;
            }
          }
          return false;
        }).toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }

  static List<String> setSearchParam(String locationName) {
    List<String> caseSearchList = [];

    // split location name into words
    List<String> words = locationName.split(' ');

    // generate all possible substrings for each word
    for (int i = 0; i < words.length; i++) {
      for (int j = i + 1; j <= words.length; j++) {
        caseSearchList.add(words.sublist(i, j).join(' '));
      }
    }

    // generate all possible prefixes for each word
    for (int i = 0; i < words.length; i++) {
      String prefix = '';
      for (int j = 0; j < words[i].length; j++) {
        prefix += words[i][j];
        caseSearchList.add(prefix);
      }
    }

    return caseSearchList;
  }

  static Future<void> updateSearchKeyword() async {
    try {
      final snapshot = await _communityCollection.get();
      if (snapshot.docs.isNotEmpty) {
        for (final doc in snapshot.docs) {
          final community = Community.fromSnapshot(doc);
          final searchKeyword = setSearchParam(community.location);

          await _communityCollection
              .doc(community.communityId)
              .update({'searchKeyword': searchKeyword});
        }
      }
    } catch (e) {
      logger.e('Error: $e');
    }
  }
}
