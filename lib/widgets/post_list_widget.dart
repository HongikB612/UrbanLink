import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/post/post.dart';
import 'package:urbanlink_project/pages/postpage/postedpage.dart';
import 'package:urbanlink_project/services/auth.dart';

class PostList extends StatefulWidget {
  final Stream<List<Post>>? postStream;

  const PostList({Key? key, this.postStream}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  Widget _buildPost(Post post) {
    final authorName = post.authorName;
    return ListTile(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
          child: Text(
            post.postTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
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
                  //좋아요 버튼 (누를 수는 없는 상태)
                  Row(children: <Widget>[
                    const Icon(Icons.favorite, color: Colors.grey),
                    // like count
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: Text(
                        post.postLikeCount.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ]),
                  //좋아요 버튼 (누를 수는 없는 상태)
                  const SizedBox(
                    width: 10,
                  ),
                  Row(children: <Widget>[
                    const Icon(Icons.thumb_down, color: Colors.grey),
                    // like count
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: Text(
                        post.postDislikeCount.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ]),

                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Get.to(() => const PostedPage(), arguments: post);
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    final isPostsPage = Get.currentRoute == '/PostsPage';
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
          if (posts.isEmpty && isPostsPage == true) {
            return const Center(
              child: Text('이 커뮤니티에는 포스트가 없습니다.\n글을 작성하여 이곳에 첫 포스트를 남겨보세요!'),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return _buildPost(posts[index]);
                  },
                ),
              ),
            ],
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
