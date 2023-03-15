import 'package:flutter/material.dart';

class PostingPage extends StatefulWidget {
  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  TextEditingController? titleController;
  TextEditingController? contentController;
  
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posting'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: '제목'),
              ),
              Expanded(child: TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: 100,
                decoration: InputDecoration(labelText: '내용'),
              )),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('게시하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

