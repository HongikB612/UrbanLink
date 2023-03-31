import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/user/user.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
import 'package:urbanlink_project/pages/loginpage/loginpage.dart';
import 'package:urbanlink_project/widgets/text_fieldwidget.dart';

class ProfileSettingPage extends StatefulWidget {
  final MyUser myUser;

  const ProfileSettingPage({super.key, required this.myUser});

  @override
  State<ProfileSettingPage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ProfileSettingPage> {
  final _auth = FirebaseAuth.instance;
  late final String _email;

  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;
    if (user != null) {
      _email = user.email ?? '';
    }
  }

  Future<void> _resetPassword() async {
    if (_auth.currentUser != null) {
      try {
        final navigator = Navigator.of(context);
        await _auth.sendPasswordResetEmail(email: _email);
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Password Reset Email Sent'),
            content: Text(
                'A password reset link has been sent to $_email. Please follow the instructions in the email to reset your password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  navigator.pop();
                  _auth.signOut();
                  Get.offAll(() => const LoginPage());
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        navigator.pop();
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'No user found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: widget.myUser.userName,
              onChanged: (name) {
                widget.myUser.userName = name;
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'About',
              text: widget.myUser.userExplanation,
              maxLines: 5,
              onChanged: (explain) {
                widget.myUser.userExplanation = explain;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Reset Password'),
                      content: const Text(
                          'Are you sure you want to reset your password?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _resetPassword();
                            if (_errorMessage != null) {
                              Get.snackbar('경고', _errorMessage!);
                            }
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    );
                  }),
              child: const Text('Reset Password'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () async {
                await UserDatabaseService.updateUserName(
                    userId: widget.myUser.userId, name: widget.myUser.userName);

                await UserDatabaseService.updateUserExplanation(
                    userId: widget.myUser.userId,
                    explanation: widget.myUser.userExplanation);

                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
