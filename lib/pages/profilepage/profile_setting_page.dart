import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/pages/mainpage/mainpage.dart';
import 'package:urbanlink_project/repositories/user_database_service.dart';
import 'package:urbanlink_project/widgets/text_fieldwidget.dart';

class ProfileSettingPage extends StatefulWidget {
  final MyUser myUser;

  const ProfileSettingPage({super.key, required this.myUser});

  @override
  State<ProfileSettingPage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ProfileSettingPage> {
  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
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
                child: const Text('Save'),
                onPressed: () async {
                  await UserDatabaseService.updateUserName(
                      userId: widget.myUser.userId,
                      name: widget.myUser.userName);

                  await UserDatabaseService.updateUserExplanation(
                      userId: widget.myUser.userId,
                      explanation: widget.myUser.userExplanation);

                  Get.offAll(() => const MainPage(
                        /// profile page로 이동
                        selectedIndex: 2,
                      ));
                },
              )
            ],
          ),
        ),
      );
}
