
import 'package:flutter/material.dart';

class PostedPage extends StatelessWidget {
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