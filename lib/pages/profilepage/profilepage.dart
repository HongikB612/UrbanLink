import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
import 'package:urbanlink_project/widgets/menu_drawer_widget.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/database/post_database_service.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:urbanlink_project/widgets/post_list_widget.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.postStream});
  final Stream<List<Post>>? postStream;

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
    const double profileRound = 40;
    return Container(
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        //height: profileHeight,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(profileRound),
            topRight: Radius.circular(profileRound),
            bottomLeft: Radius.circular(profileRound),
            bottomRight: Radius.circular(profileRound),
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    minRadius: 40.0,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 37.0,
                      backgroundImage:
                          AssetImage('assets/images/profileImage.jpeg'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 7),
                  child: Text(
                    profileUser?.userName ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 35,),
              child: BubbleSpecialOne(
                text: profileUser?.userExplanation ?? 'Hi, How are you?',
                isSender: false,
                color: Colors.white.withOpacity(0.3),
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(250, 63, 186, 219),
        shadowColor: Colors.transparent,
      ),
      endDrawer: MenuDrawer(
        myUser: _myUser,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: const Color.fromARGB(250, 63, 186, 219),
            child:
            SizedBox(
              height: 200,
              child: profileBox(_myUser),
            ),
          ),
          Expanded(
              child: PostList(
            postStream:
                PostDatabaseService.getPostsByUserId(_myUser?.userId ?? ''),
          ))
        ],
      ),
    );
  }
}
