class MyUser {
  final String userId;
  String userName;
  String userEmail;
  String? userExplanation;

  MyUser({
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.userExplanation,
  });
}
