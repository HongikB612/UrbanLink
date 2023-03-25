import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/pages/postpage/postedpage.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
import 'package:urbanlink_project/services/auth.dart';

class PostListComponent {
  Widget _buildPost(Post post) {
    return StreamBuilder<MyUser?>(
      stream: UserDatabaseService.getUserStreamById(post.postAuthorId),
      builder: (context, snapshot) {
        final authorName = snapshot.data?.userName ?? 'Unknown';
        return Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          color: const Color.fromRGBO(153, 153, 153, 0.3),
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                topLeft: Radius.zero,
                topRight: Radius.zero,
              ),
            ),
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Column(  //프로필
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.ice_skating,
                        size: 30,
                      ),
                      Text(
                        authorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  title: Text(  //제목
                    post.postTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(  //본문
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        //color: Colors.pinkAccent,
                        padding: EdgeInsets.fromLTRB(0, 10, 2, 10),
                        child: Text(
                          post.postContent,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 300,
                        child: Expanded(
                          //flex: ,
                          child: Image.asset("assets/images/blueround.png", fit:BoxFit.contain),
                        ),
                      ),
                      Text(
                        '${post.postCreatedTime.month}/${post.postCreatedTime.day}/${post.postCreatedTime.year}',
                        style: const TextStyle(fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(() => const PostedPage(), arguments: post);
                    },
                ),

                Container(
                  //좋아요 버튼
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  StreamBuilder<List<Post>> postStreamBuilder(Stream<List<Post>>? function) {
    return StreamBuilder<List<Post>>(
      stream: function,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          logger.e(snapshot.error ?? 'Unknown error');
          return Center(
            child: Text('Error: ${snapshot.error ?? 'Unknown error'}'),
          );
        } else if (snapshot.hasData) {
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return _buildPost(posts[index]);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
