import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  static Future<void> createUser(String uid, String name, String email) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    final json = {
      'userId': docUser.id,
      'userName': name,
      'userEmail': email,
      'userExplanation': '',
    };

    // create document and write data to Firebase
    await docUser.set(json);
  }
}
