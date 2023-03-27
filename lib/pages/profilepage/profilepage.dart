import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
import 'package:urbanlink_project/widgets/menu_drawer_widget.dart';
import 'package:urbanlink_project/widgets/post_list_widget.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/database/post_database_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  StreamSubscription<MyUser?>? _subscription;

  MyUser? _myUser;

  @override
  void initState() {
    super.initState();
    _subscribeToUserChanges();
  }

  @override
  void dispose() {
    _unsubscribeFromUserChanges();
    super.dispose();
  }

  void _subscribeToUserChanges() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _subscription = UserDatabaseService.getUserById(currentUser.uid)
          .asStream()
          .listen((myUser) {
        setState(() {
          _myUser = myUser;
        });
      });
    }
  }

  void _unsubscribeFromUserChanges() {
    _subscription?.cancel();
    _subscription = null;
  }

  Widget profileBox(MyUser? profileUser) {
    const textProfileDescriptionStyle = TextStyle(fontSize: 20);
    const double profileHeight = 150;
    const double profileRound = 40;
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        height: profileHeight,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(153, 153, 153, 0.3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(profileRound),
            topRight: Radius.circular(profileRound),
            bottomLeft: Radius.circular(profileRound),
            bottomRight: Radius.circular(profileRound),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: const CircleAvatar(
                    minRadius: 40.0,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 35.0,
                      backgroundImage:
                          AssetImage('assets/images/profileImage.jpeg'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(profileUser?.userName ?? 'Unknown',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(
                                  blurRadius: 9.0,
                                  color: Colors.grey.withOpacity(0.7),
                                  offset: const Offset(0, 4),
                                ),
                              ])),
                      Text(profileUser?.userExplanation ?? '',
                          style: textProfileDescriptionStyle),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(250, 63, 186, 219),
        shadowColor: Colors.grey,
      ),
      endDrawer: MenuDrawer(
        myUser: _myUser,
      ),
      body: Column(
        children: <Widget>[
          profileBox(_myUser),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 20, 0, 10),
            child: const Text('My Posts',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: PostList(
                  postStream: PostDatabaseService.getPostsByUserId(
                      _myUser?.userId ?? 'Unknown'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
