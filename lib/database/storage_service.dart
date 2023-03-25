// storage service.dart

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:urbanlink_project/services/auth.dart';

class StorageService {
  static Future<String> uploadPostImage({
    required String postId,
    required String userId,
    required File image,
    required int index,
  }) async {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref();
    final fileRef = storageRef
        .child('posts/$postId/${userId + image.path + index.toString()}');
    try {
      await fileRef.putFile(image);
      final url = await fileRef.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      logger.e('Error: $e');
      return '';
    }
  }

  static Future<String> uploadProfileImage({
    required String userId,
    required File image,
  }) async {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref();
    final fileRef = storageRef.child('profile/$userId/${image.path}');
    try {
      await fileRef.putFile(image);
      final url = await fileRef.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      logger.e('Error: $e');
      return '';
    }
  }
}
