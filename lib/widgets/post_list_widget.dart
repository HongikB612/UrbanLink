import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:urbanlink_project/pages/postpage/postedpage.dart';
import 'package:urbanlink_project/services/auth.dart';
import 'package:urbanlink_project/widgets/like_button.dart';

class PostList extends StatefulWidget {
  final Stream<List<Post>>? postStream;

  const PostList({Key? key, this.postStream}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  Widget _buildPost(Post post) {
    final authorName = post.authorName;
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
          topLeft: Radius.zero,
          topRight: Radius.zero,
        ),
      ),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      elevation: 5,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
          child: Text(
            post.postTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.postContent,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  authorName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  ' | ',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  '${post.postCreatedTime.month}/${post.postCreatedTime.day}/${post.postCreatedTime.year}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                children: <Widget>[
                  //좋아요 버튼
                  postLikeButton(post),
                  const SizedBox(
                    width: 10,
                  ),
                  // 싫어요 버튼
                  postDislikeButton(post),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Get.to(() => const PostedPage(), arguments: post);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
      stream: widget.postStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          logger.e(snapshot.error ?? 'Unknown error');
          return Center(
            child: Text('Error: ${snapshot.error ?? 'Unknown error'}'),
          );
        } else if (snapshot.hasData) {
          final posts = snapshot.data!;
          if (posts.isEmpty) {
            return const Center(
              child: Text('이 커뮤니티에는 포스트가 없습니다.\n글을 작성하여 이곳에 첫 포스트를 남겨보세요!'),
            );
          }
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
