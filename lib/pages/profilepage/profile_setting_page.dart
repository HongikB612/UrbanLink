import 'package:flutter/material.dart';
import 'package:urbanlink_project/models/user.dart';
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
            actions: [
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () async {},
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Full Name',
                text: widget.myUser.userName,
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: widget.myUser.userEmail,
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'About',
                text: widget.myUser.userExplanation,
                maxLines: 5,
                onChanged: (about) {},
              ),
            ],
          ),
        ),
      );
}
