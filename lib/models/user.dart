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

  factory MyUser.fromJson(Map<String, dynamic> data) {
    return MyUser(
      userId: data['userId'] ?? 'Unknown',
      userName: data['userName'] ?? 'Unknown',
      userEmail: data['userEmail'] ?? 'Unknown',
      userExplanation: data['userExplanation'] ?? 'Unknown',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyUser &&
        other.userId == userId &&
        other.userName == userName &&
        other.userEmail == userEmail &&
        other.userExplanation == userExplanation;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        userEmail.hashCode ^
        userExplanation.hashCode;
  }
}
