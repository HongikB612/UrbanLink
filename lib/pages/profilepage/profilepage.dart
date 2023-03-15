import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbanlink_project/widgets/menu_drawer_widget.dart';
import 'package:urbanlink_project/widgets/post_list_component.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/repositories/post_database_service.dart';
import 'package:urbanlink_project/repositories/user_database_service.dart';
import 'package:urbanlink_project/services/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<MyUser?> _setUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        final myUser = await UserDatabaseService.getUserById(currentUser.uid);
        return myUser;
      } on Exception catch (e) {
        logger.e('Exception: $e');
      } catch (e) {
        logger.e('Error: $e');
      }
    }
    return null;
  }

  Widget profileBox(MyUser? profileUser) {
    const textProfileUserStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    const textProfileDescriptionStyle = TextStyle(fontSize: 20);
    const double profileHeight = 200;
    const double profileRound = 40;
    return Container(
        height: profileHeight,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 10,
            ),
          ],
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  minRadius: 60.0,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage:
                        AssetImage('assets/images/profileImage.jpeg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(profileUser?.userName ?? 'Unknown',
                          style: textProfileUserStyle),
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
    return FutureBuilder<MyUser?>(
      future: _setUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final myUser = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            endDrawer: MenuDrawer(
              myUser: myUser,
            ),
            body: Column(
              children: <Widget>[
                profileBox(myUser),
                const Text('Post List', style: TextStyle(fontSize: 30)),
                Expanded(
                  child: postListComponent.postStreamBuilder(
                    PostDatabaseService.getPostsByUserId(
                        myUser?.userId ?? 'Unknown'),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
