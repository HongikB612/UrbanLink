class MyUser {
  final String id;
  String? name;
  String? email;

  MyUser({
    required this.id,
    required this.name,
    this.email,
  });
}
