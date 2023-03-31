import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:urbanlink_project/pages/postpage/postedpage.dart';
import 'package:urbanlink_project/services/auth.dart';

class PostListSquareWidget extends StatefulWidget {
  final Stream<List<Post>>? postStream;

  const PostListSquareWidget({Key? key, this.postStream}) : super(key: key);

  @override
  State<PostListSquareWidget> createState() => _PostListSquareWidgetState();
}

class _PostListSquareWidgetState extends State<PostListSquareWidget> {
  Widget _buildPost(Post post) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.fromLTRB(50, 30, 50, 30),
      child: SizedBox(
        height: 50,
        width: 30,
        child: ListTile(
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
              Text(
                '${post.postCreatedTime.month}/${post.postCreatedTime.day}/${post.postCreatedTime.year}',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          onTap: () {
            Get.to(() => const PostedPage(), arguments: post);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPostsPage = Get.currentRoute == '/PostsPage';
    return SizedBox(
      height: 300,
      child: Expanded(
        child: StreamBuilder<List<Post>>(
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
              return Row(
                children: [
                  Expanded(
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return _buildPost(posts[index]);
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 1,
                        )),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
