
import 'package:flutter/material.dart';

class PostedPage extends StatefulWidget {
  @override
  State<PostedPage> createState() => _PostedPageState();
}

class _PostedPageState extends State<PostedPage> {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: Container(
        child: Center(
          child: Text(args , style: TextStyle(fontSize: 30),),
        ),
      ),
    );
  }
}