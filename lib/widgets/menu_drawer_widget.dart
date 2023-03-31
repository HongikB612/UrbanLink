import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/user/user.dart';
import 'package:urbanlink_project/pages/loginpage/login.dart';
import 'package:urbanlink_project/pages/profilepage/profile_setting_page.dart';
import 'package:urbanlink_project/services/auth.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    super.key,
    MyUser? myUser,
  }) : _myUser = myUser;

  final MyUser? _myUser;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: const Icon(Icons.person_pin),
              title: const Text('Profile Settings'),
              onTap: () {
                logger.i('Profile Settings');
                if (widget._myUser == null) {
                  needTologinAlertDialog(context);
                } else {
                  if (widget._myUser != null) {
                    Get.to(() => ProfileSettingPage(
                          myUser: widget._myUser!,
                        ));
                  } else {
                    needTologinAlertDialog(context);
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          AuthService().signOut();
                          Get.offAll(() => const LoginPage());
                        },
                        child: const Text('Logout')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> needTologinAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Login'),
              content: const Text('Please login first.'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      Get.back();
                      Get.to(() => const LoginPage());
                    },
                    child: const Text('Login')),
              ],
            ));
  }
}
