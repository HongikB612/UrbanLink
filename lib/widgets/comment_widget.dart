import 'package:flutter/material.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
import 'package:urbanlink_project/models/comment/comment.dart';
import 'package:urbanlink_project/models/user/user.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  const CommentWidget({
    super.key,
    required this.comment,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MyUser?>(
        stream: UserDatabaseService.getUserStreamById(
            widget.comment.commentAuthorId),
        builder: (context, snapshot) {
          final authorName = snapshot.data?.userName ?? 'Unknown';
          return Container(
              padding: const EdgeInsets.fromLTRB(5, 3, 30, 0),
              color: Colors.white70,
              child: Row(
                children: <Widget>[
                  Container(
                    //누리꾼 정보
                    margin: const EdgeInsets.all(5),
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.abc_sharp),
                    ),
                  ),
                  Column(
                    //댓글 내용
                    children: <Widget>[
                      Text(
                        authorName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Text(widget.comment.commentContent,
                            style: const TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                ],
              ));
        });
  }
}
