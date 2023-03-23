import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
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
                const Text(
                  "이름",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: const Text("댓글",
                      style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ],
        ));
  }
}
