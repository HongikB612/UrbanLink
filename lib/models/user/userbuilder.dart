import 'package:urbanlink_project/models/user/user.dart';

class UserBuilder {
  String _userName = '';
  String _userEmail = '';
  String _userId = '';
  String _userExplanation = '';

  UserBuilder setUserName(String userName) {
    _userName = userName;
    return this;
  }

  UserBuilder setUserEmail(String userEmail) {
    _userEmail = userEmail;
    return this;
  }

  UserBuilder setUserId(String userId) {
    _userId = userId;
    return this;
  }

  UserBuilder setUserExplanation(String userExplanation) {
    _userExplanation = userExplanation;
    return this;
  }

  MyUser build() {
    return MyUser(
      userId: _userId,
      userName: _userName,
      userEmail: _userEmail,
      userExplanation: _userExplanation,
    );
  }
}
