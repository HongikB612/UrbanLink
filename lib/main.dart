import 'package:flutter/material.dart';
import 'package:urbanlink_project/pages/homepage.dart';
import 'package:urbanlink_project/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'UrbanLink';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(
        title: 'login',
      ),
    );
  }
}
