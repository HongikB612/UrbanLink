import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
import 'package:urbanlink_project/widgets/menu_drawer_widget.dart';
import 'package:urbanlink_project/widgets/post_list_component.dart';
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
    const double profileHeight = 200;
    const double profileRound = 40;
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        height: profileHeight,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
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
                const CircleAvatar(
                  minRadius: 60.0,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage:
                        AssetImage('assets/images/profileImage.jpeg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(profileUser?.userName ?? 'Unknown',
                          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
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
    final postListComponent = PostListComponent();
    return Scaffold(
      backgroundColor: Colors.white38,
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
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 20, 0, 10),
            child: const Text('My Posts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
          ),
          Expanded(
            child: postListComponent.postStreamBuilder(
              PostDatabaseService.getPostsByUserId(
                  _myUser?.userId ?? 'Unknown'),
            ),
          ),
        ],
      ),
    );
  }
}
