import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/pages/homepage/homepage.dart';
import 'firebase_options.dart';

import 'package:urbanlink_project/pages/postpage/postspage.dart';
import 'package:urbanlink_project/pages/postpage/postedpage.dart';
import 'package:urbanlink_project/pages/postpage/postingpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UrbanLink',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      initialRoute: '/',
      routes: {
        '/posts': (context) => PostsPage(),
        '/posting' : (context) => PostingPage(),
        '/posted' : (context) => PostedPage(),
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() async {
    super.dispose();
  }
}