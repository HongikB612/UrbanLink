import 'dart:ffi';

class MyUser {
  final String userId;
  String userName;
  String userEmail;
  String userExplanation;

  MyUser({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userExplanation,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userExplanation': userExplanation,
    };
  }

  static fromJson(Map<String, dynamic> data) {
    return MyUser(
      userId: data['userId'],
      userName: data['userName'],
      userEmail: data['userEmail'],
      userExplanation: data['userExplanation'],
    );
  }
}
