import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/pages/login.dart';
import 'package:urbanlink_project/pages/mainpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _logout();
    _auth();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _auth() {
    // 사용자 인증정보 확인. 딜레이를 두어 확인
    Future.delayed(const Duration(milliseconds: 100), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.off(() => const LoginPage());
      } else {
        Get.off(() => const MainPage());
      }
    });
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
