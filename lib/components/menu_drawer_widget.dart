import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/pages/loginpage/login.dart';
import 'package:urbanlink_project/services/auth.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
  });

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
            const ListTile(
              leading: Icon(Icons.person_pin),
              title: Text('Profile Settings'),
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
}
